package vo.order;

public class OrdersHistory {
	private int orderNo;
	private String id;
	private int productNo;
	private int orderCnt;
	private int orderHistoryStatus;
	private String createdate;
	private String updatedate;
		
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
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getOrderCnt() {
		return orderCnt;
	}
	public void setOrderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}
	public int getOrderHistoryStatus() {
		return orderHistoryStatus;
	}
	public void setOrderHistoryStatus(int orderHistoryStatus) {
		this.orderHistoryStatus = orderHistoryStatus;
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
