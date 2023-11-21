package com.org.iopts.detection.vo;

import java.io.Serializable;
import java.util.Arrays;

public class GlobalFilterVo implements Serializable {
	private String id;
	private String apply_to;
	private String type;
	private String expression;
	private String name;
	private String status;
	private String network;

	public GlobalFilterVo() {
		// TODO Auto-generated constructor stub
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getApply_to() {
		return apply_to;
	}

	public void setApply_to(String apply_to) {
		this.apply_to = apply_to;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getExpression() {
		return expression;
	}

	public void setExpression(String expression) {
		this.expression = expression;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	public String getNetwork() {
		return network;
	}

	public void setNetwork(String network) {
		this.network = network;
	}

	@Override
	public String toString() {
		return "GlobalFilterVo [id=" + id + ", apply_to=" + apply_to + ", type=" + type + ", expression=" + expression
				+ ", name=" + name + ", status=" + status + ", network=" + network + "]";
	}
	
	
}