package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class LicenseGroupsVo implements Serializable {
	private String idx;
	private String up_idx;
	private String name;
	private long license_usage;
	private long diff_license_usage;
	private String parent_group;
	private int team;
	private String target_id;
	private int stype;
	
	public LicenseGroupsVo() { 
		// TODO Auto-generated constructor stub
	}
	
	public String getIdx() {
		return idx;
	}



	public void setIdx(String idx) {
		this.idx = idx;
	}



	public String getUp_idx() {
		return up_idx;
	}



	public void setUp_idx(String up_idx) {
		this.up_idx = up_idx;
	}



	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getLicense_usage() {
		return license_usage;
	}

	public void setLicense_usage(long license_usage) {
		this.license_usage = license_usage;
	}
	
	public long getDiff_license_usage() {
		return diff_license_usage;
	}

	public void setDiff_license_usage(long diff_license_usage) {
		this.diff_license_usage = diff_license_usage;
	}

	public int getTeam() {
		return team;
	}

	public void setTeam(int team) {
		this.team = team;
	}

	public String getTarget_id() {
		return target_id;
	}

	public void setTarget_id(String target_id) {
		this.target_id = target_id;
	}

	public String getParent_group() {
		return parent_group;
	}

	public void setParent_group(String parent_group) {
		this.parent_group = parent_group;
	}
	
	public int getStype() {
		return stype;
	}

	public void setStype(int stype) {
		this.stype = stype;
	}

	@Override
	public String toString() {
		return "LicenseGroupsVo [idx=" + idx + ", up_idx=" + up_idx + ", name=" + name + ", license_usage="
				+ license_usage + ", diff_license_usage=" + diff_license_usage + ", parent_group=" + parent_group
				+ ", team=" + team + ", target_id=" + target_id + "]";
	}
	
}