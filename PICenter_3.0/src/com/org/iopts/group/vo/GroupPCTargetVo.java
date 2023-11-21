package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class GroupPCTargetVo implements Serializable {
	private String target_id;
	private int ap_no;
	private String name;
	private String mac_name;
	private String platform;
	private String target_use;
	private boolean agent_connected;
	private String agent_connected_ip;
	private String user_no;
	private String user_name;
	private String insa_code;

	public GroupPCTargetVo() {

	}
	
	 /**
     * @param target_id
     * @param ap_no
     * @param name
     * @param mac_name
     * @param platform
     * @param target_use
     * @param agent_connected
     * @param agent_connected_ip
     * @param user_no
     * @param user_name
     * @param insa_code
     */
    public GroupPCTargetVo(String target_id, int ap_no, String name, String mac_name, String platform, String target_use,
    		boolean agent_connected, String agent_connected_ip, String user_no, String user_name, String insa_code) {
       
        this.target_id = target_id;
        this.ap_no = ap_no;
        this.name = name;
        this.mac_name = mac_name;
        this.platform = platform;
        this.target_use = target_use;
        this.agent_connected = agent_connected;
        this.agent_connected_ip = agent_connected_ip;
        this.user_no = user_no;
        this.user_name = user_name;
        this.insa_code = insa_code;
    }
    

	/**
    * @param insa_code
    */
   public GroupPCTargetVo(String insa_code) {
      
       this.insa_code = insa_code;
   }
    
    @Override
    public boolean equals(Object object) {
    	GroupPCTargetVo pc = (GroupPCTargetVo) object;
	    // name은 상관없이, id만 같으면 true를 리턴합니다.
	    if (pc.insa_code.equals(this.insa_code)) {
	    	return true;
	    }
	    return false;
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

	public String getUser_no() {
		return user_no;
	}

	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getInsa_code() {
		return insa_code;
	}

	public void setInsa_code(String insa_code) {
		this.insa_code = insa_code;
	}

	@Override
	public String toString() {
		return "GroupPCTargetVo [target_id=" + target_id + ", ap_no=" + ap_no + ", name=" + name + ", mac_name="
				+ mac_name + ", platform=" + platform + ", target_use=" + target_use + ", agent_connected="
				+ agent_connected + ", agent_connected_ip=" + agent_connected_ip + ", user_no=" + user_no
				+ ", user_name=" + user_name + ", insa_code=" + insa_code + "]";
	}
    
}