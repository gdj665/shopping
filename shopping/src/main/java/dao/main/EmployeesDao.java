package dao.main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.id.Customer;
import vo.id.Employees;
import vo.order.Orders;
import vo.order.OrdersHistory;
import vo.product.Discount;

public class EmployeesDao {

	// employees 유효성 검사
	public int checkEmployees(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String checkSql = "SELECT count(*) cnt, emp_level empLevel\r\n"
				+ "FROM employees\r\n"
				+ "WHERE id = ?";
		PreparedStatement checkStmt = conn.prepareStatement(checkSql);
		checkStmt.setString(1, id);
		ResultSet checkRs = checkStmt.executeQuery();
		int empLevel = 0;
		if(checkRs.next()) {
			if (checkRs.getInt("cnt") == 0) {
				return 0;
			}
			empLevel = checkRs.getInt("empLevel");
		}
		return empLevel;
	}
	
	// id 유효성 검사
	public boolean checkId(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String checkIdSql = "SELECT COUNT(*) cnt\r\n"
				+ "FROM id_list\r\n"
				+ "WHERE id = ?";
		PreparedStatement checkIdStmt = conn.prepareStatement(checkIdSql);
		checkIdStmt.setString(1, id);
		ResultSet checkIdRs = checkIdStmt.executeQuery();
		// 중복 id있으면 false반환
		if (checkIdRs.next()) {
			if (checkIdRs.getInt("cnt") > 0) {
				System.out.println("중복된 아이디");
				return true;
			}
		}
		return false;
	}

	// 비밀번호 유효성 체크
	public boolean checkPw(Employees employees) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT id, last_pw lastPw\r\n"
				+ "FROM id_list\r\n"
				+ "WHERE id = ? AND last_pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, employees.getId());
		stmt.setString(2, employees.getEmpPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			return true;
		}
		return false;
	} 
	
	// 구매 내역 출력
	public ArrayList<Orders> ordersList() throws Exception{
		System.out.println("ordersList");
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT id, order_no orderNo, order_status orderStatus, order_price orderPrice, order_point_use orderPointUse, createdate\r\n"
				+ "FROM orders WHERE order_status NOT IN(0)\r\n"
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
	
	// 할인 출력
	public Discount selectDiscountOne(int discountNo) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
				+ "FROM discount d INNER JOIN product p\r\n"
				+ "	ON d.product_no = p.product_no\r\n"
				+ "WHERE d.discount_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, discountNo);
		ResultSet rs = stmt.executeQuery();
		Discount d = new Discount();
		if(rs.next()) {
			d.setDiscountNo(rs.getInt("discountNo"));
			d.setProductNo(rs.getInt("productNo"));
			d.setProductName(rs.getString("productName"));
			d.setDiscountBegin(rs.getString("discountBegin"));
			d.setDiscountEnd(rs.getString("discountEnd"));
			d.setDiscountRate(rs.getDouble("discountRate"));
			d.setCreatedate(rs.getString("createdate"));
			d.setUpdatedate(rs.getString("updatedate"));
		}
		
		return d;
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
						+ "WHERE(discount_begin BETWEEN ? AND SYSDATE()) OR (discount_end BETWEEN ? AND SYSDATE()) OR (discount_begin <= ? AND discount_end >= SYSDATE())"
						+ "ORDER BY createdate desc";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, beginDate);
				stmt.setString(2, beginDate);
				stmt.setString(3, beginDate);
			} else {
				String sql = "SELECT d.discount_no discountNo, d.product_no productNo, p.product_name productName, d.discount_begin discountBegin, d.discount_end discountEnd, d.discount_rate discountRate, d.createdate, d.updatedate\r\n"
						+ "FROM discount d INNER JOIN product p\r\n"
						+ "	ON d.product_no = p.product_no\r\n"
						+ "WHERE (discount_begin BETWEEN ? AND ?) OR (discount_end BETWEEN ? AND ?) OR (discount_begin <= ? AND discount_end >= ?)"
						+ "ORDER BY createdate desc";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, beginDate);
				stmt.setString(2, endDate);
				stmt.setString(3, beginDate);
				stmt.setString(4, endDate);
				stmt.setString(5, beginDate);
				stmt.setString(6, endDate);
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
	
	// 할인 체크
	public boolean checkDiscount(Discount discount) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT count(*) cnt\r\n"
				+ "FROM discount\r\n"
				+ "WHERE product_no = ? AND ((discount_begin BETWEEN ? AND ?) OR (discount_end BETWEEN ? AND ?) OR (discount_begin <= ? AND discount_end >= ?))";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, discount.getProductNo());
		stmt.setString(2, discount.getDiscountBegin());
		stmt.setString(3, discount.getDiscountEnd());
		stmt.setString(4, discount.getDiscountBegin());
		stmt.setString(5, discount.getDiscountEnd());
		stmt.setString(6, discount.getDiscountBegin());
		stmt.setString(7, discount.getDiscountEnd());
		ResultSet rs = stmt.executeQuery();
		boolean checkDiscount = false;
		if(rs.next()) {
			if(rs.getInt("cnt") == 0) {
				checkDiscount = true;
			}
		}
		return checkDiscount;
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
	
	// 할인 수정
	public int updateDiscount(int discountNo, Discount discount) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "UPDATE discount SET discount_begin = ?, discount_end = ?, discount_rate = ?, updatedate = NOW()\r\n"
				+ "WHERE discount_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, discount.getDiscountBegin());
		stmt.setString(2, discount.getDiscountEnd());
		stmt.setDouble(3, discount.getDiscountRate());
		stmt.setInt(4, discountNo);
		int row = stmt.executeUpdate();
		return row;
	}
	
	// 할인 삭제
	public int deleteDiscount(int discountNo) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "DELETE FROM discount\r\n"
				+ "WHERE discount_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, discountNo);
		int row = stmt.executeUpdate();
		return row;
	}
	
	// 회원 출력
	public ArrayList<Customer> selectCustomer() throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT c.id id, il.active active, c.cstm_rank cstmRank, c.cstm_point cstmPoint, c.cstm_last_login cstmLastLogin, c.cstm_agree cstmAgree\r\n"
				+ "FROM customer c INNER JOIN id_list il\r\n"
				+ "	ON c.id = il.id";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Customer> customerList = new ArrayList<>();
		while(rs.next()) {
			Customer c = new Customer();
			c.setId(rs.getString("id"));
			c.setActive(rs.getInt("active"));
			c.setCstmRank(rs.getString("cstmRank"));
			c.setCstmPoint(rs.getInt("cstmPoint"));
			c.setCstmLastLogin(rs.getString("cstmLastLogin"));
			c.setCstmAgree(rs.getString("cstmAgree"));
			customerList.add(c);
		}
		return customerList;
	} 
	
	// 회원 출력
	public Customer selectCustomer(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT c.id id, il.active active, c.cstm_name cstmName, c.cstm_address cstmAddress, c.cstm_email cstmEmail, \r\n"
				+ "c.cstm_birth cstmBirth, c.cstm_phone cstmPhone, c.cstm_rank cstmRank, c.cstm_point cstmPoint, c.cstm_last_login cstmLastLogin,c.cstm_agree cstmAgree, c.createdate createdate, c.updatedate updatedate\r\n"
				+ "FROM customer c INNER JOIN id_list il\r\n"
				+ "ON c.id = il.id"
				+ " WHERE c.id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		Customer c = new Customer();
		if(rs.next()) {
			c.setId(rs.getString("id"));
			c.setActive(rs.getInt("active"));
			c.setCstmName(rs.getString("cstmName"));
			c.setCstmAddress(rs.getString("cstmAddress"));
			c.setCstmEmail(rs.getString("cstmEmail"));
			c.setCstmBirth(rs.getString("cstmBirth"));
			c.setCstmPhone(rs.getString("cstmPhone"));
			c.setCstmRank(rs.getString("cstmRank"));
			c.setCstmPoint(rs.getInt("cstmPoint"));
			c.setCstmLastLogin(rs.getString("cstmLastLogin"));
			c.setCstmAgree(rs.getString("cstmAgree"));
			c.setCreatedate(rs.getString("createdate"));
			c.setUpdatedate(rs.getString("updatedate"));
		}
		return c;
	} 

	// 회원 수정
	public int updateCustomer(String id, int active) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "UPDATE id_list SET active = ?\r\n"
				+ "WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, active);
		stmt.setString(2, id);
		int row = stmt.executeUpdate();
		return row;
	} 
	
	// employees 출력
	public ArrayList<Employees> selectEmployees() throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT id, emp_name empName, emp_level empLevel, createdate, updatedate\r\n"
				+ "FROM employees";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Employees> employeesList = new ArrayList<>();
		while(rs.next()) {
			Employees e = new Employees();
			e.setId(rs.getString("id"));
			e.setEmpName(rs.getString("empName"));
			e.setEmpLevel(rs.getInt("empLevel"));
			e.setCreatedate(rs.getString("createdate"));
			e.setUpdatedate(rs.getString("updatedate"));
			employeesList.add(e);
		}
		return employeesList;
	} 
	
	// employees 출력
	public Employees selectEmployees(String employeesId) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT id, emp_name empName, emp_level empLevel, createdate, updatedate\r\n"
				+ "FROM employees\r\n"
				+ "WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, employeesId);
		ResultSet rs = stmt.executeQuery();
		Employees e = new Employees();
		if(rs.next()) {
			e.setId(rs.getString("id"));
			e.setEmpName(rs.getString("empName"));
			e.setEmpLevel(rs.getInt("empLevel"));
			e.setCreatedate(rs.getString("createdate"));
			e.setUpdatedate(rs.getString("updatedate"));
		}
		return e;
	} 
	
	// employees 수정
	public int updateEmployees(String preEmployeesId, Employees employees) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		// id 중복 체크 중복이면 true반환
		if(checkId(employees.getId())) {
			return 0;
		}
		String updateIdSql = "UPDATE id_list SET id = ?, last_pw = ? WHERE id = ?";
		PreparedStatement updateIdStmt = conn.prepareStatement(updateIdSql);
		updateIdStmt.setString(1, employees.getId());
		updateIdStmt.setString(2, employees.getEmpPw());
		updateIdStmt.setString(3, preEmployeesId);
		int row = updateIdStmt.executeUpdate();
		if (row != 1) {
			System.out.println("아이디, 비번 수정실패");
			return 0;
		}
		String updateEmpSql = "UPDATE employees SET emp_name = ?, emp_level = ?, updatedate = NOW() WHERE id = ?";
		PreparedStatement updateEmpStmt = conn.prepareStatement(updateEmpSql);
		updateEmpStmt.setString(1, employees.getEmpName());
		updateEmpStmt.setInt(2, employees.getEmpLevel());
		updateEmpStmt.setString(3, employees.getId());
		row = updateEmpStmt.executeUpdate();
		return row;
	} 
	
	// employees 수정
	public int updateEmployees(Employees employees) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String updateIdSql = "UPDATE id_list SET last_pw = ? WHERE id = ?";
		PreparedStatement updateIdStmt = conn.prepareStatement(updateIdSql);
		updateIdStmt.setString(1, employees.getEmpPw());
		updateIdStmt.setString(2, employees.getId());
		int row = updateIdStmt.executeUpdate();
		if (row != 1) {
			System.out.println("비번 수정실패");
			return 0;
		}
		String updateEmpSql = "UPDATE employees SET emp_name = ?, emp_level = ?, updatedate = NOW() WHERE id = ?";
		PreparedStatement updateEmpStmt = conn.prepareStatement(updateEmpSql);
		updateEmpStmt.setString(1, employees.getEmpName());
		updateEmpStmt.setInt(2, employees.getEmpLevel());
		updateEmpStmt.setString(3, employees.getId());
		row = updateEmpStmt.executeUpdate();
		return row;
	} 
	
	// employees 추가
	public int insertEmployees(Employees employees) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String insertIdSql = "INSERT INTO id_list VALUES (?, ?, 1, NOW())";
		PreparedStatement insertIdStmt = conn.prepareStatement(insertIdSql);
		insertIdStmt.setString(1, employees.getId());
		insertIdStmt.setString(2, employees.getEmpPw());
		int row = insertIdStmt.executeUpdate();
		if (row != 1) {
			return 0;
		}
		String insertEmpSql = "INSERT INTO employees VALUES(?, ?, ?, NOW(), NOW())";
		PreparedStatement insertEmpStmt = conn.prepareStatement(insertEmpSql);
		insertEmpStmt.setString(1, employees.getId());
		insertEmpStmt.setString(2, employees.getEmpName());
		insertEmpStmt.setInt(3, employees.getEmpLevel());
		row = insertEmpStmt.executeUpdate();
		return row;
	}
}
