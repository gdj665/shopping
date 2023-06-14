package dao.cs;

import java.sql.*;
import java.util.*;

import util.*;
import vo.cs.*;

public class CsDao {
	
	// 1) 제품마다의 리뷰 리스트 부르기
	public ArrayList<Qa> questionList(int productNo) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT q_no,id,q_content,createdate,updatedate FROM question WHERE product_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,productNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Qa> list = new ArrayList<>();
		while(rs.next()) {
			Qa q = new Qa();
			q.setqNo(rs.getInt("q_no"));
			q.setId(rs.getString("id"));
			q.setqContent(rs.getString("q_content"));
			q.setCreatedate(rs.getString("createdate"));
			q.setUpdatedate(rs.getString("updatedate"));
			list.add(q);
		}
		return list;
	}
	
	// 2) 질문에 답변한것 출력
	public ArrayList<HashMap<String,Object>> answerList(int qNo) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT id,a_no,q_no,a_content,createdate,updatedate FROM answer WHERE q_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,qNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> a = new HashMap<>();
			a.put("id", rs.getString("id"));
			a.put("aNo",rs.getInt("a_no"));
			a.put("qNo",rs.getInt("q_no"));
			a.put("aContent", rs.getString("a_content"));
			a.put("createdate", rs.getString("createdate"));
			a.put("updatedate", rs.getString("updatedate"));
			list.add(a);
		}
		return list;
	}
	
	// 3) 답변 입력 메서드
	public int insertProductContent(int qNo, String aContent, String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO answer(q_no,a_content,id,createdate,updatedate) values(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,qNo);
		stmt.setString(2,aContent);
		stmt.setString(3,id);
		row = stmt.executeUpdate();
		
		String sql2 = "UPDATE question SET checked = 'Y' WHERE q_no = ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1,qNo);
		row = stmt2.executeUpdate();
		return row;
	}
	
	// 4) 사용자 제품문의 질문 등록 메서드
	public int insertProductQuestion(int productNo,String id, String qContent) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO question(product_no,q_content,id,createdate,updatedate) values(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,productNo);
		stmt.setString(2,qContent);
		stmt.setString(3,id);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 5) 1대1 문의 리스트 출력 메서드
	public ArrayList<HashMap<String,Object>> oneCsList(String id) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT oq_no,left(oq_content,20) oq_content ,id,oq_title,checked,createdate,updatedate FROM one_question WHERE id = ? ORDER BY updatedate DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,id);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> a = new HashMap<>();
			a.put("oqNo",rs.getInt("oq_no"));
			a.put("oqContent", rs.getString("oq_content"));
			a.put("id", rs.getString("id"));
			a.put("oqTitle", rs.getString("oq_title"));
			a.put("createdate", rs.getString("createdate"));
			a.put("updatedate", rs.getString("updatedate"));
			a.put("checked", rs.getString("checked"));
			list.add(a);
		}
		return list;
	}
	
	// 6) 1대1 문의 추가 메서드
	public int insertCsList(String id,String oqTitle, String oqContent) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO one_question(id,oq_title,oq_content,createdate,updatedate) values(?,?,?,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, oqTitle);
		stmt.setString(3, oqContent);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 7) 1대1 문의 상세페이지
	public ArrayList<HashMap<String,Object>> oneCs(int oqNo) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT oq_title,oq_content,createdate,updatedate FROM one_question WHERE oq_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,oqNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		if(rs.next()) {
			HashMap<String,Object> a = new HashMap<>();
			a.put("oqTitle", rs.getString("oq_title"));
			a.put("oqContent", rs.getString("oq_content"));
			list.add(a);
		}
		return list;
	}
	
	// 8) 답변 입력 메서드
	public int insertEtcCs(int oqNo, String oaContent, String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "INSERT INTO one_answer(oq_no,oa_content,id,checked,createdate,updatedate) values(?,?,?,0,NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,oqNo);
		stmt.setString(2,oaContent);
		stmt.setString(3,id);
		row = stmt.executeUpdate();
		
		String sql2 = "UPDATE one_question SET checked = 'N' WHERE oq_no = ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1,oqNo);
		row = stmt2.executeUpdate();
		
		return row;
	}
	
	// 8-1) 관리자 답변 입력 메서드
		public int insertEmpAnswer(int oqNo, String oaContent, String id) throws Exception {
			int row = 0;
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			
			String sql = "INSERT INTO one_answer(oq_no,oa_content,id,checked,createdate,updatedate) values(?,?,?,1,NOW(),NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1,oqNo);
			stmt.setString(2,oaContent);
			stmt.setString(3,id);
			row = stmt.executeUpdate();
			
			String sql2 = "UPDATE one_question SET checked = 'Y' WHERE oq_no = ?";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setInt(1,oqNo);
			row = stmt2.executeUpdate();
			
			return row;
		}
		
	// 9) 문의글 삭제 메서드
	public int deleteEtcCsOne(int oqNo) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM one_question WHERE oq_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,oqNo);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 10) ETC문의글 답변 조회 메서드
	public ArrayList<HashMap<String,Object>> etcAnswerList(int oqNo) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT id,oa_no,oa_content,createdate,updatedate,checked FROM one_answer WHERE oq_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,oqNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> a = new HashMap<>();
			a.put("id", rs.getString("id"));
			a.put("oaNo", rs.getInt("oa_no"));
			a.put("oaContent", rs.getString("oa_content"));
			a.put("createdate", rs.getString("createdate"));
			a.put("updatedate", rs.getString("updatedate"));
			a.put("checked", rs.getInt("checked"));
			list.add(a);
		}
		return list;
	}
	
	// 11) ETC문의글 수정 메서드
	public int updateEtcCsOne(String oqTitle,String oqContent,int oqNo) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "UPDATE one_question SET oq_title = ?, oq_content = ? WHERE oq_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,oqTitle);
		stmt.setString(2,oqContent);
		stmt.setInt(3,oqNo);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 12) 기타 문의 댓글 삭제 메서드
	public int deleteEtcAnswer(int oaNo) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM one_answer WHERE oa_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,oaNo);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 13) 제품 문의 댓글 삭제 메서드
	public int deleteProductAnswer(int aNo) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM answer WHERE a_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,aNo);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 14) 제품 문의 질문 삭제 메서드
	public int deleteProductQuestion(int qNo) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE FROM question WHERE q_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,qNo);
		row = stmt.executeUpdate();
		return row;
	}
}
