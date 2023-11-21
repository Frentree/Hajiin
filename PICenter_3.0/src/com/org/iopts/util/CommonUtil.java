package com.org.iopts.util;

import java.io.IOException;
import java.io.Reader;
import java.math.BigDecimal;
import java.sql.Clob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;

@Service("CommonUtil")
public class CommonUtil
{
	/**
	 * CamelCase : SnakeCase to CamelCase.
	 * @param paramStr
	 * @return String
	 */
	public static String toCamelCase(String paramStr)
	{
		String parts[] = paramStr.split("_");
		String camelCaseString = "";
		for(String part : parts)
		{
			if(camelCaseString.equals(""))
			{
				camelCaseString = part.toLowerCase();
			}
			else
			{
				camelCaseString = camelCaseString + (part.substring(0, 1).toUpperCase() + part.substring(1).toLowerCase());
			}
		}

		return camelCaseString;
	}

	/**
	 * CamelCase : SnakeCase to CamelCase.
	 * @param paramMap
	 * @return HashMap
	 */
	public static HashMap<String, Object> toCamelCase(HashMap<String, Object> paramMap)
	{
		Iterator<String> iterator = paramMap.keySet().iterator();
		HashMap<String, Object> resultMap = new HashMap<>();
		while(iterator.hasNext())
		{
			String key = iterator.next();
			resultMap.put(toCamelCase(key), paramMap.get(key));
		}

		return resultMap;
	}

	/**
	 * CamelCase : SnakeCase to CamelCase.
	 * @param paramList
	 * @return List
	 */
	@SuppressWarnings("unchecked")
	public static List<Object> toCamelCase(List<Object> paramList)
	{
		List<Object> resultList = new ArrayList<>();

		for(int i = 0; i < paramList.size(); i++)
		{
			resultList.add(toCamelCase((HashMap<String, Object>)paramList.get(i)));
		}

		return resultList;
	}

	/**
	 * IP 암호화.
	 * ex) 192.168.0.1 to 192.xxx.0.1
	 * @param plainIp
	 * @return String
	 */
	public static String encryptIp(Object plainIp) 
	{
		String ip = null2Str(plainIp, "0.0.0.0");
		String temp[] = ip.split("\\.");

		StringBuffer buf = new StringBuffer();

		for(int i = 0; i < temp.length; i++)
		{
			if(i == 1)
			{
				buf.append("x.");
			}
			else if(i == 3)
			{
				buf.append(temp[i]);
			}
			else
			{
				buf.append(temp[i] + ".");
			}
		}

		return buf.toString();
	}

	/**
	 * BigDecimal 연산.
	 * @param left
	 * @param right
	 * @param operator
	 * @return String
	 */
	public static String calculateBigDecimal(String left, String right, String operator)
	{
		BigDecimal leftNum = new BigDecimal(left);
		BigDecimal rightNum = new BigDecimal(right);

		if(operator.equals("+"))
		{
			return leftNum.add(rightNum).toString();
		}
		else if(operator.equals("-"))
		{
			return leftNum.subtract(rightNum).toString();
		}
		else if(operator.equals("*"))
		{
			return leftNum.multiply(rightNum).toString();
		}
		else if(operator.equals("/"))
		{
			return leftNum.divide(rightNum, 2, BigDecimal.ROUND_FLOOR).toString();
		}
		else
		{
			return null;
		}
	}

	/**
	 * 문자열 변환 : CLOB to String. DTO 가 EgovMap.
	 * @param paramMap
	 * @param paramKey
	 * @return String
	 */
	public static String convertClobToString(Map paramMap, String paramKey) throws Exception
	{
		Clob clob = (Clob)paramMap.get(paramKey);
		Reader reader = clob.getCharacterStream();
		StringBuffer out = new StringBuffer();
		char buff[] = new char[1024];
		int nchars = 0;

		while((nchars = reader.read(buff)) > 0)
		{
			out.append(buff, 0, nchars);
		}

		return out.toString();
	}

	/**
	 * 문자열 변환 : 문자열 중 일치하는 문자 치환.
	 * @param str
	 * @param oldStr
	 * @param newStr
	 * @return String
	 */
	public static String replaceAll(String str, String oldStr, String newStr)
	{
		if(str == null) return "";

		Pattern p = Pattern.compile(oldStr);
		Matcher m = p.matcher(str);

		StringBuffer sb = new StringBuffer();
		boolean result = m.find();

		while(result)
		{
			m.appendReplacement(sb, newStr);
			result = m.find();
		}

		m.appendTail(sb);

		return sb.toString();
	}

	/**
	 * 문자열 변환 : null to strDefault.
	 * @param paramObject
	 * @param returnStr
	 * @return String
	 */
	public static String null2Str(Object paramObject, String returnStr)
	{
		if(paramObject == null || paramObject.toString().length() == 0)
		{
			return returnStr;
		}
		else
		{
			return paramObject.toString();
		}
	}

	/**
	 * 문자열 변환 : XSS escape.
	 * @param paramStr
	 * @return String
	 */
	public static String escapeXSS(String paramStr)
	{
		return StringEscapeUtils.escapeHtml(paramStr);
	}

	/**
	 * 문자열 변환 : XSS unescape.
	 * @param paramStr
	 * @return String
	 */
	public static String unescapeXSS(String paramStr)
	{
		return StringEscapeUtils.unescapeHtml(paramStr);
	}

	/**
	 * 문자열 변환 : 특수문자 및 공백 제거.
	 * @param paramStr
	 * @return String
	 */
	public static String repalceSpecialChar(String paramStr)
	{
		StringBuffer result = new StringBuffer();

		if(paramStr != null)
		{
			int l = paramStr.length();

			for(int i = 0; i < l; i++)
			{
				if(paramStr.charAt(i) == ' ' || paramStr.charAt(i) == '~' || paramStr.charAt(i) == '`' || paramStr.charAt(i) == '!' || paramStr.charAt(i) == '@' ||
						paramStr.charAt(i) == '#' || paramStr.charAt(i) == '$' || paramStr.charAt(i) == '%' || paramStr.charAt(i) == '^' || paramStr.charAt(i) == '&' ||
						paramStr.charAt(i) == '*' || paramStr.charAt(i) == '-' || paramStr.charAt(i) == '=' || paramStr.charAt(i) == '+' || paramStr.charAt(i) == '\\' ||
						paramStr.charAt(i) == '|' || paramStr.charAt(i) == '[' || paramStr.charAt(i) == '{' || paramStr.charAt(i) == '}' || paramStr.charAt(i) == ']' ||
						paramStr.charAt(i) == ';' || paramStr.charAt(i) == ':' || paramStr.charAt(i) == '\'' || paramStr.charAt(i) == ',' || paramStr.charAt(i) == '<' ||
						paramStr.charAt(i) == '.' || paramStr.charAt(i) == '>' || paramStr.charAt(i) == '/' || paramStr.charAt(i) == '?')
				{
					result.append("");
				}
				else
				{
					result.append(paramStr.charAt(i));
				}
			}
		}

		return result.toString();
	}
	
	/**
	 * 문자열이 비어있는지 검사.
	 * @param str 검사할 문자열
	 * @return 문자열이 비어있으면 true, 아니면 false
	 */
	public static boolean isEmpty(String str) {
		if(str == null) {
			return true;
		} else {
			if(str.trim().length() <= 0) {
				return true;
			} else {
				return false;
			}
		}
	}
	
	public static boolean isAddrEmpty(String addr) {

		String[] split = addr.split("\\|");
		int length = 0;
		
		for(int i = 0; i < split.length; i++) {
			length += split[i].trim().length();
		}
		
		if(length > 0) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
     * 문자열 A에서 Z사이의 랜덤 문자열을 구하는 기능을 제공 시작문자열과 종료문자열 사이의 랜덤 문자열을 구하는 기능
     *
     * @param startChr
     *            - 첫 문자
     * @param endChr
     *            - 마지막문자
     * @return 랜덤문자
     * @exception MyException
     * @see
     */
    public static String getRandomStr(char startChr, char endChr) {

		int randomInt;
		String randomStr = null;
	
		// 시작문자 및 종료문자를 아스키숫자로 변환한다.
		int startInt = Integer.valueOf(startChr);
		int endInt = Integer.valueOf(endChr);
	
		// 시작문자열이 종료문자열보가 클경우
		if (startInt > endInt) {
		    throw new IllegalArgumentException("Start String: " + startChr + " End String: " + endChr);
		}
	
		try {
		    // 랜덤 객체 생성
		    SecureRandom rnd = new SecureRandom();
	
		    do {
			// 시작문자 및 종료문자 중에서 랜덤 숫자를 발생시킨다.
			randomInt = rnd.nextInt(endInt + 1);
		    } while (randomInt < startInt); // 입력받은 문자 'A'(65)보다 작으면 다시 랜덤 숫자 발생.
	
		    // 랜덤 숫자를 문자로 변환 후 스트링으로 다시 변환
		    randomStr = (char)randomInt + "";
		} catch (Exception e) {
		    //e.printStackTrace();
		    throw new RuntimeException(e);	// 2011.10.10 보안점검 후속조치
		}
	
		// 랜덤문자열를 리턴
		return randomStr;
    }
	

	 /**
	* 특정숫자 집합에서 랜덤 숫자를 구하는 기능 시작숫자와 종료숫자 사이에서 구한 랜덤
	* 숫자를 반환한다
	* @param startNum
	*        - 시작숫자
	* @param endNum
	*        - 종료숫자
	* @return 랜덤숫자
	* @exception MyException
	* @see
	*/
	public static int getRandomNum(int startNum, int endNum) {
	
	  int randomNum = 0;
	
	  try {
	
	      // 랜덤 객체 생성
	      SecureRandom rnd = new SecureRandom();
	
	      do {
	
	          // 종료숫자내에서 랜덤 숫자를 발생시킨다.
	          randomNum = rnd.nextInt(endNum + 1);
	
	      } while (randomNum < startNum); // 랜덤 숫자가
	                                      // 시작숫자보다
	                                      // 작을경우 다시
	                                      // 랜덤숫자를
	                                      // 발생시킨다.
	
	  } catch (Exception e) {
	
	      //log.debug(e.getMessage());
	      //log.trace(e.getMessage());
	
	  }
	
	  return randomNum;
	
	}
}