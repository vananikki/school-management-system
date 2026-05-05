import mysql.connector
from db_config import get_connection

def get_active_role(cursor):
    """
    Xác định Role nào đang được kích hoạt trong session MySQL hiện tại.
    """
    cursor.execute("SELECT CURRENT_ROLE();")
    result = cursor.fetchone()
    role_str = result[0].lower() if result and result[0] else ""
    
    if 'admin_role' in role_str:
        return "Admin"
    elif 'coordinator_role' in role_str:
        return "Coordinator"
    elif 'teacher_role' in role_str:
        return "Teacher"
    return "Guest"

def add_student_ui():
    """
    Quyền: Admin và Coordinator đều có thể thêm sinh viên.
    """
    conn = get_connection()
    cursor = conn.cursor()
    try:
        role = get_active_role(cursor)
        if role not in ["Admin", "Coordinator"]:
            print(f"\n❌ ACCESS DENIED: Quyền {role} không thể thực hiện thao tác này.")
            return

        print("\n--- NEW STUDENT REGISTRATION ---")
        # ... logic nhập liệu và INSERT giữ nguyên ...
        
    finally:
        cursor.close()
        conn.close()

def enter_grade_ui():
    """
    Quyền: Cả 3 Role đều có quyền nhập điểm (theo lệnh GRANT của bạn).
    """
    conn = get_connection()
    cursor = conn.cursor()
    try:
        role = get_active_role(cursor)
        if role == "Guest":
            print("\n❌ ACCESS DENIED: Vui lòng đăng nhập.")
            return

        print("\n--- GRADE ENTRY MODULE ---")
        # ... logic nhập điểm giữ nguyên ...[cite: 1]
        
    finally:
        cursor.close()
        conn.close()

def transfer_student_ui():
    """
    Quyền: Chỉ Admin hoặc Coordinator mới được phép điều chuyển sinh viên.
    """
    conn = get_connection()
    cursor = conn.cursor()
    try:
        role = get_active_role(cursor)
        if role not in ["Admin", "Coordinator"]:
            print(f"\n❌ ACCESS DENIED: Cần quyền Admin/Coordinator để chuyển lớp.")
            return

        print("\n--- STUDENT TRANSFER MODULE ---")
        # ... logic gọi callproc('sp_TransferStudent') ...[cite: 1]
        
    finally:
        cursor.close()
        conn.close()