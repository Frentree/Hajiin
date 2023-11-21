package com.org.iopts.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.org.iopts.dto.Pi_AgentVO;

@Repository
public class Pi_AgentDAO {	

	private static final Logger logger = LoggerFactory.getLogger(Pi_AgentDAO.class);

	@Autowired
    @Resource(name = "sqlSession")
    private SqlSession sqlSession;

	private static final String Namespace = "agentmapper";
	
	public List<Pi_AgentVO> selectAgent_Info(String host_name) throws Exception {
		return sqlSession.selectList(Namespace+".selectAgent_Info", host_name);
	}
	

	public List<Pi_AgentVO> dashAgent_Info(String target_id) throws Exception {
		return sqlSession.selectList(Namespace+".dashAgent_Info", target_id);
	}
}
