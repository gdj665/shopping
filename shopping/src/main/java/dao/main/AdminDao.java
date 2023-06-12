package dao.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.order.Orders;
import vo.order.OrdersHistory;
import vo.product.Discount;

public class AdminDao {
	
	// 구매 내역 출력
	public ArrayList<Orders> ordersList() throws Exception{
		System.out.println("ordersList");
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT id, order_no orderNo, order_status orderStatus, order_price orderPrice, order_point_use orderPointUse, createdate\r\n"
				+ "FROM orders\r\n"
				+ "ORDER BY createdate DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
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
//			System.out.println("checkList");
		}
//		System.out.println(ordersList.size() + " <- ordersList.size");
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
//			System.out.println("checkList");
		}
//		System.out.println(ordersList.size() + " <- ordersList.size");
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
//			System.out.println("checkList");
		}
//		System.out.println(ordersList.size() + " <- ordersList.size");
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
//			System.out.println("checkList");
		}
//		System.out.println(ordersList.size() + " <- ordersList.size");
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
//			System.out.println("checkHL");
		}
//		System.out.println(ordersHistoryList.size() + " <- ordersHistoryList.size");
		return ordersHistoryList;
	}
	
	// 주문 내역 상태 변경
	public int orderStatusUpdate(int orderStatus, String[] orderNo) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "UPDATE orders SET order_status = ?\r\n"
				+ "WHERE order_no = ?";
		ArrayList<Integer> checkUpdateList = new ArrayList<>();
		for (String s : orderNo) {
			int i = Integer.parseInt(s);
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, orderStatus);
			stmt.setInt(2, i);
			int row = stmt.executeUpdate();
			checkUpdateList.add(row);
		}
		int checkUpdate = checkUpdateList.size();
		return checkUpdate;
	}
	
	// 할인 리스트 출력
	public ArrayList<Discount> selectDiscount() throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
				+ "FROM discount d INNER JOIN product p\r\n"
				+ "	ON d.product_no = p.product_no\r\n"
				+ "ORDER BY createdate desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Discount> discountList = new ArrayList<>();
		while(rs.next()) {
			Discount d = new Discount();
			d.setDiscountNo(rs.getInt("discountNo"));
			d.setProductNo(rs.getInt("productNo"));
			d.setProductName(rs.getString("productName"));
			d.setDiscountBegin(rs.getString("discountBegin"));
			d.setDiscountEnd(rs.getString("discountEnd"));
			d.setDiscountRate(rs.getDouble("discountRate"));
			d.setCreatedate(rs.getString("createdate"));
			d.setUpdatedate(rs.getString("updatedate"));
			discountList.add(d);
		}
		
		return discountList;
	}
	
	// 할인 리스트 출력 where searchProducntNo
	public ArrayList<Discount> selectDiscount(int searchProductNo) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
				+ "FROM discount d INNER JOIN product p\r\n"
				+ "	ON d.product_no = p.product_no\r\n"
				+ "WHERE d.product_no = ?\r\n"
				+ "ORDER BY createdate desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, searchProductNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Discount> discountList = new ArrayList<>();
		while(rs.next()) {
			Discount d = new Discount();
			d.setDiscountNo(rs.getInt("discountNo"));
			d.setProductNo(rs.getInt("productNo"));
			d.setProductName(rs.getString("productName"));
			d.setDiscountBegin(rs.getString("discountBegin"));
			d.setDiscountEnd(rs.getString("discountEnd"));
			d.setDiscountRate(rs.getDouble("discountRate"));
			d.setCreatedate(rs.getString("createdate"));
			d.setUpdatedate(rs.getString("updatedate"));
			discountList.add(d);
		}
		
		return discountList;
	}

	// 할인 리스트 출력 where splitSearchProduct
	public ArrayList<Discount> selectDiscount(String[] splitSearchProduct) throws Exception {
		for (int i = 0; i < splitSearchProduct.length; i++){
			splitSearchProduct[i] = "%" + splitSearchProduct[i] + "%";
		}
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String likeSql = "WHERE";
		for (int i = 0; i < splitSearchProduct.length; i++) {
			if (i < splitSearchProduct.length - 1) {
				likeSql += " p.product_name LIKE ? AND ";
			} else {
				likeSql += " p.product_name LIKE ? ";
			}
		}
		String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
				+ "FROM discount d INNER JOIN product p\r\n"
				+ "	ON d.product_no = p.product_no\r\n"
				+ likeSql
				+ "ORDER BY createdate desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		int pramCnt = 1;
		for (String s : splitSearchProduct) {
			stmt.setString(pramCnt, s);
			pramCnt++;
		}
		ResultSet rs = stmt.executeQuery();
		ArrayList<Discount> discountList = new ArrayList<>();
		while(rs.next()) {
			Discount d = new Discount();
			d.setDiscountNo(rs.getInt("discountNo"));
			d.setProductNo(rs.getInt("productNo"));
			d.setProductName(rs.getString("productName"));
			d.setDiscountBegin(rs.getString("discountBegin"));
			d.setDiscountEnd(rs.getString("discountEnd"));
			d.setDiscountRate(rs.getDouble("discountRate"));
			d.setCreatedate(rs.getString("createdate"));
			d.setUpdatedate(rs.getString("updatedate"));
			discountList.add(d);
		}
		
		return discountList;
	}
	
	// 할인 리스트 출력 where beginDate, String endDate
	public ArrayList<Discount> selectDiscount(String searchDate, String beginDate, String endDate) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		if ("discountWhole".equals(searchDate)) {
			if (endDate == null) {
				String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
						+ "FROM discount d INNER JOIN product p\r\n"
						+ "	ON d.product_no = p.product_no\r\n"
						+ "WHERE d.discount_begin >= ? AND d.discount_end <= SYSDATE()"
						+ "ORDER BY createdate desc";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, beginDate);
			} else {
				String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
						+ "FROM discount d INNER JOIN product p\r\n"
						+ "	ON d.product_no = p.product_no\r\n"
						+ "WHERE d.discount_begin >= ? AND d.discount_end <= ?"
						+ "ORDER BY createdate desc";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, beginDate);
				stmt.setString(2, endDate);
			}
		}
		if ("discountBegin".equals(searchDate)) {
			if (endDate == null) {
				String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
						+ "FROM discount d INNER JOIN product p\r\n"
						+ "	ON d.product_no = p.product_no\r\n"
						+ "WHERE d.discount_begin BETWEEN ? AND SYSDATE()"
						+ "ORDER BY createdate desc";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, beginDate);
			} else {
				String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
						+ "FROM discount d INNER JOIN product p\r\n"
						+ "	ON d.product_no = p.product_no\r\n"
						+ "WHERE d.discount_begin BETWEEN ? AND ?"
						+ "ORDER BY createdate desc";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, beginDate);
				stmt.setString(2, endDate);
			}
		}
		if ("discountEnd".equals(searchDate)) {
			if (endDate == null) {
				String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
						+ "FROM discount d INNER JOIN product p\r\n"
						+ "	ON d.product_no = p.product_no\r\n"
						+ "WHERE d.discount_end BETWEEN ? AND SYSDATE()"
						+ "ORDER BY createdate desc";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, beginDate);
			} else {
				String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
						+ "FROM discount d INNER JOIN product p\r\n"
						+ "	ON d.product_no = p.product_no\r\n"
						+ "WHERE d.discount_end BETWEEN ? AND ?"
						+ "ORDER BY createdate desc";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, beginDate);
				stmt.setString(2, endDate);
			}
		}
		ResultSet rs = stmt.executeQuery();
		ArrayList<Discount> discountList = new ArrayList<>();
		while(rs.next()) {
			Discount d = new Discount();
			d.setDiscountNo(rs.getInt("discountNo"));
			d.setProductNo(rs.getInt("productNo"));
			d.setProductName(rs.getString("productName"));
			d.setDiscountBegin(rs.getString("discountBegin"));
			d.setDiscountEnd(rs.getString("discountEnd"));
			d.setDiscountRate(rs.getDouble("discountRate"));
			d.setCreatedate(rs.getString("createdate"));
			d.setUpdatedate(rs.getString("updatedate"));
			discountList.add(d);
		}
		
		return discountList;
	}
	
	// 할인 리스트 출력 where searchRate
	public ArrayList<Discount> selectDiscount(double searchRate) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
				+ "FROM discount d INNER JOIN product p\r\n"
				+ "	ON d.product_no = p.product_no\r\n"
				+ "WHERE d.discount_rate = ?"
				+ "ORDER BY createdate desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setDouble(1, searchRate);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Discount> discountList = new ArrayList<>();
		while(rs.next()) {
			Discount d = new Discount();
			d.setDiscountNo(rs.getInt("discountNo"));
			d.setProductNo(rs.getInt("productNo"));
			d.setProductName(rs.getString("productName"));
			d.setDiscountBegin(rs.getString("discountBegin"));
			d.setDiscountEnd(rs.getString("discountEnd"));
			d.setDiscountRate(rs.getDouble("discountRate"));
			d.setCreatedate(rs.getString("createdate"));
			d.setUpdatedate(rs.getString("updatedate"));
			discountList.add(d);
		}
		
		return discountList;
	}
	
	// 할인 추가
	public int insertDiscount(Discount discount) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "INSERT INTO discount (product_no, discount_begin, discount_end, discount_rate, createdate, updatedate)\r\n"
				+ "VALUES(?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, discount.getProductNo());
		stmt.setString(2, discount.getDiscountBegin());
		stmt.setString(3, discount.getDiscountEnd());
		stmt.setDouble(4, discount.getDiscountRate());
		int row = stmt.executeUpdate();
		return row;
	}
}
