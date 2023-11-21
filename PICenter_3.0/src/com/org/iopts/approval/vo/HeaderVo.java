package com.org.iopts.approval.vo;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "HEAD")
@XmlAccessorType(XmlAccessType.FIELD)
public class HeaderVo {
	@XmlElement(name = "CNCODE")
	private String cncode;
	
	@XmlElement(name = "MODULE")
	private String module;
	
	@XmlElement(name = "MSGSTR")
	private String msgstr;
	
	@XmlElement(name = "SYSCODE")
	private String syscode;

	public String getCncode() {
		return cncode;
	}

	public void setCncode(String cncode) {
		this.cncode = cncode;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getMsgstr() {
		return msgstr;
	}

	public void setMsgstr(String msgstr) {
		this.msgstr = msgstr;
	}

	public String getSyscode() {
		return syscode;
	}

	public void setSyscode(String syscode) {
		this.syscode = syscode;
	}
	
}
