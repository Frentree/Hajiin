package com.org.iopts.dto.co;

import com.google.gson.annotations.SerializedName;

public class PauseCo {
	@SerializedName("days")
	private String days;
	
	@SerializedName("from")
	private String from;
	
	@SerializedName("to")
	private String to;
	

	public String getDays() {
		return days;
	}

	public void setDays(String days) {
		this.days = days;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

}
