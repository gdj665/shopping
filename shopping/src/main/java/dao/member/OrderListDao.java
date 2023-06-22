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
					+ "o.order_cnt orderCnt, o.createdate createdate \r\n"
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
				m.put("orderCnt", rs.getInt("orderCnt"));
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
				
					PreparedStatement stmt = conn.prepareStatement("SELECT o.id id, o.order_no orderNo, o.order_status orderStatus, o.order_price orderPrice, \r\n"
							+ "o.order_point_use orderPointUse, o.createdate createdate, \r\n"
							+ "GROUP_CONCAT(p.product_name) productName\r\n"
							+ "FROM orders o inner join orders_history oh\r\n"
							+ "ON o.order_no = oh.order_no\r\n"
							+ "INNER JOIN product p\r\n"
							+ "ON p.product_no = oh.product_no\r\n"
							+ "WHERE order_status NOT IN(0) AND id = ?\r\n"
							+ "GROUP BY o.order_no\r\n"
							+ "ORDER BY createdate DESC");
					
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
						list.add(m);
					}
					return list;
				}
		
		// 구매 내역 출력
		public ArrayList<Orders> orderOnetest() throws Exception{
			System.out.println("ordersList");
			DBUtil DBUtil = new DBUtil();
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement("SELECT i.product_save_filename saveFile, o.order_no orderNo, p.product_name productName, p.product_price productPrice, \r\n"
					+ "o.order_cnt orderCnt, o.createdate createdate \r\n"
					+ "FROM customer c \r\n"
					+ "INNER JOIN orders r ON c.id = r.id\r\n"
					+ "INNER JOIN orders_history o ON r.order_no = o.order_no\r\n"
					+ "INNER JOIN product p ON p.product_no = o.product_no\r\n"
					+ "INNER JOIN product_img i ON i.product_no = p.product_no\r\n"
					+ "WHERE o.order_no = ?\r\n"
					+ "ORDER BY o.createdate DESC");
			ResultSet rs = stmt.executeQuery();
			ArrayList<Orders> ordersList = new ArrayList<>();
			ArrayList<OrdersHistory> ordersHistoryList = new ArrayList<>();
			while(rs.next()) {
				Orders o = new Orders();
				o.setId(rs.getString("id"));
				o.setOrderNo(rs.getInt("orderNo"));
				o.setOrderStatus(rs.getInt("orderStatus"));
				o.setOrderPrice(rs.getInt("orderPrice"));
				o.setOrderPointUse(rs.getInt("orderPointUse"));
				o.setCreatedate(rs.getString("createdate"));
				ordersHistoryList = ordersHistoryList(o.getOrderNo());
				o.setOrdersHistoryList(ordersHistoryList);
				ordersList.add(o);
//				System.out.println("checkList");
			}
//			System.out.println(ordersList.size() + " <- ordersList.size");
			return ordersList;
		}
		
		
		// 구매 내역 출력 where order_status = ?
		public ArrayList<Orders> ordersList(int orderStatus) throws Exception{
			System.out.println("ordersList with orderStatus");
			DBUtil DBUtil = new DBUtil();
			Connection conn = DBUtil.getConnection();
			String sql = "SELECT id, order_no orderNo, order_status orderStatus, order_price orderPrice, order_point_use orderPointUse, createdate\r\n"
					+ "FROM orders\r\n"
					+ "WHERE order_status = ?\r\n"
					+ "ORDER BY createdate DESC";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderStatus);
			ResultSet rs = stmt.executeQuery();
			ArrayList<Orders> ordersList = new ArrayList<>();
			ArrayList<OrdersHistory> ordersHistoryList = new ArrayList<>();
			while(rs.next()) {
				Orders o = new Orders();
				o.setId(rs.getString("id"));
				o.setOrderNo(rs.getInt("orderNo"));
				o.setOrderStatus(rs.getInt("orderStatus"));
				o.setOrderPrice(rs.getInt("orderPrice"));
				o.setOrderPointUse(rs.getInt("orderPointUse"));
				o.setCreatedate(rs.getString("createdate"));
				ordersHistoryList = ordersHistoryList(o.getOrderNo());
				o.setOrdersHistoryList(ordersHistoryList);
				ordersList.add(o);
//				System.out.println("checkList");
			}
//			System.out.println(ordersList.size() + " <- ordersList.size");
			return ordersList;
		}
		
		// 구매 내역 출력 createdate between  beginDate and nvl(endDate, sysdate()) 
		public ArrayList<Orders> ordersList(String beginDate, String endDate) throws Exception{
			System.out.println("ordersList with date");
			DBUtil DBUtil = new DBUtil();
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = null;
			if (endDate == null) {
				String sql = "SELECT id, order_no orderNo, order_status orderStatus, order_price orderPrice, order_point_use orderPointUse, createdate\r\n"
						+ "FROM orders\r\n"
						+ "WHERE createdate BETWEEN ? AND SYSDATE()\r\n"
						+ "ORDER BY createdate DESC";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, beginDate);
			} else {
				String sql = "SELECT id, order_no orderNo, order_status orderStatus, order_price orderPrice, order_point_use orderPointUse, createdate\r\n"
						+ "FROM orders\r\n"
						+ "WHERE createdate BETWEEN ? AND ?\r\n"
						+ "ORDER BY createdate DESC";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, beginDate);
				stmt.setString(2, endDate);
			}
			ResultSet rs = stmt.executeQuery();
			ArrayList<Orders> ordersList = new ArrayList<>();
			ArrayList<OrdersHistory> ordersHistoryList = new ArrayList<>();
			while(rs.next()) {
				Orders o = new Orders();
				o.setId(rs.getString("id"));
				o.setOrderNo(rs.getInt("orderNo"));
				o.setOrderStatus(rs.getInt("orderStatus"));
				o.setOrderPrice(rs.getInt("orderPrice"));
				o.setOrderPointUse(rs.getInt("orderPointUse"));
				o.setCreatedate(rs.getString("createdate"));
				ordersHistoryList = ordersHistoryList(o.getOrderNo());
				o.setOrdersHistoryList(ordersHistoryList);
				ordersList.add(o);
//				System.out.println("checkList");
			}
//			System.out.println(ordersList.size() + " <- ordersList.size");
			return ordersList;
		}
		
		// 구매 내역 출력 where order_status, createdate
		public ArrayList<Orders> ordersList(int orderStatus, String beginDate, String endDate) throws Exception{
			System.out.println("ordersList with all");
			DBUtil DBUtil = new DBUtil();
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = null;
			if (endDate == null) {
				String sql = "SELECT id, order_no orderNo, order_status orderStatus, order_price orderPrice, order_point_use orderPointUse, createdate\r\n"
						+ "FROM orders\r\n"
						+ "WHERE WHERE order_status = ? AND createdate BETWEEN ? AND SYSDATE()\r\n"
						+ "ORDER BY createdate DESC";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, orderStatus);
				stmt.setString(2, beginDate);
			} else {
				String sql = "SELECT id, order_no orderNo, order_status orderStatus, order_price orderPrice, order_point_use orderPointUse, createdate\r\n"
						+ "FROM orders\r\n"
						+ "WHERE WHERE order_status = ? AND createdate BETWEEN ? AND ?\r\n"
						+ "ORDER BY createdate DESC";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, orderStatus);
				stmt.setString(2, beginDate);
				stmt.setString(3, endDate);
			}
			ResultSet rs = stmt.executeQuery();
			ArrayList<Orders> ordersList = new ArrayList<>();
			ArrayList<OrdersHistory> ordersHistoryList = new ArrayList<>();
			while(rs.next()) {
				Orders o = new Orders();
				o.setId(rs.getString("id"));
				o.setOrderNo(rs.getInt("orderNo"));
				o.setOrderStatus(rs.getInt("orderStatus"));
				o.setOrderPrice(rs.getInt("orderPrice"));
				o.setOrderPointUse(rs.getInt("orderPointUse"));
				o.setCreatedate(rs.getString("createdate"));
				ordersHistoryList = ordersHistoryList(o.getOrderNo());
				o.setOrdersHistoryList(ordersHistoryList);
				ordersList.add(o);
//				System.out.println("checkList");
			}
//			System.out.println(ordersList.size() + " <- ordersList.size");
			return ordersList;
		}
		
		// 구매 물품 목록 출력
		public ArrayList<OrdersHistory> ordersHistoryList(int orderNo) throws Exception{
			DBUtil DBUtil = new DBUtil();
			Connection conn = DBUtil.getConnection();
			String sql = "SELECT oh.order_no orderNo, oh.product_no productNo, p.product_name productName, p.product_price productPrice, oh.order_cnt orderCnt\r\n"
					+ "FROM orders_history oh INNER JOIN product p\r\n"
					+ "	ON oh.product_no = p.product_no\r\n"
					+ "WHERE oh.order_no = ? \r\n"
					+ "ORDER BY oh.product_no";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderNo);
			ResultSet rs = stmt.executeQuery();
			ArrayList<OrdersHistory> ordersHistoryList = new ArrayList<>();
			while(rs.next()) {
				OrdersHistory oh = new OrdersHistory();
				oh.setProductNo(rs.getInt("productNo"));
				oh.setProductName(rs.getString("productName"));
				oh.setProductPrice(rs.getInt("productPrice"));
				oh.setOrderCnt(rs.getInt("orderCnt"));
				ordersHistoryList.add(oh);
//				System.out.println("checkHL");
			}
//			System.out.println(ordersHistoryList.size() + " <- ordersHistoryList.size");
			return ordersHistoryList;
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
