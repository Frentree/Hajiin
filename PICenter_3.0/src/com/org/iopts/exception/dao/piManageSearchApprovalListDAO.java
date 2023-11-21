package com.org.iopts.exception.dao;

import java.util.HashMap;
import java.util.List;

public interface piManageSearchApprovalListDAO {

	List<HashMap<String, Object>> searchApprovalListData(HashMap<String, Object> params);

	List<HashMap<String, Object>> selectProcessGroupPath(HashMap<String, Object> params);

	List<HashMap<String, Object>> searchApprovalAllListData(HashMap<String, Object> params);

}
