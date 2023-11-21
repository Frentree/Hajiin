package com.org.iopts.report.service;

import java.util.HashMap;
import java.util.List;

public interface piReportExceptService {

	public List<HashMap<String, Object>> searchExceptionList(HashMap<String, Object> params) throws Exception;
}