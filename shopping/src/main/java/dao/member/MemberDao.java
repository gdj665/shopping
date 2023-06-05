package dao.member;

import java.sql.*;
import java.util.*;
import util.*;
import vo.id.*;

public class MemberDao {
	
	// 회원가입시 id테이블에 데이터값 넣기
	public int insertId(String id, String pw) throws Exception{
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		
		//id테이블 데이터값 입력쿼리
		PreparedStatement idStmt = conn.prepareStatement("INSERT INTO id_list(id, last_pw, active, createdate, updatedate) values(?, PASSWORD(?), 'y', now(), now())");
		
		// id테이블값 넣기
		idStmt.setString(1, id);
		idStmt.setString(2, pw);
	
		int row1 = idStmt.executeUpdate();
		System.out.println(row1+"<-- row1");
		if(row1 == 0) {
			return row1;
		}
		// 비밀번호 이력 테이블에 데이터값 입력 쿼리
		PreparedStatement pwStmt = conn.prepareStatement("INSERT INTO pw_history(id, pw_no, createdate) values(?,PASSWORD(?),now())");
		
		pwStmt.setString(1, id);
		pwStmt.setString(2, pw);
		int row2 = pwStmt.executeUpdate();
		System.out.println(row2+"<-- row2");
		if(row2 == 0) {
			return row2;
		}
		if(row1 > 0 && row2 > 0) {
			row1 = 1;
		}
		return row;
	}
	
	// 회원가입시 고객테이블에 데이터 값 넣기
	public int insertCustomer(Customer custm) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		
		// 고객 테이블 데이터 값 입력 쿼리
		
		PreparedStatement customerStmt = conn.prepareStatement("INSERT INTO customer(id, cstm_name, cstm_address, cstm_email, cstm_birth, cstm_gender, cstm_phone"
				+ "cstm_rank, cstm_point, cstm_agree, cstm_last_login, createdate, updatedate) "
				+ "values(?,?,?,?,?,?,?,'BRONZE',0,?,now(),now())");
		
		customerStmt.setString(1, custm.getId());
		customerStmt.setString(2, custm.getCstmName());
		customerStmt.setString(3, custm.getCstmAddress());
		customerStmt.setString(4, custm.getCstmEmail());
		customerStmt.setString(5, custm.getCstmBirth());
		customerStmt.setString(6, custm.getCstmGender());
		customerStmt.setString(7, custm.getCstmPhone());
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
		PreparedStatement stmt = conn.prepareStatement("UPDATE customer SET cstm_name, cstm_address = ?, cstm_email = ? updatedate = now() WHERE id = ? ");
		stmt.setString(1, custm.getCstmName());
		stmt.setString(2, custm.getCstmAddress());
		stmt.setString(3, custm.getCstmEmail());
		stmt.setString(4, custm.getId());
		
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 로그인
	public int login(IdList list) throws Exception {
		int row = 0;
		// 아이디 활성화여부
		String active = "";
		
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("SELECT id, active FROM id_list WHERE id = ? AND last_pw = PASSWORD(?)");
		stmt.setString(1, list.getId());
		stmt.setString(2, list.getLastPw());
		row = stmt.executeUpdate();
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			active = rs.getString("");
			return row;
			
		}
		
		//활성화가 y인지 n인지 확인하기
		if(active.equals('1')) {
			// 고객로그인시 마지막 로그인일자 업데이트
			PreparedStatement activeStmt = conn.prepareStatement("SELECT count(*) FROM customer WHERE id = ?");
			activeStmt.setString(1, list.getId());
			ResultSet activeRs = activeStmt.executeQuery();
			int cnt = 0;
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
			if(cnt>0) {
				PreparedStatement csLoginStmt = conn.prepareStatement("UPDATE customer set cstm_last_login = now() WHERE id = ?");
				stmt.setString(1, list.getId());
				System.out.println("로그인날짜 업데이트");
			}
		} else if(active.equals('1')) {
			return row;
		}
		
		
		// 관리자 로그인
		
		String level = "";
		
		PreparedStatement levelStmt = conn.prepareStatement("SELECT emp_name empName, emp_level empLevel, "
				+ "count(*) FROM employees WHERE id=? ");
		ResultSet levelRs = levelStmt.executeQuery();
		if(level.equals(1)) {
			System.out.println("1등급 관리자 입니다");
		} else if(level.equals(2)) {
			System.out.println("2등급 관리자 입니다");
		} else {
			System.out.println("3등급 관리자 입니다");
		}
		
		return row;
		
	}
	
	// 관리자 로그인
	public int adminLogin(String id) {
	    int level = 0;

	    try {
	        Connection conn = null;
			@SuppressWarnings("null")
			PreparedStatement levelStmt = conn.prepareStatement("SELECT emp_level FROM employees WHERE id = ?");
	        levelStmt.setString(1, id);
	        ResultSet levelRs = levelStmt.executeQuery();

	        if (levelRs.next()) {
	            level = levelRs.getInt("emp_level");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        // 오류 처리 로직 추가
	    }

	    if (level == 1) {
	        System.out.println("1등급 관리자입니다.");
	    } else if (level == 2) {
	        System.out.println("2등급 관리자입니다.");
	    } else {
	        System.out.println("3등급 관리자입니다.");
	    }

	    return level;
	}
	
	// 회원 비밀번호 변경시 이전 사용한 비밀번호인지 체크하기
	public int checkPwList(IdList list) throws Exception {
		int pwCheckRow = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("SELECT count(*) FROM pw_history WHERE id = ? AND last_pw = PASSWORD(?)");
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
		// 비밀번호 이력 갯수
		int cnt = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		// 비밀번호 id_list 테이블에 입력
		PreparedStatement stmt = conn.prepareStatement("UPDATE id_List SET last_pw = PASSWORD(?) WHERE id = ?");
		stmt.setString(1, list.getId());
		stmt.setString(2, list.getLastPw());
		idListRow = stmt.executeUpdate();
		// 비밀번호 이력 데이터값 추가
		PreparedStatement pwHistoryStmt = conn.prepareStatement("INSERT INTO pw_history(id, pw_no, createdate) values(?,PASSWORD(?),now())");
		pwHistoryStmt.setString(1, list.getId());
		pwHistoryStmt.setString(2, list.getLastPw());
		
		PreparedStatement cntStmt = conn.prepareStatement("SELECT count(*) FROM pw_history WHERE id = ?");
		cntStmt.setString(1, list.getId());
		ResultSet rs = cntStmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		if(cnt > 3) {
			
		// 비밀번호 이력 3개 이상이면 삭제
			
		PreparedStatement historyDelStmt = conn.prepareStatement("DELETE FROM pw_history WHERE id = ? "
				+ "AND createdate =  SELECT MIN(createdate) FROM pw_history WHERE id = ?)");
		
		historyDelStmt.setString(1, list.getId());
		historyDelStmt.setString(2, list.getLastPw());
		int pwHistoryDeleteRow = historyDelStmt.executeUpdate();
		System.out.println(pwHistoryDeleteRow+"<--pwHistoryDeleteRow 비밀번호 이력이 3개 이상이므로 삭제 제일 오래된 비밀번호 삭제완료");
		}
		return idListRow;
	}
	
	// 비밀번호 확인
	
	public int ckPw(IdList list) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("SELECT count(*) FROM id_list WHERE id = ? AND last_pw = PASSWORD(?)");
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
		
		PreparedStatement stmt = conn.prepareStatement("SELECT cstm_name cstmName, cstm_address cstmAddress, cstm_email cstmEmail, "
				+ "cstm_birth cstmBirth, cstm_rank cstmRank, cstm_point cstmPoint, createdate "
				+ "FROM customer WHERE id = ?");
		
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
	
	
	// 고객 포인트 내역조회
	public ArrayList<HashMap<String, Object>> cstmPointList(int beginRow, int rowPerPage, String id) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		
		PreparedStatement stmt =conn.prepareStatement( "SELECT p.order_no orderNo, p.point point, p.createdate createdate "
				+ "FROM customer c INNER JOIN orders o ON  c.id = o.id INNER JOIN point_history p ON o.order_no = p.order_no "
				+ "WHERE c.id = ? ORDER BY p.createdate DESC LIMIT ?,? ");
	
		stmt.setString(1, id);
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("orderNo",rs.getInt("orderNo"));
			m.put("point", rs.getInt("point"));
			m.put("createdate", rs.getString("createdate"));
			list.add(m);
		}
		return list;
	}
	
	//고객당 포인트리스트 행 총 갯수 조회
	public int selectPointRow(String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM customer c INNER JOIN orders o ON  c.id = o.id INNER JOIN point_history p ON o.order_no = p.order_no WHERE c.id = ? ORDER BY p.createdate DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("count(*)");
		}
			return row;
		}
	//모든 고객의 리스트 행의 수 조회
	public int pointRow() throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM customer";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
			return row;
		}
	
	// 주문내역
	public ArrayList<HashMap<String, Object>> orderList(String id, int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
	
		PreparedStatement stmt = conn.prepareStatement("SELECT o.order_no orderNo, p.product_No productNo, o.order_status orderStatus, o.order_cnt orderCnt, o.order_price orderPrice, o.createdate createdate "
				+ "FROM customer c INNER JOIN orders o ON c.id = o.id INNER JOIN product p ON p.product_no = o.product_no "
				+ "WHERE c.id = ? ORDER BY o.updatedate LIMIT ?,?");
		
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
	// 총 행의 수 구하기
	
	public int orderCnt() throws Exception {
		int row = 0;
		
		DBUtil dbUtil = new DBUtil();
		
		Connection conn = dbUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM orders");
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		
		return row;
	}
	
}
