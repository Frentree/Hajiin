package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class GroupTreeVo implements Serializable {
	private String idx;
	private String name;
	private String up_idx;
	private int type;
	private String connected;

	public GroupTreeVo() {

	}
	
	 /**
     * @param idx
     * @param name
     * @param up_idx
     * @param type
     * @param connected
     */
    public GroupTreeVo(String idx, String name, String up_idx,
            int type, String connected) {
       
        this.idx = idx;
        this.name = name;
        this.up_idx = up_idx;
        this.type = type;
        this.connected = connected;
    }

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUp_idx() {
		return up_idx;
	}

	public void setUp_idx(String up_idx) {
		this.up_idx = up_idx;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getConnected() {
		return connected;
	}

	public void setConnected(String connected) {
		this.connected = connected;
	}

	@Override
	public String toString() {
		return "GroupTreeVo [idx=" + idx + ", name=" + name + ", up_idx=" + up_idx + ", type=" + type + ", connected="
				+ connected + "]";
	}
   
}