package com.org.iopts.util;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.org.iopts.service.Pi_TargetServiceImpl;
/**
 * class DataUtil
 * Raonmind Common DataUtil
 * @author Raonmind
 */

@Service("DataUtil")
public class DataUtil
{
	private static final Logger logger = LoggerFactory.getLogger(DataUtil.class);
	
	public static Map<String,Object> convertJSON2MAP(JSONObject jsonObject)
	{
		if (jsonObject == null) return null;

		Map<String,Object> map = new HashMap<String,Object>();
		try {
	        for(Iterator<String> keys = jsonObject.keys(); keys.hasNext();) {
	        	String mapKey = keys.next();
	        	map.put(mapKey, jsonObject.get(mapKey));
	        }
		}
		catch (JSONException e) {
			e.printStackTrace();
			System.out.println("########### JSON Convert Exception ###########");
			System.out.println("json input string = " + jsonObject.toString());
			map.put("resultCode", -99999);
			map.put("resultMessage", "JSON Convert Exception");
			return map;
		}
		
		map.put("resultCode", 0);
        return map;
	}

	public static String makeEncFileName() throws IOException
	{
		// 파일명 변경 -- nano time으로 생성
		Long fileNameLast = System.nanoTime();
		
		String renameFile = fileNameLast.toString();

        // 파일명 암호화 
		char[] chars = renameFile.toCharArray();
		StringBuffer hex = new StringBuffer();
        for (int i = 0; i < chars.length; i++) {
            hex.append(Integer.toHexString((int) chars[i]));
        }
        
        return hex.toString();
	}
	
}