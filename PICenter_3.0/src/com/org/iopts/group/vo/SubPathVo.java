package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class SubPathVo implements Serializable {
	private String idx;
	private String parent_id;
	private String target_id;
	private int ap_no;
	private String name;
	private String fid;

	public SubPathVo() {

	}

	public SubPathVo(String idx, String parent_id, String target_id, int ap_no, String name, String fid) {
		super();
		this.idx = idx;
		this.parent_id = parent_id;
		this.target_id = target_id;
		this.ap_no = ap_no;
		this.name = name;
		this.fid = fid;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String getParent_id() {
		return parent_id;
	}

	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}

	public String getTarget_id() {
		return target_id;
	}

	public void setTarget_id(String target_id) {
		this.target_id = target_id;
	}

	public int getAp_no() {
		return ap_no;
	}

	public void setAp_no(int ap_no) {
		this.ap_no = ap_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	

	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
		this.fid = fid;
	}

	@Override
	public String toString() {
		return "SubPathVo [idx=" + idx + ", parent_id=" + parent_id + ", target_id=" + target_id + ", ap_no=" + ap_no
				+ ", name=" + name + "]";
	}
	
}