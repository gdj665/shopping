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
		
			PreparedStatement stmt = conn.prepareStatement("SELECT i.product_save_filename saveFile, o.order_no orderNo, p.product_name productName, p.product_price productPrice, o.order_cnt orderCnt, o.createdate createdate \r\n"
					+ "FROM customer c \r\n"
					+ "INNER JOIN orders r ON c.id = r.id\r\n"
					+ "INNER JOIN orders_history o ON r.order_no = o.order_no\r\n"
					+ "INNER JOIN product p ON p.product_no = o.product_no\r\n"
					+ "INNER JOIN product_img i ON i.product_no = p.product_no\r\n"
					+ "WHERE c.id = ? \r\n"
					+ "ORDER BY o.createdate DESC LIMIT ?,?");
			
			stmt.setString(1, id);
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("saveFile", rs.getString("saveFile"));
				m.put("orderNo", rs.getInt("orderNo"));
				m.put("productName", rs.getString("productName"));
				m.put("productPrice", rs.getInt("productPrice"));
				m.put("orderCnt", rs.getInt("orderCnt"));
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
