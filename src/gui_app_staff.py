import tkinter as tk
from tkinter import messagebox, ttk, simpledialog
from db_config import get_connection
import mysql.connector
# Move reporting imports to the top for better structure
try:
    from reporting_modules import plot_class_performance
except ImportError:
    # Fallback if the file isn't named exactly reporting_modules.py
    plot_class_performance = lambda: print("Reporting module not found")

class SchoolManagementGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("NEU Academic Management System (v1.2)")
        self.root.geometry("550x700")
        self.root.configure(padx=30, pady=20)

        # Header
        tk.Label(root, text="STAFF DASHBOARD", font=("Helvetica", 20, "bold"), fg="#1a237e").pack(pady=(10, 20))

        # --- SECTION 1: STUDENT & TEACHER MANAGEMENT ---
        self.create_section_label("Student & Teacher Management")
        
        tk.Button(root, text="Register New Student", command=self.gui_add_student, 
                  width=45, height=2, bg="#e3f2fd").pack(pady=5)
        
        tk.Button(root, text="Enter Student Grades", command=self.gui_enter_grade, 
                  width=45, height=2, bg="#e3f2fd").pack(pady=5)
        
        tk.Button(root, text="Transfer Student (Class Change)", command=self.gui_transfer_student, 
                  width=45, height=2, bg="#e3f2fd").pack(pady=5)
        
        tk.Button(root, text="Manage Class Teacher Assignments", command=self.gui_update_teacher, 
                  width=45, height=2, bg="#e3f2fd").pack(pady=5)

        # --- SECTION 2: REPORTING & ANALYTICS ---
        self.create_section_label("Reporting & Analytics Management")

        tk.Button(root, text="Generate Student Scorecard", command=self.gui_generate_scorecard, 
                  width=45, height=2, bg="#f1f8e9").pack(pady=5)
        
        tk.Button(root, text="View Performance Chart (Visual)", command=plot_class_performance, 
                  width=45, height=2, bg="#f1f8e9").pack(pady=5)
        
        # FIXED: Call self.gui_teacher_load_summary instead of the external function
        tk.Button(root, text="Teacher Load Summary", command=self.gui_teacher_load_summary, 
                  width=45, height=2, bg="#f1f8e9").pack(pady=5)

        # Logout
        tk.Button(root, text="Secure Logout", command=root.quit, 
                  width=20, bg="#ffebee", fg="#b71c1c", font=("Helvetica", 10, "bold")).pack(pady=30)

    def create_section_label(self, text):
        lbl = tk.Label(self.root, text=text, font=("Helvetica", 12, "bold"), fg="#455a64")
        lbl.pack(anchor="w", pady=(15, 0))
        ttk.Separator(self.root, orient='horizontal').pack(fill='x', pady=5)

    # --- GUI INTERACTION METHODS ---

    def gui_transfer_student(self):
        sid = simpledialog.askinteger("Input", "Enter Student ID:", parent=self.root)
        if sid is None: return
        cid = simpledialog.askinteger("Input", "Enter New Class ID:", parent=self.root)
        if cid is None: return

        conn = get_connection()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.callproc('sp_TransferStudent', [sid, cid])
                conn.commit()
                messagebox.showinfo("Success", f"Student {sid} transferred to Class {cid}!")
            except mysql.connector.Error as err:
                messagebox.showerror("Database Error", err)
            finally:
                conn.close()

    def gui_add_student(self):
        name = simpledialog.askstring("Input", "Enter Full Name:", parent=self.root)
        if not name: return
        email = simpledialog.askstring("Input", "Enter Email:", parent=self.root)
        cid = simpledialog.askinteger("Input", "Enter Class ID:", parent=self.root)
        
        conn = get_connection()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute("INSERT INTO Students (StudentName, Email, ClassID) VALUES (%s, %s, %s)", (name, email, cid))
                conn.commit()
                messagebox.showinfo("Success", f"Student {name} registered successfully!")
            except mysql.connector.Error as err:
                messagebox.showerror("Database Error", err)
            finally:
                conn.close()

    def gui_enter_grade(self):
        sid = simpledialog.askinteger("Input", "Enter Student ID:", parent=self.root)
        sub_id = simpledialog.askinteger("Input", "Enter Subject ID:", parent=self.root)
        score = simpledialog.askfloat("Input", "Enter Score (0.0 - 10.0):", parent=self.root)
        
        if None in (sid, sub_id, score): return

        conn = get_connection()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute("INSERT INTO Grades (StudentID, SubjectID, Score) VALUES (%s, %s, %s)", (sid, sub_id, score))
                conn.commit()
                messagebox.showinfo("Success", "Grade recorded and Class Statistics updated!")
            except mysql.connector.Error as err:
                messagebox.showerror("Database Error", err)
            finally:
                conn.close()

    def gui_update_teacher(self):
        cid = simpledialog.askinteger("Input", "Enter Class ID:", parent=self.root)
        tid = simpledialog.askinteger("Input", "Enter New Teacher ID:", parent=self.root)
        
        if cid is None or tid is None: return

        conn = get_connection()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute("UPDATE Classes SET TeacherID = %s WHERE ClassID = %s", (tid, cid))
                conn.commit()
                messagebox.showinfo("Success", "Teacher assignment updated!")
            except mysql.connector.Error as err:
                messagebox.showerror("Database Error", err)
            finally:
                conn.close()

    def gui_generate_scorecard(self):
        sid = simpledialog.askinteger("Input", "Enter Student ID:", parent=self.root)
        if sid is None: return

        conn = get_connection()
        if conn:
            try:
                cursor = conn.cursor()
                query = """
                    SELECT sub.SubjectName, g.Score 
                    FROM Grades g
                    JOIN Subjects sub ON g.SubjectID = sub.SubjectID
                    WHERE g.StudentID = %s
                """
                cursor.execute(query, (sid,))
                results = cursor.fetchall()
                
                if results:
                    report = f"Scorecard for ID {sid}:\n" + "-"*30 + "\n"
                    for row in results:
                        report += f"{row[0]}: {row[1]}\n"
                    messagebox.showinfo("Student Scorecard", report)
                else:
                    messagebox.showwarning("Not Found", "No grades found for this student.")
            except mysql.connector.Error as err:
                messagebox.showerror("Database Error", err)
            finally:
                conn.close()

    def gui_teacher_load_summary(self):
        conn = get_connection()
        if not conn: return
        try:
            cursor = conn.cursor()
            query = """
                SELECT t.TeacherName, COUNT(DISTINCT c.ClassID), IFNULL(SUM(cs.TotalRecords), 0)
                FROM Teachers t
                LEFT JOIN Classes c ON t.TeacherID = c.TeacherID
                LEFT JOIN ClassStats cs ON c.ClassID = cs.ClassID
                GROUP BY t.TeacherID, t.TeacherName
                ORDER BY 3 DESC;
            """
            cursor.execute(query)
            results = cursor.fetchall()

            report_window = tk.Toplevel(self.root)
            report_window.title("Teacher Load Summary Report")
            report_window.geometry("600x400")

            tk.Label(report_window, text="Teacher Workload Analysis", font=("Helvetica", 14, "bold"), pady=10).pack()

            cols = ('Teacher Name', 'Total Classes', 'Students Managed')
            tree = ttk.Treeview(report_window, columns=cols, show='headings')
            for col in cols:
                tree.heading(col, text=col)
                tree.column(col, width=180, anchor="center")

            for row in results:
                tree.insert("", "end", values=(row[0], row[1], int(row[2])))

            tree.pack(expand=True, fill='both', padx=10, pady=10)
            tk.Button(report_window, text="Close Report", command=report_window.destroy).pack(pady=10)
        except mysql.connector.Error as err:
            messagebox.showerror("Database Error", f"Could not generate report: {err}")
        finally:
            conn.close()

if __name__ == "__main__":
    root = tk.Tk()
    app = SchoolManagementGUI(root)
    root.mainloop()