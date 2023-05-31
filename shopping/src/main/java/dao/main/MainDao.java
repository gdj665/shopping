package dao.main;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.product.Product;

public class MainDao {
	// 최근 발매 앨범 정렬
	public ArrayList<Product> selectRecentlyProduct() throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		int viewNum = 6;
		String sql = "SELECT p.product_name productName, p.product_status productStatus, pi.product_save_filename productSaveFilname, pi.product_filetype productFiletype"
				+ " FROM product p INNTER JOIN product_img pi"
				+ " ON p.product_no = pi.product_no ORDER BY createdate DESC LIMIT ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, viewNum);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Product> productList = new ArrayList<>();
		while(rs.next()) {
			Product p = new Product();
			p.setProductName(rs.getString("productName"));
			p.setProductStatus(rs.getString("productStatus"));
			p.setProductSaveFilename(rs.getString("productSaveFilename"));
			p.setProductFiletype(rs.getString("productFiletype"));
			productList.add(p);
		}
		return productList;
	}
	// 판매량 순으로 정렬
	public ArrayList<Product> selectPopularProduct() throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		int viewNum = 6;
		String sql = "SELECT SUM(oh.order_cnt) SUM, p.product_name productName, PI.product_save_filename productSaveFilename, p.product_status productStatus, pi.product_filetype productFiletype\r\n"
				+ "FROM orders_history oh  INNER JOIN product_img PI\r\n"
				+ "			ON oh.product_no = PI.product_no\r\n"
				+ "				INNER JOIN product p\r\n"
				+ "				ON oh.product_no = p.product_no\r\n"
				+ "GROUP BY oh.product_no\r\n"
				+ "ORDER BY SUM desc LIMIT ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, viewNum);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Product> productList = new ArrayList<>();
		while(rs.next()) {
			Product p = new Product();
			p.setProductName(rs.getString("productName"));
			p.setProductStatus(rs.getString("productStatus"));
			p.setProductSaveFilename(rs.getString("productSaveFilename"));
			p.setProductFiletype(rs.getString("productFiletype"));
			productList.add(p);
		}
		return productList;
	}
}
