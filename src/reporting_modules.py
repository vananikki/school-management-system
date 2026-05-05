# reporting.py
import mysql.connector
from db_config import get_connection
import matplotlib.pyplot as plt

def generate_scorecard():
    """
    Fetches and displays a student's scorecard.
    """
    print("\n--- STUDENT SCORECARD GENERATOR ---")
    student_id = int(input("Enter Student ID: "))
    
    try:
        conn = get_connection()
        cursor = conn.cursor()
        
        # Optimized query to fetch grades and subject names
        query = """
            SELECT sub.SubjectName, g.Score 
            FROM Grades g
            JOIN Subjects sub ON g.SubjectID = sub.SubjectID
            WHERE g.StudentID = %s
        """
        cursor.execute(query, (student_id,))
        results = cursor.fetchall()
        
        if results:
            print(f"\nScorecard for Student ID: {student_id}")
            print("-" * 30)
            for row in results:
                print(f"Subject: {row[0]:<20} | Score: {row[1]}")
            print("-" * 30)
        else:
            print("⚠️ No records found for this Student ID.")
            
    except mysql.connector.Error as err:
        print(f"❌ Database Error: {err}")
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

def plot_class_performance():
    """
    Generates a bar chart showing the Average GPA per Class.
    Uses the optimized ClassStats table.
    """
    print("\n--- GENERATING PERFORMANCE CHART ---")
    
    try:
        conn = get_connection()
        cursor = conn.cursor()
        
        # Leveraging the pre-calculated ClassStats table for speed
        cursor.execute("SELECT ClassID, AverageGPA FROM ClassStats WHERE TotalRecords > 0")
        data = cursor.fetchall()
        
        if not data:
            print("⚠️ No statistical data available to plot.")
            return

        class_ids = [str(row[0]) for row in data]
        avg_gpas = [row[1] for row in data]
        
        # Plotting using Matplotlib
        plt.figure(figsize=(10, 6))
        plt.bar(class_ids, avg_gpas, color='forestgreen')
        plt.xlabel('Class ID')
        plt.ylabel('Average GPA')
        plt.title('Academic Performance by Class (NEU)')
        plt.ylim(0, 10) # Assuming grading scale is 0-10
        plt.grid(axis='y', linestyle='--', alpha=0.7)
        
        print("📊 Chart generated successfully. Please check the pop-up window.")
        plt.show()
            
    except mysql.connector.Error as err:
        print(f"❌ Database Error: {err}")
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()


def generate_teacher_load_summary():
    """
    Generates a summary of the teaching load for each instructor.
    Shows the number of classes assigned and the total number of students managed.
    """
    print("\n--- TEACHER LOAD SUMMARY REPORT ---")
    
    try:
        conn = get_connection()
        cursor = conn.cursor()
        
        # Query to aggregate teacher workload
        # It counts unique classes and total students across those classes
        query = """
            SELECT 
                t.TeacherName, 
                COUNT(DISTINCT c.ClassID) AS TotalClasses,
                SUM(cs.TotalRecords) AS TotalStudentsManaged
            FROM Teachers t
            LEFT JOIN Classes c ON t.TeacherID = c.TeacherID
            LEFT JOIN ClassStats cs ON c.ClassID = cs.ClassID
            GROUP BY t.TeacherID, t.TeacherName
            ORDER BY TotalStudentsManaged DESC;
        """
        
        cursor.execute(query)
        results = cursor.fetchall()
        
        if results:
            print(f"{'Teacher Name':<25} | {'Classes':<10} | {'Total Students':<15}")
            print("-" * 55)
            for row in results:
                # Handle cases where a teacher might not have a class assigned yet
                classes = row[1] if row[1] else 0
                students = int(row[2]) if row[2] else 0
                print(f"{row[0]:<25} | {classes:<10} | {students:<15}")
            print("-" * 55)
        else:
            print("⚠️ No teacher load data found.")
            
    except mysql.connector.Error as err:
        print(f"❌ Database Error: {err}")
    finally:
        if 'conn' in locals() and conn.is_connected():
            cursor.close()
            conn.close()

