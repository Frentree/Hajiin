package com.org.iopts.statistics.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.org.iopts.group.vo.GroupTargetVo;
import com.org.iopts.statistics.vo.StatisticsVo;

public interface StatisticsDAO {

	List<Map<String, Object>> statisticsList(Map<String, Object> result);
	
	List<Map<String, Object>> manageList(Map<String, Object> result);

	List<Map<String, Object>> manageBarList(Map<String, Object> result);

	List<Map<String, Object>> mainChartStatistics(Map<String, Object> result);

	List<Map<String, Object>> TOPGridList(Map<String, Object> result);

	Map<String, Object> totalStatistics(Map<String, Object> result);

	List<Object> selectDataImple(Map<String, Object> result);



}
