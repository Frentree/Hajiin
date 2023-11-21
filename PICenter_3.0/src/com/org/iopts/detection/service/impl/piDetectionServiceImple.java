package com.org.iopts.detection.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.detection.controller.piDetectionController;
import com.org.iopts.detection.dao.piDetectionDAO;
import com.org.iopts.detection.service.piDetectionService;
import com.org.iopts.util.SessionUtil;

@Service("detectionService")
@Transactional
public class piDetectionServiceImple implements piDetectionService {

	private static Logger log = LoggerFactory.getLogger(piDetectionController.class);

	@Inject
	private piDetectionDAO detectionDao;

	@Override
	public List<HashMap<String, Object>> selectFindSubpath(HashMap<String, Object> params) throws Exception
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no"  , user_no);

		List<HashMap<String, Object>>findList = detectionDao.selectFindSubpath(params);

		return findList;
	}

	@Override
	public HashMap<String, Object> selectProcessDocuNum(HashMap<String, Object> params) throws Exception 
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		HashMap<String, Object> memberMap = detectionDao.selectProcessDocuNum(params);

		return memberMap;
	}
	
	@Override
	public HashMap<String, Object> select_process_docu_num(HashMap<String, Object> params) throws Exception 
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);
		
		log.info("select_process_docu_num  >> " + params);
		
		HashMap<String, Object> memberMap = detectionDao.selectProcessDocuNum(params);
		
		return memberMap;
	}

	@Override
	public HashMap<String, Object> selectExceptionDocuNum(HashMap<String, Object> params) throws Exception 
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		HashMap<String, Object> memberMap = detectionDao.selectExceptionDocuNum(params);

		return memberMap;
	}
	
	@Override
	public HashMap<String, Object> selectDMZTime() throws Exception 
	{
		HashMap<String, Object> dmzTime = detectionDao.selectDMZTime();

		return dmzTime;
	}

	@Override
	public HashMap<String, Object> registProcessGroup(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		List<String> deletionList = (List<String>)params.get("deletionList");

		params.put("user_no", user_no);
		params.put("hash_id", deletionList.get(0));
		params.put("notePad", params.get("notePad"));

		detectionDao.registProcessGroup(params);

		return params;
	}
	
	@Override
	public HashMap<String, Object> regist_process_group(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		List<String> deletionList = (List<String>)params.get("deletionList");
		
		params.put("user_no", user_no);
		params.put("hash_id", deletionList.get(0));
		params.put("notePad", params.get("notePad"));
		
		log.info("regist_process_group >>> " + params );
		
		detectionDao.regist_process_group(params);
		
		return params;
	}
	
	@Override
	@Transactional
	public void registProcess(HashMap<String, Object> params, HashMap<String, Object> GroupMap) throws Exception 
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		List<String> deletionList = (List<String>)params.get("deletionList");

		for (int i = 0; i < deletionList.size(); i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			params.put("user_no", user_no);
			params.put("hash_id", deletionList.get(i));
			params.put("data_processing_group_idx", GroupMap.get("idx"));
			params.put("notePad", GroupMap.get("notePad"));

			detectionDao.registProcess(params);
		}
	}
	
	@Override
	@Transactional
	public void regist_process(HashMap<String, Object> params, HashMap<String, Object> GroupMap) throws Exception 
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		List<String> deletionList = (List<String>)params.get("deletionList");
		
		for (int i = 0; i < deletionList.size(); i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			params.put("user_no", user_no);
			params.put("hash_id", deletionList.get(i));
			params.put("data_processing_group_idx", GroupMap.get("data_processing_group_idx"));
			params.put("notePad", GroupMap.get("notePad"));
			
			log.info("regist_process >>>>> " + params);
			
			detectionDao.regist_process(params);
		}
	}

	@Override
	public void registPathException(HashMap<String, Object> params) throws Exception 
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");

		List<String> path_ex = (List<String>)params.get("path_ex");
		List<String> target_id = (List<String>)params.get("target_id");
		List<String> path_ex_scope = (List<String>)params.get("path_ex_scope");

		String hashCodeStr = "";
		int cnt = 0;

		HashMap<String, Object> insertExcepGroupMap = null;
		HashMap<String, Object> insertExcepMap = null;

		for (int i = 0; i < path_ex_scope.size(); i++) 
		{
			insertExcepGroupMap = new HashMap<String, Object>();

			insertExcepGroupMap.put("target_id", 		  target_id.get(i));
			insertExcepGroupMap.put("user_no", 			  user_no);
			insertExcepGroupMap.put("path_ex_flag",       params.get("path_ex_flag"));
			insertExcepGroupMap.put("path_ex_group_id",   params.get("path_ex_group_id"));
			insertExcepGroupMap.put("path_ex_scope",      path_ex_scope.get(i));
			insertExcepGroupMap.put("path_ex_group_name", params.get("path_ex_group_name"));

			detectionDao.registPathExceptionGroup(insertExcepGroupMap);			// pi_path_exception_group 테이블 저장

			for(int j = 0; j < path_ex.size(); j++) 
			{
				insertExcepMap = new HashMap<String, Object>();
				hashCodeStr = path_ex.get(j);
				hashCodeStr += path_ex_scope.get(i);

				insertExcepMap.put("target_id",                target_id.get(i));
				insertExcepMap.put("path_ex",                  path_ex.get(j));
				insertExcepMap.put("user_no",                  user_no);
				insertExcepMap.put("path_ex_flag",             params.get("path_ex_flag"));
				insertExcepMap.put("path_ex_scope",            path_ex_scope.get(i));
				insertExcepMap.put("hash_code",                hashCodeStr.hashCode());
				insertExcepMap.put("path_exception_group_idx", insertExcepGroupMap.get("idx"));

				cnt = detectionDao.preCheckRegistPathException(insertExcepMap);

				if(cnt < 1) {
					detectionDao.registPathException(insertExcepMap);
				}
			}
		}
	}
	
	@Override
	public void registPathCharge(HashMap<String, Object> params) throws Exception 
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		List<String> path_ex = (List<String>)params.get("path_ex");
		List<String> target_id = (List<String>)params.get("target_id");
		List<String> hostname = (List<String>)params.get("aPathHost");
		String ok_user_no = (String)params.get("ok_user_no");
		
		log.info("hostname = " + hostname + "\nok_user_no = " + ok_user_no );
		
		HashMap<String, Object> insertPathChargeGroupMap = null;
		
		for (int i = 0; i < path_ex.size(); i++) 
		{
			insertPathChargeGroupMap = new HashMap<String, Object>();
			
			for(int j = 0; j < target_id.size(); j++) 
			{
				insertPathChargeGroupMap.put("path_ex", 		   path_ex.get(i));
				insertPathChargeGroupMap.put("target_id", 		   target_id.get(j));
				insertPathChargeGroupMap.put("user_no", 		   user_no);
				insertPathChargeGroupMap.put("ok_user_no", 		   ok_user_no);
				insertPathChargeGroupMap.put("host_name", 		   hostname.get(j));
				
				detectionDao.registPathCharge(insertPathChargeGroupMap);			// pi_exception 테이블 저장
			}
		}
	}

	@Override
	public List<HashMap<String, Object>> selectTeamMember(HashMap<String, Object> params) throws Exception
	{
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String insa_code = SessionUtil.getSession("memberSession", "INSA_CODE");

		params.put("user_no",   user_no);
		params.put("insa_code", insa_code);

		return detectionDao.selectTeamMember(params);
	}

	@Override
	public void registChange(HashMap<String, Object> params) throws Exception
	{
		log.info("registChange ServiceImple check : "+params);

		String user_no     = SessionUtil.getSession("memberSession", "USER_NO");
		String ok_user_no  = (String) params.get("ok_user_no");
		String change_type = (String) params.get("change_type");
		String path_id = "";

		List<String> path = (List<String>) params.get("path");
		List<String> target_id = (List<String>) params.get("target_id");
		List<String> hash_id = (List<String>) params.get("hash_id");

		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> hashList = null;

		if (change_type.equals("add")) {
			for (int i = 0; i < target_id.size(); i++) 
			{
				map.put("target_id", target_id.get(i));
				for (int j = 0; j < path.size(); j++) 
				{
					path_id = (String) path.get(j);
					map.put("path", path_id.replaceAll("/\\|\\\\/g", "\\"));
					hashList = detectionDao.selectHashId(map);
					for (int k = 0; k < hashList.size(); k++) 
					{
						//map.put("hash_id", hashList.get(j).get("HASH_ID"));
						map.put("hash_id", hashList.get(k).get("HASH_ID"));
						map.put("path", hashList.get(k).get("PATH"));		// 추가 : 입력한 path 경로로 조회된 실제 path
						map.put("user_no", user_no);
						map.put("ok_user_no", ok_user_no);

						detectionDao.registChange(map);
					}
				}
			}
		}
		else if (change_type.equals("select")) {
			for (int i = 0; i < target_id.size(); i++) 
			{
				map.put("target_id", target_id.get(i));
	
				for (int j = 0; j < hash_id.size(); j++) 
				{
					map.put("hash_id", hash_id.get(j));
					map.put("path", path.get(j));
					map.put("user_no", user_no);
					map.put("ok_user_no", ok_user_no);
					log.info("registChange : " + map.toString());
	
					detectionDao.registChange(map);
				}
			}
		}
	}
	
	@Override
	public List<HashMap<String, Object>> selectDownloadList(HashMap<String, Object> params,	HashMap<String, Object> targetInfo) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no"  , user_no);
		
		List<HashMap<String, Object>>findList = detectionDao.selectFindSubpath2(params);
		if("Remote Access Only".equals(targetInfo.get("PLATFORM"))) {			// DB 데이터일 경우
			List<HashMap<String, Object>> resultList = new ArrayList<>();
			
			for(int i=0; i<findList.size(); i++) {
				String shortname = findList.get(i).get("SHORTNAME").toString();
				String[] split_shortname = shortname.split("/");
//				log.info("["+i+"] :: " + findList.get(i).get("SHORTNAME"));
//				log.info("["+i+"] split_shortname :: " + split_shortname.length);
//				log.info("["+i+"] ID :: " + findList.get(i).get("ID").toString());
//				log.info("["+i+"] LEVEL :: " + findList.get(i).get("LEVEL").toString());
//				log.info(findList.get(i).toString());
				
				if(split_shortname.length <= 3 && "1".equals(findList.get(i).get("LEVEL").toString())) {
					resultList.add(findList.get(i));
				}
			}
			
			if(resultList.size() < findList.size()) {
				for(int i=0; i<findList.size(); i++) {
					String shortname = findList.get(i).get("SHORTNAME").toString();
					String[] split_shortname = shortname.split("/");
					
					if(split_shortname.length > 3) {		// LOB 컬럼이 있을경우
						String lob_shortname = split_shortname[0]+"/"+split_shortname[1]+"/"+split_shortname[2];
						String id = findList.get(i).get("ID").toString();
						int lob_type1 = Integer.parseInt(findList.get(i).get("TYPE1").toString());
						int lob_type2 = Integer.parseInt(findList.get(i).get("TYPE2").toString());
						int lob_type3 = Integer.parseInt(findList.get(i).get("TYPE3").toString());
						int lob_type4 = Integer.parseInt(findList.get(i).get("TYPE4").toString());
						int lob_type5 = Integer.parseInt(findList.get(i).get("TYPE5").toString());
						int lob_type6 = Integer.parseInt(findList.get(i).get("TYPE6").toString());
						int lob_type = Integer.parseInt(findList.get(i).get("TYPE").toString());
						
						for(int j=0; j<resultList.size(); j++) {
							String result_shortname = resultList.get(j).get("SHORTNAME").toString();
							if(result_shortname.equals(lob_shortname) && !id.equals(resultList.get(j).get("ID").toString())) {
								int find_type1 = Integer.parseInt(resultList.get(j).get("TYPE1").toString());
								int find_type2 = Integer.parseInt(resultList.get(j).get("TYPE2").toString());
								int find_type3 = Integer.parseInt(resultList.get(j).get("TYPE3").toString());
								int find_type4 = Integer.parseInt(resultList.get(j).get("TYPE4").toString());
								int find_type5 = Integer.parseInt(resultList.get(j).get("TYPE5").toString());
								int find_type6 = Integer.parseInt(resultList.get(j).get("TYPE6").toString());
								int find_type = Integer.parseInt(resultList.get(j).get("TYPE").toString());
								
								resultList.get(j).put("TYPE1", find_type1+lob_type1);
								resultList.get(j).put("TYPE2", find_type2+lob_type2);
								resultList.get(j).put("TYPE3", find_type3+lob_type3);
								resultList.get(j).put("TYPE4", find_type4+lob_type4);
								resultList.get(j).put("TYPE5", find_type5+lob_type5);
								resultList.get(j).put("TYPE6", find_type6+lob_type6);
								resultList.get(j).put("TYPE"	, find_type+lob_type);
								break;
							}
							if(j == (resultList.size() - 1 )) {
								HashMap<String, Object> map = findList.get(i);
								map.put("SHORTNAME", lob_shortname);
								resultList.add(map);
								break;
							}
						}
					}
				}
			}
			return resultList;
		} else {
			
			return findList;
		}
		
	}
}