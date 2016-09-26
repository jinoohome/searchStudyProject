package detail.model.vo;

import java.io.Serializable;

public class Store implements Serializable{
	//Field
	private String storeId;
	private String storeName;
	private String categoryId;
	private String localCode;
	private String address;
	private String homepage;
	private String tell;
	private String price;
	private String weekDayTime;
	private String weekEndTime;
	private String etc;
	
	//Constructor
	public Store(){}
	

	public Store(String storeName, String categoryId, String localCode, String address, String homepage,
			String tell, String price, String weekDayTime, String weekEndTime, String etc) {
		super();

		this.storeName = storeName;
		this.categoryId = categoryId;
		this.localCode = localCode;
		this.address = address;
		this.homepage = homepage;
		this.tell = tell;
		this.price = price;
		this.weekDayTime = weekDayTime;
		this.weekEndTime = weekEndTime;
		this.etc = etc;
	}
	
	
	
	public Store(String storeId, String storeName, String categoryId, String localCode, String address, String homepage,
			String tell, String price, String weekDayTime, String weekEndTime, String etc) {
		super();
		this.storeId = storeId;
		this.storeName = storeName;
		this.categoryId = categoryId;
		this.localCode = localCode;
		this.address = address;
		this.homepage = homepage;
		this.tell = tell;
		this.price = price;
		this.weekDayTime = weekDayTime;
		this.weekEndTime = weekEndTime;
		this.etc = etc;
	}


	@Override
	public String toString(){
		return  storeId  + ", " +  storeName + ", " + categoryId + ", " + localCode + ", " + address + ", " + homepage + ", " + 
				tell + ", " + price + ", " + weekDayTime + ", " + weekEndTime + ", " + etc;
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

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getLocalCode() {
		return localCode;
	}

	public void setLocalCode(String localCode) {
		this.localCode = localCode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getHomepage() {
		return homepage;
	}

	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}

	public String getTell() {
		return tell;
	}

	public void setTell(String tell) {
		this.tell = tell;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getWeekDayTime() {
		return weekDayTime;
	}

	public void setWeekDayTime(String weekDayTime) {
		this.weekDayTime = weekDayTime;
	}

	public String getWeekEndTime() {
		return weekEndTime;
	}

	public void setWeekEndTime(String weekEndTime) {
		this.weekEndTime = weekEndTime;
	}


	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}
	
	

}
