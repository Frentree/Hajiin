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
	<title>개인정보검출관리센터</title>
	<!-- Publish CSS -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/skt-design1.css" />

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
	<!-- wrap -->
	<div class="wrap_login">
		<!-- section -->
		<section>
			<img class="CancleImg" id="btnCancleNewNetPolicyPopup" src="${pageContext.request.contextPath}/resources/assets/images/mail_title.png">
			<img class="CancleImg" id="btnCancleNewNetPolicyPopup" src="${pageContext.request.contextPath}/resources/assets/images/mail_icon.png">
			<img class="CancleImg" id="btnCancleNewNetPolicyPopup" src="${pageContext.request.contextPath}/resources/assets/images/mail_icon2.png">
		</section>
		<!-- section -->
	</div>
	<!-- wrap -->
</body>
</html>