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
		
		// 기존 아이디와 중복체크
		PreparedStatement ckIdStmt = conn.prepareStatement("SELECT COUNT(*) FROM id_list where id = ?");
		ckIdStmt.setString(1, id);
		ResultSet rs = ckIdStmt.executeQuery();
		int row1 = 0;
		if(rs.next()) {
			row1 = rs.getInt(1);
		}
		
		if(row1 == 0) {
		
		//id테이블 데이터값 입력쿼리
		PreparedStatement idStmt = conn.prepareStatement("INSERT INTO id_list(id, last_pw, active, createdate) values(?, PASSWORD(?), 1, now())");
		idStmt.setString(1, id);
		idStmt.setString(2, pw);
		int row2 = idStmt.executeUpdate();
		System.out.println(row2);
		
		
		// 비밀번호 이력 테이블에 비밀번호 입력
		PreparedStatement pwStmt = conn.prepareStatement("INSERT INTO pw_history(id, pw, createdate) values(?,PASSWORD(?),now())");
		pwStmt.setString(1, id);
		pwStmt.setString(2, pw);
		int row3 = pwStmt.executeUpdate();
		System.out.println(row3);
		
		if(row2 > 0 && row3 > 0) {
			row = 2;
			}
		}
		if(row1 > 0) {
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
		
		PreparedStatement customerStmt = conn.prepareStatement("INSERT INTO customer(id, cstm_name, cstm_address, cstm_email, cstm_birth, cstm_gender, cstm_phone,"
				+ "cstm_rank, cstm_point, cstm_agree, cstm_last_login, createdate, updatedate)"
				+ "values(?,?,?,?,?,?,?,'BRONZE',0,?,now(),now(),now())");
		
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
		PreparedStatement stmt = conn.prepareStatement("UPDATE customer SET cstm_name = ?, cstm_address = ?, cstm_email = ?, cstm_phone = ?, updatedate = now() WHERE id = ? ");
		stmt.setString(1, custm.getCstmName());
		stmt.setString(2, custm.getCstmAddress());
		stmt.setString(3, custm.getCstmEmail());
		stmt.setString(4, custm.getCstmPhone());
		stmt.setString(5, custm.getId());
		
		row = stmt.executeUpdate();
		
		return row;
	}
	
	
	// 회원 비밀번호 변경시 이전 사용한 비밀번호인지 체크하기
	public int checkPwList(IdList list) throws Exception {
		int pwCheckRow = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM pw_history WHERE id = ? AND pw = ?");
		stmt.setString(1, list.getId());
		stmt.setString(2, list.getLastPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			pwCheckRow = rs.getInt(1);
		}
		return pwCheckRow;
	}
		
	// 회원 비밀번호 변경
	public int updatePw(IdList idList) throws Exception {
		//아이디 쿼리 실행값 변수
		int idListRow = 0;
		// 비밀번호 이력 갯수
		int cnt = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
			
		// 비밀번호 id_list 테이블에 입력
		PreparedStatement stmt = conn.prepareStatement("UPDATE id_list SET last_pw = ?, createdate = now() WHERE id = ?");
		stmt.setString(1, idList.getLastPw());
		stmt.setString(2, idList.getId());
		idListRow = stmt.executeUpdate();
		
		// 비밀번호 이력 데이터값 추가
		PreparedStatement pwHistoryStmt = conn.prepareStatement("INSERT INTO pw_history(id, pw, createdate) values(?,?,now())");
		pwHistoryStmt.setString(1, idList.getId());
		pwHistoryStmt.setString(2, idList.getLastPw());
		
		// 비밀번호 이력 데이터값 갯수 새기
		PreparedStatement pwCntStmt = conn.prepareStatement("SELECT count(*) FROM pw_history WHERE id = ?");
		pwCntStmt.setString(1, idList.getId());
		ResultSet rs = pwCntStmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		if(cnt > 3) {
			
		// 비밀번호 이력 3개 이상이면 삭제
		String historyDelSql = "DELETE FROM pw_history WHERE id = ? AND createdate =  SELECT MIN(createdate) FROM pw_history WHERE id = ?)";
		PreparedStatement historyDelStmt = conn.prepareStatement(historyDelSql);
		historyDelStmt.setString(1, idList.getId());
		historyDelStmt.setString(2, idList.getId());
		int pwHistoryDeleteRow = historyDelStmt.executeUpdate();
		System.out.println(pwHistoryDeleteRow);
		
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
		
	// 로그인
	public int login(IdList id) throws Exception {
		int row = 0;
		int ckId = 0;
		int active = 0;
		int ckLogin = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM id_list WHERE id = ?");
		stmt.setString(1, id.getId());
		stmt.setString(2, id.getLastPw());
		ResultSet loginRs = stmt.executeQuery();
		if(loginRs.next()) {
			ckId=loginRs.getInt(1);
		}
		if(ckId==0) {
			row = 4;
			return row;
		} else if(ckId>0) {
			PreparedStatement ckActiveStmt = conn.prepareStatement("SELECT active FROM id_list WHERE id = ?");
			ckActiveStmt.setString(1, id.getId());
			ResultSet ckActiveRs = ckActiveStmt.executeQuery();
			if(ckActiveRs.next()) {
				active = ckActiveRs.getInt("active");
			}
			
			// 사용 가능로그인
			if(active==1) {
				PreparedStatement falStmt = conn.prepareStatement("SELECT COUNT(*) FROM id_list WHERE id = ? AND last_pw = PASSWORD(?) AND active = ?");
				falStmt.setString(1, id.getId());
				falStmt.setString(2, id.getLastPw());
				falStmt.setInt(3,active);
				System.out.println("getId-->"+id.getId());
				System.out.println("getLastPw-->"+id.getLastPw());
				System.out.println("getActive-->"+id.getActive());
				ResultSet falRs = falStmt.executeQuery();
				if(falRs.next()) {
					ckLogin = falRs.getInt(1);
					System.out.println("ckLogin-->"+ckLogin);
					if(ckLogin==1) {
						row = 1;
					}
				}
				PreparedStatement csLoginStmt = conn.prepareStatement("UPDATE customer SET cstm_last_login = now() WHERE id = ?");
				csLoginStmt.setString(1, id.getId());
				int upRow = csLoginStmt.executeUpdate();
				if(upRow > 0 ) {
					System.out.println("고객 마지막로그인 업데이트");
				}else if(upRow == 0) {
					System.out.println("관리자입니다");
				}
			// 휴면계정
			} else if (active==2) {
				PreparedStatement falStmt2 = conn.prepareStatement("SELECT COUNT(*) FROM id_list WHERE id = ? AND last_pw = PASSWORD(?) AND active = ?");
				falStmt2.setString(1, id.getId());
				falStmt2.setString(2, id.getLastPw());
				falStmt2.setInt(3, active);
				ResultSet falRs2 = falStmt2.executeQuery();
				if(falRs2.next()) {
					ckLogin = falRs2.getInt(1);
					if(ckLogin==1) {
						row = 2;
					}
				}
			// 탈퇴 계정
			} else if (active==3) {
				PreparedStatement falStmt3 = conn.prepareStatement("SELECT COUNT(*) FROM id_list WHERE id = ? AND last_pw = PASSWORD(?) AND active = ?");
				falStmt3.setString(1, id.getId());
				falStmt3.setString(2, id.getLastPw());
				falStmt3.setInt(3, active);
				ResultSet falRs3 = falStmt3.executeQuery();
				if(falRs3.next()) {
					if(falRs3.next()) {
						ckLogin = falRs3.getInt(1);
						if(ckLogin==1) {
							row = 3;
						}
					}
				}
			}
		}
		System.out.println("login row값-->"+row);
		return row;
	}
  
	// 로그인 test
	public int exlogin(IdList id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM id_list WHERE id = ? AND last_pw = PASSWORD(?) AND active = 1");
		stmt.setString(1, id.getId());
		stmt.setString(2, id.getLastPw());
		ResultSet loginRs = stmt.executeQuery();
		if(loginRs.next()) {
			row=loginRs.getInt(1);
		}
		
		if(row > 0) {
			PreparedStatement csLoginStmt = conn.prepareStatement("UPDATE customer SET cstm_last_login = now() WHERE id = ?");
			csLoginStmt.setString(1, id.getId());
			int upRow = csLoginStmt.executeUpdate();
			if(upRow > 0 ) {
				System.out.println("고객 마지막로그인 업데이트");
			}else if(upRow == 0) {
				System.out.println("관리자입니다");
			}
		return row;
		}
		
		if(row == 0) {
			PreparedStatement falStmt = conn.prepareStatement("SELECT COUNT(*) FROM id_list WHERE id = ? AND last_pw = PASSWORD(?) AND active = 2");
			falStmt.setString(1, id.getId());
			falStmt.setString(2, id.getLastPw());
			ResultSet rs = falStmt.executeQuery();
			if(rs.next()) {
				row = 3;
			}
		}
		return row;
	}
	   
	// 아이디 확인
	public int loginCstmId(IdList idList) throws Exception {
		int cnt = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM id_list WHERE id = ?");
		stmt.setString(1, idList.getId());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		return cnt;
	}
	
	// 사원아이디 확인
	
	public int loginEmpId(IdList idList) throws Exception {
		int empCnt = 0;
		DBUtil dbUtil = new DBUtil(); 
		
		Connection conn =  dbUtil.getConnection();
		String sql = "SELECT count(*) FROM employees WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, idList.getId());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			empCnt = rs.getInt(1);
		}
		return empCnt;
	}
	
	// 관리자 레벨 확인
	
	public String loginEmpLevel(IdList idList) throws Exception{
		String level = "";
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM employees WHERE id = ? AND emp_level = '2'");
		stmt.setString(1, idList.getId());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		if(row > 0) {
			level = "2";
		} else if(row == 0) {
			PreparedStatement stmt2 = conn.prepareStatement("SELECT COUNT(*) FROM employees WHERE id = ? AND emp_level = '1'");
			stmt2.setString(1, idList.getId());
			ResultSet rs2 = stmt2.executeQuery();
			if(rs2.next()) {
				row = rs2.getInt(1);
			}
			if(row > 0) {
				level = "1";
			}
		}
		
		return level;
	}
	
	
	// 고객 마이페이지
	public HashMap<String, Object> selectCstmList(String id) throws Exception{
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement("SELECT id cstmId, cstm_name cstmName, cstm_address cstmAddress, cstm_email cstmEmail, "
				+ "cstm_birth cstmBirth, cstm_phone cstmPhone, cstm_rank cstmRank, cstm_point cstmPoint, createdate "
				+ "FROM customer WHERE id = ?");
		
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		
		HashMap<String, Object> m = new HashMap<String, Object>();
		if(rs.next()) {
			m.put("cstmId", rs.getString("cstmId"));
			m.put("cstmName", rs.getString("cstmName"));
			m.put("cstmAddress", rs.getString("cstmAddress"));
			m.put("cstmEmail", rs.getString("cstmEmail"));
			m.put("cstmBirth", rs.getString("cstmBirth"));
			m.put("cstmPhone", rs.getString("cstmPhone"));
			m.put("cstmRank", rs.getString("cstmRank"));
			m.put("cstmPoint", rs.getInt("cstmPoint"));
			m.put("createdate", rs.getString("createdate"));
			
		}
		return m;
	}
	
	// 회원 탈퇴
	public int deleteCustm(String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn =  dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement("UPDATE id_list SET active = 3 WHERE id = ?");
		stmt.setString(1, id);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 아이디중복체크
	public boolean checkIdDuplication(String id) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean isDuplicated = false;

        try {
        	DBUtil dbUtil = new DBUtil(); 
            conn =  dbUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM customer WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                isDuplicated = (count > 0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        }

        return isDuplicated;
    }
	
	
	
}
