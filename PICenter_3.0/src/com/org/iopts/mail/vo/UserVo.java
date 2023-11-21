package com.org.iopts.mail.vo;

import java.io.Serializable;
import java.util.Arrays;

public class UserVo implements Serializable {
	
	private String user_no;
	private String user_email;
	private String sosok;
	private String user_name;
	
	private int idxList;
	private String detail_con;
	private String comment;
	
	private String notePad;
	
	public UserVo() {
		// TODO Auto-generated constructor stub
	}

	public UserVo(String user_no, String user_email, String sosok, String user_name, int idxList, String detail_con,
			String comment, String note) {
		super();
		this.user_no = user_no;
		this.user_email = user_email;
		this.sosok = sosok;
		this.user_name = user_name;
		this.idxList = idxList;
		this.detail_con = detail_con;
		this.comment = comment;
		this.notePad = notePad;
	}

	public String getUser_no() {
		return user_no;
	}

	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getSosok() {
		return sosok;
	}

	public void setSosok(String sosok) {
		this.sosok = sosok;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getIdxList() {
		return idxList;
	}

	public void setIdxList(int idxList) {
		this.idxList = idxList;
	}

	public String getDetail_con() {
		return detail_con;
	}

	public void setDetail_con(String detail_con) {
		this.detail_con = detail_con;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getNotePad() {
		return notePad;
	}

	public void setNotePad(String notePad) {
		this.notePad = notePad;
	}

	@Override
	public String toString() {
		return "UserVo [user_no=" + user_no + ", user_email=" + user_email + ", sosok=" + sosok + ", user_name="
				+ user_name + ", idxList=" + idxList + ", detail_con=" + detail_con + ", comment=" + comment + ", notePad="
				+ notePad + "]";
	}

	
}