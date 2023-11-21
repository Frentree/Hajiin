package com.org.iopts.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.catalina.core.ApplicationContext;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.org.iopts.quartz.BeanUtils;

public class Pi_QuartzDAO {

	private static final Logger logger = LoggerFactory.getLogger(Pi_QuartzDAO.class);

    private SqlSession sqlSession = (SqlSession) BeanUtils.getBean("sqlSession");

	private static final String Namespace = "QuartzMapper";
	

	public List<Map<String, String>> getChangeScheduleList(Map<String, String> map) {
		return sqlSession.selectList(Namespace+".getChangeSchedule", map);
	}
	
	public List<Map<String, String>> getStopScheduleList(String stop_dtm){
		return sqlSession.selectList(Namespace+".getStopScheduleList", stop_dtm);
	}

	public void stopScanSchedule(String schedule_id) {
		sqlSession.update(Namespace+".stopScanSchedule", schedule_id);
	}

	public int getConnectHistSeq() {
		return sqlSession.selectOne(Namespace+".getConnectHistSeq");
	}

	public int insConnectHist(Map<String, String> map) {
		return sqlSession.insert(Namespace+".insConnectHist", map);
	}

	public boolean uptConnectHist(Map<String, String> map) {
		return (sqlSession.update(Namespace+".uptConnectHist", map) > 0);
	}

}
