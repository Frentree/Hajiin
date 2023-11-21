package com.org.iopts.exception.dao;

import java.util.HashMap;
import java.util.List;

public interface piManageChangeListDAO {

	List<HashMap<String, Object>> selectChangeList(HashMap<String, Object> params);

}
