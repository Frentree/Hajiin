package com.org.iopts.controller.Interceptor;


import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.org.iopts.util.SessionUtil;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(AuthenticationInterceptor.class);
	
	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		if( handler instanceof HandlerMethod == false ) {
            // return true이면  Controller에 있는 메서드가 아니므로, 그대로 컨트롤러로 진행
            return true;
        }

		logger.info("preHandle request.getRequestURI :" + request.getRequestURI());

        String DocumentRoot = request.getContextPath();
        HttpSession session = request.getSession(true); 

        //if (session.getAttribute("memberSession") == null && !request.getRequestURI().equals("/manage/pi_detection_approval_list")) {
        if (session.getAttribute("memberSession") == null) {
        	logger.info("memberSession null");
        	
        	if(request.getRequestURI().equals("/popup/detectionDetail") || request.getRequestURI().equals("/popup/detectionDetail/*") || 
    			request.getRequestURI().equals("/popup/downloadDetail") || request.getRequestURI().equals("/popup/downloadDetail/*") || 
    			request.getRequestURI().equals("/popup/exceptionGroupList")  || request.getRequestURI().equals("/popup/exceptionHostList")  || 
    			request.getRequestURI().equals("/popup/exceptionServerList")  || request.getRequestURI().equals("/popup/groupList")  || 
    			request.getRequestURI().equals("/popup/faqDetail") || request.getRequestURI().equals("/popup/faqDetail/*") || 
    			request.getRequestURI().equals("/popup/lowPath")  || request.getRequestURI().equals("/popup/netList")  || 
    			request.getRequestURI().equals("/popup/noticeDetail") || request.getRequestURI().equals("/popup/noticeDetail/*") || 
    			request.getRequestURI().equals("/popup/policyList")  || request.getRequestURI().equals("/popup/targetList")  || 
    			request.getRequestURI().equals("/popup/userList") || request.getRequestURI().equals("/popup/helpDetail") ){
        		
        		response.setContentType("text/html; charset=UTF-8");
        		PrintWriter out = response.getWriter();

        		out.println("<script language='javascript'>");
        		out.println("self.close();");
        		out.println("opener.popClose();");
        		out.println("</script>");

        		out.flush();
        	}
        	
        	if (excludeUrl(request)) { return true;} //이동하는 url이 예외 url 일경우
        	logger.info("excludeUrl false");
        	if (isAjaxRequest(request)) { //Ajax 콜인지 아닌지 판단
        		//response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
                //return false;
        	}
        	logger.info("isAjaxRequest" + DocumentRoot);
            //response.sendRedirect(DocumentRoot + "/");
            response.sendRedirect(DocumentRoot + "/");
            return false;
        } else {
        	if (request.getRequestURI().equals("/")) {
        		/*if(SessionUtil.getSession("memberSession", "USER_GRADE").equals("9")) {
        			response.sendRedirect(DocumentRoot + "/piboard");
        		} else {
        			response.sendRedirect(DocumentRoot + "/detection/pi_detection_regist");
        		}*/
        		
        		// 세션에 저장된 초기 페이지로 이동
        		response.sendRedirect(session.getAttribute("defaultPage").toString());
        	//} else if(request.getRequestURI().equals("/logout") || request.getRequestURI().equals("/manage/pi_detection_approval_list")) {
        	} else if(/*request.getRequestURI().equals("/logout") || */
        			request.getRequestURI().equals("/popup/noticeDetail") || request.getRequestURI().equals("/popup/noticeDetail/*") || 
        			request.getRequestURI().equals("/popup/downloadDetail") || request.getRequestURI().equals("/popup/downloadDetail/*") || 
        			request.getRequestURI().equals("/popup/lowPath")  || request.getRequestURI().equals("/mailImg") ||
        			request.getRequestURI().equals("/popup/faqDetail") || request.getRequestURI().equals("/popup/faqDetail/*") || 
        			request.getRequestURI().equals("/popup/userList") || request.getRequestURI().equals("/popup/helpDetail")) {
        		// logout은 그냥 통과...
        		return true;
        	}else {
        		return true;
        		// 사용자 등급에 따라 이동가능한 url 제어 (관리자(9) 아닌 경우 제약)
        		/*if(!SessionUtil.getSession("memberSession", "USER_GRADE").equals("9")) {
        			// Ajax 콜 아닌 경우 (메뉴이동 경우)
        			if (!isAjaxRequest(request)) {
	        			// 일반사용자 메뉴(화면)만 이동 가능하게 제약하며 아닌경우 위의 초기화면으로 이동한다 (아래 리스트에 없는 URL은 이동 불가)
	        			String[] normalUserUrlArr = {"/detection/pi_detection_regist"
	        			                            ,"/approval/pi_search_list"
	        			                            ,"/approval/pi_search_approval_list"
	        			                            ,"/detection/pi_notice"
	        			                            ,"/excepter/pi_exception_list"
	        			                            ,"/excepter/pi_exception_approval_list"
	        			                            ,"/change/pi_change_list"
	        			                            ,"/change/pi_path_change_list"
	        			                            ,"/detection/pi_server_list"
	        			                            ,"/scan/pi_scan_main_user"
	        			                            ,"/scan/pi_scan_rescan_user"
	        			                            ,"/scan/pi_scan_regist_user"
	        			                            ,"/scan/pi_scan_modify_user"
	        			                            ,"/scan/pi_policy_insert_user"
	        			                            ,"/popup/targetList"
	        			                            ,"/loginsms"
	        			                            ,"/submitSmsLogin"
	        			                            ,"/sms_login_resend"
	        			                            ,"/sms_login_cancel"
	        			                            ,"/search/search_status"
	        			                            
	        			                            
	        			                            };
	        			if(!Arrays.asList(normalUserUrlArr).contains(request.getRequestURI())) {
	        				response.sendRedirect(DocumentRoot + "/search/search_status");
	        			}
        			}
        		}*/
        	}
        }
		return true;
	}

	private boolean excludeUrl(HttpServletRequest request) {

		String uri = request.getRequestURI().toString().trim();
	    if (
	    	uri.equals("/") || uri.equals("/login") || uri.equals("/loginSSO") || 
	    	uri.equals("/sso_link") || uri.equals("/loginsms") || 
	    	uri.equals("/submitSmsLogin") || uri.equals("/NCLoginTestENC") || 
	    	uri.equals("/NCLoginTestEndVerify") || uri.equals("/ssoLogin") || uri.equals("/session_quit") || 
	    	uri.equals("/main1") || uri.equals("/main2") || uri.equals("/main3") || uri.equals("/pie") || 
	    	uri.equals("/skt_approval") || uri.equals("/skt_contact_list") || 
	    	uri.equals("/demo") || uri.equals("/main") ||  uri.equals("/mailImg") ||
	    	uri.equals("/favicon.ico") || uri.equals("/reset_sms_code") || uri.equals("/lockMemberRequest") ||
	    	uri.equals("/piboard_skt") || uri.equals("/sms_login_resend") || 
	    	uri.equals("/sms_login_cancel")|| uri.equals("/resetnum")|| uri.equals("/user/SMSFlag")|| 
	    	uri.equals("/resetPwd")|| uri.equals("/changeResetPwd")|| 
	    	uri.equals("/popup/noticeDetail") || uri.equals("/faqDetail") ||
	    	uri.equals("/popup/detectionDetail") || uri.equals("/popup/userList") || uri.equals("/popup/helpDetail")
	    ) {
            return true;
        } 
	    else {
	    	return false;
	    }
	}
	 
	private boolean isAjaxRequest(HttpServletRequest request) {
	    if (("xmlhttprequest").equalsIgnoreCase(request.getHeader("X-Requested-With"))) {
	    	return true;
	    }
	    return false;
	}
	
	// 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		if ((!excludeUrl(request)) && (!isAjaxRequest(request))) {
			if (modelAndView != null) {
				Map<String, Object> model = modelAndView.getModel();
				model.put("memberInfo", SessionUtil.getSession("memberSession"));

			}
		}
		super.postHandle(request, response, handler, modelAndView);
	}

}
