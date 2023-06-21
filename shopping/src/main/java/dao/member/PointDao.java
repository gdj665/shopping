package dao.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class PointDao {
		// 고객 포인트 내역조회
		public ArrayList<HashMap<String, Object>> cstmPointList(int beginRow, int rowPerPage, String id) throws Exception{
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			
			PreparedStatement stmt =conn.prepareStatement( "SELECT p.order_no orderNo, p.point_pm pointPm, p.point point, p.createdate createdate "
					+ "FROM customer c "
					+ "INNER JOIN orders o ON  c.id = o.id "
					+ "INNER JOIN point_history p ON o.order_no = p.order_no "
					+ "INNER JOIN orders_history h ON h.order_no = o.order_no "
					+ "WHERE c.id = ? ORDER BY p.createdate DESC LIMIT ?,? ");
		
			stmt.setString(1, id);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("orderNo",rs.getInt("orderNo"));
				m.put("pointPm",rs.getString("pointPm"));
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
			String sql = "SELECT count(*) FROM customer c INNER JOIN orders o ON  c.id = o.id "
					+ "INNER JOIN point_history p ON o.order_no = p.order_no WHERE c.id = ? ORDER BY p.createdate DESC";
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

}
