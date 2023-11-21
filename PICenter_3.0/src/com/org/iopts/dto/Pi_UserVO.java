package com.org.iopts.dto;

import java.util.Date;

public class Pi_UserVO {
	
	private String user_no;
	private String team_name;
	private String jikwee;
	private String jikguk;
	private String boss_name;
	private String user_name;
	private Date regdate;
	private int approval_id;
	
	public int getApproval_id() {
		return approval_id;
	}
	public void setApproval_id(int approval_id) {
		this.approval_id = approval_id;
	}
	public String getUser_no() {
		return user_no;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getJikwee() {
		return jikwee;
	}
	public void setJikwee(String jikwee) {
		this.jikwee = jikwee;
	}
	public String getJikguk() {
		return jikguk;
	}
	public void setJikguk(String jikguk) {
		this.jikguk = jikguk;
	}
	public String getBoss_name() {
		return boss_name;
	}
	public void setBoss_name(String boss_name) {
		this.boss_name = boss_name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
		
}
