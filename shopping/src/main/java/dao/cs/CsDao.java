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
		
		String sql = "SELECT id,q_no,a_content,createdate,updatedate FROM answer WHERE q_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,qNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> a = new HashMap<>();
			a.put("id", rs.getString("id"));
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
		return row;
	}
}
