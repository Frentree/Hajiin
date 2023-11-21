package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class GroupTreeServerVo implements Serializable {
	private String idx;
	private String name;
	private String up_idx;
	private int level;
	private int type;
	private String fullname;
	private String fullid;
	private boolean agent_connected;
	private String agent_connected_ip;

	public GroupTreeServerVo() {

	}
	
	 /**
     * @param idx
     * @param name
     * @param up_idx
     * @param level
     * @param fullid
     * @param agent_connected
     * @param agent_connected_ip
     */
    public GroupTreeServerVo(String idx, String name, String up_idx,
            int level, int type, String fullname, String fullid, boolean agent_connected, String agent_connected_ip) {
       
        this.idx = idx;
        this.name = name;
        this.up_idx = up_idx;
        this.level = level;
        this.type = type;
        this.fullname = fullname;
        this.fullid = fullid;
        this.agent_connected = agent_connected;
        this.agent_connected_ip = agent_connected_ip;
    }
   

	@Override
	public String toString() {
		return "GroupTreeServerVo [idx=" + idx + ", name=" + name + ", up_idx=" + up_idx + ", level=" + level
				+ ", type=" + type + ", fullname=" + fullname + ", fullid=" + fullid + "]";
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

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getFullid() {
		return fullid;
	}

	public void setFullid(String fullid) {
		this.fullid = fullid;
	}
	
	public boolean isAgent_connected() {
		return agent_connected;
	}

	public void setAgent_connected(boolean agent_connected) {
		this.agent_connected = agent_connected;
	}

	public String getAgent_connected_ip() {
		return agent_connected_ip;
	}

	public void setAgent_connected_ip(String agent_connected_ip) {
		this.agent_connected_ip = agent_connected_ip;
	}
	
	
}