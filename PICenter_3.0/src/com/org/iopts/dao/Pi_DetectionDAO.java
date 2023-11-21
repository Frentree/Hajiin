package com.org.iopts.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.org.iopts.service.Pi_DetectionServiceImple;

@Repository
public class Pi_DetectionDAO {
	
	private static Logger log = LoggerFactory.getLogger(Pi_DetectionDAO.class);
	
	@Autowired
    @Resource(name = "sqlSession")
    private SqlSession sqlSession;
	
	private static final String Namespace = "com.org.iopts.mapper.DetectionMapper";
	
	
	public void registProcessGroup(Map<String, Object> map) {
		sqlSession.insert(Namespace+".registProcessGroup", map);
	}
	
	public void registProcess(Map<String, Object> map) {
		sqlSession.insert(Namespace+".registProcess", map);
	}
	
	public void registProcessCharge(Map<String, Object> chargeMap) {
		// TODO Auto-generated method stub
		sqlSession.insert(Namespace+".registProcessCharge", chargeMap);
	}
	
	
	public int preCheckRegistPathException(Map<String, Object> insertExcepMap) {
		int cnt = 0;
		cnt = sqlSession.selectOne(Namespace+".preCheckRegistPathException", insertExcepMap);
		return cnt;
	}
	
	public void registPathExceptionGroup(Map<String, Object> insertExcepGroupMap) {
		sqlSession.insert(Namespace+".registPathExceptionGroup", insertExcepGroupMap);
	}
	public void registPathException(Map<String, Object> insertExcepMap) {
		sqlSession.insert(Namespace+".registPathException", insertExcepMap);
	}
	
	
	public void registPathExceptionCharge(Map<String, Object> insertExcepChargeMap) {
		sqlSession.insert(Namespace+".registPathExceptionCharge", insertExcepChargeMap);
	}

	public void registChange(Map<String, Object> map) {
		log.info("registChange : " + map);
		sqlSession.update(Namespace+".registChange", map);
	}
	
	
	
	
	
	public List<Map<String, Object>> selectFindSubpath(Map<String, Object> map) {
		return sqlSession.selectList(Namespace+".selectFindSubpath", map);
	}
	
	public List<Map<String, Object>> searchProcessList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace+".searchProcessList", map);
	}
	
	public List<Map<String, Object>> selectProcessPath(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace+".selectProcessPath", searchMap);
	}
	
	public List<Map<String, Object>> selectProcessGroupPath(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace+".selectProcessGroupPath", searchMap);
	}

	public List<Map<String, Object>> searchApprovalListData(Map<String, Object> map) {
		return sqlSession.selectList(Namespace+".searchApprovalListData", map);
	}
	
	
	
	public List<Map<String, Object>> selectExceptionList(Map<String, Object> map) throws Exception {

		return sqlSession.selectList(Namespace+".selectExceptionList", map);
	}

	public List<Map<String, Object>> exceptionApprovalListData(Map<String, Object> map) throws Exception {
		return sqlSession.selectList(Namespace+".exceptionApprovalListData", map);
	}

	public List<Map<String, Object>> selectExeptionPath(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace+".selectExeptionPath", searchMap);
	}

	public List<Map<String, Object>> selectExeptionName(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace+".selectExeptionName", searchMap);
	}
	
	public List<Map<String, Object>> selectChangeList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace+".selectChangeList", map);
	}
	
	
	public Map<String, Object> selectDocuNum(Map<String, Object> map) {
		return sqlSession.selectOne(Namespace + ".selectDocuNum", map);
	}
	
	public void approvalPlus(Map<String, Object> map) {
		sqlSession.update(Namespace + ".approvalPlus", map);
	}
	
	public void updateExcepStatus(Map<String, Object> map) {
		sqlSession.update(Namespace+".updateExcepStatus", map);
	}

	public void updateProcessStatus(Map<String, Object> map) {
		sqlSession.update(Namespace+".updateProcessStatus", map);
	}

	public void updateExcepApproval(Map<String, Object> map) {
		sqlSession.update(Namespace+".updateExcepApproval", map);
	}

	public void updateProcessApproval(Map<String, Object> map) {
		sqlSession.update(Namespace+".updateProcessApproval", map);
	}

	public void updateChangeApproval(Map<String, Object> map) {
		sqlSession.update(Namespace+".updateChangeApproval", map);		
	}

	public List<Map<String, Object>> selectTeamMember(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace+".selectTeamMember", searchMap);
	}

}
