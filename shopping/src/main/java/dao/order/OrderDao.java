package dao.order;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import util.*;
import vo.id.Customer;
import vo.order.*;

public class OrderDao {
	
	// 1) 고객 id를 받아서 장바구니 목록을 받아오는 메서드
	public ArrayList<HashMap<String,Object>> cartList(String id) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.product_no,\r\n"
				+ "c.cart_no,\r\n"
				+ "c.id,\r\n"
				+ "p.product_name,\r\n"
				+ "IFNULL(p.product_price*(1-d.discount_rate),p.product_price) discount_price,\r\n"
				+ "i.product_save_filename,\r\n"
				+ "c.cart_cnt,\r\n"
				+ "IFNULL(p.product_price*(1-d.discount_rate),p.product_price)* c.cart_cnt total_price,\r\n"
				+ "c.checked,\r\n"
				+ "c.createdate,\r\n"
				+ "c.updatedate \r\n"
				+ "	FROM cart c \r\n"
				+ "	LEFT OUTER JOIN product p ON c.product_no = p.product_no \r\n"
				+ "	LEFT OUTER JOIN discount d ON p.product_no = d.product_no \r\n"
				+ "	LEFT OUTER JOIN product_img i ON p.product_no = i.product_no \r\n"
				+ "	LEFT OUTER JOIN customer m ON c.id = m.id \r\n"
				+ "WHERE m.id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,id);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("productNo",rs.getInt("c.product_no"));
			m.put("cartNo",rs.getInt("c.cart_no"));
			m.put("id",rs.getString("c.id"));
			m.put("productName",rs.getString("p.product_name"));
			m.put("discountPrice",rs.getInt("discount_price"));
			m.put("productSaveFilename",rs.getString("i.product_save_filename"));
			m.put("cartCnt",rs.getInt("c.cart_cnt"));
			m.put("totalPrice",rs.getInt("total_price"));
			m.put("checked",rs.getString("c.checked"));
			m.put("createdate",rs.getString("c.createdate"));
			m.put("updatedate",rs.getString("c.updatedate"));
			list.add(m);
		}
		return list;
	}
	
	// 2) 특정 사용자가 장바구니에서 선택한 제품 중 체크되어 있는 항목에 한하여 총 합계 출력
	public int totalPrice(String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		
		String sql = "SELECT sum(IFNULL(p.product_price*(1-d.discount_rate),p.product_price)*c.cart_cnt) seltotal \r\n"
				+ "FROM cart c \r\n"
				+ "	LEFT OUTER JOIN product p ON c.product_no = p.product_no \r\n"
				+ "	LEFT OUTER JOIN discount d ON p.product_no = d.product_no \r\n"
				+ "	LEFT OUTER JOIN customer m ON c.id = m.id \r\n"
				+ "WHERE m.id = ? AND c.checked='Y'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("seltotal");
		}
		return row;
	}
	
	// 3) 장바구니에서 수량 선택가능한 최대 수 조회(product 테이블의 재고량 조회)
	public int totalstock(int productNo) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		
		String sql = "SELECT product_stock\r\n"
				+ "FROM product\r\n"
				+ "WHERE product_no=?";
		//product_stock
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,productNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("product_stock");
		}
		return row;
	}
	
	// 4) 장바구니 단일 삭제 메서드
	public int deletecart(int cartNo) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "DELETE\r\n"
				+ "FROM cart\r\n"
				+ "WHERE cart_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,cartNo);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 5) 장바구니 checked 된 값의 합계를 더하는 메서드
	// 합계를 가져온 다음에 insert문을 추가하여 order 테이블에 정보기입
	public int insertSumTotalPrice(String id) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT sum(IFNULL(p.product_price*(1-d.discount_rate),p.product_price)* c.cart_cnt) total_price\r\n"
				+ "FROM cart c\r\n"
				+ "	LEFT OUTER JOIN product p ON c.product_no = p.product_no\r\n"
				+ "	LEFT OUTER JOIN discount d ON c.product_no = d.product_no\r\n"
				+ "WHERE c.checked = 'Y' AND c.id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("total_price");
		}

		String sql2 = "INSERT INTO orders(id,order_price,createdate,updatedate) values(?,?,now(),now())";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, id);
		stmt2.setInt(2,row);
		int row2 = stmt2.executeUpdate();
		return row2;
	}
	
	// 6) 장바구니에서 checked 가 Y인 목록
	public ArrayList<HashMap<String,Object>> finishorder(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT c.cart_no,c.id,p.product_name,c.cart_cnt\r\n"
				+ "FROM cart c\r\n"
				+ "	LEFT OUTER JOIN product p ON c.product_no = p.product_no\r\n"
				+ "	LEFT OUTER JOIN customer m ON c.id = m.id\r\n"
				+ "WHERE c.id = ? AND c.checked = 'Y'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("cartNo",rs.getInt("c.cart_no"));
			m.put("id",rs.getString("c.id"));
			m.put("productName",rs.getString("p.product_name"));
			m.put("cartCnt",rs.getInt("c.cart_cnt"));
			list.add(m);
		}
		return list;
	}
	// 7) 받을 주소 조회
	public ArrayList<HashMap<String,Object>> addressName(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT address_no,address,recently_use_date FROM address WHERE id = ? ORDER BY recently_use_date DESC limit 3";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
	    while(rs.next()) {
	    	HashMap<String,Object> m = new HashMap<String,Object>();
	    	m.put("addressNo",rs.getInt("address_no"));
	    	m.put("address",rs.getString("address"));
	    	m.put("recentlyUseDate",rs.getString("recently_use_date"));
			list.add(m);
	    }
	    return list;
	}
	// 8) 카트 넘버받기 (11번에 사용)
	public ArrayList<Cart> selectCart(String id) throws Exception{
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String sql = "SELECT c.cart_no cartNo,c.id FROM cart c INNER JOIN product p\r\n"
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
			list.add(c);
		}
		return list;
	}
	
	// 9) 주문자 정보 받아오기
	public ArrayList<Customer> orderinfo(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT id,cstm_name,cstm_email,cstm_point\r\n"
				+ "FROM customer\r\n"
				+ "WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		ArrayList<Customer> list = new ArrayList<>();
		while(rs.next()) {
			Customer c = new Customer();
			c.setId(rs.getString("id"));
			c.setCstmName(rs.getString("cstm_name"));
			c.setCstmEmail(rs.getString("cstm_email"));
			c.setCstmPoint(rs.getInt("cstm_point"));
			list.add(c);
		}
		return list;
	}
	
	// 10) order테이블 정보 가져오기
	public ArrayList<HashMap<String,Object>> selordertable(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT order_no,order_status,order_price,order_point_use,createdate,updatedate,\r\n"
				+ "order_price-order_point_use total_price\r\n"
				+ "FROM orders\r\n"
				+ "WHERE id = ?\r\n"
				+ "ORDER BY createdate DESC\r\n"
				+ "LIMIT 1;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		while(rs.next()){
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("orderNo",rs.getInt("order_no"));
			m.put("orderStatus",rs.getInt("order_status"));
			m.put("orderPrice",rs.getInt("order_price"));
			m.put("orderPointUse",rs.getInt("order_point_use"));
			m.put("createdate",rs.getString("createdate"));
			m.put("updatedate",rs.getString("updatedate"));
			m.put("totalPrice",rs.getInt("total_price"));
			list.add(m);
		}
		return list;
	}
	
	// 11) order_cart 리스트에 order_no에 따른 cart_no기입
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
			// OrderNo와 id값 추출
			selectOrderNo = selectOrderRs.getInt("orderNo");
			selectOrderId = selectOrderRs.getString("id");
		}
		
		// OrderDao 8번을 사용하여 cart_no리스트 받아오기
		ArrayList<Cart> cartNoList = new ArrayList<>();
		cartNoList = selectCart(selectOrderId);
		System.out.println("cartNoList-->" +cartNoList);
		
		ArrayList<Integer> checkInsertList = new ArrayList<>();
		String insertOrdersCartSql = "INSERT INTO orders_cart(order_no, cart_no)\r\n"
				+ "VALUES (?, ?)";
		for (Cart c : cartNoList) {
			PreparedStatement insertOrdersCartStmt = conn.prepareStatement(insertOrdersCartSql);
			insertOrdersCartStmt.setInt(1, selectOrderNo);
			insertOrdersCartStmt.setInt(2, c.getCartNo());
			int row = insertOrdersCartStmt.executeUpdate();
			checkInsertList.add(row);
		}
		return checkInsertList;
	}
	
	// 12) order_no마다 있는 cart테이블 내부정보를 order_history로 이동
	public ArrayList<Integer> insertOrdersHistory(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		String selectDataSql = "SELECT o.order_no,o.id,c.product_no,c.cart_cnt\r\n"
				+ "FROM orders o\r\n"
				+ "	INNER JOIN orders_cart oc ON oc.order_no = o.order_no\r\n"
				+ "	INNER JOIN cart c ON oc.cart_no = c.cart_no\r\n"
				+ "WHERE o.id=?;";
		PreparedStatement selectDataStmt = conn.prepareStatement(selectDataSql);
		selectDataStmt.setString(1, id);
		ResultSet selectDataRs = selectDataStmt.executeQuery();
		ArrayList<OrdersHistory> orderHistoryList = new ArrayList<>();
		while (selectDataRs.next()) {
			OrdersHistory oh = new OrdersHistory();
			oh.setOrderNo(selectDataRs.getInt("o.order_no"));
			oh.setId(selectDataRs.getString("o.id"));
			oh.setProductNo(selectDataRs.getInt("c.product_no"));
			oh.setOrderCnt(selectDataRs.getInt("c.cart_cnt"));
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
			
			int row = insertOrdersCartStmt.executeUpdate();
			checkInsertList.add(row);
		}
		return checkInsertList;
	}
	// 13) order_status 변경
	public int updateOrderStatus(int orderNo) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String updateSql = "UPDATE orders SET order_status = 1 WHERE order_no = ?";
		PreparedStatement updateStmt = conn.prepareStatement(updateSql);
		updateStmt.setInt(1,orderNo);
		row = updateStmt.executeUpdate();
		return row;
	}
	// 14) 주문자 카트, orders테이블에 구매하기만하고 주문진행을 하지않은 테이블 모두삭제
	public int deleteData(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String deleteOrderSql = "DELETE FROM orders WHERE order_status = 0 AND id = ?";
		PreparedStatement deleteOrderStmt = conn.prepareStatement(deleteOrderSql);
		deleteOrderStmt.setString(1, id);
		int row = deleteOrderStmt.executeUpdate();
		//위의 row 값은 작성자가 결제를 진행하지않고 뒤로 간 경우가 없다면 실행되지 않는다
		
		String deleteCartSql = "DELETE FROM cart WHERE checked = 'Y' AND id = ?";
		PreparedStatement deleteCartStmt = conn.prepareStatement(deleteCartSql);
		deleteCartStmt.setString(1, id);
		row = deleteCartStmt.executeUpdate();
		
		return row;
	}
	
	// 15) 포인트 히스토리에 포인트 값넣기
	public int pointstat(int orderNo, String id) throws Exception {
		int row = 0;
		int pointcnt = 0;
		int usePoint = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String pointSql = "SELECT floor(0.01*(order_price-order_point_use)) pointcnt,\r\n"
				+ "order_point_use\r\n"
				+ "FROM orders\r\n"
				+ "WHERE order_no = ?";
		PreparedStatement pointStmt = conn.prepareStatement(pointSql);
		pointStmt.setInt(1, orderNo);
		ResultSet pointRs = pointStmt.executeQuery();
		if(pointRs.next()) {
			pointcnt = pointRs.getInt("pointcnt");
			usePoint = pointRs.getInt("order_point_use");
		}
		
		String insertPointSql = "INSERT INTO point_history(order_no,point_pm,point,createdate) values(?,'+',?,now())";
		PreparedStatement insertPointStmt = conn.prepareStatement(insertPointSql);
		insertPointStmt.setInt(1, orderNo);
		insertPointStmt.setInt(2, pointcnt);
		row = insertPointStmt.executeUpdate();
		
		String minusPointSql = "INSERT INTO point_history(order_no,point_pm,point,createdate) values(?,'-',?,now())";
		PreparedStatement minusPointStmt = conn.prepareStatement(minusPointSql);
		minusPointStmt.setInt(1, orderNo);
		minusPointStmt.setInt(2, usePoint);
		row = minusPointStmt.executeUpdate();
		
		String addCstmPointSql = "UPDATE customer SET cstm_point = cstm_point + ? WHERE id = ?";
		PreparedStatement addCstmPointStmt = conn.prepareStatement(addCstmPointSql);
		addCstmPointStmt.setInt(1, pointcnt);
		addCstmPointStmt.setString(2, id);
		row = addCstmPointStmt.executeUpdate();
		
		String minusCstmPointSql = "UPDATE customer SET cstm_point = cstm_point - ? WHERE id = ?";
		PreparedStatement minusCstmPointStmt = conn.prepareStatement(minusCstmPointSql);
		minusCstmPointStmt.setInt(1, usePoint);
		minusCstmPointStmt.setString(2, id);
		row = minusCstmPointStmt.executeUpdate();
		return row;
	}
	
	// 16) 주소고르고 주소값을 넘기면 해당 주소로 업데이트
	public int addressOrder(String address,int orderNo) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "UPDATE orders SET address = ? WHERE order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, address);
		stmt.setInt(2, orderNo);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 17) 주문테이블의 포인트 사용량 변경
	public int updateUsePoint(int orderPointUse,int orderNo) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "UPDATE orders SET order_point_use = ? WHERE order_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderPointUse);
		stmt.setInt(2, orderNo);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 18) 카트 테이블에서 제품수량과 구매 할 목록 변경
	public int updateCartData(String checked,int cartCnt,String id,int cartNo) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "UPDATE cart SET checked=? , cart_cnt = ? WHERE id = ? AND cart_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, checked);
		stmt.setInt(2, cartCnt);
		stmt.setString(3, id);
		stmt.setInt(4, cartNo);
		row = stmt.executeUpdate();
		return row;
	}
	
	// 19) 결제하기를 눌러서 구매진행 시에 재고량에서 구매수량 만큼 갯수를 줄이는 메서드
	public int updateProductStock(int orderNo) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT oh.product_no,p.product_stock-oh.order_cnt productcnt\r\n"
				+ "FROM orders_history oh\r\n"
				+ "LEFT OUTER\r\n"
				+ "JOIN orders o ON oh.order_no = o.order_no\r\n"
				+ "LEFT OUTER\r\n"
				+ "JOIN product p ON oh.product_no = p.product_no\r\n"
				+ "WHERE oh.order_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()){
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("productNo",rs.getInt("oh.product_no"));
			m.put("orderCnt",rs.getInt("productcnt"));
			list.add(m);
		}
		
		for(HashMap<String,Object> m : list) {
			String sql2 = "UPDATE product SET product_stock = ? WHERE product_no = ?";
			PreparedStatement stmt2 = conn.prepareStatement(sql2);
			stmt2.setInt(1, (int)m.get("orderCnt"));
			stmt2.setInt(2, (int)m.get("productNo"));
			row = stmt2.executeUpdate();
		}
		return row;
	}
	// 20) 주소추가하는 메서드
	public int insertAddress(String id,String address) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String insertAddressSql = "INSERT INTO address(id,address,recently_use_date,createdate,updatedate) values(?,?,now(),now(),now())";
		PreparedStatement insertAddressStmt = conn.prepareStatement(insertAddressSql);
		insertAddressStmt.setString(1, id);
		insertAddressStmt.setString(2, address);
		row = insertAddressStmt.executeUpdate();
		return row;
	}
	/*
	// 21) 주문 결제시 사용한 주소 최근사용으로 당기기
	public int updateAddressDate(String address) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "UPDATE address SET recently_use_date = now() WHERE address = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, address);
		row = stmt.executeUpdate();
		return row;
	}
	*/
	// 22) 선택된 주소를 order.jsp에 출력
	public ArrayList<HashMap<String,Object>> addressOne(int addressNo) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT address_no,address FROM address WHERE address_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, addressNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		while(rs.next()){
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("addressNo",rs.getInt("address_no"));
			m.put("address",rs.getString("address"));
			list.add(m);
		}
		return list;
	}
	
	// 23) addressNo에 맞는 행 출력
	public ArrayList<HashMap<String,Object>> addressRecentlyOne(int addressNo) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT address,address_no FROM address WHERE address_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, addressNo);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		if(rs.next()){
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("address",rs.getString("address"));
			m.put("addressNo", rs.getInt("address_no"));
			list.add(m);
		}
		return list;
	}
	// 24) 해당 고객의 가입 주소 출력ㄱ
	public ArrayList<HashMap<String,Object>> addressRegister(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT cstm_address FROM customer WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		ArrayList<HashMap<String,Object>> list = new ArrayList<>();
		if(rs.next()){
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("cstmAddress",rs.getString("cstm_address"));
			list.add(m);
		}
		return list;
	}
	
	// 25) 비회원 상태에서 로그인 시 장바구니데이터 생성
	public void noLoginAddCart(String id,HttpServletRequest request) throws Exception {
	    DBUtil DBUtil = new DBUtil();
	    Connection conn = DBUtil.getConnection();
	    HttpSession session = request.getSession();
	    if (session.getAttribute("loginId") != null) {
	    	HashMap<String, Cart> cartMap = (HashMap<String, Cart>) session.getAttribute("cartMap");
	        if (cartMap != null && !cartMap.isEmpty()) {
	            String sql = "INSERT INTO cart (id, product_no, cart_cnt, createdate, updatedate) VALUES (?, ?, ?, NOW(), NOW())";
	            PreparedStatement stmt = conn.prepareStatement(sql);
	            
	            for (Cart cart : cartMap.values()) {
	                stmt.setString(1, id);
	                stmt.setInt(2, cart.getProductNo());
	                stmt.setInt(3, cart.getCartCnt());
	                stmt.executeUpdate();
	            }
	            
	            // 로그인 후 카트 테이블에 추가한 데이터는 더 이상 필요하지 않으므로 삭제
	            cartMap.clear();
	            session.setAttribute("cartList", cartMap);
	        }
	    }
	}
	
	// 26) 로그인 되어 있는 상태에서 장바구니에 데이터 삽입
	public int insertCartAction(String id,int productNo, int cartCnt) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
	    Connection conn = DBUtil.getConnection();
	    
	    String sql = "INSERT INTO cart(id,product_no,cart_cnt,createdate,updatedate) VALUES (?,?,?,now(),now())";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, id);
        stmt.setInt(2, productNo);
        stmt.setInt(3, cartCnt);
        row = stmt.executeUpdate();
		return row;
	}
	//테스트 용
	public static void main(String[] args) throws Exception {
		
		/*
		// 5번 장바구니 합계 정상
		int check = orderdao.sumtotalprice("admin");
		System.out.println(check);
		*/
		/*
		// 6번 id 대비 포인트
		int check = orderdao.totalpoint("admin");
		System.out.println(check);
		*/
		/*
		// 7번 주소받아오기
		ArrayList<String> checkList = new ArrayList<>();
		checkList = orderdao.addressName("admin");
		System.out.println(checkList.get(2));
		*/
		/* 
		//8번 리스트 갯수와 카트넘버 받아오기
		ArrayList<Cart> list = new ArrayList<>();
		list = orderdao.selectCart("admin");
		System.out.println(list.size());
		*/
	}
}
