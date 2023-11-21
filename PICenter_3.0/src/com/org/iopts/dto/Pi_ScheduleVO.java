package com.org.iopts.dto;

import com.org.iopts.dto.co.PauseCo;
import com.org.iopts.dto.co.SchTargetCo;
import com.org.iopts.dto.co.ScheduleCo;

public class Pi_ScheduleVO {
	private String schedule_id;		
	private String schedule_label;			
	private String schedule_status;			
	private String schedule_repeat_days;		
	private String schedule_repeat_months;
	private String schedule_target_id;		
	private String schedule_datatype_profiles;	
	private String datatype_profiles_name;	
	private String schedule_next_scan;	
	private String schedule_next_datescan;	
	private String schedule_target_name;	
	private String schedule_cpu;	
	private String schedule_capture;	
	private String schedule_trace;	
	private String schedule_pause_days;	
	private String schedule_pause_to;	
	private String schedule_pause_from;	
	
	
	public Pi_ScheduleVO(ScheduleCo co) {
		schedule_id = co.getId();
		schedule_status = co.getStatus();
		schedule_label = co.getLabel();
		
		schedule_repeat_days = co.getRepeat_days();
		schedule_repeat_months = co.getRepeat_months();
		
		for(String s: co.getProfiles()) {
			schedule_datatype_profiles = s;
		}
		
		schedule_next_scan = co.getNext_scan();
		
		for(SchTargetCo t : co.getTargets()) {
			schedule_target_id = t.getId();
			schedule_target_name = t.getName();
		}
		
		schedule_cpu = co.getCpu();
		schedule_capture = co.getCapture();
		schedule_trace = co.getTrace();
		
		if(co.getPause() != null) {
			for(PauseCo p : co.getPause()) {
				schedule_pause_days = p.getDays();
				schedule_pause_from = p.getFrom();
				schedule_pause_to = p.getTo();
			}
		}
		
	}
	
	
	public String getSchedule_id() {
		return schedule_id;
	}
	public void setSchedule_id(String schedule_id) {
		this.schedule_id = schedule_id;
	}
	public String getSchedule_label() {
		return schedule_label;
	}
	public void setSchedule_label(String schedule_label) {
		this.schedule_label = schedule_label;
	}
	public String getSchedule_status() {
		return schedule_status;
	}
	public void setSchedule_status(String schedule_status) {
		this.schedule_status = schedule_status;
	}
	public String getSchedule_repeat_days() {
		return schedule_repeat_days;
	}
	public void setSchedule_repeat_days(String schedule_repeat_days) {
		this.schedule_repeat_days = schedule_repeat_days;
	}
	public String getSchedule_repeat_months() {
		return schedule_repeat_months;
	}
	public void setSchedule_repeat_months(String schedule_repeat_months) {
		this.schedule_repeat_months = schedule_repeat_months;
	}
	public String getSchedule_target_id() {
		return schedule_target_id;
	}
	public void setSchedule_target_id(String schedule_target_id) {
		this.schedule_target_id = schedule_target_id;
	}
	public String getSchedule_datatype_profiles() {
		return schedule_datatype_profiles;
	}
	public void setSchedule_datatype_profiles(String schedule_datatype_profiles) {
		this.schedule_datatype_profiles = schedule_datatype_profiles;
	}
	public String getSchedule_next_scan() {
		return schedule_next_scan;
	}
	public void setSchedule_next_scan(String schedule_next_scan) {
		this.schedule_next_scan = schedule_next_scan;
	}
	public String getSchedule_next_datescan() {
		return schedule_next_datescan;
	}
	public void setSchedule_next_datescan(String schedule_next_datescan) {
		this.schedule_next_datescan = schedule_next_datescan;
	}
	public String getSchedule_target_name() {
		return schedule_target_name;
	}
	public void setSchedule_target_name(String schedule_target_name) {
		this.schedule_target_name = schedule_target_name;
	}
	public String getSchedule_cpu() {
		return schedule_cpu;
	}
	public void setSchedule_cpu(String schedule_cpu) {
		this.schedule_cpu = schedule_cpu;
	}
	public String getSchedule_capture() {
		return schedule_capture;
	}
	public void setSchedule_capture(String schedule_capture) {
		this.schedule_capture = schedule_capture;
	}
	public String getSchedule_trace() {
		return schedule_trace;
	}
	public void setSchedule_trace(String schedule_trace) {
		this.schedule_trace = schedule_trace;
	}
	public String getSchedule_pause_days() {
		return schedule_pause_days;
	}
	public void setSchedule_pause_days(String schedule_pause_days) {
		this.schedule_pause_days = schedule_pause_days;
	}
	public String getSchedule_pause_to() {
		return schedule_pause_to;
	}
	public void setSchedule_pause_to(String schedule_pause_to) {
		this.schedule_pause_to = schedule_pause_to;
	}
	public String getSchedule_pause_from() {
		return schedule_pause_from;
	}
	public void setSchedule_pause_from(String schedule_pause_from) {
		this.schedule_pause_from = schedule_pause_from;
	}
	public String getDatatype_profiles_name() {
		return datatype_profiles_name;
	}
	public void setDatatype_profiles_name(String datatype_profiles_name) {
		this.datatype_profiles_name = datatype_profiles_name;
	}
	
}
