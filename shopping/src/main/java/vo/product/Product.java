package vo.product;

public class Product {
	private int productNo;
	private int categoryNo;
	private String productName;
	private int productPrice;
	private int productDiscountPrice;
	private String productStatus;
	private int productStock;
	private String productInfo;
	private int trackSumTime;
	private String productSinger;
	private String trackName;
	// 화면 표시할때 하나의 클래스로 표시해야 ArrayList에서 데이터 넣기 편함
	private String productSaveFilename;
	private String productFiletype;
	private String createdate;
	private String updatedate;
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public int getProductDiscountPrice() {
		return productDiscountPrice;
	}
	public void setProductDiscountPrice(int productDiscountPrice) {
		this.productDiscountPrice = productDiscountPrice;
	}
	public String getProductStatus() {
		return productStatus;
	}
	public void setProductStatus(String productStatus) {
		this.productStatus = productStatus;
	}
	public int getProductStock() {
		return productStock;
	}
	public void setProductStock(int productStock) {
		this.productStock = productStock;
	}
	public String getProductInfo() {
		return productInfo;
	}
	public void setProductInfo(String productInfo) {
		this.productInfo = productInfo;
	}
	public int getTrackSumTime() {
		return trackSumTime;
	}
	public void setTrackSumTime(int trackSumTime) {
		this.trackSumTime = trackSumTime;
	}
	public String getProductSinger() {
		return productSinger;
	}
	public void setProductSinger(String productSinger) {
		this.productSinger = productSinger;
	}
	public String getTrackName() {
		return trackName;
	}
	public void setTrackName(String trackName) {
		this.trackName = trackName;
	}
	public String getProductSaveFilename() {
		return productSaveFilename;
	}
	public void setProductSaveFilename(String productSaveFilename) {
		this.productSaveFilename = productSaveFilename;
	}
	public String getProductFiletype() {
		return productFiletype;
	}
	public void setProductFiletype(String productFiletype) {
		this.productFiletype = productFiletype;
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
