package com.org.iopts.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.org.iopts.dto.Pi_Scan_HostVO;
import com.org.iopts.dto.Pi_ScheduleVO;

@Repository
public class Pi_ScanDAO {	

	private static final Logger logger = LoggerFactory.getLogger(Pi_ScanDAO.class);

	@Autowired
    @Resource(name = "sqlSession")
    private SqlSession sqlSession;

	private static final String Namespace = "ScanMapper";
	
	public List<Map<String, Object>> selectSchedules(Map<String, Object> search) throws Exception {
		return sqlSession.selectList(Namespace+".selectSchedules", search);
	}
	
	public List<Pi_ScheduleVO> selectSchedule(String schedule_status) throws Exception {
		return sqlSession.selectList(Namespace+".selectSchedule", schedule_status);
	}
	
	public List<Pi_Scan_HostVO> selectScanHost() throws Exception {
		return sqlSession.selectList(Namespace+".selectScanHost");
	}

	public List<Map<String, Object>> selectDataTypes(Map<String, Object> datatypeMap) throws Exception {
		return sqlSession.selectList(Namespace+".selectDataTypes", datatypeMap);
	}

	public void changeSchedule(Map<String, Object> map) throws Exception {

		sqlSession.update(Namespace+".changeSchedule", map);
	}

	public List<Map<String, Object>> selectLocationList(Map<String, Object> map) throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectLocationList", map);
	}

	public List<Map<String, Object>> selectDatatypeList() throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectDatatypeList");
	}

	public List<Map<String, Object>> selectDatatypeVersion(String label) throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectDatatypeVersion", label);
	}

	public List<Map<String, Object>> viewScanHistory(Map<String, Object> historyList) {
		
		return sqlSession.selectList(Namespace + ".viewScanHistory", historyList);
	}

	public void registPolicy(Map<String, Object> map) {
		sqlSession.insert(Namespace + ".registPolicy", map);
	}

	public void resetDefaultPolicy(HttpServletRequest request) {
		sqlSession.update(Namespace + ".resetDefaultPolicy", request);
	}

	public void updateDefaultPolicy(Map<String, Object> map) {
		sqlSession.update(Namespace + ".updateDefaultPolicy", map);		
	}

	public List<Map<String, Object>> viewScanPolicy(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".viewScanPolicy", map);
	}

	public void updatePolicy(Map<String, Object> map) {
		sqlSession.update(Namespace + ".updatePolicy", map); 
	}
	
	public List<Map<String, String>> selectScanSchedule(String schedule_id) {
		return sqlSession.selectList(Namespace + ".selectScanSchedule", schedule_id);
	}
	
	public void changeActiveStatus(Map<String, String> uptData) {
		sqlSession.update(Namespace + ".changeActiveStatus", uptData); 
	}
	
	public void changeActiveStatus2(Map<String, String> uptData) {
		sqlSession.update(Namespace + ".changeActiveStatus2", uptData); 
	}
	
	public void insertScanSchedule(ArrayList<Map<String, String>> schedule_data) {
		for(Map<String, String> map : schedule_data) {
			sqlSession.insert(Namespace + ".insertScanSchedule", map);
		}
	}

	public String selectScheduleStatus(String schedule_id) {
		return sqlSession.selectOne(Namespace + ".selectScheduleStatus", schedule_id);
	}

	public int getConnectHistSeq() {
		return sqlSession.selectOne(Namespace + ".getConnectHistSeq");
	}
	
	public int insConnectHist(Map<String, String> map) {
		return sqlSession.insert(Namespace+".insConnectHist", map);
	}

	public boolean uptConnectHist(Map<String, String> map) {
		return (sqlSession.update(Namespace+".uptConnectHist", map) > 0);
	}

	public void updateSchedule(Pi_ScheduleVO vo) {
		sqlSession.update("updateSchedule", vo);
	}

	public Map<String, Object> getPolicyByIdx(String policy) {
		return sqlSession.selectOne(Namespace + ".getPolicyByIdx", policy);
	}

	public String getTargetName(String target_id) {
		return sqlSession.selectOne(Namespace + ".getTargetName", target_id);
	}

	public void updateStatus(Map<String, Object> map) throws Exception {
		sqlSession.update("updateStatus", map);
	}

	public List<Map<String, Object>> selectGroupList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList(Namespace + ".selectGroupList", map);
	}
	
	public List<Map<String, Object>> getProfile(Map<String, Object> historyList) {
		return sqlSession.selectList(Namespace + ".getProfile", historyList);
	}

	public void insertProfile(Map<String, Object> map) {
		sqlSession.insert(Namespace+".insertProfile", map);
	}
	
	public void updateProfile(Map<String, Object> map) {
		sqlSession.update(Namespace+".updateProfile", map);
	}
	
	public void deleteProfile(Map<String, Object> map) {
		sqlSession.insert(Namespace+".deleteProfile", map);
	}

	public Map<String, Object> selectScheduleById(Map<String, Object> map) {
		return sqlSession.selectOne(Namespace + ".selectScheduleById", map);
	}
	
	public Map<String, Object> selectDataTypeById(Map<String, Object> map) {
		return sqlSession.selectOne(Namespace + ".selectDataTypeById", map);
	}
	
	public void updateScanSchedule(Map<String, Object> map) {
		sqlSession.insert(Namespace + ".updateScanSchedule", map);
	}

	public int getDatatypesGroupidx() {
		return sqlSession.selectOne(Namespace + ".getDatatypesGroupidx");
	}

	public List<Map<String, Object>> getApList() {
		return sqlSession.selectList(Namespace + ".getApList");
	}

	public Map<String, Object> getPolicyByApno(Map<String, Object> map) {
		return sqlSession.selectOne(Namespace + ".getPolicyByApno", map);
	}

	public void disableProfile(Map<String, Object> map) {
		sqlSession.update(Namespace+".disableProfile", map);
	}

	public void insertPolicyToTarget(Map<String, Object> map) {
		sqlSession.update(Namespace+".insertPolicyToTarget", map);
	}
	
	public List<Map<String, Object>> selectScheduleGroupTargets(String schedule_id) {
		return sqlSession.selectList(Namespace + ".selectScheduleGroupTargets", schedule_id);
	}
	
}