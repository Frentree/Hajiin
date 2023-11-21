package com.org.iopts.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.dto.MemberVO;

@Repository
public class Pi_UserDAO {

	static final Logger logger = LoggerFactory.getLogger(Pi_UserDAO.class);

	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession sqlSession;

	static final String Namespace = "com.org.iopts.mapper.UserMapper";

	public Map<String, Object>  selectMember(Map<String, Object> map) throws Exception {

		return sqlSession.selectOne(Namespace + ".selectMember", map);
	}
	
	public Map<String, Object>  changeUser(Map<String, Object> map) throws Exception {

		return sqlSession.selectOne(Namespace + ".changeUser", map);
	}
	
	// 초기화 인증번호 발송
	public Map<String, Object> selectMemberNum(Map<String, Object> map) throws Exception {
		
		return sqlSession.selectOne(Namespace + ".selectMemberNum", map);
	}
	
	// 인증번호 확인
	public Map<String, Object> updateUserPwd(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace + ".updateUserPwd", map);
	}

	// 비밀번호 초기화
	public int resetPwd(Map<String, Object> map) {
		return sqlSession.update(Namespace + ".resetPwd", map);
	}
	
	// 초기화 비밀번호 변경
	public int changeResetPwd(Map<String, Object> map) {
		return sqlSession.insert(Namespace + ".changeResetPwd", map);
	}

	public Map<String, Object>  selectSSOMember(Map<String, Object> map) throws Exception {

		return sqlSession.selectOne(Namespace + ".selectSSOMember", map);
	}

	public List<Map<String, Object>>  selectTeamMember(Map<String, Object> map) throws Exception {

		return sqlSession.selectList(Namespace + ".selectTeamMember", map);
	}

	public Map<String, Object>  selectTeamManager(String boss_name) throws Exception {

		return sqlSession.selectOne(Namespace + ".selectTeamManager", boss_name);
	}
	
	public void insertLog(Map<String, Object> userLog) throws Exception {
		
		sqlSession.insert(Namespace + ".insertLog", userLog);
	}

	public List<Map<String, Object>> selectUserLogList(Map<String, Object> search) throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectUserLogList",search);
	}

	public int changeAuthCharacter(Map<String, Object> map) throws Exception {
		
		return sqlSession.insert(Namespace + ".updatePassword", map);
	}

	public String selectAccessIP(String user_no) throws Exception {

		return sqlSession.selectOne(Namespace + ".selectAccessIP", user_no);
	}
	
	public Map<String, Object> selectNotice() throws Exception {

		return sqlSession.selectOne(Namespace + ".selectNotice");
	}
	
	// 공지사항 목록 조회
	public List<Map<String, Object>> noticeList() {
		return sqlSession.selectList(Namespace + ".noticeList");
	}

	// 공지사항 검색 목록 조회
	public List<Map<String, Object>> getStatusList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".getStatusList", map);
	}
	
	// 공지사항 등록
	public void noticeInsert(Map<String, Object> input) {
		sqlSession.insert(Namespace + ".noticeInsert", input);
	}
	

	public void noticeDelete(Map<String, Object> delete) {
		sqlSession.delete(Namespace + ".noticeDelete", delete);
	}

	
	public void noticeUpdate(Map<String, Object> update) throws Exception {
		sqlSession.update(Namespace + ".noticeUpdate", update);
	}
	
	public void changeNotice(Map<String, Object> input) throws Exception {
		
		sqlSession.insert(Namespace + ".changeNotice", input);
	}
	
	public Map<String, Object> selectDownload() throws Exception {

		return sqlSession.selectOne(Namespace + ".selectDownload");
	}
	
	public List<Map<String, Object>> downloadList() {
		return sqlSession.selectList(Namespace + ".downloadList");
	}
	
	public List<Map<String, Object>> getStatusDownloadList(Map<String, Object> map) {
		return sqlSession.selectList(Namespace + ".getStatusDownloadList", map);
	}
	
	public void downloadInsert(Map<String, Object> input) {
		sqlSession.insert(Namespace + ".downloadInsert", input);
	}
	
	public void downloadUpdate(Map<String, Object> update) throws Exception {
		sqlSession.update(Namespace + ".downloadUpdate", update);
		
	}
	
	public void downloadDelete(Map<String, Object> delete) {
		sqlSession.delete(Namespace + ".downloadDelete", delete);
	}

	public void changeAccessIP(Map<String, Object> input) throws Exception {
		
		sqlSession.insert(Namespace + ".changeAccessIP", input);
	}

	public List<Map<String, Object>> selectManagerList() throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectManagerList");
	}
	
	public void changeManagerList(Map<String, Object> map) throws Exception {

		sqlSession.insert(Namespace+".changeManagerList", map);
	}
	
	public void changeUserDate(Map<String, Object> map) throws Exception {
		
		sqlSession.insert(Namespace+".changeUserDate", map);
	}
	
	public void userDelete(Map<String, Object> map) throws Exception {
		
		sqlSession.delete(Namespace+".userDelete", map);
	}

	public List<Map<String, Object>> selectTeamCode() throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectTeamCode");
	}

	public Map<String, Object> chkDuplicateUserNo(String userNo) throws Exception {
		
		return sqlSession.selectOne(Namespace + ".chkDuplicateUserNo", userNo);
	}
	
	public void createTeam(Map<String, Object> map) throws Exception {
		
		sqlSession.insert(Namespace+".createTeam", map);
	}
	
	public void createUser(Map<String, Object> map) throws Exception {

		sqlSession.insert(Namespace+".createUser", map);
	}
	
	public Map<String, Object> sumApproval(Map<String, String> map) {
		return sqlSession.selectOne(Namespace + ".sumApproval", map);
	}
	
	public List<Map<String, Object>> selectAccountOfficeList() throws Exception {
		return sqlSession.selectList(Namespace + ".selectAccountOfficeList");
	}

	public boolean updateFailedCount(Map<String, String> map) {
		return (sqlSession.update(Namespace + ".updateFailedCount", map) > 0);
	}

	/*public void createAccountInfo(Map<String, Object> map) throws Exception{
		sqlSession.insert(Namespace+".createAccountInfo", map);
	}*/

	public List<Map<String, Object>> getLogFlagList() {
		return sqlSession.selectList(Namespace + ".getLogFlagList");
	}
	
	public void updateSMSCode(Map<String, Object> map) {
		sqlSession.update(Namespace + ".updateSMSCode", map);
	}
	
	public Map<String, Object> selectSmsMember(Map<String, Object> map) throws Exception {

		return sqlSession.selectOne(Namespace + ".selectSmsMember", map);
	}

	public List<Map<String, Object>> setHeader(Map<String, Object> map) {
		
		return sqlSession.selectList(Namespace + ".setHeader", map);
	}

	public Map<String, Object> setPageData(Map<String, Object> map) {
		return sqlSession.selectOne(Namespace + ".setPageData", map);
	}
	
	public void setSmsCode(Map<String, Object> map) throws Exception {
		
		sqlSession.update(Namespace + ".setSmsCode", map);
	}

	public void reset_sms_code(Map<String, Object> map) {
		sqlSession.update(Namespace + ".reset_sms_code", map);
	}

	public void changeUserSettingDate(Map<String, Object> map) throws Exception {
		
		sqlSession.update(Namespace+".changeUserSettingDate", map);
	}

	public Map<String, Object> selectChangeMember(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectChangeMember", map);
	}

	public List<Map<String, Object>> selectMemberTeam() {
		return sqlSession.selectList(Namespace + ".selectMemberTeam");
	}
	
	public List<Map<String, Object>> selectPCAdmin(Map<String, Object> searchMap) {
		return sqlSession.selectList(Namespace + ".selectPCAdmin", searchMap);
	}

	public void updatemember(Map<String, Object> searchMap) throws Exception {
		sqlSession.update(Namespace+".updatemember", searchMap);
	}
	
	public void updateLockMember(Map<String, Object> searchMap) throws Exception {
		sqlSession.update(Namespace+".updateLockMember", searchMap);
	}

	public int lockMemberRequest(Map<String, Object> requestMap) {
		return sqlSession.update(Namespace+".lockMemberRequest", requestMap);
	}

	public int unlockMemberRequest(Map<String, Object> requestMap) {
		return sqlSession.update(Namespace+".unlockMemberRequest", requestMap);
	}

	public List<Map<String, Object>> selectLockManagerList(Map<String, Object> requestMap) throws Exception {
		
		return sqlSession.selectList(Namespace + ".selectLockManagerList", requestMap);
	}

	public Map<String, Object> selectAccoutnLockMember(Map<String, Object> requestMap)  throws Exception {
		return sqlSession.selectOne(Namespace + ".selectAccoutnLockMember", requestMap);
	}

	public List<Map<String, String>> selectAdminMember(Map<String, Object> requestMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectAdminMember", requestMap);
	}
	
	public String selectSMSFlag() throws Exception {
		return sqlSession.selectOne(Namespace + ".selectSMSFlag");
	}
	
	public void updateSMSFlag(Map<String, Object> update) throws Exception {
		sqlSession.update(Namespace + ".updateSMSFlag", update);
	}

	public List<Map<Object, Object>> selectSetting() throws Exception {
		return sqlSession.selectList(Namespace + ".selectSetting");
	}
}
