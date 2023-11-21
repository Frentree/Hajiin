<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.security.SecureRandom"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta charset="utf-8">
	
	<title>Tnet Proxy SSO 연계</title>
	<!-- <title>NH농협중앙회 서버내 개인정보 검색 시스템</title> -->
	<!-- Publish CSS -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset-PIC.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design-PIC.css" />

	<!-- Publish JS -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>

	<!--[if lte IE 8]>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/ie-8.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/ie-8.css" />
	<![endif]-->
	<!--[if lte IE 9]>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/ie-9.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/ie-9.css" />
	<![endif]-->

	<!-- Application Common Functions  -->
	<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
	
</head>

<body>
</body>

<script type="text/javascript">
$(document).ready(function () {
	if("${userid}" != null && "${userid}" != ''){
		var postData = {
				user_no : "${userid}",
		};
		
		$.ajax({
			type: "POST",
			url: "/loginSSO",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	if (resultMap.resultCode != 0) {
					alert("로그인 실패 : " + resultMap.resultMessage);
		        	return;
			    }
			    
		        if(resultMap.resultCode == 0){
		        	user_grade = resultMap.user_grade;
		        	position = resultMap.member.JIKWEE;
		        	var id = $("#user_id").val();
		        	successSSO();
		        }
			    
		    },
		    error: function (request, status, error) {
				alert("ERROR : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	} else {
		document.location.href = "/";
	}
	
}); //$(document).ready

function successSSO(){
	var user_no = $("#user_id").val();
    if ($('input:checkbox[name="save"]').is(":checked")) {
        setCookie("PiBoardUserNo", user_no, 7); // 7일 동안 쿠키 보관
    }
	else {
    	deleteCookie("PiBoardUserNo"); // 7일 동안 쿠키 보관
	}
    
   <%--  if (user_grade == 9){
    	document.location.href = "<%=request.getContextPath()%>/detection/pi_detection_regist";
    	document.location.href = "<%=request.getContextPath()%>/piboard";
    } else if(user_grade == 1) {
    	document.location.href = "<%=request.getContextPath()%>/approval/pi_search_approval_list";
    } else {
    	document.location.href = "<%=request.getContextPath()%>/detection/pi_detection_regist";
    }  --%>
    document.location.href = "https://pimc.sktelecom.com/";
}

</script>
</html>
