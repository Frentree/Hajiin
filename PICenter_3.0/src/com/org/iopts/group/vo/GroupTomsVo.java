package com.org.iopts.group.vo;

import java.io.Serializable;
import java.sql.Date;
import java.util.Arrays;

public class GroupTomsVo implements Serializable {
	private String idx;
	private String name;
	private String target_id;
	private int ap_no;
	private String up_idx;
	private int type;
	private String credate;
	private int process;
	private String platform;
	private String agent_connected_ip;
	private String agent_connected;
	
	private String location_id;
	private String comdate;
	

	public GroupTomsVo() {

	}


	public GroupTomsVo(String idx, String name, String target_id, int ap_no, String up_idx, int type, String credate,
			int process, String platform, String agent_connected_ip, String agent_connected, String location_id,
			String comdate) {
		super();
		this.idx = idx;
		this.name = name;
		this.target_id = target_id;
		this.ap_no = ap_no;
		this.up_idx = up_idx;
		this.type = type;
		this.credate = credate;
		this.process = process;
		this.platform = platform;
		this.agent_connected_ip = agent_connected_ip;
		this.agent_connected = agent_connected;
		this.location_id = location_id;
		this.comdate = comdate;
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


	public String getCredate() {
		return credate;
	}


	public void setCredate(String credate) {
		this.credate = credate;
	}


	public int getProcess() {
		return process;
	}


	public void setProcess(int process) {
		this.process = process;
	}


	public String getPlatform() {
		return platform;
	}


	public void setPlatform(String platform) {
		this.platform = platform;
	}


	public String getAgent_connected_ip() {
		return agent_connected_ip;
	}


	public void setAgent_connected_ip(String agent_connected_ip) {
		this.agent_connected_ip = agent_connected_ip;
	}


	public String getAgent_connected() {
		return agent_connected;
	}


	public void setAgent_connected(String agent_connected) {
		this.agent_connected = agent_connected;
	}


	public String getLocation_id() {
		return location_id;
	}


	public void setLocation_id(String location_id) {
		this.location_id = location_id;
	}


	public String getComdate() {
		return comdate;
	}


	public void setComdate(String comdate) {
		this.comdate = comdate;
	}


	@Override
	public String toString() {
		return "GroupTomsVo [idx=" + idx + ", name=" + name + ", target_id=" + target_id + ", ap_no=" + ap_no
				+ ", up_idx=" + up_idx + ", type=" + type + ", credate=" + credate + ", process=" + process
				+ ", platform=" + platform + ", agent_connected_ip=" + agent_connected_ip + ", agent_connected="
				+ agent_connected + ", location_id=" + location_id + ", comdate=" + comdate + "]";
	}
}