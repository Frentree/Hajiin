package com.org.iopts.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.dto.Pi_AgentVO;
import com.org.iopts.dto.Pi_TargetVO;
import com.org.iopts.dto.Pi_Target_ManageVO;
import com.org.iopts.dto.Pi_TotalDatetypeVO;

@Repository
public class Pi_DashDAO {	

	private static final Logger logger = LoggerFactory.getLogger(Pi_DashDAO.class);

	@Autowired
    @Resource(name = "sqlSession")
    private SqlSession sqlSession;

	private static final String Namespace = "dashmapper";
	
	public List<Pi_AgentVO> selectDashMenu(String user_id) throws Exception {
		return sqlSession.selectList(Namespace+".selectDashMenu",user_id);
	}
	
	public Map<String, Object> selectWebLink() {
		return sqlSession.selectOne(Namespace+".selectWebLink");
	}
	
	public Map<String, Object> selectDashInfo(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashInfo",map);
	}
	
	public Map<String, Object> selectlastScanDate(String target_id) {
		return sqlSession.selectOne(Namespace+".selectlastScanDate", target_id);
	}
	
	public List<Map<String, Object>> selectDatatypeAll(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatypeAll",type);
	}
	
	public List<Map<String, Object>> selectDatatypeAll_day(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatypeAll_day",type);
	}
	
	public List<Map<String, Object>> selectDatatypeAll_manager(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatypeAll_manager",type);
	}
	
	public List<Map<String, Object>> selectDatatypeAll_day_manager(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatypeAll_day_manager",type);
	}
	
	public List<Map<String, Object>> selectDatatype_days(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatype_days", type);
	}
	
	public List<Map<String, Object>> selectDatatype(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatype", type);
	}
	
	public List<Map<String, Object>> selectDatatype_days_manager(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatype_days_manager", type);
	}
	
	public List<Map<String, Object>> selectDatatype_manager(Map<String, Object> type) throws Exception {
		return sqlSession.selectList(Namespace+".selectDatatype", type);
	}
	
	public List<Map<String, Object>> selectDatatypes(Map<String, Object> data) throws Exception {
		return sqlSession.selectList(Namespace + ".selectDatatypes",data);
	}

	public List<Object> selectSystemCurrent(Map<String, Object> input){
		return sqlSession.selectList(Namespace + ".selectSystemCurrent",input);
	}
	
	public List<Object> selectSystemCurrentPC(Map<String, Object> input){
		return sqlSession.selectList(Namespace + ".selectSystemCurrentPC",input);
	}
	
	public List<Object> selectSystemCurrentManager(Map<String, Object> input){
		return sqlSession.selectList(Namespace + ".selectSystemCurrentManager",input);
	}
	
	public List<Object> selectSystemCurrentService(Map<String, Object> input){
		return sqlSession.selectList(Namespace + ".selectSystemCurrentService",input);
	}
	
	public List<Object> selectServerExcelDownload(Map<String, Object> input){
		return sqlSession.selectList(Namespace + ".selectServerExcelDownload",input);
	}
	
	public List<Object> selectServerExcelDownloadList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList(Namespace+".selectServerExcelDownloadList", map);
	}
	
	public List<Object> selectPCExcelDownload(Map<String, Object> input){
		return sqlSession.selectList(Namespace + ".selectPCExcelDownload",input);
	}
	
	public List<Object> selectPCExcelDownloadList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList(Namespace+".selectPCExcelDownloadList", map);
	}
	
	public List<Object> selectPathCurrent() {
		return sqlSession.selectList(Namespace + ".selectPathCurrent");
	}
	
	public List<Object> selectJumpUpHost() {
		return sqlSession.selectList(Namespace + ".selectJumpUpHost");
	}
	
	public Map<String, Object> selectDashDataDetectionList(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashDataDetectionList", map);
	}
	
	public Map<String, Object> selectDashDataDetectionServerList(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashDataDetectionServerList", map);
	}
	
	public Map<String, Object> selectDashDataDetectionPCList(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashDataDetectionPCList", map);
	}
	
	public Map<String, Object> selectDashDataCompleteList(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashDataCompleteList", map);
	}
	
	public Map<String, Object> selectDashDataDetectionItemList(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashDataDetectionItemList", map);
	}
	
	public Map<String, Object> selectDashPersonalServerDetectionItemList(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashPersonalServerDetectionItemList", map);
	}
	
	public Map<String, Object> selectDashPersonalServerComplete(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashPersonalServerComplete", map);
	}
	
	public List<Object> selectDashDataRank(Map<String, Object> input) {
		return sqlSession.selectList(Namespace + ".selectDashDataRank", input);
	}
	
	public List<Map<String, Object>> selectDashPersonalServerRank(Map<String, Object> input) {
		return sqlSession.selectList(Namespace + ".selectDashPersonalServerRank", input);
	}
	
	public List<Map<String, Object>> selectDashPersonalPCRank(Map<String, Object> input) {
		return sqlSession.selectList(Namespace + ".selectDashPersonalPCRank", input);
	}
	
	public List<Object> selectDashPersonalManagerRank(Map<String, Object> input) {
		return sqlSession.selectList(Namespace + ".selectDashPersonalManagerRank", input);
	}
	
	public List<Object> selectDashDataImple() {
		return sqlSession.selectList(Namespace + ".selectDashDataImple");
	}
	
	public List<Object> selectDashDataImpleManager(Map<String, Object> input) {
		return sqlSession.selectList(Namespace + ".selectDashDataImpleManager",input);
	}
	
	public List<Map<String, Object>> selectDashPersonalServerImple(Map<String, Object> input) throws Exception {
		return sqlSession.selectList(Namespace+".selectDashPersonalServerImple", input);
	}
	
	public List<Map<String, Object>> selectDashDataPersonalServer(Map<String, Object> input) throws Exception {
		return sqlSession.selectList(Namespace+".selectDashDataPersonalServer", input);
	}
	
	public List<Map<String, Object>> selectDashDataPersonalPC(Map<String, Object> input) throws Exception {
		return sqlSession.selectList(Namespace+".selectDashDataPersonalPC", input);
	}
	
	public Map<String, Object> selectDashDataPersonalServerCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashDataPersonalServerCount", map);
	}
	
	public List<Map<String, Object>> selectDashDataPersonalServerCircle(Map<String, Object> input) {
		return sqlSession.selectList(Namespace + ".selectDashDataPersonalServerCircle", input);
	}
	
	public List<Map<String, Object>> selectDashDataPersonalPCCircle(Map<String, Object> input) {
		return sqlSession.selectList(Namespace + ".selectDashDataPersonalPCCircle", input);
	}
	
	public Map<String, Object> selectDashDataTodoList(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashDataTodoList", map);
	}
	
	public Map<String, Object> selectDashDataTodoApproval(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashDataTodoApproval", map);
	}
	
	public Map<String, Object> selectDashDataTodoSchedule(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(Namespace+".selectDashDataTodoSchedule", map);
	}
	
	public List<Object> selectDashPCJstreePopup(Map<String, Object> map) throws Exception {
		return sqlSession.selectList(Namespace+".selectDashPCJstreePopup", map);
	}

	public List<Object> selectSystemCurrentProgressPC(Map<String, Object> input) {
		return sqlSession.selectList(Namespace + ".selectSystemCurrentProgressPC",input);
	}

	public List<Object> selectSystemCurrentProgressOneDrive(Map<String, Object> input) {
		return sqlSession.selectList(Namespace + ".selectSystemCurrentProgressOneDrive",input);
	}
	
	public List<Map<String, Object>> selectDashPersonalProgressPc(Map<String, Object> input) {
		return sqlSession.selectList(Namespace + ".selectDashPersonalProgressPc", input);
	}

	public List<Map<String, Object>> selectDashPersonalProgressOneDrive(Map<String, Object> input) {
		return sqlSession.selectList(Namespace + ".selectDashPersonalProgressOneDrive",input);
	}
}