package dao.main;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.product.Product;
import vo.product.ProductImg;
import vo.product.Track;

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
	// 받아온 mainName과 subName, beginRow, rowPerPage를 이용해서 페이지를 출력한다.
	// subName이 전체일때 mainName에 해당하는 값을 주기위해 분기를 줬음 
	public ArrayList<Product> selectProduct(String mainName, String subName, int beginRow, int rowPerPage) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT p.product_no productNo, p.product_name productName, p.product_status productStatus, pi.product_save_filename productSaveFilename, pi.product_filetype productFiletype,"
				+ " p.product_singer productSinger"
				+ " FROM product p INNER JOIN product_img pi"
				+ " ON p.product_no = pi.product_no "
				+ " INNER JOIN category c"
				+ " ON p.category_no = c.category_no"
				+ " WHERE c.category_main_name = ? AND c.category_sub_name = ?"
				+ " ORDER BY p.createdate DESC LIMIT ?, ?";
		if ("전체".equals(subName)) {
			sql = "SELECT p.product_no productNo, p.product_name productName, p.product_status productStatus, pi.product_save_filename productSaveFilename, pi.product_filetype productFiletype,"
					+ " p.product_singer productSinger"
					+ " FROM product p INNER JOIN product_img pi"
					+ " ON p.product_no = pi.product_no "
					+ " INNER JOIN category c"
					+ " ON p.category_no = c.category_no"
					+ " WHERE c.category_main_name = ?"
					+ " ORDER BY p.createdate DESC LIMIT ?, ?";
		}
		PreparedStatement stmt = conn.prepareStatement(sql);
		if ("전체".equals(subName)) {
			stmt.setString(1, mainName);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		} else {
			stmt.setString(1, mainName);
			stmt.setString(2, subName);
			stmt.setInt(3, beginRow);
			stmt.setInt(4, rowPerPage);
		}
		ResultSet rs = stmt.executeQuery();
		ArrayList<Product> productList = new ArrayList<>();
		while(rs.next()) {
			Product p = new Product();
			p.setProductNo(rs.getInt("productNo"));
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
				+ "p.product_price productPrice, p.product_price * (1 - NVL(d.discount_rate, 0)) productDiscountPrice, p.product_info productInfo, p.product_stock productStock, "
				+ "SUM(pt.track_time) sum"
				+ " FROM product p INNER JOIN product_img pi"
				+ " ON p.product_no = pi.product_no"
				+ " INNER JOIN discount d"
				+ " ON p.product_no = d.product_no"
				+ " INNER JOIN product_track pt"
				+ " ON p.product_no = pt.product_no"
				+ " WHERE p.product_no = ? AND d.discount_begin <= CURDATE() AND d.discount_end > CURDATE()";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		ResultSet rs = stmt.executeQuery();
		Product p = new Product();
		if(rs.next()) {
			p.setProductName(rs.getString("productName"));
			p.setProductPrice(rs.getInt("productPrice"));
			p.setProductDiscountPrice(rs.getInt("productDiscountPrice"));
			p.setProductStatus(rs.getString("productStatus"));
			p.setProductInfo(rs.getString("productInfo"));
			p.setTrackSumTime(rs.getInt("sum"));
			p.setProductStock(rs.getInt("productStock"));
			p.setProductSaveFilename(rs.getString("productSaveFilename"));
			p.setProductFiletype(rs.getString("productFiletype"));
		}
		return p;
	}
	
	// 앨범 수록곡 출력
	public ArrayList<Track> selectTrack(int productNo) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT pt.track_no trackNo, pt.track_title trackTitle, p.product_singer productSinger, pt.track_time trackTime"
				+ " FROM product p INNER JOIN product_track pt"
				+ " ON p.product_no = pt.product_no"
				+ " WHERE p.product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<Track> trackList = new ArrayList<>();
		while(rs.next()) {
			Track t = new Track();
			t.setTrackNo(rs.getInt("trackNo"));
			t.setTrackName(rs.getString("trackTitle"));
			t.setProductSinger(rs.getString("productSinger"));
			t.setTrackTime(rs.getInt("trackTime"));
			trackList.add(t);
		}
		return trackList;
	}
	
	// 최근 발매 앨범 정렬
	public ArrayList<Product> selectRecentlyProduct() throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		int viewNum = 6;
		String sql = "SELECT p.product_no productNo, p.product_name productName, p.product_status productStatus, pi.product_save_filename productSaveFilename, pi.product_filetype productFiletype"
				+ " FROM product p INNER JOIN product_img pi"
				+ " ON p.product_no = pi.product_no ORDER BY p.createdate DESC LIMIT ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, viewNum);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Product> productList = new ArrayList<>();
		while(rs.next()) {
			Product p = new Product();
			p.setProductNo(rs.getInt("productNo"));
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
		String sql = "SELECT SUM(oh.order_cnt) SUM, p.product_no productNo, p.product_name productName, PI.product_save_filename productSaveFilename, p.product_status productStatus, pi.product_filetype productFiletype\r\n"
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
			p.setProductNo(rs.getInt("productNo"));
			p.setProductName(rs.getString("productName"));
			p.setProductStatus(rs.getString("productStatus"));
			p.setProductSaveFilename(rs.getString("productSaveFilename"));
			p.setProductFiletype(rs.getString("productFiletype"));
			productList.add(p);
		}
		return productList;
	}
	
	//초, 분, 시 계산
	public String calculateTime(int second) {
		int remainSecond = 0;
		int minute = 0;
		int hour = 0;
		remainSecond = second % 60;
		minute = second / 60;
		hour = minute / 60;
		
		String time = second + "";
		if (hour > 0) {
			time = hour+"시 " + minute + "분 " + remainSecond + "초";
		} else if (minute > 0) {
			time = minute + "분 " + remainSecond + "초";
		}
		// System.out.println(time);
		return time;
	}
	
	// product 데이터 삽입
	public int insertProduct(Product product) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "INSERT INTO product(category_no, product_name, product_price, product_stock, product_info, product_singer, createdate, updatedate)\r\n"
				+ "VALUES(?, ?, ?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, product.getCategoryNo());
		stmt.setString(2, product.getProductName());
		stmt.setInt(3, product.getProductNo());
		stmt.setInt(4, product.getProductStock());
		stmt.setString(5, product.getProductInfo());
		stmt.setString(6, product.getProductSinger());
		int row = stmt.executeUpdate();
		System.out.println(row + " <- insert product data row");
		String selectSql = "SELECT product_no productNo"
							+ " FROM product"
							+ " ORDER BY createdate DESC LIMIT 1";
		PreparedStatement selectStmt = conn.prepareStatement(selectSql);
		ResultSet selectRs = selectStmt.executeQuery();
		int productNo = 0;
		if(selectRs.next()) {
			productNo = selectRs.getInt("productNo");
		}
		return productNo;
	}
	
	// productImg 데이터 삽입
	public int insertProductImg(int productNo, ProductImg productImg) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "INSERT INTO product_img(product_no, product_ori_filename, product_save_filename, product_filetype, createdate, updatedate)\r\n"
						+ "VALUES(?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		stmt.setString(2, productImg.getProductOriFilename());
		stmt.setString(3, productImg.getProductSaveFilename());
		stmt.setString(4, productImg.getProductFiletype());
		int row = stmt.executeUpdate();
		return row;
	}
}
