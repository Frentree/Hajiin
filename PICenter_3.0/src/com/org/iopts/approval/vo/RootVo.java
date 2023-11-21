package com.org.iopts.approval.vo;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "ROOT")
@XmlAccessorType(XmlAccessType.FIELD)
public class RootVo {
	@XmlElement(name = "HEAD")
	private HeaderVo header;
	
	@XmlElement(name = "BODY")
	private BodyVo body;

	public HeaderVo getHeader() {
		return header;
	}

	public void setHeader(HeaderVo header) {
		this.header = header;
	}

	public BodyVo getBody() {
		return body;
	}

	public void setBody(BodyVo body) {
		this.body = body;
	}
	
}
