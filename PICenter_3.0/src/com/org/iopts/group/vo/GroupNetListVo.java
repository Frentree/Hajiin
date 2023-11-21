package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

/**
 * @author thdau
 *
 */
public class GroupNetListVo implements Serializable {
	private String id;
	private String name;
	private String mac_name;
	private String onedrive_name;
	private String platform;
	private String location_id;
	private String agent_connected_ip;
	private String parent;
	private int type;

	public GroupNetListVo() {

	}
	
	 /**
     * @param target_id
     * @param ap_no
     * @param name
     * @param mac_name
     * @param platform
     * @param agent_connected_ip
     * @param target_use
     * @param agent_connected
     * @param agent_connected_ip
     */
    public GroupNetListVo(String id, String name, String mac_name, String onedrive_name, String platform, String location_id, String agent_connected_ip, String parent, int type) {
       
        this.id = id;
        this.name = name;
        this.mac_name = mac_name;
        this.onedrive_name = onedrive_name;
        this.platform = platform;
        this.location_id = location_id;
        this.agent_connected_ip = agent_connected_ip;
        this.parent = parent;
        this.type = type;
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getOnedrive_name() {
		return onedrive_name;
	}

	public void setOnedrive_name(String onedrive_name) {
		this.onedrive_name = onedrive_name;
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

	public String getAgent_connected_ip() {
		return agent_connected_ip;
	}

	public void setAgent_connected_ip(String agent_connected_ip) {
		this.agent_connected_ip = agent_connected_ip;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "GroupNetListVo [id=" + id + ", name=" + name + ", mac_name=" + mac_name + ", onedrive_name="
				+ onedrive_name + ", platform=" + platform + ", location_id=" + location_id + ", agent_connected_ip="
				+ agent_connected_ip + ", parent=" + parent + ", type=" + type + "]";
	}

    
}