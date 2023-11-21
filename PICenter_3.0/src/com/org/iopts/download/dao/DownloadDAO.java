package com.org.iopts.download.dao;

import java.util.Map;

public interface DownloadDAO {
	int selectDownloadIndex() throws Exception;
	
	void insertDownload(Map<String, Object> map) throws Exception;

	int selectFileDownloadIndex() throws Exception;

	void insertFileDownload(Map<String, Object> map) throws Exception;
}
