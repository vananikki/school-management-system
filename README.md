Dưới đây là bản **README.md** đã được nâng cấp để phản ánh đúng độ chuyên nghiệp của hệ thống, đặc biệt là nhấn mạnh vào phần phân quyền (RBAC) và bảo mật tầng cơ sở dữ liệu mà bạn vừa hoàn thiện.

---

# 🎓 NEU Academic Management System - Secure Portal

A specialized relational database solution designed to streamline institutional data orchestration and administrative workflows at the National Economics University. This system bridges the gap between raw academic data and actionable insights through a professional Python-based GUI and a robust, role-secured MySQL backend.

## 🚀 Core Features

### 🛠 Administrative Operations & RBAC
*   **Role-Based Access Control (RBAC)**: Implements native MySQL roles (`admin_role`, `coordinator_role`, `teacher_role`) to strictly enforce data access policies.
*   **Dynamic Student & Faculty Management**: Full CRUD capabilities for student profiles and faculty assignments, with functional access determined by the user's active role[cite: 1, 2].
*   **Secure Class Transition**: Automated mechanisms for student transfers via the `sp_TransferStudent` stored procedure, restricted to administrative roles to maintain institutional integrity.

### 📊 Performance Analytics
*   **Real-time Statistics**: Utilizes SQL Triggers (`trg_UpdateClassPerformance`) to auto-sync GPA averages and record counts in the `ClassStats` table immediately upon grade entry.
*   **Visual Insights**: Integrated data visualization for class performance trends and faculty workload distribution using Matplotlib.
*   **Search Optimization**: Implements Depth-First Search (DFS) for detailed scorecard generation and Breadth-First Search (BFS) for structural audits.

### 🎨 User Experience
*   **Professional Dynamic Interface**: A minimalist "Portal" built with `Tkinter`, featuring NEU’s signature deep blue palette and an adaptive UI that "grays out" unauthorized functions based on the current user's role.
*   **Secure Session Handling**: Includes an automated role activation sequence (`SET ROLE ALL`) upon login to ensure the security context is correctly applied[cite: 1, 2].

## 🛡 Security Architecture
The system employs a multi-layered security approach:
1.  **Database Layer**: Native MySQL roles define specific `GRANT` privileges for each user type.
2.  **Logic Layer**: Python-level validation using `SELECT CURRENT_ROLE()` to verify credentials before executing sensitive queries.
3.  **Presentation Layer**: Conditional UI rendering to prevent unauthorized interaction with restricted modules.

## 🛠 Tech Stack
*   **Language**: Python 3.10+
*   **Database**: MySQL 8.0+ (Optimized for 3rd Normal Form)
*   **Key Libraries**: 
    *   `mysql-connector-python` (Secure DB connectivity).
    *   `Tkinter` (Dynamic GUI Framework).
    *   `Pillow (PIL)` (NEU Brand Identity processing).
    *   `Matplotlib` (Analytics Charting).

## 🏁 Getting Started

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/vananikki/school-management-system.git
    ```
2.  **Configure Database & Roles**:
    *   Execute `schema.sql` to initialize the database.
    *   Run the Role Creation script to setup `admin_role`, `coordinator_role`, and `teacher_role`.
    *   Ensure your user is granted a default role: `SET DEFAULT ROLE ALL TO 'your_user'@'localhost';`.
3.  **Install Dependencies**:
    ```bash
    pip install mysql-connector-python pillow matplotlib
    ```
4.  **Launch the Portal**:
    
```bash
    python gui_app.py
    ```

---
*Developed as a Final Project for the School of Technology - National Economics University (NEU).*
```
