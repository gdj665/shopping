package dao.order;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import test.cartTest;
import util.*;
import vo.id.Customer;
import vo.order.*;

public class OrderDao {
	
	// 1) 고객id를 받아서 장바구니 목록을 받아오는 메서드
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
		//c.product_no
		//c.cart_no
		//c.id
		//p.product_name
		//discount_price
		//i.product_save_filename
		//c.cart_cnt
		//total_price
		//c.checked
		//c.createdate
		//c.updatedate
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,id);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("c.product_no",rs.getInt("c.product_no"));
			m.put("cart_no",rs.getInt("cart_no"));
			m.put("c.id",rs.getString("c.id"));
			m.put("p.product_name",rs.getString("p.product_name"));
			m.put("discount_price",rs.getInt("discount_price"));
			m.put("i.product_save_filename",rs.getString("i.product_save_filename"));
			m.put("c.cart_cnt",rs.getInt("c.cart_cnt"));
			m.put("total_price",rs.getInt("total_price"));
			m.put("c.checked",rs.getString("c.checked"));
			m.put("c.createdate",rs.getString("c.createdate"));
			m.put("c.updatedate",rs.getString("c.updatedate"));
			list.add(m);
		}
		return list;
	}
	
	// 2) 선택된 사용자가 장바구니에서 선택한 제품에 한하여 총 합계 출력
	public int totalPrice(String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		
		String sql = "SELECT sum(IFNULL(p.product_price*(1-d.discount_rate),p.product_price)*c.cart_cnt) seltotal \r\n"
				+ "FROM cart c \r\n"
				+ "	LEFT OUTER JOIN product p ON c.product_no = p.product_no \r\n"
				+ "	LEFT OUTER JOIN discount d ON p.product_no = d.product_no \r\n"
				+ "	LEFT OUTER JOIN customer m ON c.id = m.id \r\n"
				+ "WHERE m.id = 'admin' AND c.checked='Y'";
		//seltotal
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,id);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = rs.getInt("seltotal");
		}
		
		return row;
	}
	
	// 3) 장바구니에서 수량 선택 최대갯수 출력문
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
	
	// 5) 장바구니 checked 된 값의 합계
	public int sumtotalprice(String id) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT sum(IFNULL(p.product_price*(1-d.discount_rate),p.product_price)* c.cart_cnt) total_price\r\n"
				+ "FROM cart c\r\n"
				+ "	LEFT OUTER JOIN product p ON c.product_no = p.product_no\r\n"
				+ "	LEFT OUTER JOIN discount d ON c.product_no = d.product_no\r\n"
				+ "WHERE c.checked = 'Y'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("total_price");
		}
		String sql2 = "INSERT INTO orders(id,order_price,createdate,updatedate) values(?,?,now(),now())";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, id);
		stmt2.setInt(2,rs.getInt("total_price"));
		int row2 = stmt2.executeUpdate();
		return row;
	}
	
	// 6) id에 매칭되는 포인트 소지량
	public int totalpoint(String id) throws Exception {
		int row = 0;
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT cstm_point FROM customer WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cstm_point");
		}
		return row;
	}
	// 7) 받을 주소 조회
	public ArrayList<String> addressName(String id) throws Exception {
		DBUtil DBUtil = new DBUtil();
		Connection conn = DBUtil.getConnection();
		
		String sql = "SELECT address,recently_use_date FROM address WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		ArrayList<String> list = new ArrayList<>();
	    while(rs.next()) {
	        list.add(rs.getString("address"));
	        list.add(rs.getString("recently_use_date"));
	    }
	    return list;
	}
	// 8) 카트 사이즈 구하기
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
		int row = 0;
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
	
	
	
	
	
	//테스트 용
	public static void main(String[] args) throws Exception {
		OrderDao orderdao = new OrderDao();
		
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
