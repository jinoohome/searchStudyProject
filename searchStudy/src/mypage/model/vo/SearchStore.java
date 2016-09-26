package mypage.model.vo;

public class SearchStore implements java.io.Serializable{
	
	private String storeId;
	private String storeName;
	private String localName;
	private String categoryName;
	private int score;
	private String price;
	private String homepage;
	private String imgRoute;
	
	public SearchStore(){}

	public SearchStore(String storeId, String storeName, String localName, String categoryName, int score, String price,
			String homepage, String imgRoute) {
		super();
		this.storeId = storeId;
		this.storeName = storeName;
		this.localName = localName;
		this.categoryName = categoryName;
		this.score = score;
		this.price = price;
		this.homepage = homepage;
		this.imgRoute = imgRoute;
	}

	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getLocalName() {
		return localName;
	}

	public void setLocalName(String localName) {
		this.localName = localName;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getHomepage() {
		return homepage;
	}

	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}

	public String getImgRoute() {
		return imgRoute;
	}

	public void setImgRoute(String imgRoute) {
		this.imgRoute = imgRoute;
	}
	
	@Override
	public String toString(){
		return storeName+", "+categoryName+", "+localName+
				", "+score+", "+price+", "+homepage+", "+imgRoute;
	}
	
}
