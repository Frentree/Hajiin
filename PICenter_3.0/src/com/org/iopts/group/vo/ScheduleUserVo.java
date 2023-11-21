package com.org.iopts.group.vo;

import java.io.Serializable;

public class ScheduleUserVo implements Serializable {
	private String target_id;
	private int ap_no;
	private String name;
	private String mac_name;
	private String platform;
	private boolean agent_connected;
	private int agent_connected_chk;
	private String agent_connected_ip;
	private String target_use;
	private String location_id;
	private int cores;

	
	private String comdate;
	
	public ScheduleUserVo() {

	}
	
	 /**
     * @param idx
     * @param name
     * @param mac_name
     * @param platform
     * @param ap_no
     * @param agent_connected
     * @param agent_connected_chk
     * @param agent_connected_ip
     * @param target_
     * @param location_id
     */

	public ScheduleUserVo(String target_id, int ap_no, String name, String mac_name, String platform, boolean agent_connected, int agent_connected_chk,
			String agent_connected_ip, String target_use, String location_id, int cores, String comdate) {
		super();
		this.target_id = target_id;
		this.ap_no = ap_no;
		this.name = name;
		this.mac_name = mac_name;
		this.platform = platform;
		this.agent_connected = agent_connected;
		this.agent_connected_chk = agent_connected_chk;
		this.agent_connected_ip = agent_connected_ip;
		this.target_use = target_use;
		this.location_id = location_id;
		this.cores = cores;
		this.comdate = comdate;
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

	public String getTarget_use() {
		return target_use;
	}

	public void setTarget_use(String target_use) {
		this.target_use = target_use;
	}

	public String getLocation_id() {
		return location_id;
	}

	public void setLocation_id(String location_id) {
		this.location_id = location_id;
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

	@Override
	public String toString() {
		return "ScheduleUserVo [target_id=" + target_id + ", ap_no=" + ap_no + ", name=" + name + ", mac_name="
				+ mac_name + ", platform=" + platform + ", agent_connected=" + agent_connected
				+ ", agent_connected_chk=" + agent_connected_chk + ", agent_connected_ip=" + agent_connected_ip
				+ ", target_use=" + target_use + ", location_id=" + location_id + ", cores=" + cores + ", comdate="
				+ comdate + "]";
	}
	
}