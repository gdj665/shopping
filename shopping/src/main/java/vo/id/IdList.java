package vo.id;

public class IdList {
	private String id;
	private String lastPw;
	private int active;
	private String createdate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLastPw() {
		return lastPw;
	}
	public void setLastPw(String lastPw) {
		this.lastPw = lastPw;
	}
	public int getActive() {
		return active;
	}
	public void setActive(int active) {
		this.active = active;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
}
