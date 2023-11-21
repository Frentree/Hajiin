package com.org.iopts.dto.co;

import java.util.List;

import com.google.gson.annotations.SerializedName;

public class SchTargetCo {
	@SerializedName("id")
	private String id;
	
	@SerializedName("name")
	private String name;
	
	@SerializedName("locations")
	private List<SchLocationCo> locations;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<SchLocationCo> getLocations() {
		return locations;
	}

	public void setLocations(List<SchLocationCo> locations) {
		this.locations = locations;
	}
}
