package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class ScheduleServerNotTargetVo implements Serializable {
	private String target_id;
	private int ap_no;
	private String name;
	private String target_use;
	private boolean agent_connected;
	private int agent_connected_chk;
	private String agent_connected_ip;
	private String location_id;

	public ScheduleServerNotTargetVo() {

	}
	
	 /**
     * @param target_id
     * @param ap_no
     * @param name
     * @param target_use
     * @param agent_connected
     * @param agent_connected_chk
     * @param agent_connected_ip
     * @param location_id
     */
    public ScheduleServerNotTargetVo(String target_id, int ap_no, String name, 
    		String target_use, boolean agent_connected, 
            int agent_connected_chk,  String agent_connected_ip, String location_id) {
       
        this.target_id = target_id;
        this.ap_no = ap_no;
        this.name = name;
        this.target_use = target_use;
        this.agent_connected = agent_connected;
        this.agent_connected_chk = agent_connected_chk;
        this.agent_connected_ip = agent_connected_ip;
        this.location_id = location_id;
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
	
	public int getAgent_connected_chk() {
		return agent_connected_chk;
	}

	public void setAgent_connected_chk(int agent_connected_chk) {
		this.agent_connected_chk = agent_connected_chk;
	}

	public String getLocation_id() {
		return location_id;
	}

	public void setLocation_id(String location_id) {
		this.location_id = location_id;
	}

	@Override
	public String toString() {
		return "GroupTargetVo [target_id=" + target_id + ", ap_no=" + ap_no + ", target_use=" + target_use
				+ ", agent_connected=" + agent_connected + ", agent_connected_ip=" + agent_connected_ip + "]";
	}
    
}