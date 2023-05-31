package dao.main;

import util.DBUtil;
import vo.product.Product;

public class MainDao {
	public Product selectRecentlyProduct() {
		DBUtil conn = new DBUtil();
		String sql = "SELECT FROM product ORDER BY "
		return null;
	}
}
