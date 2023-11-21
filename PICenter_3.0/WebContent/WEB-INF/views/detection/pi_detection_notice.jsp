<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title> NH농협은행 서버 내 개인정보 검색 시스템</title>
<!-- <title> NH농협중앙회 서버 내 개인정보 검색 시스템</title> -->

<link href="${pageContext.request.contextPath}/resources/assets/css/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<!-- Publish JS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui.js" type="text/javascript"></script>

<!--[if lte IE 8]>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/ie-8.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/ie-8.css" />
<![endif]-->

<!--[if lte IE 9]>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/ie-9.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/ie-9.css" />
<![endif]-->

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.ui-deps.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.js"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/jquery.jqGrid.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/i18n/grid.locale-kr.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/wickedpicker.js"></script>

<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />

<!-- Application Common Functions  -->
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<!-- Publish CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design.css" />

</head>

<script type="text/javascript">


</script>

<body>
<!-- wrap -->
<div class="wrap_notice" >
	<div class="notice_map">
		<div style="overflow: auto; width: 700px; padding-left:25px; padding-right:25px; text-align: left; height: 550px; ">
			<p style="font-size: 25px; margin-top: 70px;">${noticeMap.NOTICE_TITLE} <!-- <span style="font-size: 11px; margin-left: 30px;">작성일 : ${noticeMap.REGDATE}</span> --></p>
			<pre style="font-size: 13px; margin-top: 30px; font-family:'S-CoreDream-5Medium',dotum,'돋움',sans-serif;">${noticeMap.NOTICE_CON}</pre>
		</div>
		<div class="notice_button">
			<button name="btn_close" id="btn_close" style="font-size: 13px; position: absolute; left: 10px; bottom: 5px; ">하루 동안 보지 않기</button>
			<button onclick="window.close();" style="font-size: 13px; position: absolute; right: 10px; bottom: 5px; ">창닫기</button>
		</div>
	</div>
	
</div>
	
	
</body>

<script type="text/javascript">

	
/* setCookie function */
function setCookie(cname, value, expire) {
   var todayValue = new Date();
   // 오늘 날짜를 변수에 저장

   todayValue.setDate(todayValue.getDate() + expire);
   document.cookie = cname + "=" + encodeURI(value) + "; expires=" + todayValue.toGMTString() + "; path=/;";
}


$("#btn_close").click(function(e) {
	setCookie("notice_popup", "end" , 1);
    // 하루동안이므로 1을 설정
    window.close();
    // 현재 열려있는 팝업은 닫으면서 쿠키값을 저장
});

$(document).ready(function () {
	
	
});

</script>
	
</html>
