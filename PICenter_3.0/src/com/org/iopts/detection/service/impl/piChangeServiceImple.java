package com.org.iopts.detection.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.detection.dao.piChangeDAO;
import com.org.iopts.detection.service.piChangeService;
import com.org.iopts.util.SessionUtil;

@Service("changeService")
@Transactional
public class piChangeServiceImple implements piChangeService {
	
	private static Logger log = LoggerFactory.getLogger(piChangeServiceImple.class);

	@Inject
	private piChangeDAO changeDao;

	@Override
	public List<HashMap<String, Object>> selectChangeList(HashMap<String, Object> params) throws Exception
	{
		log.info("selectChangeList -> 담당자 변경 리스트");
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		return changeDao.selectChangeList(params);
	}
	
	@Override
	public List<HashMap<String, Object>> selectPathChangeList(HashMap<String, Object> params) throws Exception
	{
		log.info("selectPathChangeList -> 경로 담당자 변경 리스트");
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);
		
		return changeDao.selectPathChangeList(params);
	}

	@Override
	public void updateChangeApproval(HashMap<String, Object> params) throws Exception
	{
		log.info("updateChangeApproval 로그체크");
		
		// target Array
		List<String> targetArr = new ArrayList<String>();
		List<String> targetArrUniq = new ArrayList<String>();
		
		String ok_user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("ok_user_no", ok_user_no);
		
		List<String> idxList    = (List<String>) params.get("idxList");
		List<String> targetList = (List<String>) params.get("targetList");
		List<String> hashIdList = (List<String>) params.get("hashIdList");
		log.info("chargeIdList 로그체크 : " + idxList);

		for (int i = 0; i < idxList.size(); i++) {
			params.put("idx", idxList.get(i));
			params.put("target_id", targetList.get(i));
			params.put("hash_id", hashIdList.get(i));

			log.info("updateChangeApproval 로그체크2 : " + params);
			changeDao.updateChangeApproval(params);

			if ("E".equals(params.get("apprType"))) {
				changeDao.updateChangeFind(params);
				
				targetArr.add(targetList.get(i));	// 승인으로 담당자 변경될 항목들의 target 수집
			}
		}
		
		// 담당자변경 승인일 경우 
		if("E".equals(params.get("apprType"))) {
			HashMap<String, Object> paramTarget = new HashMap<String, Object>();
			
			// 담당자변경 승인된 target의 중복제거
			for(int i=0; i<targetArr.size(); i++) {
				if(!targetArrUniq.contains(targetArr.get(i))) {
					targetArrUniq.add(targetArr.get(i));
				}
			}
			
			// 담당자 변경 승인된 taget을 해당 담당자가 가지고 있도록  insert into on duplicate key update
			for(int i=0; i<targetArrUniq.size(); i++) {
				paramTarget = new HashMap<String, Object>();
				paramTarget.put("USER_NO", ok_user_no);
				paramTarget.put("TARGET_ID", targetArrUniq.get(i));
				changeDao.insertUpdateTargetUserByChangeApproval(paramTarget);
			}
		}
	}
	
	@Override
	public void updatePathChangeApproval(HashMap<String, Object> params) throws Exception
	{
		log.info("updatePathChangeApproval 로그체크");
		
		// target Array
		List<String> targetArr = new ArrayList<String>();
		List<String> targetArrUniq = new ArrayList<String>();
		
		String ok_user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("ok_user_no", ok_user_no);
		
		List<String> idxList    = (List<String>) params.get("idxList");
		List<String> targetList = (List<String>) params.get("targetList");
		log.info("chargeIdList 로그체크 : " + idxList);
		
		for (int i = 0; i < idxList.size(); i++) {
			params.put("idx", idxList.get(i));
			params.put("target_id", targetList.get(i));
			
			log.info("updatePathChangeApproval 로그체크2 : " + params);
			changeDao.updatePathChangeApproval(params);
			
			if ("E".equals(params.get("apprType"))) {
				/*changeDao.updateChangeFind(params);*/
				
				targetArr.add(targetList.get(i));	// 승인으로 담당자 변경될 항목들의 target 수집
			}
		}
		
		// 담당자변경 승인일 경우 
		if("E".equals(params.get("apprType"))) {
			HashMap<String, Object> paramTarget = new HashMap<String, Object>();
			
			// 담당자변경 승인된 target의 중복제거
			for(int i=0; i<targetArr.size(); i++) {
				if(!targetArrUniq.contains(targetArr.get(i))) {
					targetArrUniq.add(targetArr.get(i));
				}
			}
			
			// 담당자 변경 승인된 taget을 해당 담당자가 가지고 있도록  insert into on duplicate key update
			for(int i=0; i<targetArrUniq.size(); i++) {
				paramTarget = new HashMap<String, Object>();
				paramTarget.put("USER_NO", ok_user_no);
				paramTarget.put("TARGET_ID", targetArrUniq.get(i));
				changeDao.insertUpdateTargetUserByChangeApproval(paramTarget);
			}
		}
	}
}