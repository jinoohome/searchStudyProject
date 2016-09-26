package mypage.model.vo;

import java.util.ArrayList;

public class Store {

	private String storeId;
	private String storeName;
	private String categoryName;
	private String localName; 
	private String address;
	private String price;
	private String openTime;
	private String closeTime;
	private int count;
	private String etc;
	private ArrayList photoList;
	
	public Store() {}
	
	public Store(String storeId, String storeName, String categoryName, String localName, String address, String price,
			String openTime, String closeTime, int count, String etc, ArrayList photoList) {
		super();
		this.storeId = storeId;
		this.storeName = storeName;
		this.categoryName = categoryName;
		this.localName = localName;
		this.address = address;
		this.price = price;
		this.openTime = openTime;
		this.closeTime = closeTime;
		this.count = count;
		this.etc = etc;
		this.photoList = photoList;
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

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getLocalName() {
		return localName;
	}

	public void setLocalName(String localName) {
		this.localName = localName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getOpenTime() {
		return openTime;
	}

	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	public String getCloseTime() {
		return closeTime;
	}

	public void setCloseTime(String closeTime) {
		this.closeTime = closeTime;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public ArrayList getPhotoList() {
		return photoList;
	}

	public void setPhotoList(ArrayList photoList) {
		this.photoList = photoList;
	}

	@Override
	public String toString() {
		return this.storeId + " " + this.storeName + " " + 
				this.categoryName + " " + this.localName + " " +
				this.address + " " + this.price + " " +
				this.openTime + " " +  this.closeTime + " " +
				this.count + " " +  this.etc + " " +
				this.photoList.get(0) +" " +  this.photoList.get(1) +" "+ 
				this.photoList.get(2) + " " + this.photoList.get(3) + " " +
				 this.photoList.get(4); 
				
				
	}
	
	


	
	
}