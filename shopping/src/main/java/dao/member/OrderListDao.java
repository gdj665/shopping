package dao.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.order.Orders;
import vo.order.OrdersHistory;

public class OrderListDao {
		// 주문내역
		public ArrayList<HashMap<String, Object>> orderListA(String id, int beginRow, int rowPerPage) throws Exception{
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
		// 주문 상세보기
		public ArrayList<HashMap<String, Object>> orderOne(int orderNo) throws Exception{
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			DBUtil dbUtil = new DBUtil(); 
			Connection conn =  dbUtil.getConnection();
			
			PreparedStatement stmt = conn.prepareStatement("SELECT i.product_save_filename saveFile, o.order_no orderNo, p.product_name productName, p.product_price productPrice, \r\n"
					+ "r.order_status orderStatus, o.createdate createdate \r\n"
					+ "FROM customer c \r\n"
					+ "INNER JOIN orders r ON c.id = r.id\r\n"
					+ "INNER JOIN orders_history o ON r.order_no = o.order_no\r\n"
					+ "INNER JOIN product p ON p.product_no = o.product_no\r\n"
					+ "INNER JOIN product_img i ON i.product_no = p.product_no\r\n"
					+ "WHERE o.order_no = ?\r\n"
					+ "ORDER BY o.createdate DESC");
			
			stmt.setInt(1, orderNo);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("saveFile", rs.getString("saveFile"));
				m.put("orderNo", rs.getInt("orderNo"));
				m.put("productName", rs.getString("productName"));
				m.put("productPrice", rs.getInt("productPrice"));
				m.put("orderStatus", rs.getInt("orderStatus"));
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
				
					PreparedStatement stmt = conn.prepareStatement("SELECT o.id, o.order_no orderNo, o.order_status orderStatus, \r\n"
							+ "o.order_price orderPrice, o.order_point_use orderPointUse,\r\n"
							+ "       (o.order_price - o.order_point_use)  totalPrice,\r\n"
							+ "       o.createdate createdate,\r\n"
							+ "       GROUP_CONCAT(p.product_name) productName\r\n"
							+ "FROM orders o\r\n"
							+ "INNER JOIN orders_history oh ON o.order_no = oh.order_no\r\n"
							+ "INNER JOIN product p ON p.product_no = oh.product_no\r\n"
							+ "WHERE o.order_status NOT IN (0) AND o.id = ?\r\n"
							+ "GROUP BY o.order_no\r\n"
							+ "ORDER BY o.createdate DESC");
					
					stmt.setString(1, id);
					stmt.setInt(2, beginRow);
					stmt.setInt(3, rowPerPage);
					ResultSet rs = stmt.executeQuery();
						while(rs.next()) {
						HashMap<String, Object> m = new HashMap<String, Object>();
						m.put("orderNo", rs.getInt("orderNo"));
						m.put("orderStatus", rs.getInt("orderStatus"));
						m.put("orderPrice", rs.getInt("orderPrice"));
						m.put("orderPointUse", rs.getInt("orderPointUse"));
						m.put("createdate", rs.getString("createdate"));
						m.put("productName", rs.getString("productName"));
						m.put("totalPrice", rs.getInt("totalPrice"));
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
