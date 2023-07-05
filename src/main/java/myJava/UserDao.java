package myJava;
import java.sql.*;

public class UserDao {

    public static int addUser(User user) {
        String query = "INSERT INTO Users " +
            "(FullName, Email, Password, Balance) VALUES (?, ?, ?, ?);";

        Connection connection = DBUtil.getConnection();
        if (connection == null)
        	return 0;

        int result = 0;

        try {
        	try {
	            // Step 2:Create a statement using connection object
	            PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	            ps.setString(1, user.getFullName());
	            ps.setString(2, user.getEmail());
	            ps.setString(3, user.getPassword());	
	            ps.setInt(4, user.getBalance());
	            System.out.println(ps);
	            
	            // Step 3: Execute the query or update query
	            result = ps.executeUpdate();
	            ResultSet rs = ps.getGeneratedKeys();
	            if (rs.next()) {
	               user.setId(rs.getInt(1));
	            }
	            DBUtil.closePreparedStatement(ps);
	            
	            System.out.println("user-id = " + user.getId());

        	} finally {
        		DBUtil.freeConnection(connection);
        	}

        } catch (SQLException e) {
            // process sql exception
            DBUtil.printSQLException(e);
        }
        return result;
    }

    
    public static int delUser(int userId) {
        String query = "DELETE FROM Users " +
            "WHERE Id = ?;";

        Connection connection = DBUtil.getConnection();
        if (connection == null)
        	return 0;

        int result = 0;

        try {
        	try {
	            // Step 2:Create a statement using connection object
	            PreparedStatement ps = connection.prepareStatement(query);
	            ps.setInt(1, userId);
	            System.out.println(ps);
	            
	            // Step 3: Execute the query or update query
	            ps.executeUpdate();
	            result = 1;
	            DBUtil.closePreparedStatement(ps);
	            
        	} finally {
        		DBUtil.freeConnection(connection);
        	}

        } catch (SQLException e) {
            // process sql exception
            DBUtil.printSQLException(e);
        }
        return result;
    }


    public static User getUser(String email) {
        String query = "SELECT * FROM Users " +
            "WHERE Email = ?;";

        Connection connection = DBUtil.getConnection();
        if (connection == null)
        	return null;

        User user = null;

        try {
        	try {
	            // Step 2:Create a statement using connection object
	            PreparedStatement ps = connection.prepareStatement(query);
	            ps.setString(1, email);
	            System.out.println(ps);
	            
	            // Step 3: Execute the query or update query
	            ResultSet rs = ps.executeQuery();
	            if (rs.next()) {
	                user = new User();
	                user.setId(rs.getInt("Id"));
	                user.setFullName(rs.getString("FullName"));
	                user.setEmail(rs.getString("Email"));
	                user.setPassword(rs.getString("Password"));
	                user.setBalance(rs.getInt("Balance"));
	            }
	            DBUtil.closePreparedStatement(ps);
	            
        	} finally {
        		DBUtil.freeConnection(connection);
        	}

        } catch (SQLException e) {
            // process sql exception
            DBUtil.printSQLException(e);
        }
        return user;
    }

    public static User[] getUsers() {
        String queryCount = "SELECT count(*) FROM Users;";
        String query = "SELECT * FROM Users;";

        Connection connection = DBUtil.getConnection();
        if (connection == null)
        	return null;

        User user = null;
        User[] usersArr = null;
        int count = 0;

        try {
        	try {
	            // Step 2:Create a statement using connection object
	            PreparedStatement ps = connection.prepareStatement(queryCount);
	            System.out.println(ps);
	            
	            // Step 3: Execute the query or update query
	            ResultSet rs = ps.executeQuery();
	            if (rs.next()) {
	                count = rs.getInt("Count(*)");
	            }
	            DBUtil.closePreparedStatement(ps);
	            
	            if (count == 0)
	            	return null;
	            
	            usersArr = new User[count];

	         // Step 2:Create a statement using connection object
	            ps = connection.prepareStatement(query);
	            System.out.println(ps);
	            
	            // Step 3: Execute the query or update query
	            rs = ps.executeQuery();
	            int i = 0;
	            while (rs.next()) {
	                user = new User();
	                user.setId(rs.getInt("Id"));
	                user.setFullName(rs.getString("FullName"));
	                user.setEmail(rs.getString("Email"));
	                user.setPassword(rs.getString("Password"));
	                user.setBalance(rs.getInt("Balance"));
	                usersArr[i++] = user;
	            }
	            DBUtil.closePreparedStatement(ps);
	            
        	} finally {
        		DBUtil.freeConnection(connection);
        	}

        } catch (SQLException e) {
            // process sql exception
            DBUtil.printSQLException(e);
        }
        return usersArr;
    }
    public static int updateUser(User user) {
        String query = "UPDATE Users SET Balance = ? WHERE Id = ?;";

        Connection connection = DBUtil.getConnection();
        if (connection == null)
            return 0;

        int result = 0;

        try {
            try {
                // Step 2: Create a statement using the connection object
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, user.getBalance());
                ps.setInt(2, user.getId());
                System.out.println(ps);

                // Step 3: Execute the update query
                result = ps.executeUpdate();
                DBUtil.closePreparedStatement(ps);
            } finally {
                DBUtil.freeConnection(connection);
            }
        } catch (SQLException e) {
            // Process SQL exception
            DBUtil.printSQLException(e);
        }
        return result;
    }


}
