package com.org.iopts.search.vo;

import java.io.Serializable;
import java.util.Arrays;

public class DataTypeVo implements Serializable {

	private String datatype_id;
	private String std_id;
	private int ap_no;
	private String datatype_label;
	private String create_user;
	private String ocr;
	private String recent;
	private String capture;
	

	public DataTypeVo() {

	}
	
	 /**
     * @param datatype_id
     * @param std_id
     * @param ap_no
     * @param datatype_label
     * @param create_user
     * @param ocr
     * @param recent
     * @param capture
     */
    public DataTypeVo(String datatype_id,
    		String std_id, 
            int ap_no, 
            String datatype_label,  
            String create_user, 
            String ocr, 
            String recent, 
            String capture) {
       
        this.datatype_id = datatype_id;
        this.std_id = std_id;
        this.ap_no = ap_no;
        this.datatype_label = datatype_label;
        this.create_user = create_user;
        this.ocr = ocr;
        this.recent = recent;
        this.capture = capture;
    }

	@Override
	public String toString() {
		return "DataTypeVo [datatype_id=" + datatype_id + ", std_id=" + std_id + ", ap_no=" + ap_no
				+ ", datatype_label=" + datatype_label + ", create_user=" + create_user + ", ocr=" + ocr + ", recent="
				+ recent + ", capture=" + capture + "]";
	}

	public String getDatatype_id() {
		return datatype_id;
	}

	public void setDatatype_id(String datatype_id) {
		this.datatype_id = datatype_id;
	}

	public String getStd_id() {
		return std_id;
	}

	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}

	public int getAp_no() {
		return ap_no;
	}

	public void setAp_no(int ap_no) {
		this.ap_no = ap_no;
	}

	public String getDatatype_label() {
		return datatype_label;
	}

	public void setDatatype_label(String datatype_label) {
		this.datatype_label = datatype_label;
	}

	public String getCreate_user() {
		return create_user;
	}

	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}

	public String getOcr() {
		return ocr;
	}

	public void setOcr(String ocr) {
		this.ocr = ocr;
	}

	public String getRecent() {
		return recent;
	}

	public void setRecent(String recent) {
		this.recent = recent;
	}

	public String getCapture() {
		return capture;
	}

	public void setCapture(String capture) {
		this.capture = capture;
	}

}