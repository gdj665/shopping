package dao.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class OrderListDao {
		// 주문내역
		public ArrayList<HashMap<String, Object>> orderList(String id, int beginRow, int rowPerPage) throws Exception{
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
		
			PreparedStatement stmt = conn.prepareStatement("SELECT o.order_no orderNo, p.product_No productNo, o.order_cnt orderCnt, o.createdate createdate \r\n"
					+ "FROM customer c INNER JOIN orders_history o ON c.id = o.orders_history_no\r\n"
					+ "INNER JOIN product p ON p.product_no = o.product_no \r\n"
					+ "WHERE c.id = ? ORDER BY o.createdate LIMIT ?,?");
			
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
			
			DBUtil dbUtil =
	new DBUtil();
			
			Connection conn = dbUtil.getConnection();
			
			PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM orders");
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				row = rs.getInt(1);
			}
			
			return row;
		}

}
