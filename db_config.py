# db_config.py
import mysql.connector
from mysql.connector import Error

def get_connection():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='SchoolManagement',
            user='teacher_nguyenvanhung',          
            password='nguyenvanhung' 
        )
        
        if connection.is_connected():
            server_info = connection.get_server_info()
            print(f"✅ Successfully connected to MySQL Server version {server_info}")
            return connection
            
    except Error as e:
        print(f"❌ Error while connecting to MySQL: {e}")
        return None

# Self-test block to verify the connection
if __name__ == "__main__":
    test_conn = get_connection()
    if test_conn:
        test_conn.close()
        print("🔌 Connection closed after test.")