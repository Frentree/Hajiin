package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class GroupTargetVo implements Serializable {
	private String target_id;
	private int ap_no;
	private String name;
	private String mac_name;
	private String platform;
	private String up_idx;
	private String target_use;
	private boolean agent_connected;
	private String agent_connected_ip;
	private String agent_connected_chk;
	
	private String comdate;

	public GroupTargetVo() {

	}
	
	 /**
     * @param target_id
     * @param ap_no
     * @param name
     * @param mac_name
     * @param platform
     * @param up_idx
     * @param target_use
     * @param agent_connected
     * @param agent_connected_ip
     * @param agent_connected_chk
     */
	public GroupTargetVo(String target_id, int ap_no, String name, String mac_name, String platform, String up_idx, String target_use,
			boolean agent_connected, String agent_connected_ip, String agent_connected_chk, String comdate) {
		super();
		this.target_id = target_id;
		this.ap_no = ap_no;
		this.name = name;
		this.mac_name = mac_name;
		this.platform = platform;
		this.up_idx = up_idx;
		this.target_use = target_use;
		this.agent_connected = agent_connected;
		this.agent_connected_ip = agent_connected_ip;
		this.agent_connected_chk = agent_connected_chk;
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

	public String getUp_idx() {
		return up_idx;
	}

	public void setUp_idx(String up_idx) {
		this.up_idx = up_idx;
	}

	public String getTarget_use() {
		return target_use;
	}

	public void setTarget_use(String target_use) {
		this.target_use = target_use;
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

	public String getAgent_connected_chk() {
		return agent_connected_chk;
	}

	public void setAgent_connected_chk(String agent_connected_chk) {
		this.agent_connected_chk = agent_connected_chk;
	}

	public String getComdate() {
		return comdate;
	}

	public void setComdate(String comdate) {
		this.comdate = comdate;
	}

	@Override
	public String toString() {
		return "GroupTargetVo [target_id=" + target_id + ", ap_no=" + ap_no + ", name=" + name + ", mac_name="
				+ mac_name + ", platform=" + platform + ", up_idx=" + up_idx + ", target_use=" + target_use
				+ ", agent_connected=" + agent_connected + ", agent_connected_ip=" + agent_connected_ip
				+ ", agent_connected_chk=" + agent_connected_chk + ", comdate=" + comdate + "]";
	}

	
}