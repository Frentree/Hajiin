package com.org.iopts.report.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.HashMap;

public interface piReportExceptDAO {

	public List<HashMap<String, Object>> searchExceptionList(HashMap<String, Object> params) throws SQLException;
}