package com.org.iopts.exception.service;

import java.util.HashMap;
import java.util.List;

public interface piManageSearchApprovalListService {

	List<HashMap<String, Object>> searchApprovalListData(HashMap<String, Object> params);

	List<HashMap<String, Object>> selectProcessGroupPath(HashMap<String, Object> params);

	List<HashMap<String, Object>> searchApprovalAllListData(HashMap<String, Object> params);


}
