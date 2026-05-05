import tkinter as tk
from tkinter import messagebox, ttk, simpledialog
from PIL import Image, ImageTk
from db_config import get_connection
import mysql.connector

# Palette màu chuyên nghiệp NEU
COLORS = {
    "primary": "#0054a5",
    "hover": "#003d7a",
    "bg_light": "#ffffff",
    "text_main": "#2c3e50",
    "accent_green": "#27ae60",
    "accent_red": "#e74c3c",
    "disabled": "#bdc3c7"
}

class SchoolManagementGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("NEU Academic Management System - Staff Portal")
        self.root.geometry("600x850")
        self.root.configure(bg=COLORS["bg_light"])

        # 1. Xác định Role hiện tại từ Database
        self.user_role = self.fetch_db_role()

        # Container chính
        self.main_frame = tk.Frame(self.root, bg=COLORS["bg_light"], padx=40, pady=20)
        self.main_frame.pack(expand=True, fill="both")

        self.setup_header()

        # --- SECTION 1: ADMINISTRATION ---
        self.create_section_label(f"Administration (Role: {self.user_role})")
        
        # Phân quyền nút bấm dựa trên role cụ thể[cite: 1, 2]
        self.add_animated_button("Register New Student", self.gui_add_student, COLORS["primary"], 
                                 required_roles=["Admin", "Coordinator"])
        
        self.add_animated_button("Enter Student Grades", self.gui_enter_grade, COLORS["primary"], 
                                 required_roles=["Admin", "Coordinator", "Teacher"])
        
        self.add_animated_button("Transfer Student (Class Change)", self.gui_transfer_student, COLORS["primary"], 
                                 required_roles=["Admin", "Coordinator"])
        
        self.add_animated_button("Assign Class Teacher", self.gui_update_teacher, COLORS["primary"], 
                                 required_roles=["Admin"])

        # --- SECTION 2: INSIGHTS ---
        self.create_section_label("Insights & Analytics")
        self.add_animated_button("Generate Scorecard", self.gui_generate_scorecard, COLORS["accent_green"], 
                                 required_roles=["Admin", "Coordinator", "Teacher"])
        
        # Import module vẽ biểu đồ
        try:
            from reporting_modules import plot_class_performance
            self.add_animated_button("View Performance Chart", plot_class_performance, COLORS["accent_green"], 
                                     required_roles=["Admin", "Coordinator"])
        except ImportError:
            print("Warning: reporting_modules.py not found.")

        self.add_animated_button("Teacher Load Summary", self.gui_teacher_load_summary, COLORS["accent_green"], 
                                 required_roles=["Admin"])

        # Footer
        tk.Button(self.main_frame, text="SECURE LOGOUT", command=root.quit, 
                  font=("Segoe UI", 9, "bold"), bg=COLORS["accent_red"], fg="white",
                  relief="flat", cursor="hand2", padx=20, pady=10).pack(pady=40)

    def fetch_db_role(self):
        """Kích hoạt Role và lấy Role đang hoạt động từ MySQL"""
        conn = get_connection()
        if not conn: return "Guest"
        try:
            cursor = conn.cursor()
            cursor.execute("SET ROLE ALL;") 
            cursor.execute("SELECT CURRENT_ROLE();")
            result = cursor.fetchone()
            role_str = result[0].lower() if result and result[0] else ""
            
            if 'admin_role' in role_str: return "Admin"
            if 'coordinator_role' in role_str: return "Coordinator"
            if 'teacher_role' in role_str: return "Teacher"
            return "Guest"
        except:
            return "Guest"
        finally:
            conn.close()

    def setup_header(self):
        """Hiển thị Logo và Tiêu đề NEU"""
        try:
            img = Image.open("neu_logo.png").resize((100, 100), Image.Resampling.LANCZOS)
            self.logo_img = ImageTk.PhotoImage(img)
            tk.Label(self.main_frame, image=self.logo_img, bg=COLORS["bg_light"]).pack(pady=(0, 5))
        except: pass
        tk.Label(self.main_frame, text="NATIONAL ECONOMICS UNIVERSITY", 
                 font=("Segoe UI", 14, "bold"), fg=COLORS["primary"], bg=COLORS["bg_light"]).pack()

    def create_section_label(self, text):
        frame = tk.Frame(self.main_frame, bg=COLORS["bg_light"])
        frame.pack(fill="x", pady=(20, 5))
        tk.Label(frame, text=text.upper(), font=("Segoe UI", 8, "bold"), fg="#95a5a6", bg=COLORS["bg_light"]).pack(side="left")

    def add_animated_button(self, text, command, color, required_roles):
        """Tạo nút có phân quyền và hiệu ứng hover"""
        is_allowed = self.user_role in required_roles
        state = "normal" if is_allowed else "disabled"
        final_color = color if is_allowed else COLORS["disabled"]

        btn = tk.Button(self.main_frame, text=text, command=command, state=state,
                        font=("Segoe UI", 10, "bold"), bg=final_color, fg="white",
                        relief="flat", cursor="hand2" if is_allowed else "arrow", pady=10, bd=0)
        btn.pack(fill="x", pady=6)

        if is_allowed:
            btn.bind("<Enter>", lambda e: btn.config(bg=COLORS["hover"]))
            btn.bind("<Leave>", lambda e: btn.config(bg=color))
        return btn

    # --- CÁC HÀM TƯƠNG TÁC DATABASE (Đã fix lỗi AttributeError) ---

    def gui_add_student(self):
        name = simpledialog.askstring("Input", "Full Name:")
        email = simpledialog.askstring("Input", "Email:")
        cid = simpledialog.askinteger("Input", "Class ID:")
        if name and cid:
            conn = get_connection()
            try:
                cursor = conn.cursor()
                cursor.execute("SET ROLE ALL;")
                cursor.execute("INSERT INTO Students (StudentName, Email, ClassID) VALUES (%s, %s, %s)", (name, email, cid))
                conn.commit()
                messagebox.showinfo("Success", f"Student {name} registered!")
            except Exception as e: messagebox.showerror("Error", e)
            finally: conn.close()

    def gui_enter_grade(self):
        sid = simpledialog.askinteger("Input", "Student ID:")
        sub_id = simpledialog.askinteger("Input", "Subject ID:")
        score = simpledialog.askfloat("Input", "Score (0-10):")
        if sid and sub_id and score is not None:
            conn = get_connection()
            try:
                cursor = conn.cursor()
                cursor.execute("SET ROLE ALL;")
                cursor.execute("INSERT INTO Grades (StudentID, SubjectID, Score) VALUES (%s, %s, %s)", (sid, sub_id, score))
                conn.commit()
                messagebox.showinfo("Success", "Grade recorded!")
            except Exception as e: messagebox.showerror("Error", e)
            finally: conn.close()

    def gui_transfer_student(self):
        sid = simpledialog.askinteger("Input", "Student ID:")
        cid = simpledialog.askinteger("Input", "New Class ID:")
        if sid and cid:
            conn = get_connection()
            try:
                cursor = conn.cursor()
                cursor.execute("SET ROLE ALL;")
                cursor.callproc('sp_TransferStudent', [sid, cid])
                conn.commit()
                messagebox.showinfo("Success", "Transfer completed!")
            except Exception as e: messagebox.showerror("Error", e)
            finally: conn.close()

    def gui_update_teacher(self):
        cid = simpledialog.askinteger("Input", "Class ID:")
        tid = simpledialog.askinteger("Input", "Teacher ID:")
        if cid and tid:
            conn = get_connection()
            try:
                cursor = conn.cursor()
                cursor.execute("SET ROLE ALL;")
                cursor.execute("UPDATE Classes SET TeacherID = %s WHERE ClassID = %s", (tid, cid))
                conn.commit()
                messagebox.showinfo("Success", "Teacher updated!")
            except Exception as e: messagebox.showerror("Error", e)
            finally: conn.close()

    def gui_generate_scorecard(self):
        sid = simpledialog.askinteger("Input", "Student ID:")
        if sid:
            conn = get_connection()
            try:
                cursor = conn.cursor()
                cursor.execute("SET ROLE ALL;")
                cursor.execute("SELECT sub.SubjectName, g.Score FROM Grades g JOIN Subjects sub ON g.SubjectID = sub.SubjectID WHERE g.StudentID = %s", (sid,))
                results = cursor.fetchall()
                if results:
                    msg = "\n".join([f"{r[0]}: {r[1]}" for r in results])
                    messagebox.showinfo("Scorecard", msg)
                else: messagebox.showwarning("Empty", "No grades found.")
            finally: conn.close()

    def gui_teacher_load_summary(self):
        # ... logic hiển thị bảng workload tương tự như bản cũ ...
        pass

if __name__ == "__main__":
    root = tk.Tk()
    root.iconbitmap("neu_logo.ico")
    app = SchoolManagementGUI(root)
    root.mainloop()
    # Gắn icon dùng file PNG có sẵn của bạn
