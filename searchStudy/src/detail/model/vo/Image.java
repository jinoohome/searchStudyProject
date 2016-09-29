package detail.model.vo;

import java.io.Serializable;

public class Image implements Serializable {
	private String storeId;
	private String photo1;
	private String photo2;
	private String photo3;
	private String photo4;
	private String photo5;

	public Image() {
	}
	
	public Image(String storeId, String photo1, String photo2, String photo3, String photo4, String photo5) {
		super();
		this.storeId = storeId;
		this.photo1 = photo1;
		this.photo2 = photo2;
		this.photo3 = photo3;
		this.photo4 = photo4;
		this.photo5 = photo5;
	}

	public Image(String photo1, String photo2, String photo3, String photo4, String photo5) {
		super();
		this.photo1 = photo1;
		this.photo2 = photo2;
		this.photo3 = photo3;
		this.photo4 = photo4;
		this.photo5 = photo5;
	}

	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	public String getPhoto1() {
		return photo1;
	}

	public void setPhoto1(String photo1) {
		this.photo1 = photo1;
	}

	public String getPhoto2() {
		return photo2;
	}

	public void setPhoto2(String photo2) {
		this.photo2 = photo2;
	}

	public String getPhoto3() {
		return photo3;
	}

	public void setPhoto3(String photo3) {
		this.photo3 = photo3;
	}

	public String getPhoto4() {
		return photo4;
	}

	public void setPhoto4(String photo4) {
		this.photo4 = photo4;
	}

	public String getPhoto5() {
		return photo5;
	}

	public void setPhoto5(String photo5) {
		this.photo5 = photo5;
	}

	@Override
	public String toString() {
		return "Image [storeId=" + storeId + ", photo1=" + photo1 + ", photo2=" + photo2 + ", photo3=" + photo3
				+ ", photo4=" + photo4 + ", photo5=" + photo5 + "]";
	}


}
