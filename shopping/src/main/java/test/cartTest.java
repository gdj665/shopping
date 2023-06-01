package test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.order.Cart;
import vo.order.OrdersHistory;

public class cartTest {
	
	// 장바구니에서 데이터 가져오기
	// 입력된 id와 checked 둘다 맞을 경우 가져옴
	public ArrayList<Cart> selectCart(String id) throws Exception{
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT c.cart_no cartNo, c.id id, c.product_no productNo, c.cart_cnt cartCnt, p.product_price * c.cart_cnt price\r\n"
				+ "FROM cart c INNER JOIN product p\r\n"
				+ "		ON c.product_no = p.product_no\r\n"
				+ "WHERE c.id = ? AND c.checked = 1";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Cart> list = new ArrayList<>();
		while(rs.next()) {
			Cart c = new Cart();
			c.setCartNo(rs.getInt("cartNo"));
			c.setId(rs.getString("id"));
			c.setProductNo(rs.getInt("productNo"));
			c.setCartCnt(rs.getInt("cartCnt"));
			c.setPrice(rs.getInt("price"));
			list.add(c);
		}
		System.out.println(list.size());
		return list;
	}
	
	// parametet값을 받아와서 그값을 입력 받아서 orders에 데이터 입력
	public int insertOrders(String id, int orderSumPrice, int pointUse) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "INSERT INTO orders(id, order_price, order_point_use, createdate, updatedate)\r\n"
				+ " VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setInt(2, orderSumPrice);
		stmt.setInt(3, pointUse);
		// System.out.println(stmt);
		int row = stmt.executeUpdate();
		return row;
	}
	
	// orders에서 하나의 값을 특정하는 것이 어려워서 가장 최근에 만들어진 orders 행을 불러 와서 order_no를 특정
	// 그 값과 selectCart에서 만든 list를 이용해서 ordersCart에 데이터 값을 입력
	public ArrayList<Integer> insertOrdersCart() throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String selectOrderNoSql = "SELECT order_no orderNo, id\r\n"
				+ "FROM orders\r\n"
				+ "ORDER BY createdate DESC\r\n"
				+ "LIMIT 1";
		PreparedStatement selectOrderStmt = conn.prepareStatement(selectOrderNoSql);
		ResultSet selectOrderRs = selectOrderStmt.executeQuery();
		int selectOrderNo = 0;
		String selectOrderId = null;
		if (selectOrderRs.next()) {
			selectOrderNo = selectOrderRs.getInt("orderNo");
			selectOrderId = selectOrderRs.getString("id");
		}
		
		
		ArrayList<Cart> cartNoList = new ArrayList<>();
		cartNoList = selectCart(selectOrderId);
		System.out.println(cartNoList);
		
		ArrayList<Integer> checkInsertList = new ArrayList<>();
		String insertOrdersCartSql = "INSERT INTO orders_cart(order_no, cart_no)\r\n"
				+ "VALUES (?, ?)";
		for (Cart c : cartNoList) {
			PreparedStatement insertOrdersCartStmt = conn.prepareStatement(insertOrdersCartSql);
			insertOrdersCartStmt.setInt(1, selectOrderNo);
			insertOrdersCartStmt.setInt(2, c.getCartNo());
			// System.out.println(insertOrdersCartStmt);
			int row = insertOrdersCartStmt.executeUpdate();
			// System.out.println(row);
			checkInsertList.add(row);
		}
		return checkInsertList;
	}
	
	// 구매하는 사용자 id 값을 입력 받아서 order와 orders_cart에서 order_no가 같은것을 가져오고
	// 그 값을 가지고 cart_no을 통해서 product_no를 가져온다
	// 가져온 값으로 ordersHistoryList에 값을 넣고 insert한다. 
	public ArrayList<Integer> insertOrdersHistory(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String selectDataSql = "SELECT o.order_no orderNo, o.id id, c.product_no productNo, c.cart_cnt cartCnt\r\n"
				+ "FROM orders o INNER JOIN orders_cart oc\r\n"
				+ "		ON o.order_no = oc.order_no\r\n"
				+ "		INNER JOIN cart c\r\n"
				+ "		ON oc.cart_no = c.cart_no\r\n"
				+ "WHERE o.id = ?";
		PreparedStatement selectDataStmt = conn.prepareStatement(selectDataSql);
		selectDataStmt.setString(1, id);
		// System.out.println(selectDataStmt);
		ResultSet selectDataRs = selectDataStmt.executeQuery();
		ArrayList<OrdersHistory> orderHistoryList = new ArrayList<>();
		while (selectDataRs.next()) {
			OrdersHistory oh = new OrdersHistory();
			oh.setOrderNo(selectDataRs.getInt("orderNo"));
			oh.setId(selectDataRs.getString("id"));
			oh.setProductNo(selectDataRs.getInt("productNo"));
			oh.setOrderCnt(selectDataRs.getInt("cartCnt"));
			orderHistoryList.add(oh);
		}
		
		ArrayList<Integer> checkInsertList = new ArrayList<>();
		String insertDataSql = "INSERT INTO orders_history(order_no, product_no, order_cnt, createdate)\r\n"
				+ "VALUES(?, ?, ?, NOW())";
		for (OrdersHistory oh : orderHistoryList) {
			PreparedStatement insertOrdersCartStmt = conn.prepareStatement(insertDataSql);
			insertOrdersCartStmt.setInt(1, oh.getOrderNo());
			insertOrdersCartStmt.setInt(2, oh.getProductNo());
			insertOrdersCartStmt.setInt(3, oh.getOrderCnt());
			// System.out.println(insertOrdersCartStmt);
			int row = insertOrdersCartStmt.executeUpdate();
			checkInsertList.add(row);
		}
		return checkInsertList;
	}
	
	// id와 checked 체크해서 해당하는 cart 값을 삭제한다.
	public int deleteData(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String deleteDataSql = "DELETE FROM cart\r\n"
				+ "WHERE id = ? AND checked = 1";
		PreparedStatement deleteDataStmt = conn.prepareStatement(deleteDataSql);
		deleteDataStmt.setString(1, id);
		int row = deleteDataStmt.executeUpdate();
		return row;
	}
	
	public static void main(String[] args) throws Exception {
		cartTest ct = new cartTest();
		/*
		ArrayList<Cart> cartList = new ArrayList<>();
		cartList = ct.selectCart("test1");
		System.out.println(cartList.get(0).getId());
		*/
		/*
		int check = ct.insertOrders("test1", 30000, 0);
		System.out.println(check);
		*/
		/*
		ArrayList<Integer> checkList = new ArrayList<>();
		checkList = ct.insertOrdersCart();
		System.out.println(checkList.get(0));
		*/
		/*
		ArrayList<Integer> checkList = new ArrayList<>();
		checkList = ct.insertOrdersHistory("test1");
		System.out.println(checkList.get(0));
		*/
		/*
		int check = ct.deleteData("test1");
		System.out.println(check);
		*/
		
		
	}
}
