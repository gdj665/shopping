package vo.order;

public class Orders {
	private int orderNo;
	private String id;
	private int orderStatus;
	private int orderPrice;
	private int orderPointUse;
	private String productSaveFilename;
	private String createdate;
	private String updatedate;
	
	public String getProductSaveFilename() {
		return productSaveFilename;
	}
	public void setProductSaveFilename(String productSaveFilename) {
		this.productSaveFilename = productSaveFilename;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}
	public int getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}
	public int getOrderPointUse() {
		return orderPointUse;
	}
	public void setOrderPointUse(int orderPointUse) {
		this.orderPointUse = orderPointUse;
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
