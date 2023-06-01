package dao.main;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.product.Product;

public class MainDao {
	
	// 카테고리 체크
	// 카테고리 별로 product를 출력하기 위해서 카테고리를 특정화 해야한다.
	// mainName 과 subName을 조건으로 주고 결과값을 int 값으로 categoryNo를 받아온다.
	public int checkCategory(String mainName, String subName) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT category_no categoryNo\r\n"
				+ "FROM category\r\n"
				+ "WHERE category_main_name = ? AND category_sub_name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mainName);
		stmt.setString(2, subName);
		ResultSet rs = stmt.executeQuery();
		int categoryNo = 0;
		if (rs.next()) {
			categoryNo = rs.getInt("categoryNo");
		}
		
		return categoryNo;
	}
	
	// 앨범 출력
	// 받아온 categoryNo와 beginRow, rowPerPage를 이용해서 페이지를 출력한다.
	public ArrayList<Product> selectProduct(int categoryNo, int beginRow, int rowPerPage) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT p.product_name productName, p.product_status productStatus, pi.product_save_filename productSaveFilename, pi.product_filetype productFiletype,"
				+ " p.product_singer productSinger"
				+ " FROM product p INNER JOIN product_img pi"
				+ " ON p.product_no = pi.product_no "
				+ " WHERE p.category_no = ?"
				+ " ORDER BY p.createdate DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Product> productList = new ArrayList<>();
		while(rs.next()) {
			Product p = new Product();
			p.setProductName(rs.getString("productName"));
			p.setProductStatus(rs.getString("productStatus"));
			p.setProductSinger(rs.getString("productSinger"));
			p.setProductSaveFilename(rs.getString("productSaveFilename"));
			p.setProductFiletype(rs.getString("productFiletype"));
			productList.add(p);
		}
		return productList;
	}
	
	// 앨범 상세 출력
	public Product selectProductOne(int productNo) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT p.product_name productName, p.product_status productStatus, pi.product_save_filename productSaveFilename, pi.product_filetype productFiletype, "
				+ "p.product_price productPrice, p.product_price * (1 - NVL(d.discount_rate, 0)) productDiscountPrice, p.product_info productInfo, p.product_stock productStock"
				+ " FROM product p INNER JOIN product_img pi"
				+ " ON p.product_no = pi.product_no"
				+ " INNER JOIN discount d"
				+ " ON p.product_no = d.product_no"
				+ " WHERE d.discount_begin <= CURDATE() AND d.discount_end > CURDATE()";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		Product p = new Product();
		if(rs.next()) {
			p.setProductName(rs.getString("productName"));
			p.setProductPrice(rs.getInt("productPrice"));
			p.setProductDiscountPrice(rs.getInt("productDiscountPrice"));
			p.setProductStatus(rs.getString("productStatus"));
			p.setProductInfo(rs.getString("productInfo"));
			p.setProductStock(rs.getInt("productStock"));
			p.setProductSaveFilename(rs.getString("productSaveFilename"));
			p.setProductFiletype(rs.getString("productFiletype"));
		}
		return p;
	}
	
	// 최근 발매 앨범 정렬
	public ArrayList<Product> selectRecentlyProduct() throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		int viewNum = 6;
		String sql = "SELECT p.product_name productName, p.product_status productStatus, pi.product_save_filename productSaveFilename, pi.product_filetype productFiletype"
				+ " FROM product p INNER JOIN product_img pi"
				+ " ON p.product_no = pi.product_no ORDER BY p.createdate DESC LIMIT ?";
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
	
	//
}
