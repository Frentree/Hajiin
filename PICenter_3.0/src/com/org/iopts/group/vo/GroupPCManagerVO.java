package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class GroupPCManagerVO implements Serializable {
	
	private int level;
	private String insa_code;
	private String team_name;
	private String full_team_nm;
	private String parent;
	private String connected;
	private int ap_no;
	
	private String name;
	private String mac_name;
	private String platform;
	private String agent_connected_ip;
	private String TARGET_ID;
	
	public GroupPCManagerVO() {

	}

	 /**
     * @param level
     * @param insa_code
     * @param team_name
     * @param full_team_name
     * @param parent
     * @param connected
     * @param ap_no
     */
	public GroupPCManagerVO(int level, String insa_code, String team_name, String full_team_nm,	String parent,
			String connected, int ap_no) {
		this.level = level;
		this.insa_code = insa_code;
		this.team_name = team_name;
		this.full_team_nm = full_team_nm;
		this.parent = parent;
		this.connected = connected;
		this.ap_no = ap_no;
	}
	
	public GroupPCManagerVO(int level, String insa_code, String team_name, String full_team_nm, String parent,
			String connected, int ap_no, String name, String mac_name, String platform, String agent_connected_ip, String tARGET_ID) {
		super();
		this.level = level;
		this.insa_code = insa_code;
		this.team_name = team_name;
		this.full_team_nm = full_team_nm;
		this.parent = parent;
		this.connected = connected;
		this.ap_no = ap_no;
		this.name = name;
		this.mac_name = mac_name;
		this.platform = platform;
		this.agent_connected_ip = agent_connected_ip;
		TARGET_ID = tARGET_ID;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getInsa_code() {
		return insa_code;
	}

	public void setInsa_code(String insa_code) {
		this.insa_code = insa_code;
	}

	public String getTeam_name() {
		return team_name;
	}

	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}

	public String getFull_team_nm() {
		return full_team_nm;
	}

	public void setFull_team_nm(String full_team_nm) {
		this.full_team_nm = full_team_nm;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	public String getConnected() {
		return connected;
	}

	public void setConnected(String connected) {
		this.connected = connected;
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

	public String getAgent_connected_ip() {
		return agent_connected_ip;
	}

	public void setAgent_connected_ip(String agent_connected_ip) {
		this.agent_connected_ip = agent_connected_ip;
	}

	public String getTARGET_ID() {
		return TARGET_ID;
	}

	public void setTARGET_ID(String tARGET_ID) {
		TARGET_ID = tARGET_ID;
	}

	@Override
	public String toString() {
		return "GroupPCManagerVO [level=" + level + ", insa_code=" + insa_code + ", team_name=" + team_name
				+ ", full_team_nm=" + full_team_nm + ", parent=" + parent + ", connected=" + connected + ", ap_no="
				+ ap_no + ", name=" + name + ", mac_name=" + mac_name + ", platform=" + platform
				+ ", agent_connected_ip=" + agent_connected_ip + ", TARGET_ID=" + TARGET_ID + "]";
	}

}