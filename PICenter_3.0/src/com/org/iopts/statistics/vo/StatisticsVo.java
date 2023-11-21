package com.org.iopts.statistics.vo;

import java.io.Serializable;
import java.util.Arrays;

public class StatisticsVo implements Serializable {
	private String target_id;
	private int ap_no;
	private int path_cnt;
	private int total;
	private int rrn;
	private int mobile_phone;
	private int account_num;
	private int card_num;
	private int foreigner;
	private int driver;
	private int email;
	private int passport;
	private String service_nm;
	private int maxresult;
	
	private int local_phone;
	
	private String Type;
	
	public StatisticsVo() {
		// TODO Auto-generated constructor stub
	}

	public StatisticsVo(String target_id, int ap_no, int path_cnt, int total, int rrn, int mobile_phone,
			int account_num, int card_num, int foreigner, int driver, int email, int passport, String service_nm,
			int maxresult, int local_phone, String type) {
		super();
		this.target_id = target_id;
		this.ap_no = ap_no;
		this.path_cnt = path_cnt;
		this.total = total;
		this.rrn = rrn;
		this.mobile_phone = mobile_phone;
		this.account_num = account_num;
		this.card_num = card_num;
		this.foreigner = foreigner;
		this.driver = driver;
		this.email = email;
		this.passport = passport;
		this.service_nm = service_nm;
		this.maxresult = maxresult;
		this.local_phone = local_phone;
		Type = type;
	}

	public String getTarget_id() {
		return target_id;
	}

	public void setTarget_id(String target_id) {
		this.target_id = target_id;
	}

	public int getAp_no() {
		return ap_no;
	}

	public void setAp_no(int ap_no) {
		this.ap_no = ap_no;
	}

	public int getPath_cnt() {
		return path_cnt;
	}

	public void setPath_cnt(int path_cnt) {
		this.path_cnt = path_cnt;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getRrn() {
		return rrn;
	}

	public void setRrn(int rrn) {
		this.rrn = rrn;
	}

	public int getMobile_phone() {
		return mobile_phone;
	}

	public void setMobile_phone(int mobile_phone) {
		this.mobile_phone = mobile_phone;
	}

	public int getAccount_num() {
		return account_num;
	}

	public void setAccount_num(int account_num) {
		this.account_num = account_num;
	}

	public int getCard_num() {
		return card_num;
	}

	public void setCard_num(int card_num) {
		this.card_num = card_num;
	}

	public int getForeigner() {
		return foreigner;
	}

	public void setForeigner(int foreigner) {
		this.foreigner = foreigner;
	}

	public int getDriver() {
		return driver;
	}

	public void setDriver(int driver) {
		this.driver = driver;
	}

	public int getEmail() {
		return email;
	}

	public void setEmail(int email) {
		this.email = email;
	}

	public int getPassport() {
		return passport;
	}

	public void setPassport(int passport) {
		this.passport = passport;
	}

	public String getService_nm() {
		return service_nm;
	}

	public void setService_nm(String service_nm) {
		this.service_nm = service_nm;
	}

	public int getMaxresult() {
		return maxresult;
	}

	public void setMaxresult(int maxresult) {
		this.maxresult = maxresult;
	}

	public int getLocal_phone() {
		return local_phone;
	}

	public void setLocal_phone(int local_phone) {
		this.local_phone = local_phone;
	}

	public String getType() {
		return Type;
	}

	public void setType(String type) {
		Type = type;
	}

	@Override
	public String toString() {
		return "StatisticsVo [target_id=" + target_id + ", ap_no=" + ap_no + ", path_cnt=" + path_cnt + ", total="
				+ total + ", rrn=" + rrn + ", mobile_phone=" + mobile_phone + ", account_num=" + account_num
				+ ", card_num=" + card_num + ", foreigner=" + foreigner + ", driver=" + driver + ", email=" + email
				+ ", passport=" + passport + ", service_nm=" + service_nm + ", maxresult=" + maxresult
				+ ", local_phone=" + local_phone + ", Type=" + Type + "]";
	}
}