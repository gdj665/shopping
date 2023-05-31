package dao.order;

import java.sql.*;

import util.*;
import vo.order.*;

public class OrderDao {
	
	// 1) 고객id를 받아서 장바구니 목록을 받아오는 메서드
	public Cart cartList(String id) throws Exception {
		Cart cart = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		String sql = "SELECT c.product_no,c.cart_no,c.id,p.product_name,IFNULL(p.product_price*(1-d.discount_rate),p.product_price) discount_price,i.product_save_filename,c.cart_cnt,IFNULL(p.product_price*(1-d.discount_rate),p.product_price)* c.cart_cnt total_price,c.checked,c.createdate,c.updatedate FROM cart c LEFT OUTER JOIN product p ON c.product_no = p.product_no LEFT OUTER JOIN discount d ON p.product_no = d.product_no LEFT OUTER JOIN product_img i ON p.product_no = i.product_no LEFT OUTER JOIN customer m ON c.id = m.id WHERE m.id = ?;";
		//c.product_no
		//c.cart_no
		//c.id
		//p.product_name
		//discount_price
		//i.product_save_filename
		//c.cart_cnt
		//total_price
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,id);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			cart = new Cart();
			cart.setCartNo(rs.getInt("cart_no"));
			cart.setId(rs.getString("c.id"));
			cart.setProductName(rs.getString("p.product_name"));
			cart.setProductNo(rs.getInt("c.product_no"));
			cart.setPrice(rs.getInt("discount_price"));
			cart.setSumPrice(rs.getInt("total_price"));
			cart.setCartCnt(rs.getInt("c.cart_cnt"));
			cart.setProductName(rs.getString("i.product_save_filename"));
			cart.setChecked(rs.getString("c.checked"));
			cart.setCreatedate(rs.getString("c.createdate"));
			cart.setUpdatedate(rs.getString("c.updatedate"));
		}
		return cart;
	}
	
	// 2) 선택된 사용자가 장바구니에서 선택한 제품에 한하여 총 합계 출력
	public int totalPrice(String id) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		
		String sql = "SELECT sum(IFNULL(p.product_price*(1-d.discount_rate),p.product_price)*c.cart_cnt) seltotal FROM cart c LEFT OUTER JOIN product p ON c.product_no = p.product_no LEFT OUTER JOIN discount d ON p.product_no = d.product_no LEFT OUTER JOIN customer m ON c.id = m.id WHERE m.id = ? AND c.checked='Y';";
		//seltotal
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,id);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = rs.getInt("seltotal");
		}
		
		return row;
	}
	
	// 3) 장바구니에서 구매하기를 누르면 구매페이지로 넘어가는 정보
	
}
