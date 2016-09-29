package detail.model.vo;

import java.io.Serializable;

public class Service implements Serializable {

	private String storeId;
	private String laptop;
	private String beam;
	private String wifi;
	private String board;

	public Service() {
	}
	
	public Service(String storeId, String laptop, String beam, String wifi, String board) {
		super();
		this.storeId = storeId;
		this.laptop = laptop;
		this.beam = beam;
		this.wifi = wifi;
		this.board = board;
	}

	public String getStoreId() {
		return storeId;
	}

	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}

	public String getLaptop() {
		return laptop;
	}

	public void setLaptop(String laptop) {
		this.laptop = laptop;
	}

	public String getBeam() {
		return beam;
	}

	public void setBeam(String beam) {
		this.beam = beam;
	}

	public String getWifi() {
		return wifi;
	}

	public void setWifi(String wifi) {
		this.wifi = wifi;
	}

	public String getBoard() {
		return board;
	}

	public void setBoard(String board) {
		this.board = board;
	}

	@Override
	public String toString() {
		return "Service [storeId=" + storeId + ", laptop=" + laptop + ", beam=" + beam + ", wifi=" + wifi + ", board="
				+ board + "]";
	}
	

}
