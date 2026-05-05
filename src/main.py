import sys
from db_config import get_connection
from student_teacher_modules import add_student_ui, enter_grade_ui, update_class_teacher_ui, transfer_student_ui
from reporting_modules import generate_scorecard, plot_class_performance, generate_teacher_load_summary

def main_menu():
    """
    Main entry point for the School Management System.
    Provides a Command Line Interface (CLI) for academic staff.
    """
    while True:
        print("\n" + "="*45)
        print("   NEU ACADEMIC MANAGEMENT SYSTEM (v1.0)   ")
        print("="*45)
        print(" [1] Register New Student")
        print(" [2] Enter Student Grades")
        print(" [3] Transfer Student to New Class")
        print(" [4] Manage Class Teacher Assignments")
        print(" [5] Generate Student Scorecard")
        print(" [6] View Class Performance Chart (Visual)")
        print(" [7] View Teacher Load Summary")
        print(" [0] Exit System")
        print("-" * 45)
        
        choice = input("Select an option (0-7): ")
        
        try:
            if choice == '1':
                add_student_ui()
            elif choice == '2':
                enter_grade_ui()
            elif choice == '3':
                transfer_student_ui()
            elif choice == '4':
                update_class_teacher_ui()
            elif choice == '5':
                generate_scorecard()
            elif choice == '6':
                plot_class_performance()
            elif choice == '7':
                generate_teacher_load_summary()
            elif choice == '0':
                print("Exiting system. Goodbye!")
                sys.exit()
            else:
                print("⚠️ Invalid selection. Please choose between 0 and 7.")
        
        except Exception as e:
            print(f"❌ An unexpected error occurred: {e}")
            input("\nPress Enter to return to Menu...")

if __name__ == "__main__":
    # First, verify database availability
    check_conn = get_connection()
    if check_conn:
        check_conn.close()
        main_menu()
    else:
        print("❌ Critical Error: Could not connect to the database. System aborted.")