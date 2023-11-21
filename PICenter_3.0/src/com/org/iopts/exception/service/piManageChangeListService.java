package com.org.iopts.exception.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface piManageChangeListService {

	List<HashMap<String, Object>> selectChangeList(HashMap<String, Object> params) throws SQLException;

}
