package util;

import java.sql.Connection;
import java.sql.DriverManager;
public class DBUtil {
	public Connection getConnection() throws Exception {
		String driver = "org.mariadb.jdbc.Driver";
		String dbUrl= "jdbc:mariadb://3.35.102.67:3306/shoppingmall";
		String dbUser = "root";
		String dbPw = "java1234";
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		return conn;
	}
}
