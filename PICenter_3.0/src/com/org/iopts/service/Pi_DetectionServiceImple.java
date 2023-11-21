package com.org.iopts.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.dao.Pi_DetectionDAO;
import com.org.iopts.util.SessionUtil;

@Service
public class Pi_DetectionServiceImple implements Pi_DetectionService {
	
	private static Logger log = LoggerFactory.getLogger(Pi_DetectionServiceImple.class);
	
	@Inject
	private Pi_DetectionDAO detectionDao;
	
	@Override
	@Transactional
	//public void registProcessGroup(HttpServletRequest request) throws Exception {
	public Map<String, Object> registProcessGroup(HttpServletRequest request) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String next_date_remedi = request.getParameter("next_date_remedi");
		String processing_flag = request.getParameter("processing_flag");
		String data_processing_name = request.getParameter("data_processing_name");
		String data_processing_group_id = request.getParameter("data_processing_group_id");
		String[] deletionList = request.getParameterValues("deletionList[]");
		
		Map<String, Object> GroupMap = new HashMap<String, Object>();
		
		GroupMap.put("hash_id", deletionList[0]);
		GroupMap.put("user_no", user_no);
		GroupMap.put("next_date_remedi", next_date_remedi);
		GroupMap.put("processing_flag", processing_flag);
		GroupMap.put("data_processing_name", data_processing_name);
		GroupMap.put("data_processing_group_id", data_processing_group_id);
		
		detectionDao.registProcessGroup(GroupMap);
		
		return GroupMap;
		
		/*
		for (int i = 0; i < deletionList.length; i++) {
			
			map.put("hash_id", deletionList[i]);
			map.put("user_no", user_no);
			map.put("next_date_remedi", next_date_remedi);
			map.put("processing_flag", processing_flag);
			map.put("data_processing_name", data_processing_name);
			map.put("data_processing_group_id", data_processing_group_id);
			log.info("registProcessGroup : " + map.toString());
		}
		
		detectionDao.registProcessGroup(map);
		*/
	}
	
	@Override
	@Transactional
	public void registProcess(HttpServletRequest request, Map<String, Object> GroupMap) throws Exception {
		log.info("registProcess ServiceImple check");
		
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String processing_flag = request.getParameter("processing_flag");
		String data_processing_group_id = request.getParameter("data_processing_group_id");
		String[] deletionList = request.getParameterValues("deletionList[]");
		
		for (int i = 0; i < deletionList.length; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("user_no", user_no);
			map.put("hash_id", deletionList[i]);
			map.put("processing_flag", processing_flag);
			map.put("data_processing_group_id", data_processing_group_id);
			
			map.put("data_processing_group_idx", GroupMap.get("idx"));
			
			log.info("registProcess : " + map.toString());
			
			detectionDao.registProcess(map);
			
		}
		
	}
	
	@Override
	public void registProcessCharge(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String ok_user_no = request.getParameter("ok_user_no");
		String data_processing_charge_id = request.getParameter("data_processing_charge_id");
		String data_processing_charge_name = request.getParameter("data_processing_charge_name");
		log.info("registProcessCharge 체크");

		Map<String, Object> chargeMap = new HashMap<String, Object>();
		chargeMap.put("user_no", user_no);
		chargeMap.put("ok_user_no", ok_user_no);
		chargeMap.put("data_processing_charge_id", data_processing_charge_id);
		chargeMap.put("data_processing_charge_name", data_processing_charge_name);
		log.info("registProcessCharge 체크2 : " + chargeMap.toString());
		detectionDao.registProcessCharge(chargeMap);
	}
	
	
	/*
	@Override
	public void registPathExceptionGroup(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String path_ex_group_name = request.getParameter("path_ex_group_name");
		String path_ex_flag = request.getParameter("path_ex_flag");
		String path_ex_group_id = request.getParameter("path_ex_group_id");
		String[] path_ex_scope = request.getParameterValues("path_ex_scope[]");
		String[] target_id = request.getParameterValues("target_id[]");
		
		Map<String, Object> insertExcepGroupMap = new HashMap<String, Object>();
		
		for (int i = 0; i < target_id.length; i++) {
			log.info("registPathExceptionGroup 첫번째 for문 : " + insertExcepGroupMap);
			insertExcepGroupMap.put("target_id", target_id[i]);
			
			
			for (int j = 0; j < path_ex_scope.length; j++) {
				insertExcepGroupMap.put("user_no", user_no);
				insertExcepGroupMap.put("path_ex_flag", path_ex_flag);
				insertExcepGroupMap.put("path_ex_group_id", path_ex_group_id);
				insertExcepGroupMap.put("path_ex_scope", path_ex_scope[j]);
				insertExcepGroupMap.put("path_ex_group_name", path_ex_group_name);
				log.info("registPathExceptionGroup : " + insertExcepGroupMap);
				detectionDao.registPathExceptionGroup(insertExcepGroupMap);
			}
		}
	}
	*/
	@Override
	public void registPathException(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String path_ex_group_name = request.getParameter("path_ex_group_name");
		String path_ex_flag = request.getParameter("path_ex_flag");
		String path_ex_group_id = request.getParameter("path_ex_group_id");
		String[] target_id = request.getParameterValues("target_id[]");
		String[] path_ex_scope = request.getParameterValues("path_ex_scope[]");
		String[] path_ex = request.getParameterValues("path_ex[]");
		String hashCodeStr = "";
		int cnt = 0;
		
		Map<String, Object> insertExcepGroupMap;
		Map<String, Object> insertExcepMap;
		for (int i = 0; i < path_ex_scope.length; i++) {
			insertExcepGroupMap = new HashMap<String, Object>();
			log.info("registPathExceptionGroup 첫번째 for문 : " + insertExcepGroupMap);
			insertExcepGroupMap.put("target_id", target_id[i]);
			insertExcepGroupMap.put("user_no", user_no);
			insertExcepGroupMap.put("path_ex_flag", path_ex_flag);
			insertExcepGroupMap.put("path_ex_group_id", path_ex_group_id);
			insertExcepGroupMap.put("path_ex_scope", path_ex_scope[i]);
			insertExcepGroupMap.put("path_ex_group_name", path_ex_group_name);
			log.info("registPathExceptionGroup : " + insertExcepGroupMap);
			detectionDao.registPathExceptionGroup(insertExcepGroupMap);			// pi_path_exception_group 테이블 저장
			
			for(int j = 0; j < path_ex.length; j++) {
				insertExcepMap = new HashMap<String, Object>();
				hashCodeStr = path_ex[j];
				hashCodeStr += path_ex_scope[i];
				
				insertExcepMap.put("path_ex", path_ex[j]);
				
				insertExcepMap.put("user_no", user_no);
				insertExcepMap.put("path_ex_flag", path_ex_flag);
				insertExcepMap.put("path_ex_group_id", path_ex_group_id);
				insertExcepMap.put("path_ex_scope", path_ex_scope[i]);
				
				insertExcepMap.put("hash_code", hashCodeStr.hashCode());
				
				insertExcepMap.put("path_exception_group_idx", insertExcepGroupMap.get("idx"));
				
				cnt = detectionDao.preCheckRegistPathException(insertExcepMap);
				if(cnt < 1) {
					detectionDao.registPathException(insertExcepMap);
				}
				
			}
			
		}
		
		
		/*
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String path_ex_flag = request.getParameter("path_ex_flag");
		String path_ex_group_id = request.getParameter("path_ex_group_id");
		String[] path_ex_scope = request.getParameterValues("path_ex_scope[]");
		String[] path_ex = request.getParameterValues("path_ex[]");
		String hashCodeStr = "";
		int cnt = 0;
		log.info("ServiceImple registPathException 호출");
	
		Map<String, Object> insertExcepMap = new HashMap<String, Object>();
		for (int i = 0; i < path_ex.length; i++) {
			insertExcepMap.put("path_ex", path_ex[i]);
			//log.info("insertExcepMap : " + insertExcepMap);
			hashCodeStr = path_ex[i];
			
			for (int j = 0; j < path_ex_scope.length; j++) {
				insertExcepMap.put("user_no", user_no);
				insertExcepMap.put("path_ex_flag", path_ex_flag);
				insertExcepMap.put("path_ex_group_id", path_ex_group_id);
				insertExcepMap.put("path_ex_scope", path_ex_scope[j]);
				hashCodeStr += path_ex_scope[j];
				insertExcepMap.put("hash_code", hashCodeStr.hashCode());
				log.info("insertExcepMap 2번 for문 : " + insertExcepMap);
				cnt = detectionDao.preCheckRegistPathException(insertExcepMap);
				if(cnt < 1) {
					detectionDao.registPathException(insertExcepMap);
				}
			}
		}
		*/
	}
	
	
	
	@Override
	public void registPathExceptionCharge(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String ok_user_no = request.getParameter("ok_user_no");
		String path_ex_charge_name = request.getParameter("path_ex_charge_name");
		String path_ex_charge_id = request.getParameter("path_ex_charge_id");
		log.info("서비스 임플 exceptionList 확인");

		Map<String, Object> insertExcepChargeMap = new HashMap<String, Object>();
		insertExcepChargeMap.put("user_no", user_no);
		insertExcepChargeMap.put("ok_user_no", ok_user_no);
		insertExcepChargeMap.put("path_ex_charge_name", path_ex_charge_name);
		insertExcepChargeMap.put("path_ex_charge_id", path_ex_charge_id);
		log.info("registPathExceptionCharge : " + insertExcepChargeMap.toString());
		detectionDao.registPathExceptionCharge(insertExcepChargeMap);
	}
	
	@Override
	public void registChange(HttpServletRequest request) {
		log.info("registChange ServiceImple check");
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String ok_user_no = request.getParameter("ok_user_no");

		String[] path = request.getParameterValues("path[]");
		String[] target_id = request.getParameterValues("target_id[]");
		String[] hash_id = request.getParameterValues("hash_id[]");

		Map<String, Object> map = new HashMap<String, Object>();
		
		for (int i = 0; i < target_id.length; i++) {
			map.put("target_id", target_id[i]);
				for (int j = 0; j < hash_id.length; j++) {
					map.put("hash_id", hash_id[j]);
					map.put("path", path[j]);
					map.put("user_no", user_no);
					map.put("ok_user_no", ok_user_no);
					log.info("registChange : " + map.toString());
					detectionDao.registChange(map);
			}
		}
	}
	
	
	@Override
	public List<Map<String, Object>> selectFindSubpath(HttpServletRequest request) {
		
		String target_id = request.getParameter("target_id");
		String location  = request.getParameter("location");
		String user_no   = SessionUtil.getSession("memberSession", "USER_NO");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("target_id", target_id);
		map.put("location" , location);
		map.put("user_no"  , user_no);
		
		List<Map<String, Object>>findMap = detectionDao.selectFindSubpath(map);
		
		return findMap;
	}

	@Override
	public List<Map<String, Object>> searchProcessList(HttpServletRequest request) {
		
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String status = request.getParameter("approval_status");
		log.info("status 체크 : " + status);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", user_no);
		map.put("status", status);

		return detectionDao.searchProcessList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectProcessPath(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		searchMap.put("user_no", user_no);
		searchMap.put("data_processing_group_id", request.getParameter("data_processing_group_id"));
		log.info("selectProcessPath map 체크 : " + searchMap);
		
		return detectionDao.selectProcessPath(searchMap);
	}
	
	@Override
	public List<Map<String, Object>> selectProcessGroupPath(HashMap<String, Object> params) {
		return detectionDao.selectProcessGroupPath(params);
	}
	/*public List<Map<String, Object>> selectProcessGroupPath(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);
		searchMap.put("data_processing_charge_id", request.getParameter("data_processing_charge_id"));
		log.info("selectProcessGroupPath map 체크 : " + searchMap);
		
		return detectionDao.selectProcessGroupPath(searchMap);
	}*/
	
	@Override
	@Transactional
	public void approvalPlus(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String approval_id = request.getParameter("approval_id");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", user_no);
		map.put("approval_id", approval_id);
		detectionDao.approvalPlus(map);
	}

	@Override
	@Transactional
	public Map<String, Object> selectDocuNum(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", user_no);
		
		Map<String, Object> memberMap = detectionDao.selectDocuNum(map);
		log.info("selectDocuNum : " + memberMap);
		
		return memberMap;
		
	}

	@Override
	@Transactional
	public List<Map<String, Object>> selectExceptionList(HttpServletRequest request) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String status = request.getParameter("approval_status");
		String comment = request.getParameter("comment");
		log.info("status 체크 : " + status);
		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		searchMap.put("user_no", user_no);
		searchMap.put("status", status);
		searchMap.put("comment", comment);
		log.info("searchMap 체크 : " + searchMap);
		return detectionDao.selectExceptionList(searchMap);
	}

	@Override
	public List<Map<String, Object>> selectChangeList(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String status = request.getParameter("approval_status");
		String reason = request.getParameter("reason");
		String request_status = request.getParameter("request_status");
		
		
		Map<String, Object> searchMap = new HashMap<String, Object>();

		searchMap.put("user_no", user_no);
		searchMap.put("status", status);
		searchMap.put("reason", reason);
		searchMap.put("request_status", request_status);
		log.info("status 체크 : " + searchMap);
		searchMap.put("target_id", request.getParameter("target_id"));
		
		return detectionDao.selectChangeList(searchMap);
	}

	@Override
	public List<Map<String, Object>> searchApprovalListData(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		Map<String, Object> searchMap = new HashMap<String, Object>();

		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);
		searchMap.put("fromDate", request.getParameter("fromDate"));
		searchMap.put("toDate", request.getParameter("toDate"));
		searchMap.put("target_id", request.getParameter("target_id"));

		return detectionDao.searchApprovalListData(searchMap);
	}

	@Override
	public List<Map<String, Object>> exceptionApprovalListData(HttpServletRequest request) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		Map<String, Object> searchMap = new HashMap<String, Object>();

		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);

		return detectionDao.exceptionApprovalListData(searchMap);
	}

	@Override
	public List<Map<String, Object>> selectExeptionPath(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		searchMap.put("user_no", user_no);
		searchMap.put("path_ex_scope", request.getParameter("path_ex_scope"));
		log.info("searchMap 체크 : " + searchMap);
		searchMap.put("path_ex_group_id", request.getParameter("path_ex_group_id"));
		log.info("searchMap 체크 : " + searchMap);
		
		return detectionDao.selectExeptionPath(searchMap);
	}
	
	@Override
	public Map<String, Object> selectExeptionName(HttpServletRequest request) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String[] path_ex_charge_id = request.getParameterValues("path_ex_charge_id[]");

		Map<String, Object> searchMap = new HashMap<String, Object>();
		for (int i = 0; i < path_ex_charge_id.length; i++) {
			searchMap.put("user_no", user_no);
			searchMap.put("path_ex_charge_id", path_ex_charge_id[i]);
			detectionDao.selectExeptionName(searchMap);
			log.info("searchMap 확인 : " + searchMap);
		}
		
		return searchMap;
	}
	
	@Override
	public void updateExcepStatus(HttpServletRequest request) {
		log.info("updateExcepStatus 로그체크");
		
		
		String ok_user_no = request.getParameter("ok_user_no");
		String apprType = request.getParameter("apprType");
		String path_ex_charge_id = request.getParameter("path_ex_charge_id");
		String[] idxList = request.getParameterValues("idxList[]");
		String[] path_ex_scope = request.getParameterValues("path_ex_scope[]");
		
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < idxList.length; i++) {
			map.put("idxList", idxList[i]);
			map.put("path_ex_scope", path_ex_scope);
			map.put("path_ex_charge_id", path_ex_charge_id);
			map.put("ok_user_no", ok_user_no);
			map.put("apprType", apprType);
			log.info("updateExcepStatus 로그체크2 : " + map);
			detectionDao.updateExcepStatus(map);
		}  
	}

	@Override
	public void updateProcessStatus(HttpServletRequest request) {
		log.info("updateProcessStatus 로그체크");
		
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String ok_user_no = request.getParameter("ok_user_no");
		String apprType = request.getParameter("apprType");
		String data_processing_charge_id = request.getParameter("data_processing_charge_id");
		String group_id = request.getParameter("groupId");
		String comment = request.getParameter("comment");
		String[] idxList = request.getParameterValues("idxList[]");
		log.info("registProcessCharge 체크");
		
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < idxList.length; i++) {
			map.put("idx", idxList[i]);
			map.put("user_no", user_no);
			map.put("ok_user_no", ok_user_no);
			map.put("apprType", apprType);
			map.put("data_processing_charge_id", data_processing_charge_id);
			map.put("data_processing_group_id", group_id);
			map.put("comment", comment);
			log.info("updateProcessStatus 로그체크2 : " + map);
			detectionDao.updateProcessStatus(map);
		}
	}

	@Override
	public void updateExcepApproval(HttpServletRequest request) {
		log.info("updateExcepApproval 로그체크");
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String reason = request.getParameter("reason");
		log.info("reason 로그체크 : " + reason);
		
		String apprType = request.getParameter("apprType");
		log.info("apprType 로그체크 : " + apprType);
		
		String[] chargeIdList = request.getParameterValues("chargeIdList[]");
		log.info("chargeIdList 로그체크 : " + chargeIdList);
		
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < chargeIdList.length; i++) {
			map.put("chargeIdList", chargeIdList[i]);
			map.put("user_no", user_no);
			map.put("apprType", apprType);
			map.put("reason", reason);
			log.info("updateExcepApproval 로그체크2 : " + map);
			detectionDao.updateExcepApproval(map);
		}
	}

	@Override
	public void updateProcessApproval(HttpServletRequest request) {
		log.info("updateProcessApproval 로그체크");
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String reason = request.getParameter("reason");
		String apprType = request.getParameter("apprType");
		String dpgId = request.getParameter("dpgId");
		String[] chargeIdList = request.getParameterValues("chargeIdList[]");
		log.info("chargeIdList 로그체크 : " + chargeIdList);
		
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < chargeIdList.length; i++) {
			map.put("chargeIdList", chargeIdList[i]);
			map.put("user_no", user_no);
			map.put("apprType", apprType);
			map.put("dpgId", dpgId);
			map.put("reason", reason);
			log.info("updateProcessApproval 로그체크2 : " + map);
			detectionDao.updateProcessApproval(map);
		}
	}

	@Override
	public void updateChangeApproval(HttpServletRequest request) {
		log.info("updateChangeApproval 로그체크");
		
		String update_owner = SessionUtil.getSession("memberSession", "USER_NO");
		String ok_user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String reason = request.getParameter("reason");
		String apprType = request.getParameter("apprType");
		String[] idxList = request.getParameterValues("idxList[]");
		log.info("chargeIdList 로그체크 : " + idxList);
		
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < idxList.length; i++) {
			map.put("idx", idxList[i]);
			map.put("update_owner", update_owner);
			map.put("ok_user_no", ok_user_no);
			map.put("apprType", apprType);
			map.put("reason", reason);
			log.info("updateChangeApproval 로그체크2 : " + map);
			detectionDao.updateChangeApproval(map);
		}
	}

	@Override
	public List<Map<String, Object>> selectTeamMember(HttpServletRequest request) {
		Map<String, Object> searchMap = new HashMap<String, Object>();
		searchMap.put("insa_code", SessionUtil.getSession("memberSession", "INSA_CODE"));
		searchMap.put("user_no", SessionUtil.getSession("memberSession", "USER_NO"));
		
		return detectionDao.selectTeamMember(searchMap);
	}

}