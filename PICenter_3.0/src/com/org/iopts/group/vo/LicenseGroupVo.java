package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class LicenseGroupVo implements Serializable {
	private String idx;
	private String up_idx;
	private String name;
	private String recon_name;
	private String target_id;
	private String type;
	private String data_usage;
	private String agent_connected_ip;
	
	private String team;
	
	private String server_group;
	private String recon_group;
	private int target_count;
	private String group_id;
	private String parent_group;
	
	private String host_name;
	private String group_name;
	
	private String pic_id;
	private boolean pic_status;
	private String recon_id;
	private boolean recon_status;
	
	
	public LicenseGroupVo() {
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


	public String getRecon_name() {
		return recon_name;
	}


	public void setRecon_name(String recon_name) {
		this.recon_name = recon_name;
	}


	public String getTarget_id() {
		return target_id;
	}


	public void setTarget_id(String target_id) {
		this.target_id = target_id;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getData_usage() {
		return data_usage;
	}
	public void setData_usage(String data_usage) {
		this.data_usage = data_usage;
	}
	public String getAgent_connected_ip() {
		return agent_connected_ip;
	}
	public void setAgent_connected_ip(String agent_connected_ip) {
		this.agent_connected_ip = agent_connected_ip;
	}
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	public String getServer_group() {
		return server_group;
	}
	public void setServer_group(String server_group) {
		this.server_group = server_group;
	}
	public String getRecon_group() {
		return recon_group;
	}
	public void setRecon_group(String recon_group) {
		this.recon_group = recon_group;
	}
	public int getTarget_count() {
		return target_count;
	}
	public void setTarget_count(int target_count) {
		this.target_count = target_count;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getParent_group() {
		return parent_group;
	}
	public void setParent_group(String parent_group) {
		this.parent_group = parent_group;
	}
	public String getHost_name() {
		return host_name;
	}
	public void setHost_name(String host_name) {
		this.host_name = host_name;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getPic_id() {
		return pic_id;
	}
	public void setPic_id(String pic_id) {
		this.pic_id = pic_id;
	}
	public boolean isPic_status() {
		return pic_status;
	}
	public void setPic_status(boolean pic_status) {
		this.pic_status = pic_status;
	}
	public String getRecon_id() {
		return recon_id;
	}
	public void setRecon_id(String recon_id) {
		this.recon_id = recon_id;
	}
	public boolean isRecon_status() {
		return recon_status;
	}

	public void setRecon_status(boolean recon_status) {
		this.recon_status = recon_status;
	}


	@Override
	public String toString() {
		return "LicenseGroupVo [idx=" + idx + ", up_idx=" + up_idx + ", name=" + name + ", recon_name=" + recon_name
				+ ", target_id=" + target_id + ", type=" + type + ", data_usage=" + data_usage + ", agent_connected_ip="
				+ agent_connected_ip + ", team=" + team + ", server_group=" + server_group + ", recon_group="
				+ recon_group + ", target_count=" + target_count + ", group_id=" + group_id + ", parent_group="
				+ parent_group + ", host_name=" + host_name + ", group_name=" + group_name + ", pic_id=" + pic_id
				+ ", pic_status=" + pic_status + ", recon_id=" + recon_id + ", recon_status=" + recon_status + "]";
	}
	
	
}