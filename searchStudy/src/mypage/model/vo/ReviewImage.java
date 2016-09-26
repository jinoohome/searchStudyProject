package mypage.model.vo;

public class ReviewImage {
	private int listNo;
	private String originPhoto1;
	private String renamePhoto1;
	private String originPhoto2;
	private String renamePhoto2;
	private String originPhoto3;
	private String renamePhoto3;
	private String originPhoto4;
	private String renamePhoto4;
	private String originPhoto5;
	private String renamePhoto5;
	
	public ReviewImage(){}
	
	public ReviewImage(int listNo) {
		super();
		this.listNo = listNo;
	}

	public ReviewImage(int listNo, String originPhoto1, String renamePhoto1) {
		super();
		this.listNo = listNo;
		this.originPhoto1 = originPhoto1;
		this.renamePhoto1 = renamePhoto1;
	}

	public ReviewImage(int listNo, String originPhoto1, String renamePhoto1, String originPhoto2,
			String renamePhoto2) {
		super();
		this.listNo = listNo;
		this.originPhoto1 = originPhoto1;
		this.renamePhoto1 = renamePhoto1;
		this.originPhoto2 = originPhoto2;
		this.renamePhoto2 = renamePhoto2;
	}

	public ReviewImage(int listNo, String originPhoto1, String renamePhoto1, String originPhoto2,
			String renamePhoto2, String originPhoto3, String renamePhoto3) {
		super();
		this.listNo = listNo;
		this.originPhoto1 = originPhoto1;
		this.renamePhoto1 = renamePhoto1;
		this.originPhoto2 = originPhoto2;
		this.renamePhoto2 = renamePhoto2;
		this.originPhoto3 = originPhoto3;
		this.renamePhoto3 = renamePhoto3;
	}

	public ReviewImage(int listNo, String originPhoto1, String renamePhoto1, String originPhoto2,
			String renamePhoto2, String originPhoto3, String renamePhoto3, String originPhoto4,
			String renamePhoto4) {
		super();
		this.listNo = listNo;
		this.originPhoto1 = originPhoto1;
		this.renamePhoto1 = renamePhoto1;
		this.originPhoto2 = originPhoto2;
		this.renamePhoto2 = renamePhoto2;
		this.originPhoto3 = originPhoto3;
		this.renamePhoto3 = renamePhoto3;
		this.originPhoto4 = originPhoto4;
		this.renamePhoto4 = renamePhoto4;
	}

	public ReviewImage(int listNo, String originPhoto1, String renamePhoto1, String originPhoto2,
			String renamePhoto2, String originPhoto3, String renamePhoto3, String originPhoto4,
			String renamePhoto4, String originPhoto5, String renamePhoto5) {
		super();
		this.listNo = listNo;
		this.originPhoto1 = originPhoto1;
		this.renamePhoto1 = renamePhoto1;
		this.originPhoto2 = originPhoto2;
		this.renamePhoto2 = renamePhoto2;
		this.originPhoto3 = originPhoto3;
		this.renamePhoto3 = renamePhoto3;
		this.originPhoto4 = originPhoto4;
		this.renamePhoto4 = renamePhoto4;
		this.originPhoto5 = originPhoto5;
		this.renamePhoto5 = renamePhoto5;
	}

	@Override
	public String toString(){
		return listNo + ", [" + originPhoto1 + ", " + renamePhoto1 + "], "
					+ "[" + originPhoto2 + ", " + renamePhoto2 + "], "
					+ "[" + originPhoto3 + ", " + renamePhoto3 + "], "
					+ "[" + originPhoto4 + ", " + renamePhoto4 + "], "
					+ "[" + originPhoto5 + ", " + renamePhoto5 + "]"; 
	}

	public int getListNo() {
		return listNo;
	}

	public void setListNo(int listNo) {
		this.listNo = listNo;
	}

	public String getOriginPhoto1() {
		return originPhoto1;
	}

	public void setOriginPhoto1(String originPhoto1) {
		this.originPhoto1 = originPhoto1;
	}

	public String getRenamePhoto1() {
		return renamePhoto1;
	}

	public void setRenamePhoto1(String renamePhoto1) {
		this.renamePhoto1 = renamePhoto1;
	}

	public String getOriginPhoto2() {
		return originPhoto2;
	}

	public void setOriginPhoto2(String originPhoto2) {
		this.originPhoto2 = originPhoto2;
	}

	public String getRenamePhoto2() {
		return renamePhoto2;
	}

	public void setRenamePhoto2(String renamePhoto2) {
		this.renamePhoto2 = renamePhoto2;
	}

	public String getOriginPhoto3() {
		return originPhoto3;
	}

	public void setOriginPhoto3(String originPhoto3) {
		this.originPhoto3 = originPhoto3;
	}

	public String getRenamePhoto3() {
		return renamePhoto3;
	}

	public void setRenamePhoto3(String renamePhoto3) {
		this.renamePhoto3 = renamePhoto3;
	}

	public String getOriginPhoto4() {
		return originPhoto4;
	}

	public void setOriginPhoto4(String originPhoto4) {
		this.originPhoto4 = originPhoto4;
	}

	public String getRenamePhoto4() {
		return renamePhoto4;
	}

	public void setRenamePhoto4(String renamePhoto4) {
		this.renamePhoto4 = renamePhoto4;
	}

	public String getOriginPhoto5() {
		return originPhoto5;
	}

	public void setOriginPhoto5(String originPhoto5) {
		this.originPhoto5 = originPhoto5;
	}

	public String getRenamePhoto5() {
		return renamePhoto5;
	}

	public void setRenamePhoto5(String renamePhoto5) {
		this.renamePhoto5 = renamePhoto5;
	}

	

		
}
