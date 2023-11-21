package com.org.iopts.exception.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.detection.dao.piChangeDAO;
import com.org.iopts.detection.service.impl.piChangeServiceImple;
import com.org.iopts.exception.dao.piManageChangeListDAO;
import com.org.iopts.exception.service.piManageChangeListService;
import com.org.iopts.util.SessionUtil;

@Service
@Transactional
public class piManageChangeListServiceImple implements piManageChangeListService {

	private static Logger log = LoggerFactory.getLogger(piChangeServiceImple.class);

	@Inject
	private piManageChangeListDAO changeDao;

	@Override
	public List<HashMap<String, Object>> selectChangeList(HashMap<String, Object> params) throws SQLException {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		return changeDao.selectChangeList(params);
	}
	
}
