package dao.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.order.Orders;
import vo.order.OrdersHistory;

public class AdminDao {
	
	// 구매 내역 출력
	public ArrayList<Orders> ordersList() throws Exception{
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT id, order_no orderNo, order_status orderStatus, order_price orderPrice, order_point_use orderPointUse, createdate\r\n"
				+ "FROM orders\r\n"
				+ "ORDER BY createdate DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Orders> ordersList = new ArrayList<>();
		while(rs.next()) {
			Orders o = new Orders();
			o.setId(rs.getString("id"));
			o.setOrderNo(rs.getInt("orderNo"));
			o.setOrderStatus(rs.getInt("orderStatus"));
			o.setOrderPrice(rs.getInt("orderPrice"));
			o.setOrderPointUse(rs.getInt("orderPointUse"));
			o.setCreatedate(rs.getString("createdate"));
			ArrayList<OrdersHistory> ordersHistoryList = new ArrayList<>();
			ordersHistoryList = ordersHistoryList(o.getOrderNo());
			o.setOrdersHistoryList(ordersHistoryList);
			
		}
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
		}
		return ordersHistoryList;
	}
}
