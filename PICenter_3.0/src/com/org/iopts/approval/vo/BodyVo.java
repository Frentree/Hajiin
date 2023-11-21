package com.org.iopts.approval.vo;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "BODY")
@XmlAccessorType(XmlAccessType.FIELD)
public class BodyVo {
	@XmlElement(name = "IFIDVALUE")
	private String ifidvalue;
	@XmlElement(name = "SUBJECT")
	private String subject;
	@XmlElement(name = "USERID")
	private String userid;
	@XmlElement(name = "FORMCODE")
	private String formcode;
	@XmlElement(name = "KEYFORMCODE")
	private String keyformcode;
	@XmlElement(name = "APPLINEINFO")
	private String applineinfo;
	@XmlElement(name = "APPLINE")
	private String appline;
	@XmlElement(name = "APPOPTION")
	private String appoption;
	@XmlElement(name = "NOTIFY")
	private String notify;
	@XmlElement(name = "KEEPFOR")
	private String keepfor;
	@XmlElement(name = "SECURITY")
	private String security;
	@XmlElement(name = "DOCTYPE")
	private String doctype;
	@XmlElement(name = "FIELDLIST")
	private String filedlist;
	@XmlElement(name = "SABUN")
	private String sabun;
	@XmlElement(name = "NAME")
	private String name;
	@XmlElement(name = "SOSOK")
	private String sosok;
	public String getIfidvalue() {
		return ifidvalue;
	}
	public void setIfidvalue(String ifidvalue) {
		this.ifidvalue = ifidvalue;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getFormcode() {
		return formcode;
	}
	public void setFormcode(String formcode) {
		this.formcode = formcode;
	}
	public String getKeyformcode() {
		return keyformcode;
	}
	public void setKeyformcode(String keyformcode) {
		this.keyformcode = keyformcode;
	}
	public String getApplineinfo() {
		return applineinfo;
	}
	public void setApplineinfo(String applineinfo) {
		this.applineinfo = applineinfo;
	}
	public String getAppline() {
		return appline;
	}
	public void setAppline(String appline) {
		this.appline = appline;
	}
	public String getAppoption() {
		return appoption;
	}
	public void setAppoption(String appoption) {
		this.appoption = appoption;
	}
	public String getNotify() {
		return notify;
	}
	public void setNotify(String notify) {
		this.notify = notify;
	}
	public String getKeepfor() {
		return keepfor;
	}
	public void setKeepfor(String keepfor) {
		this.keepfor = keepfor;
	}
	public String getSecurity() {
		return security;
	}
	public void setSecurity(String security) {
		this.security = security;
	}
	public String getDoctype() {
		return doctype;
	}
	public void setDoctype(String doctype) {
		this.doctype = doctype;
	}
	public String getFiledlist() {
		return filedlist;
	}
	public void setFiledlist(String filedlist) {
		this.filedlist = filedlist;
	}
	public String getSabun() {
		return sabun;
	}
	public void setSabun(String sabun) {
		this.sabun = sabun;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSosok() {
		return sosok;
	}
	public void setSosok(String sosok) {
		this.sosok = sosok;
	}
	
}
