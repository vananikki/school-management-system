import time
from collections import deque
from db_config import get_connection

def fetch_school_graph():
    """Truy vấn dữ liệu từ MySQL để xây dựng cấu trúc đồ thị thực tế"""
    conn = get_connection()
    if not conn:
        return None
    
    cursor = conn.cursor(dictionary=True)
    graph = {}

    try:
        # 1. Lấy mối quan hệ Lớp -> Sinh viên
        cursor.execute("SELECT ClassID, StudentID, StudentName FROM Students")
        students = cursor.fetchall()
        
        # 2. Lấy mối quan hệ Sinh viên -> Điểm số & Môn học
        cursor.execute("""
            SELECT g.StudentID, s.SubjectName, g.Score 
            FROM Grades g 
            JOIN Subjects s ON g.SubjectID = s.SubjectID
        """)
        grades = cursor.fetchall()

        # Xây dựng đồ thị: Class -> Students -> Grades
        for row in students:
            class_key = f"Class_{row['ClassID']}"
            student_key = f"Student_{row['StudentID']}_{row['StudentName']}"
            
            if class_key not in graph:
                graph[class_key] = []
            graph[class_key].append(student_key)
            
            # Gán danh sách điểm cho từng sinh viên
            if student_key not in graph:
                graph[student_key] = [
                    f"{g['SubjectName']}: {g['Score']}" 
                    for g in grades if g['StudentID'] == row['StudentID']
                ]

        return graph
    finally:
        cursor.close()
        conn.close()

def bfs_log(graph, start_node):
    print(f"\n--- [REAL-DB LOG] BFS STARTING FROM {start_node} ---")
    if start_node not in graph: return
    
    queue = deque([start_node])
    start_time = time.time()
    
    while queue:
        current = queue.popleft()
        print(f"Level Access: {current}")
        if current in graph and isinstance(graph[current], list):
            for neighbor in graph[current]:
                if neighbor.startswith("Student_"):
                    print(f"   |-- Found Student: {neighbor}")
                    queue.append(neighbor)
    
    print(f"Execution Time: {time.time() - start_time:.6f}s")

def dfs_log(graph, node):
    print(f"\n--- [REAL-DB LOG] DFS STARTING FROM {node} ---")
    if node not in graph: return
    
    start_time = time.time()
    def dive(n):
        print(f"Diving into: {n}")
        if n in graph:
            for item in graph[n]:
                if "Student_" in str(item):
                    dive(item)
                else:
                    print(f"      => Data Point: {item}")
    
    dive(node)
    print(f"Execution Time: {time.time() - start_time:.6f}s")

if __name__ == "__main__":
    school_graph = fetch_school_graph()
    if school_graph:
        # Thay 'Class_101' bằng một ClassID có thật trong DB của bạn
        first_class = list(school_graph.keys())[0] 
        bfs_log(school_graph, first_class)
        dfs_log(school_graph, first_class)