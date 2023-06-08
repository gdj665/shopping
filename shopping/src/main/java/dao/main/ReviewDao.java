package dao.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.product.Review;
import vo.product.ReviewImg;

public class ReviewDao {
	
	// 리뷰 작성 유효성 검사
	public boolean checkId(String id, int productNo) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT COUNT(*) cnt\r\n"
				+ "FROM orders o INNER JOIN orders_history oh\r\n"
				+ "	ON o.order_no = oh.order_no\r\n"
				+ "WHERE o.id = ? AND oh.product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setInt(2, productNo);
		// System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		int cnt = 0;
		if(rs.next()) {
			cnt = rs.getInt("cnt");
		}
		if (cnt == 0) {
			return false;
		}
		return true;
	}
	
	// 리뷰 title list 출력
	public ArrayList<Review> selectReviewTitleList(int productNo) throws Exception{
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT review_no reviewNo, review_title reviewTitle\r\n"
				+ "FROM review\r\n"
				+ "WHERE product_no = ? \r\n"
				+ "ORDER BY createdate DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		// System.out.println(stmt + "selectReviewTitleList stmt");
		ResultSet rs = stmt.executeQuery();
		ArrayList<Review> reviewList = new ArrayList<>(); 
		while (rs.next()) {
			Review r = new Review();
			r.setReviewNo(rs.getInt("reviewNo"));
			r.setReviewTitle(rs.getString("reviewTitle"));
			reviewList.add(r);
		}
		return reviewList;
	}
	
	// 리뷰 상세 출력
	public Review selectReview(int reviewNo) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT r.id id, p.product_no productNo, p.product_name productName, PI.product_save_filename productSaveFilename, r.review_title reviewTitle, r.review_content reviewContent, r.createdate createdate\r\n"
				+ "FROM review r INNER JOIN product p\r\n"
				+ "	ON r.product_no = p.product_no\r\n"
				+ "	INNER JOIN product_img pi\r\n"
				+ "	ON r.product_no = PI.product_no\r\n"
				+ "WHERE review_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, reviewNo);
		ResultSet rs = stmt.executeQuery();
		Review review = new Review();
		if (rs.next()) {
			review.setId(rs.getString("id"));
			review.setProductNo(rs.getInt("productNo"));
			review.setProductName(rs.getString("productName"));
			review.setProductSaveFilename(rs.getString("productSaveFilename"));
			review.setReviewTitle(rs.getString("reviewTitle"));
			review.setReviewContent(rs.getString("reviewContent"));
			review.setCreatedate(rs.getString("createdate"));
		}
		return review;
	}
	
	// 리뷰 입력
	public int insertReview(Review review) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "INSERT INTO review (id, product_no, review_title, review_content, createdate, updatedate)\r\n"
				+ "VALUES(?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, review.getId());
		stmt.setInt(2, review.getProductNo());
		stmt.setString(3, review.getReviewTitle());
		stmt.setString(4, review.getReviewContent());
		int row = stmt.executeUpdate();
		int reviewNo = 0;
		if (row > 0) {
			String selectSql = "SELECT review_no reviewNo\r\n"
					+ "FROM review\r\n"
					+ "WHERE id = ?\r\n"
					+ "ORDER BY createdate DESC\r\n"
					+ "LIMIT 1";
			PreparedStatement selectStmt = conn.prepareStatement(selectSql);
			selectStmt.setString(1, review.getId());
			ResultSet selectRs = selectStmt.executeQuery();
			if (selectRs.next()) {
				reviewNo = selectRs.getInt("reviewNo");
			}
		}
		return reviewNo;
	}
	
	// 리뷰 수정
	public int updateReview(Review review) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "UPDATE review SET review_title = ?,\r\n"
				+ "						review_content = ?,\r\n"
				+ "						updatedate = NOW()\r\n"
				+ "WHERE review_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, review.getReviewTitle());
		stmt.setString(2, review.getReviewContent());
		stmt.setInt(3, review.getReviewNo());
		int row = stmt.executeUpdate();
		return row;
	}
	
	// reviewImg 데이터 삽입
	public int insertreviewImg(int reviewNo, ReviewImg reviewImg) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "INSERT INTO review_img(review_no, review_ori_filename, review_save_filename, review_filetype, createdate, updatedate)\r\n"
				+ "VALUES(?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, reviewNo);
		stmt.setString(2, reviewImg.getReviewOriFilename());
		stmt.setString(3, reviewImg.getReviewSaveFilename());
		stmt.setString(4, reviewImg.getReviewFiletype());
		int row = stmt.executeUpdate();
		return row;
	}
	
	// reviewImg 데이터 출력
	public ArrayList<Review> selectReviewImg(int reviewNo) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT review_save_filename reviewSaveFilename\r\n"
				+ "FROM review_img\r\n"
				+ "WHERE review_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, reviewNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Review> reviewImgList = new ArrayList<>();
		while (rs.next()) {
			Review r = new Review();
			r.setReviewSaveFilename(rs.getString("reviewSaveFilename"));
			reviewImgList.add(r);
		}
		return reviewImgList;
	}
	
	// reviewImg 데이터 수정
	public int updateReviewImg(int reviewNo, ReviewImg reviewImg) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "UPDATE review_img SET review_ori_filename = ?,\r\n"
				+ "							review_save_filename = ?,\r\n"
				+ "							review_filetype = ?,\r\n"
				+ "							updatedate = NOW()\r\n"
				+ "WHERE review_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, reviewImg.getReviewOriFilename());
		stmt.setString(2, reviewImg.getReviewSaveFilename());
		stmt.setString(3, reviewImg.getReviewFiletype());
		stmt.setInt(4, reviewNo);
		int row = stmt.executeUpdate();
		return row;
	}
}
