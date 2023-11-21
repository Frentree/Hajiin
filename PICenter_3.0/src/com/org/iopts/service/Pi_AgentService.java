package com.org.iopts.service;

import java.util.List;

import com.org.iopts.dto.Pi_AgentVO;

public interface Pi_AgentService {
	
	public List<Pi_AgentVO> selectAgent_Info(String host_name) throws Exception;

	public List<Pi_AgentVO> dashAgent_Info(String target_id) throws Exception;
	
}
