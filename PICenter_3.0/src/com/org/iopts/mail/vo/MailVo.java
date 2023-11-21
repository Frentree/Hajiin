package com.org.iopts.mail.vo;

import java.io.Serializable;
import java.util.Arrays;

public class MailVo implements Serializable {
	private String hostnm;
	private String target_id;
	private String bpinfrauser;
	private String bpinfrauser_mail;
	private String bpappuserid;
	private String bpappuser_mail;
	private String sktinfrauserid;
	private String sktinfrauser_mail;
	private String assetnosch;
	private String date;
	
	private String service_nm;
	private String agent_connected_ip;
	
	
	public MailVo() {
		// TODO Auto-generated constructor stub
	}


	public MailVo(String hostnm, String target_id, String bpinfrauser, String bpinfrauser_mail, String bpappuserid,
			String bpappuser_mail, String sktinfrauserid, String sktinfrauser_mail, String assetnosch, String date,
			String service_nm, String agent_connected_ip) {
		super();
		this.hostnm = hostnm;
		this.target_id = target_id;
		this.bpinfrauser = bpinfrauser;
		this.bpinfrauser_mail = bpinfrauser_mail;
		this.bpappuserid = bpappuserid;
		this.bpappuser_mail = bpappuser_mail;
		this.sktinfrauserid = sktinfrauserid;
		this.sktinfrauser_mail = sktinfrauser_mail;
		this.assetnosch = assetnosch;
		this.date = date;
		this.service_nm = service_nm;
		this.agent_connected_ip = agent_connected_ip;
	}


	public String getHostnm() {
		return hostnm;
	}


	public void setHostnm(String hostnm) {
		this.hostnm = hostnm;
	}


	public String getTarget_id() {
		return target_id;
	}


	public void setTarget_id(String target_id) {
		this.target_id = target_id;
	}


	public String getBpinfrauser() {
		return bpinfrauser;
	}


	public void setBpinfrauser(String bpinfrauser) {
		this.bpinfrauser = bpinfrauser;
	}


	public String getBpinfrauser_mail() {
		return bpinfrauser_mail;
	}


	public void setBpinfrauser_mail(String bpinfrauser_mail) {
		this.bpinfrauser_mail = bpinfrauser_mail;
	}


	public String getBpappuserid() {
		return bpappuserid;
	}


	public void setBpappuserid(String bpappuserid) {
		this.bpappuserid = bpappuserid;
	}


	public String getBpappuser_mail() {
		return bpappuser_mail;
	}


	public void setBpappuser_mail(String bpappuser_mail) {
		this.bpappuser_mail = bpappuser_mail;
	}


	public String getSktinfrauserid() {
		return sktinfrauserid;
	}


	public void setSktinfrauserid(String sktinfrauserid) {
		this.sktinfrauserid = sktinfrauserid;
	}


	public String getSktinfrauser_mail() {
		return sktinfrauser_mail;
	}


	public void setSktinfrauser_mail(String sktinfrauser_mail) {
		this.sktinfrauser_mail = sktinfrauser_mail;
	}


	public String getAssetnosch() {
		return assetnosch;
	}


	public void setAssetnosch(String assetnosch) {
		this.assetnosch = assetnosch;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public String getService_nm() {
		return service_nm;
	}


	public void setService_nm(String service_nm) {
		this.service_nm = service_nm;
	}


	public String getAgent_connected_ip() {
		return agent_connected_ip;
	}


	public void setAgent_connected_ip(String agent_connected_ip) {
		this.agent_connected_ip = agent_connected_ip;
	}


	@Override
	public String toString() {
		return "MailVo [hostnm=" + hostnm + ", target_id=" + target_id + ", bpinfrauser=" + bpinfrauser
				+ ", bpinfrauser_mail=" + bpinfrauser_mail + ", bpappuserid=" + bpappuserid + ", bpappuser_mail="
				+ bpappuser_mail + ", sktinfrauserid=" + sktinfrauserid + ", sktinfrauser_mail=" + sktinfrauser_mail
				+ ", assetnosch=" + assetnosch + ", date=" + date + ", service_nm=" + service_nm
				+ ", agent_connected_ip=" + agent_connected_ip + "]";
	}

	

}