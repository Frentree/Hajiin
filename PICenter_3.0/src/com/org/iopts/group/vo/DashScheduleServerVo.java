package com.org.iopts.group.vo;

import java.io.Serializable;
import java.util.Arrays;

public class DashScheduleServerVo implements Serializable {
	private String schedule_group_id;
	private String user_no;
	private String target_id;
	private int ap_no;
	private String type;
	private String id;
	private String regdate;

	public DashScheduleServerVo() {

	}
	
	 /**
     * @param schedule_group_id
     * @param user_no
     * @param target_id
     * @param ap_no
     * @param type
     * @param id
     * @param regdate
     */
	public DashScheduleServerVo(String schedule_group_id, String user_no, String target_id, int ap_no, String type,
			String id, String regdate) {
		this.schedule_group_id = schedule_group_id;
		this.user_no = user_no;
		this.target_id = target_id;
		this.ap_no = ap_no;
		this.type = type;
		this.id = id;
		this.regdate = regdate;
	}

	public String getSchedule_group_id() {
		return schedule_group_id;
	}

	public void setSchedule_group_id(String schedule_group_id) {
		this.schedule_group_id = schedule_group_id;
	}

	public String getUser_no() {
		return user_no;
	}

	public void setUser_no(String user_no) {
		this.user_no = user_no;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "DashScheduleServerVo [schedule_group_id=" + schedule_group_id + ", user_no=" + user_no + ", target_id="
				+ target_id + ", ap_no=" + ap_no + ", type=" + type + ", id=" + id + ", regdate=" + regdate + "]";
	}

}