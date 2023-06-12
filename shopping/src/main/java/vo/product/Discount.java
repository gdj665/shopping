package vo.product;

public class Discount {
	private int discountNo;
	private int productNo;
	private String productName;
	private String discountBegin;
	private String discountEnd;
	private double discountRate;
	private String createdate;
	private String updatedate;
	public int getDiscountNo() {
		return discountNo;
	}
	public void setDiscountNo(int discountNo) {
		this.discountNo = discountNo;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getDiscountBegin() {
		return discountBegin;
	}
	public void setDiscountBegin(String discountBegin) {
		this.discountBegin = discountBegin;
	}
	public String getDiscountEnd() {
		return discountEnd;
	}
	public void setDiscountEnd(String discountEnd) {
		this.discountEnd = discountEnd;
	}
	public double getDiscountRate() {
		return discountRate;
	}
	public void setDiscountRate(double discountRate) {
		this.discountRate = discountRate;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
}
