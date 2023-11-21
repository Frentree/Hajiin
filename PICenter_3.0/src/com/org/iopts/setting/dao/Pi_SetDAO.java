package com.org.iopts.setting.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.dto.MemberVO;

@Repository
public class Pi_SetDAO {

	static final Logger logger = LoggerFactory.getLogger(Pi_SetDAO.class);

	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession sqlSession;

	static final String Namespace = "com.org.iopts.mapper.SetMapper";

	public List<Map<Object, Object>> selectSetting() throws Exception {
		return sqlSession.selectList(Namespace + ".selectSetting");
	}

	public List<Map<String, Object>> patternList() {
		return sqlSession.selectList(Namespace + ".patternList");
	}
}
