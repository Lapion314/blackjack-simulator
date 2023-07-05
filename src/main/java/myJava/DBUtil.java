package myJava;
import java.sql.*;
public class DBUtil {
 
	final static String DB_URL = "jdbc:mysql://localhost:3306/";
	final static String DB_SCHEMA = "webdb";
	final static String DB_USER = "root";
	final static String DB_PASS = "root";
	
	public static Connection getConnection() {
		try {
			// Initialize MySQL driver
			Class.forName("com.mysql.cj.jdbc.Driver");
	
			try {
	            return DriverManager.getConnection(DB_URL+DB_SCHEMA, DB_USER, DB_PASS);
	        } catch (SQLException e) {
	        	printSQLException(e);
	            return null;
	        }
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
			return null;
		}
    }
 
    public static void freeConnection(Connection c) {
        try {
            c.close();
        } catch (SQLException e) {
        	printSQLException(e);
        }
    }

	
    public static void closeStatement(Statement s) {
        try {
            if (s != null) {
                s.close();
            }
        } catch (SQLException e) {
        	printSQLException(e);
        }
    }
 
    public static void closePreparedStatement(Statement ps) {
        try {
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
        	printSQLException(e);
        }
    }
 
    public static void closeResultSet(ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
        	printSQLException(e);
        }
    }
    
    public static void printSQLException(SQLException ex) {
        for (Throwable e: ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }

}