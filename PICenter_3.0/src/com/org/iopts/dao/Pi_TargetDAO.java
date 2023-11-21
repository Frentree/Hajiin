package com.org.iopts.dao;
 
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.org.iopts.dto.Pi_TargetVO;

@Repository("Pi_TargetDAO")
public class Pi_TargetDAO {

	private static final Logger logger = LoggerFactory.getLogger(Pi_TargetDAO.class);

	@Autowired
    private SqlSession sqlSession;

	private static final String Namespace = "target";
	
	public List<Map<String, Object>> selectTargetManage() throws Exception {
		
		return sqlSession.selectList(Namespace+".selectTargetManage");
	}

	public List<Map<String, Object>> selectTargetList(String host) throws Exception {
		
		return sqlSession.selectList(Namespace+".selectTargetList", host);
	}

	public List<Map<String, Object>> selectTargetUser(Map<String, Object> map) throws Exception {
		
		return sqlSession.selectList(Namespace+".selectTargetUser", map);
	}

	public void deleteTargetUser(Map<String, Object> map) throws Exception {
		
		sqlSession.delete(Namespace+".deleteTargetUser", map);
	}
	
	public void registTargetUser(Map<String, Object> map) throws Exception {
		sqlSession.insert(Namespace+".registTargetUser", map);
	}
	
	public void registTargetUserBySelect(Map<String, Object> map) throws Exception {
		sqlSession.insert(Namespace+".registTargetUserBySelect", map);
	}
	
	public int insertTarget(List<Pi_TargetVO> list) throws Exception {
		int ret = 0;
		ret = sqlSession.insert(Namespace+".insertTargets", list);
		return ret;
	}

	public List<Map<String, Object>> selectUserTargetList(Map<String, Object> searchMap) throws Exception {
		
		return sqlSession.selectList(Namespace+".selectUserTargetList", searchMap);
	}
	
	public List<Map<String, Object>> selectServerList(Map<String, Object> searchMap) throws Exception {
		
		return sqlSession.selectList(Namespace+".selectServerList", searchMap);
	}

	public List<Map<String, Object>> selectTargetUserList(String target) throws Exception {
		
		return sqlSession.selectList(Namespace+".selectTargetUserList", target);
	}

	public List<Map<String, Object>> selectServerFileTopN(Map<String, Object> searchMap) {

		return sqlSession.selectList(Namespace + ".selectServerFileTopN", searchMap);
	}

	public List<Map<String, Object>> selectAdminServerFileTopN(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace + ".selectAdminServerFileTopN", searchMap);
	}
	
	// DMZ List 조회
	public List<Map<String, Object>> selectDmzList(HashMap<String, Object> params) {
		return sqlSession.selectList(Namespace+".selectDmzList", params);
	}
	
	// DMZ Info Save
	public void saveDmzInfo(HashMap<String, Object> params) {
		sqlSession.insert(Namespace+".saveDmzInfo", params);
	}
	// DMZ Info Save Asterisk
	public void saveDmzInfoAstr(HashMap<String, Object> params) {
		sqlSession.insert(Namespace+".saveDmzInfoAstr", params);
	}
	
	
	// DMZ List Delete
	public void deleteDmzList(HashMap<String, Object> params) {
		sqlSession.delete(Namespace+".deleteDmzList", params);
	}

	public HashMap<String, Object> selectTargetById(HashMap<String, Object> params) {
		return sqlSession.selectOne(Namespace+".selectTargetById", params);
	}
	
	public List<Map<String, Object>> selectAllUseTarget() {
		return sqlSession.selectList(Namespace+".selectAllUseTarget");
	}

	public List<Map<String, Object>> selectGroupList(Map<String, Object> map) throws SQLException {
		return sqlSession.selectList(Namespace+".selectGroupList", map);
	}

	public List<Map<String, Object>> getTargetList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace+".getTargetList", map);
	}

	public Map<String, Object> getGroupDetails(Map<String, Object> map) {
		return sqlSession.selectOne(Namespace+".getGroupDetails", map);
	}

	public void updateGroupDetails(Map<String, Object> map) {
		sqlSession.update(Namespace+".updateGroupDetails", map);
	}

	public void addNewGroup(Map<String, Object> map) {
		sqlSession.insert(Namespace+".addNewGroup", map);
	}

	public void deleteGroup(Map<String, Object> map) {
		sqlSession.delete(Namespace+".deleteGroup", map);
	}

	public void deleteGroupIdx_target(Map<String, Object> map) {
		sqlSession.update(Namespace+".deleteGroupIdx_target", map);
	}

	public void pushTargetToGroup(Map<String, Object> map) {
		sqlSession.update(Namespace+".pushTargetToGroup", map);
	}

	public List<Map<String, Object>> selectAllUseTarget(Map<String, Object> dbMap) {
		return sqlSession.selectList(Namespace+".selectAllUseTarget", dbMap);
	}
	
	public List<Map<String, Object>> selectUserGroupList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace+".selectUserGroupList", map);
	}
	
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace+".selectNoticeList", map);
	}

	public List<Map<String, Object>> selectServerTargetUser(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace + ".selectServerTargetUser", searchMap);
	}
	
	public List<Map<String, Object>> selectPCTargetUserName(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace + ".selectPCTargetUserName", searchMap);
	}
	
	public List<Map<String, Object>> selectPCTargetUser(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace + ".selectPCTargetUser", searchMap);
	}
	
	public List<Map<String, Object>> selectPCTargetUserData(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace + ".selectPCTargetUserData", searchMap);
	}

	public List<Map<String, Object>> getExceptionList() throws Exception {
		return sqlSession.selectList(Namespace+".getExceptionList");
	}
	
	public List<Map<String, Object>> exceptionSearchList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".exceptionSearchList", map);
	}
	
	public List<Map<String, Object>> selectSKTManagerList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".selectSKTManagerList", map);
	}
	
	public List<Map<String, Object>> selectAddSKTManagerList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".selectAddSKTManagerList", map);
	}
	
	public void insertSKTManager(Map<String, Object> map) {
		sqlSession.insert(Namespace+".insertSKTManager", map);
	}
	
	public void insertSKTManagerUser(Map<String, Object> map) {
		sqlSession.insert(Namespace+".insertSKTManagerUser", map);
	}
	
	public void deleteSKTManager(Map<String, Object> map) {
		sqlSession.delete(Namespace+".deleteSKTManager", map);
	}
	
	public void deleteSKTManagerUser(Map<String, Object> map) {
		sqlSession.delete(Namespace+".deleteSKTManagerUser", map);
	}
	
	public void updateSKTManagerGrade(Map<String, Object> map) {
		sqlSession.update(Namespace+".updateSKTManagerGrade", map);
	}

	public List<Map<String, Object>> selectPCManagerList() {
		return sqlSession.selectList(Namespace + ".selectPCManagerList");
	}

	public List<Map<String, Object>> selectVersionList() {
		return sqlSession.selectList(Namespace + ".selectVersionList");
	}
	
	public Map<String, Object> selectChkSKTManager(Map<String, Object> map) {
		return sqlSession.selectOne(Namespace+".selectChkSKTManager", map);
	}
	
	public List<Map<String, Object>> selectUpGroupUser(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".selectUpGroupUser", map);
	}
	
	public List<Map<String, Object>> selectDownGroupUser(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".selectDownGroupUser", map);
	}
	
	public List<Map<String, Object>> selectGroupUser(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".selectGroupUser", map);
	}
	
	public List<Map<String, Object>> apServerList() {
		return sqlSession.selectList(Namespace + ".apServerList");
	}
	
	public List<Map<String, Object>> selectMngrList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".selectMngrList", map);
	}
	
	public List<Map<String, Object>> selectInaccessibleList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".selectInaccessibleList", map);
	}

	public void updateChkStatus(Map<String, Object> map) {
		sqlSession.update(Namespace+".updateChkStatus", map);
	}
}
