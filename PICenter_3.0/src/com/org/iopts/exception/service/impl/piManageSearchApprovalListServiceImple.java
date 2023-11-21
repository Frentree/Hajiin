package com.org.iopts.exception.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;
import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.exception.dao.piManageSearchApprovalListDAO;
import com.org.iopts.exception.service.piManageSearchApprovalListService;
import com.org.iopts.util.SessionUtil;

@Service
@Transactional
public class piManageSearchApprovalListServiceImple implements piManageSearchApprovalListService {
	
private static Logger log = LoggerFactory.getLogger(piManageSearchApprovalListServiceImple.class);
	
	@Inject
	private piManageSearchApprovalListDAO managedao;
	
	@Override
	public List<HashMap<String, Object>> searchApprovalListData(HashMap<String, Object> params) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		params.put("user_no", user_no);
		params.put("user_grade", user_grade);

		return managedao.searchApprovalListData(params);
	}

	@Override
	public List<HashMap<String, Object>> selectProcessGroupPath(HashMap<String, Object> params) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		String charge_id = (String)params.get("CHARGE_ID_LIST");
		List<String> charge_id_list = new ArrayList<String>();
		if(charge_id != null && !"".equals(charge_id)) {
			StringTokenizer st = new StringTokenizer(charge_id,",");
			while(st.hasMoreTokens()) {
				charge_id_list.add(st.nextToken());
			}
		}

		params.put("user_no", user_no);
		params.put("user_grade", user_grade);
		params.put("charge_id_list", charge_id_list);

		return managedao.selectProcessGroupPath(params);
	}

	@Override
	public List<HashMap<String, Object>> searchApprovalAllListData(HashMap<String, Object> params) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		params.put("user_no", user_no);

		return managedao.searchApprovalAllListData(params);
	}

}
