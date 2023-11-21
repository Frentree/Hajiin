package com.org.iopts.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.dao.Pi_AgentDAO;
import com.org.iopts.dto.Pi_AgentVO;
import com.org.iopts.dto.Pi_TargetVO;

@Service
public class Pi_AgentServiceImpl implements Pi_AgentService {

	@Inject
	private Pi_AgentDAO dao;
	
	@Override
	public List<Pi_AgentVO> selectAgent_Info(String host_name) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectAgent_Info(host_name);
	}
	
	@Override
	public List<Pi_AgentVO> dashAgent_Info(String target_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.dashAgent_Info(target_id);
	}
}
