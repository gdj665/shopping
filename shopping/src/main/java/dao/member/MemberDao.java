package dao.member;


import java.sql.*;
import java.util.*;
import util.*;
import vo.id.*;

public class MemberDao {
	
	// 회원가입시 id테이블에 데이터값 넣기
	public int insertId(String id, String lastPw) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		//id테이블 데이터값 입력쿼리
		String idSql = "INSERT INTO id_list(id, last_pw, active, createdate, updatedate) values(?, PASSWORD(?), 'y', now(), now())";
		// 비밀번호 이력 테이블에 데이터값 입력 쿼리
		String pwSql = "INSERT INTO pw_history(id, pw_no, createdate) values(?,PASSWORD(?),now())";
		// id테이블 벨류값 넣기
		PreparedStatement  idStmt = conn.prepareStatement(idSql);
		idStmt.setString(1, id);
		idStmt.setString(2, lastPw);
		int row1 = idStmt.executeUpdate();
		System.out.println(row1+"<-- row1");
		if(row1 == 0) {
			return row1;
		}
		PreparedStatement pwStmt = conn.prepareStatement(pwSql);
		pwStmt.setString(1, id);
		pwStmt.setString(2, lastPw);
		int row2 = pwStmt.executeUpdate();
		System.out.println(row2+"<-- row2");
		if(row2 == 0) {
			return row2;
		}
		if(row1 > 0 && row2 > 0) {
			row = 1;
		}
		return row;
	}
	
	// 회원가입시 고객테이블에 데이터 값 넣기
	public int insertCustomer(Customer custm) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		
		// 고객 테이블 데이터 값 입력 쿼리
		String customerSql = "INSERT INTO customer(id, cstm_name, cstm_address, cstm_email, cstm_birth, cstm_phone, cstm_gender, cstm_rank, cstm_point, cstm_agress, createdate, updatedate) values(?,?,?,?,?,?,?,'BRONZE',0,?,now(),now())";
		
		PreparedStatement customerStmt = conn.prepareStatement(customerSql);
		customerStmt.setString(1, custm.getId());
		customerStmt.setString(2, custm.getCstmName());
		customerStmt.setString(3, custm.getCstmAddress());
		customerStmt.setString(4, custm.getCstmEmail());
		customerStmt.setString(5, custm.getCstmBirth());
		customerStmt.setString(6, custm.getCstmAgree());
		customerStmt.setString(7, custm.getCstmGender());
		customerStmt.setString(8, custm.getCstmAgree());
		row = customerStmt.executeUpdate();
		return row;
	}
	
	// 회원정보 수정
	public int updateCustomer(Customer custm) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// 고객 테이블 데이터값 수정 쿼리
		String customerSql = "UPDATE customer SET cstm_address = ?, cstm_email = ?, cstm_phone = ? updatedate = now() WHERE id = ? ";
		PreparedStatement stmt = conn.prepareStatement(customerSql);
		stmt.setString(1, custm.getCstmAddress());
		stmt.setString(2, custm.getCstmEmail());
		stmt.setString(3, custm.getCstmAgree());
		stmt.setString(4, custm.getId());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 로그인
	public int login(IdList id) throws Exception {
		int row = 0;
		// 아이디 활성화여부
		String active = "";
		
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("SELECT id, active FROM id_list WHERE id = ? AND last_pw = PASSWORD(?)");
		stmt.setString(1, id.getId());
		stmt.setString(2, id.getLastPw());
		row = stmt.executeUpdate();
		ResultSet acRs = stmt.executeQuery();
		if(acRs.next()) {
			active = acRs.getString(2);
		}
		//활성화가 y인지 n인지 확인하기
		if(active.equals('y')) {
			// 고객로그인시 마지막 로그인일자 업데이트
			PreparedStatement csIdStmt = conn.prepareStatement("SELECT count(*) FROM customer WHERE id = ?");
			csIdStmt.setString(1, id.getId());
			ResultSet rs = csIdStmt.executeQuery();
			int cnt = 0;
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			if(cnt>0) {
				PreparedStatement csLoginStmt = conn.prepareStatement("UPDATE customer set cstm_last_login = now() WHERE id = ?");
				stmt.setString(1, id.getId());
				System.out.println("로그인날짜 업데이트");
			}
		} else if(active.equals('y')) {
			return row = 0;
		}
		return row;
		
	}
	
	// 회원 비밀번호 변경시 이전 사용한 비밀번호인지 체크하기
	public int checkPwList(IdList list) throws Exception {
		int pwCheckRow = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM pw_history WHERE id = ? AND last_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, list.getId());
		stmt.setString(2, list.getLastPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			pwCheckRow = rs.getInt(1);
		}
		return pwCheckRow;
	}
	
	// 회원 비밀번호 변경
	public int updateIdList(IdList list) throws Exception {
		//아이디 쿼리 실행값 변수
		int idListRow = 0;
		// 비밀번호 이력 쿼리 실행값
		int pwHistoryRow = 0;
		// 비밀번호 이력 갯수
		int cnt = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// 비밀번호 id_list 테이블에 입력
		String sql = "UPDATE id_List SET last_pw = PASSWORD(?) WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, list.getId());
		stmt.setString(2, list.getLastPw());
		idListRow = stmt.executeUpdate();
		// 비밀번호 이력 데이터값 추가
		String pwHistortSql = "INSERT INTO pw_history(id, pw_no, createdate) values(?,PASSWORD(?),now())";
		PreparedStatement pwHistoryStmt = conn.prepareStatement(pwHistortSql);
		pwHistoryStmt.setString(1, list.getId());
		pwHistoryStmt.setString(2, list.getLastPw());
		pwHistoryRow = pwHistoryStmt.executeUpdate();
		// 비밀번호 이력 데이터값 갯수 새기
		String cntSql = "  SELECT count(*) FROM pw_history WHERE id = ?";
		PreparedStatement cntStmt = conn.prepareStatement(cntSql);
		cntStmt.setString(1, list.getId());
		ResultSet rs = cntStmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		if(cnt > 3) {
			
		// 비밀번호 이력 3개 이상이면 삭제
			
		String historyDelSql = "DELETE FROM pw_history WHERE id = ? AND createdate =  SELECT MIN(createdate) FROM pw_history WHERE id = ?)";
		PreparedStatement historyDelStmt = conn.prepareStatement(historyDelSql);
		historyDelStmt.setString(1, list.getId());
		historyDelStmt.setString(2, list.getId());
		int pwHistoryDeleteRow = historyDelStmt.executeUpdate();
		System.out.println(pwHistoryDeleteRow+"<--pwHistoryDeleteRow 비밀번호 이력이 3개 이상이므로 삭제 제일 오래된 비밀번호 삭제완료");
		}
		return idListRow;
	}
	
	// 비밀번호 맞는지 확인
	
	public int ckPw(IdList list) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM id_list WHERE id = ? AND last_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, list.getId());
		stmt.setString(2, list.getLastPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}	
		return row;
	}
	// 고객 마이페이지
	public ArrayList<HashMap<String, Object>> selectCstmList(String id) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT cstm_name cstmName, cstm_address cstmAddress, cstm_email cstmEmail, cstm_birth cstmBirth, cstm_rank cstmRank, cstm_point cstmPoint, createdate "
				+ "FROM customer WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cstmName", rs.getString("cstmName"));
			m.put("cstmAddress", rs.getString("cstmAddress"));
			m.put("cstmEmail", rs.getString("cstmEmail"));
			m.put("cstmBirth", rs.getString("cstmBirth"));
			m.put("cstmRank", rs.getString("cstmRank"));
			m.put("cstmPoint", rs.getInt("cstmPoint"));
			m.put("createdate", rs.getString("createdate"));
			list.add(m);
			
		}
		return list;
	}
	// 회원 탈퇴
	public int deleteCustm(String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "UPDATE id_list SET active = 'n' updatedate = now() WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 관리자가 모든 고객 포인트 내역 조회 
	public ArrayList<HashMap<String, Object>> pointList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT id 고객아이디,cstm_point 포인트 FROM customer LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("고객아이디", rs.getString("고객아이디"));
			m.put("포인트", rs.getInt("포인트"));
			list.add(m);
		}
		return list;
	}
	// 고객 포인트 내역조회
	public ArrayList<HashMap<String, Object>> cstmPointList(int beginRow, int rowPerPage, String id) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "  SELECT p.order_no orderNo, p.point_pm pointPm, p.point point, p.createdate createdate "
				+ "FROM customer c INNER JOIN orders o ON  c.id = o.id INNER JOIN point_history p ON o.order_no = p.order_no "
				+ "WHERE c.id = ? ORDER BY p.createdate DESC LIMIT ?,? ";
		PreparedStatement stmt =conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("orderNo",rs.getInt("orderNo"));
			m.put("pointPm", rs.getString("pointPm"));
			m.put("point", rs.getInt("point"));
			m.put("createdate", rs.getString("createdate"));
			list.add(m);
		}
		return list;
	}
	// 주문내역
	public ArrayList<HashMap<String, Object>> orderList(String id, int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT o.order_no orderNo, p.product_name productName, o.order_status orderStatus, o.order_cnt orderCnt, o.order_price orderPrice, o.createdate createdate "
				+ "FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN product p ON p.product_no = o.product_no "
				+ "WHERE c.id = ? ORDER BY o.updatedate LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("orderNo", rs.getString("orderNo"));
			m.put("productName", rs.getString("productName"));
			m.put("orderStatus", rs.getString("orderStatus"));
			m.put("orderCnt", rs.getInt("orderCnt"));
			m.put("orderPrice", rs.getInt("orderPrice"));
			m.put("createdate", rs.getString("createdate"));
			list.add(m);
		}
		return list;
	}
	
}
