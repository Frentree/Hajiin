package com.org.iopts.util;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.org.iopts.dao.Pi_TargetDAO;


/**
 * class PkmUtil.<br />
 * PKM`s Utils.<br />
 * @author PKM : pminmin@nate.com
 */
@Service("SessionUtil")
public class SessionUtil
{

	private static final Logger logger = LoggerFactory.getLogger(Pi_TargetDAO.class);
	/**
	 * HttpSession 객체 정보 추출.
	 * @param sessionKey
	 * @param sessionName
	 * @return String
	 */
	@SuppressWarnings("unchecked")
	public static Map<String,Object> getSession(String sessionName)
	{
		HttpSession session = (HttpSession)getRequestInfo("getSession", null);

		return (Map<String, Object>)session.getAttribute(sessionName);
	}
	
	/**
	 * HttpSession 객체 정보 추출.
	 * @param sessionName
	 * @param sessionKey
	 * @return String
	 */
	public static String getSession(String sessionName, String sessionKey)
	{
		HttpSession session = (HttpSession)getRequestInfo("getSession", null);

		String result;

		if(session.getAttribute(sessionName) == null)
		{
			result = null;
		}
		else
		{
			Map<String,Object> sessionInfo = (Map<String,Object>)session.getAttribute("memberSession");

			result = sessionInfo.get(sessionKey).toString();
		}

		return result;
	}

	/**
	 * HttpSession 객체 생성. (String)
	 * @param sessionName
	 * @param paramMap
	 * @return void
	 */
	public static void setSession(String sessionName, String str) {
		HttpSession session = (HttpSession)getRequestInfo("getSession", null);
        
		session.setAttribute(sessionName, str);
		//session.setMaxInactiveInterval(600);
		session.setMaxInactiveInterval(1800);
	}
	
	/**
	 * HttpSession 객체 생성. (Map)
	 * @param sessionName
	 * @param paramMap
	 * @return void
	 */
	
	public static void setSession(String sessionName, Map<String,Object> paramMap)
	{
		
		HttpSession session = (HttpSession)getRequestInfo("getSession", null);
        
		session.setAttribute(sessionName, paramMap);
		//session.setMaxInactiveInterval(600);
		session.setMaxInactiveInterval(1800);
	}
	
	/**
	 * HttpSession 객체 생성. (List)
	 * @param sessionName
	 * @param list
	 * @return void
	 */
	public static void setSession(String sessionName, List<Map<String, Object>> list) {
		// TODO Auto-generated method stub
		HttpSession session = (HttpSession)getRequestInfo("getSession", null);
        
		session.setAttribute(sessionName, list);
		//session.setMaxInactiveInterval(600);
		session.setMaxInactiveInterval(1800);
	}
	/**
	 * HttpSession 세션 종료.
	 * @param sessionName
	 * @param paramMap
	 * @return void
	 */
	public static void closeSession(String sessionName)
	{
		HttpSession session = (HttpSession)getRequestInfo("getSession", null);
		session.invalidate();
	}

	/**
	 * HttpServletRequest 객체 정보 추출.
	 * @param requestMethod
	 * @return Object
	 */
	public static Object getRequestInfo(String requestMethod, String param)
	{
		ServletRequestAttributes sra = (ServletRequestAttributes)RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = sra.getRequest();

		if(requestMethod.equals("getRequestURI"))
		{
			return request.getRequestURI();
		}
		else if(requestMethod.equals("getMethod"))
		{
			return request.getMethod();
		}
		else if(requestMethod.equals("getRequestURL"))
		{
			return request.getRequestURL();
		}
		else if(requestMethod.equals("getQueryString"))
		{
			return request.getQueryString();
		}
		else if(requestMethod.equals("getRemoteAddr"))
		{
			return CommonUtil.null2Str(request.getRemoteAddr(), "255.255.255.255");
		}
		else if(requestMethod.equals("getRemoteHost"))
		{
			return request.getRemoteHost();
		}
		else if(requestMethod.equals("getRemoteUser"))
		{
			return request.getRemoteUser();
		}
		else if(requestMethod.equals("getSession"))
		{
			return request.getSession();
		}
		else if(requestMethod.equals("getHeader"))
		{
			return request.getHeader("User-Agent");
		}
		else if(requestMethod.equals("getAjaxFlag"))
		{
			boolean result = false;

			if(CommonUtil.null2Str(request.getHeader("x-requested-with"), "").equals("XMLHttpRequest"))
			{
				result = true;
			}
			else
			{
				result = false;
			}

			return result;
		/*}
		else if(requestMethod.equals("getInitParameter"))
		{
			return request.getServletContext().getInitParameter("globalsProperties");*/
		}
		else if(requestMethod.equals("getScheme"))
		{
			return request.getScheme();
		}
		else if(requestMethod.equals("getServerName"))
		{
			return request.getServerName();
		}
		else if(requestMethod.equals("getServerPort"))
		{
			return request.getServerPort();
		}
		else if(requestMethod.equals("getContextPath"))
		{
			return request.getContextPath();
		}
		else if(requestMethod.equals("getParameter"))
		{
			return request.getParameter(param);
		}
		else
		{
			return "required requestMethod!!";
		}
	}

}