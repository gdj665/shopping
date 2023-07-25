package dao.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.product.Product;

public class SearchDao {
	
	// 곡 찾기 where 가수 이름에 검색어가 들어간 곡
	public ArrayList<Product> searchTrackWithSinger(String[] searchWord) throws Exception {
		for (int i = 0; i < searchWord.length; i++){
			searchWord[i] = "%" + searchWord[i] + "%";
		}
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String likeSql = "WHERE";
		for (int i = 0; i < searchWord.length; i++) {
			if (i < searchWord.length - 1) {
				likeSql += " p.product_singer LIKE ? AND ";
			} else {
				likeSql += " p.product_singer LIKE ? ";
			}
		}
		String sql = "SELECT p.product_no productNo, pt.track_title trackTitle, p.product_singer productSinger, p.product_name productName\r\n"
				+ "FROM product p INNER JOIN product_track pt\r\n"
				+ "	ON p.product_no = pt.product_no\r\n"
				+ likeSql;
		PreparedStatement stmt = conn.prepareStatement(sql);
		int pramCnt = 1;
		for (String s : searchWord) {
			stmt.setString(pramCnt, s);
			pramCnt++;
		}
		//System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Product> productList = new ArrayList<>();
		while (rs.next()) {
			Product p = new Product();
			p.setProductNo(rs.getInt("productNo"));
			p.setTrackName(rs.getString("trackTitle"));
			p.setProductSinger(rs.getString("productSinger"));
			p.setProductName(rs.getString("productName"));
			productList.add(p);
		}
		return productList;
	}
	
	// 검색어가 들어간 곡 찾기
	public ArrayList<Product> searchTrackName(String[] searchWord) throws Exception {
		for (int i = 0; i < searchWord.length; i++){
			searchWord[i] = "%" + searchWord[i] + "%";
		}
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String likeSql = "WHERE";
		for (int i = 0; i < searchWord.length; i++) {
			if (i < searchWord.length - 1) {
				likeSql += " pt.track_title LIKE ? AND ";
			} else {
				likeSql += " pt.track_title LIKE ? ";
			}
		}
		String sql = "SELECT p.product_no productNo, pt.track_title trackTitle, p.product_singer productSinger, p.product_name productName\r\n"
				+ "FROM product p INNER JOIN product_track pt\r\n"
				+ "	ON p.product_no = pt.product_no\r\n"
				+ likeSql;
		PreparedStatement stmt = conn.prepareStatement(sql);
		int pramCnt = 1;
		for (String s : searchWord) {
			stmt.setString(pramCnt, s);
			pramCnt++;
		}
		ResultSet rs = stmt.executeQuery();
		ArrayList<Product> productList = new ArrayList<>();
		while (rs.next()) {
			Product p = new Product();
			p.setProductNo(rs.getInt("productNo"));
			p.setTrackName(rs.getString("trackTitle"));
			p.setProductSinger(rs.getString("productSinger"));
			p.setProductName(rs.getString("productName"));
			productList.add(p);
		}
		return productList;
	}
	
	// 곡 찾기 where 앨범 이름에 검색어가 들어간 곡
	public ArrayList<Product> searchTrackWithProductName(String[] searchWord) throws Exception {
		for (int i = 0; i < searchWord.length; i++){
			searchWord[i] = "%" + searchWord[i] + "%";
		}
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String likeSql = "WHERE";
		for (int i = 0; i < searchWord.length; i++) {
			if (i < searchWord.length - 1) {
				likeSql += " p.product_name LIKE ? AND ";
			} else {
				likeSql += " p.product_name LIKE ? ";
			}
		}
		String sql = "SELECT p.product_no productNo, pt.track_title trackTitle, p.product_singer productSinger, p.product_name productName\r\n"
				+ "FROM product p INNER JOIN product_track pt\r\n"
				+ "	ON p.product_no = pt.product_no\r\n"
				+ likeSql;
		PreparedStatement stmt = conn.prepareStatement(sql);
		int pramCnt = 1;
		for (String s : searchWord) {
			stmt.setString(pramCnt, s);
			pramCnt++;
		}
		ResultSet rs = stmt.executeQuery();
		ArrayList<Product> productList = new ArrayList<>();
		while (rs.next()) {
			Product p = new Product();
			p.setProductNo(rs.getInt("productNo"));
			p.setTrackName(rs.getString("trackTitle"));
			p.setProductSinger(rs.getString("productSinger"));
			p.setProductName(rs.getString("productName"));
			productList.add(p);
		}
		return productList;
	}
	
	// 검색어가 들어간 앨범 찾기 
	public ArrayList<Product> searchProductName(String[] searchWord) throws Exception {
		for (int i = 0; i < searchWord.length; i++){
			searchWord[i] = "%" + searchWord[i] + "%";
		}
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String likeSql = "WHERE";
		for (int i = 0; i < searchWord.length; i++) {
			if (i < searchWord.length - 1) {
				likeSql += " p.product_name LIKE ? AND ";
			} else {
				likeSql += " p.product_name LIKE ? ";
			}
		}
		String sql = "SELECT p.product_no productNo, p.product_singer productSinger, p.product_name productName, pi.product_save_filename productSaveFilename, pi.product_filetype productFiletype\r\n"
				+ "FROM product p INNER JOIN product_img pi\r\n"
				+ "	ON p.product_no = pi.product_no\r\n"
				+ likeSql;
		PreparedStatement stmt = conn.prepareStatement(sql);
		int pramCnt = 1;
		for (String s : searchWord) {
			stmt.setString(pramCnt, s);
			pramCnt++;
		}
		ResultSet rs = stmt.executeQuery();
		ArrayList<Product> productList = new ArrayList<>();
		while (rs.next()) {
			Product p = new Product();
			p.setProductNo(rs.getInt("productNo"));
			p.setProductSinger(rs.getString("productSinger"));
			p.setProductName(rs.getString("productName"));
			p.setProductSaveFilename(rs.getString("productSaveFilename"));
			p.setProductFiletype(rs.getString("productFiletype"));
			productList.add(p);
		}
		return productList;
	}
}
