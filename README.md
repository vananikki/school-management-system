# 🎓 NEU Academic Management System - Portal

A specialized relational database solution designed to streamline institutional data orchestration and administrative workflows. This system bridges the gap between raw academic data and actionable insights through a professional Python-based GUI and a robust MySQL backend.

## 🚀 Core Features

### 🛠 Administrative Operations
*   **Student & Faculty Management**: Full CRUD (Create, Read, Update, Delete) capabilities for student profiles and teacher assignments.
*   **Class Transition Logic**: Automated mechanisms for student transfers and class reassignments while maintaining historical data integrity.
*   **Curriculum Coordination**: Standardized subject creation and academic scheduling.

### 📊 Performance Analytics
*   **Real-time Statistics**: Utilizes SQL Triggers (`trg_UpdateClassPerformance`) to auto-sync GPA averages and record counts in the `ClassStats` table upon grade entry.
*   **Visual Insights**: Integrated data visualization for class performance trends and faculty workload distribution.
*   **Search Optimization**: Implements Depth-First Search (DFS) for detailed scorecard generation and Breadth-First Search (BFS) for structural audits.

### 🎨 User Experience
*   **Professional Interface**: A minimalist "Portal" built with `Tkinter`, featuring NEU’s signature deep blue palette and modern gray aesthetics.
*   **Interactive Design**: Smooth hover animations and real-time input validation to prevent SQL errors and enhance usability.

## 🛠 Tech Stack
*   **Language**: Python 3.10+
*   **Database**: MySQL (Optimized for 3rd Normal Form)
*   **Libraries**: 
    *   `mysql-connector-python` (Database connectivity)
    *   `Tkinter` (GUI Framework)
    *   `Pillow (PIL)` (Logo & Image processing)
    *   `Matplotlib` (Analytics Charting)

## 🏗 Database Architecture
The system utilizes a relational schema focused on referential integrity. Key tables include:
*   `Students`, `Teachers`, `Classes`, `Subjects`, `Grades`.
*   `ClassStats`: An automated analytical table managed by backend triggers.

## 🏁 Getting Started

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/vananikki/school-management-system.git
    ```
2.  **Configure Database**:
    *   Execute the SQL scripts provided in `schema.sql` to initialize the MySQL database.
    *   Update `db_config.py` with your local MySQL credentials.
3.  **Install Dependencies**:
    ```bash
    pip install mysql-connector-python pillow matplotlib
    ```
4.  **Launch the Portal**:
    
```bash
    python gui_app_2.py
    ```

---
*Developed as a Final Project for the School of Technology - National Economics University.*
```
