package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class ScheduleServerVo implements Serializable {
	private String idx;
	private String id;
	private int ap_no;
	private String name;
	private String up_idx;
	private int type;
	private boolean agent_connected;
	private int agent_connected_chk;
	private String agent_connected_ip;
	private String target_id;
	private String mac_name;
	private String platform;
	private String location_id;
	private int connected;
	private int cores;
	
	private String comdate;

	public ScheduleServerVo() {
		// TODO Auto-generated constructor stub
	}

	public ScheduleServerVo(String idx, int ap_no, String name, String up_idx, int type, boolean agent_connected,
			int agent_connected_chk, String agent_connected_ip, String target_id, String mac_name, String platform, String location_id, int connected, int cores) {
		super();
		this.idx = idx;
		this.ap_no = ap_no;
		this.name = name;
		this.up_idx = up_idx;
		this.type = type;
		this.agent_connected = agent_connected;
		this.agent_connected_chk = agent_connected_chk;
		this.agent_connected_ip = agent_connected_ip;
		this.target_id = target_id;
		this.mac_name = mac_name;
		this.platform = platform;
		this.location_id = location_id;
		this.connected = connected;
		this.cores = cores;
	}
	
	public ScheduleServerVo(String idx, int ap_no, String name, String up_idx, int type, boolean agent_connected,
			int agent_connected_chk, String agent_connected_ip, String target_id, String mac_name, String platform, String location_id, int connected,
			int cores, String comdate) {
		super();
		this.idx = idx;
		this.ap_no = ap_no;
		this.name = name;
		this.up_idx = up_idx;
		this.type = type;
		this.agent_connected = agent_connected;
		this.agent_connected_chk = agent_connected_chk;
		this.agent_connected_ip = agent_connected_ip;
		this.target_id = target_id;
		this.mac_name = mac_name;
		this.platform = platform;
		this.location_id = location_id;
		this.connected = connected;
		this.cores = cores;
		this.comdate = comdate;
	}
	
	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
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

	public boolean isAgent_connected() {
		return agent_connected;
	}

	public void setAgent_connected(boolean agent_connected) {
		this.agent_connected = agent_connected;
	}

	public int getAgent_connected_chk() {
		return agent_connected_chk;
	}

	public void setAgent_connected_chk(int agent_connected_chk) {
		this.agent_connected_chk = agent_connected_chk;
	}

	public String getAgent_connected_ip() {
		return agent_connected_ip;
	}

	public void setAgent_connected_ip(String agent_connected_ip) {
		this.agent_connected_ip = agent_connected_ip;
	}

	public String getTarget_id() {
		return target_id;
	}

	public void setTarget_id(String target_id) {
		this.target_id = target_id;
	}

	public String getMac_name() {
		return mac_name;
	}

	public void setMac_name(String mac_name) {
		this.mac_name = mac_name;
	}

	public String getPlatform() {
		return platform;
	}

	public void setPlatform(String platform) {
		this.platform = platform;
	}

	public String getLocation_id() {
		return location_id;
	}

	public void setLocation_id(String location_id) {
		this.location_id = location_id;
	}

	public int getConnected() {
		return connected;
	}

	public void setConnected(int connected) {
		this.connected = connected;
	}

	public int getCores() {
		return cores;
	}

	public void setCores(int cores) {
		this.cores = cores;
	}

	public String getComdate() {
		return comdate;
	}

	public void setComdate(String comdate) {
		this.comdate = comdate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "ScheduleServerVo [idx=" + idx + ", id=" + id + ", ap_no=" + ap_no + ", name=" + name + ", up_idx="
				+ up_idx + ", type=" + type + ", agent_connected=" + agent_connected + ", agent_connected_chk="
				+ agent_connected_chk + ", agent_connected_ip=" + agent_connected_ip + ", target_id=" + target_id
				+ ", mac_name=" + mac_name + ", platform=" + platform + ", location_id=" + location_id + ", connected="
				+ connected + ", cores=" + cores + ", comdate=" + comdate + "]";
	}
	
	

}