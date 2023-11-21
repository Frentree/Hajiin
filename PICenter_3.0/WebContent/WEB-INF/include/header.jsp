<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% response.setHeader("Pragma", "no-cache"); response.setHeader("Cache-Control", "no-cache"); response.setHeader("Cache-Control", "no-store"); response.setDateHeader("Expires", 0L); %>
<!DOCTYPE html>
<html lang="ko">
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-cache">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8" />
<!-- <title>pimc.sktelecom.com</title> -->
<title>개인정보 검출관리 센터</title>

<link rel="icon" href="data:,">

<link href="${pageContext.request.contextPath}/resources/assets/css/ui.fancytree-sktPIC.css" rel="stylesheet" type="text/css" /> 
<link href="${pageContext.request.contextPath}/resources/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<!-- Publish JS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui.js" type="text/javascript"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/echart/echarts-all.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/echart/echarts.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.ui-deps.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.js"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/jquery.jqGrid.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/i18n/grid.locale-kr.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/wickedpicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/select2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jstree.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/exceljs.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/fileserver.js"></script>

<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/select2.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/jquery-ui-PIC.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/ui.jqgrid-PIC.css" />

<!-- Application Common Functions  -->
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<!-- Publish CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset-PIC.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design-PIC.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.min.css" />

<style>
#questionIcon:hover{
	cursor: pointer;
}
@media screen and (-ms-high-contrast: active) , ( -ms-high-contrast : none) {
	.popup_tbl{
		table-layout: fixed;
	}
}

/* #sessionUpdate{
	cursor:pointer; 
	border: 0px solid window;
	background-color: window;
	color : blue;
	text-decoration: underline;
	text-underline-position:under
} */
</style>
</head>

<script type="text/javascript">

var passwordRules = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{1,50}).{8,50}$/;
var phoneRules = /^\d{3}\d{3,4}\d{4}$/;
var emailRules = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
var nameRules =  /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|]+$/;
var popList = [];
$(document).ready(function () {
	
	window.onbeforeunload = function() {
		for(i=0 ; i < popList.length ; i++){
    		popList[i].close();
         }
	};
	
	$(document).on("keyup", "#changeUserSettingPhoneNM", function() { 
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
	});
	
    var ntime = performance.timing;
    var request = ntime.responseStart - ntime.requestStart; // 요청 소요 시간
    
	Loading();	
    
	setTimeout("closeLoading()", request);
	
	// 로그인 사용자 정보
	var user_upper = "${memberInfo.USER_NO}".toUpperCase();
	
	$("#user_Information").text("${memberInfo.USER_NAME}("+user_upper+")");

	var list = $(".gnb_menu li a");
	list.each(function(i, element) {
		$(element).removeClass("on")
	});

	if ("#${menuKey}".length != 1) {
		$("#${menuKey}").addClass('on');
		$("#${menuKey}").removeAttr("href")
	};	
	
	$("#btnLogout").on("click", function(e) {
		Logout();
	});
	$("#btnPopClose").on("click", function(e) {
		Logout();
	});
	/* $("#btnsessionClose").on("click", function(e) {
		$("#sessionUpdatePop").hide();
	}); */
	function Logout(){
		var postData = {};
		$.ajax({
			type: "POST",
			url: "/logout",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	window.location = "${pageContext.request.contextPath}/";
		    },
		    error: function (request, status, error) {
				alert("ERROR : " + error);
		        console.log("ERROR : ", error);
		    }
		});
		
		for(i=0 ; i < popList.length ; i++){
    		popList[i].close();
         }
	};
	
	// 사용자이동 button click event
	$("#btnMoveUserPage").click(function() {
		// 사용자 MainPage 이동
		document.location.href = "<%=request.getContextPath()%>/detection/pi_detection_regist";
	});
	
	$("nav > ul > li").mouseenter(function(){
		$(this).children(".gnb_sub_menu_dash").stop().slideDown(400);
		$(this).children(".gnb_sub_menu_policy").stop().slideDown(400);
	    $(this).children(".gnb_sub_menu_target").stop().slideDown(400);
	    $(this).children(".gnb_sub_menu_search").stop().slideDown(400);
	    $(this).children(".gnb_sub_menu_detection").stop().slideDown(400);
	    $(this).children(".gnb_sub_menu_community").stop().slideDown(400);
	    $(this).children(".gnb_sub_menu_user").stop().slideDown(400);
	});
	
	$("nav > ul > li").mouseleave(function(){
		$(this).children(".gnb_sub_menu_dash").stop().slideUp(200);
	    $(this).children(".gnb_sub_menu_policy").stop().slideUp(200);
	    $(this).children(".gnb_sub_menu_target").stop().slideUp(200);
	    $(this).children(".gnb_sub_menu_search").stop().slideUp(200);
	    $(this).children(".gnb_sub_menu_detection").stop().slideUp(200);
	    $(this).children(".gnb_sub_menu_community").stop().slideUp(200);
	    $(this).children(".gnb_sub_menu_user").stop().slideUp(200);
	});
	
	
	var changeUserSettingNM = "";
	var changeUserSettingPhoneNM = "";
	var changeUserSettingEmail = "";
	var changeUserSettingpassword = "";
	var checkUserSettingpassword = "";
	
	$("#user_setting").click(function () {
		$("#userSettingDatePopup").show();
		$.ajax({
			type: "POST",
			url: "/user/SMSFlag",
			async : false,
			//data : postData,
		    success: function (resultMap) {
		    	 if(resultMap.result == "Y"){
		    		$("#btnUserSMSFlag").html("SMS인증 비활성화");
		    	}else {
		    		$("#btnUserSMSFlag").html("SMS인증 활성화");
		    	}
		    },
		    error: function (request, status, error) {
				alert("ERROR : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	$("#btnUserSMSFlag").click(function () {
		$.ajax({
			type: "POST",
			url: "/user/updateSMSFlag",
			async : false,
			//data : postData,
		    success: function (resultMap) {
		    	if(resultMap.resultCode == 0){
		    		alert(resultMap.resultMessage);
		    	}else if(resultMap.resultCode == 1) {
		    		alert(resultMap.resultMessage);
		    	}
		    	$("#userSettingDatePopup").hide();
		    },
		    error: function (request, status, error) {
				alert("ERROR : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	$("#btnUserSettingDateCancel").click(function () {
		
		$("#changeUserSettingNM").val("${memberInfo.USER_NAME}");
		$("#changeUserSettingPhoneNM").val("${memberInfo.USER_PHONE}");
    	$("#changeUserSettingEmail").val("${memberInfo.USER_EMAIL}");
    	$("#changeUserSettingpassword").val("");
    	$("#checkUserSettingpassword").val("");
		
		$("#userSettingDatePopup").hide();
	});
	
	$("#btnUserSettingDateSave").click(function () {
		
		changeUserSettingNM = $("#changeUserSettingNM").val().trim();
		changeUserSettingPhoneNM = $("#changeUserSettingPhoneNM").val().trim();
		changeUserSettingEmail = $("#changeUserSettingEmail").val().trim();
		changeUserSettingpassword = $("#changeUserSettingpassword").val().trim();
		checkUserSettingpassword = $("#checkUserSettingpassword").val().trim();
		
		if(changeUserSettingNM != "${memberInfo.USER_NAME}"){
			if (isNull(changeUserSettingNM)) {
				$("#changeUserSettingNM").focus();
				alert("이름을 입력하십시요.");
				return;
			}
			
			if (!nameRules.test(changeUserSettingNM)) {
				$("#changeUserSettingNM").focus();
				alert("이름은 한글,영어,숫자만 가능합니다.");
				return;
			}
		};
		
		if (!isNull(changeUserSettingpassword) || !isNull(checkUserSettingpassword) ) {
			if (changeUserSettingpassword != checkUserSettingpassword) {
				$("#checkUserSettingpassword").focus();
				alert("비밀번호와 비밀번호확인이 일치하지 않습니다.");
				return;
			}
	
			if (!passwordRules.test(changeUserSettingpassword)) {
				$("#changeUserSettingpassword").focus();
				alert("비밀번호는 숫자/영문자/특수문자를 1개 이상, 8자 이상입력하십시요. : " + changeUserSettingpassword);
				return;
			}
		}
		
		if(changeUserSettingPhoneNM != "${memberInfo.USER_PHONE}"){
			if (isNull(changeUserSettingPhoneNM)) {
				$("#changeUserSettingPhoneNM").focus();
				alert("전화번호를 입력하십시요.");
				return;
			}
			
			if (!phoneRules.test(changeUserSettingPhoneNM)) {
				$("#changeUserSettingPhoneNM").focus();
				alert("올바른 전화번호를 입력하십시오.");
				return;
			}
		};
		
		if(changeUserSettingEmail != "${memberInfo.USER_EMAIL}"){
			if (isNull(changeUserSettingEmail)) {
				$("#changeUserSettingEmail").focus();
				alert("이메일을 입력하십시요.");
				return;
			}
			
			if (!emailRules.test(changeUserSettingEmail)) {
				$("#changeUserSettingEmail").focus();
				alert("올바른 이메일 형식으로 입력하십시오.");
				return;
			}
		};
		
		var trimmedPhoneNumber = changeUserSettingPhoneNM.replace(/-/g, '');
		
		
		var postData = {
			changeUserSettingNM : changeUserSettingNM,
			changeUserSettingPhoneNM : trimmedPhoneNumber,
			changeUserSettingEmail : changeUserSettingEmail,
			changeUserSettingpassword : changeUserSettingpassword,
			checkUserSettingpassword : checkUserSettingpassword
		};
		$.ajax({
			type: "POST",
			url: "/user/userSetting",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	
		    	console.log("dasfdaf");
		    	console.log(resultMap);
		    	
		    	alert("사용자 정보가 수정 되었습니다. 로그인을 다시 진행해주세요.");
		    	
		    	var postData = {};
				$.ajax({
					type: "POST",
					url: "/logout",
					async : false,
					data : postData,
				    success: function (resultMap) {
				    	window.location = "${pageContext.request.contextPath}/";
				    },
				    error: function (request, status, error) {
						alert("ERROR : " + error);
				        console.log("ERROR : ", error);
				    }
				});
		    	
		    	/* $("#changeUserSettingPhoneNM").val("");
		    	$("#changeUserSettingPhoneNM").val("${memberInfo.USER_PHONE}");
		    	$("#changeUserSettingEmail").val("");
		    	$("#changeUserSettingEmail").val("${memberInfo.USER_EMAIL}");
		    	$("#changeUserSettingpassword").val("");
		    	$("#checkUserSettingpassword").val("");
		    	$("#userSettingDatePopup").hide(); */
		    	
		    	location.reload();
		    	
		    },
		    error: function (request, status, error) {
		    	alert("사용자 정보 수정 실패 : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	var questionIconHover = document.getElementById('questionIcon');
	
	questionIconHover.addEventListener("mouseover", function () {
		$("#passwordQuestion").show();
	});
	
	questionIconHover.addEventListener("mouseout", function () {
		$("#passwordQuestion").hide();
	});
	
	$(window).scroll(function(){
	    $('#header').css({left: 0 - $(this).scrollLeft()});
   	})

   	$("#changeUser").click(function() {
   		userListWindows("changeUser");
   	});
	
	$("#btnCancleUserSettingDatePopup").on("click", function(e) {
		
		$("#changeUserSettingPhoneNM").val("${memberInfo.USER_PHONE}");
    	$("#changeUserSettingEmail").val("${memberInfo.USER_EMAIL}");
		$("#changeUserSettingpassword").val("");
		$("#checkUserSettingpassword").val("");
		
		$("#userSettingDatePopup").hide();
	});
	
	$("#btnCanclePopClose").on("click", function(e) {
		Logout();
	});
   	
});

<%-- <%
session.setMaxInactiveInterval(30); 
%> --%>

function popClose(){
	$("#popClose").show();
};

var SetTime= <%= session.getMaxInactiveInterval() %>; 
 
 
function Loading() {
    var maskHeight = $(document).height();
    var maskWidth  = window.document.body.clientWidth;
     
    var mask       = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
    var loadingImg ='';
     
    loadingImg +=" <div id='loadingImg'>";
    loadingImg +=" <img src='${pageContext.request.contextPath}/resources/assets/images/spinner.gif' style='position:absolute; z-index:9500; text-align:center; display:block; top:650%; left:42%;'/>";
    loadingImg += "</div>";  
 
    $('body')
        .append(mask)
 
    $('#mask').css({
            'width' : maskWidth,
            'height': maskHeight,
            'opacity' :'0.3'
    });
    
    $('#mask').show();
  
    $('.container_header').append(loadingImg);
    $('#loadingImg').show();
}

function closeLoading() {
    $('#mask, #loadingImg').hide();
    $('#mask, #loadingImg').remove(); 
}

function userListWindows(info){
	
	console.log("Asdfadf");
	var pop_url = "${getContextPath}/popup/userList";
	var id = "targetList"
	var winWidth = 700;
	var winHeight = 570;
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
	var pop = window.open(pop_url,id,popupOption);
	/* popList.push(pop);
	sessionUpdate(); */
	
	var newForm = document.createElement('form');
	newForm.method='POST';
	newForm.action=pop_url;
	newForm.name='newForm';
	newForm.target=id;
	
	var data = document.createElement('input');
	data.setAttribute('type','hidden');
	data.setAttribute('name','info');
	data.setAttribute('value',info);
	
	newForm.appendChild(data);
	document.body.appendChild(newForm);
	newForm.submit();
	
	document.body.removeChild(newForm);
}

function htmlTag(cellvalue, options, rowObject) {
	
	var result = cellvalue;
	if(cellvalue != null) {
		result = result.replaceAll("&", "&amp;");
		result = result.replaceAll("<", "&lt;");
		result = result.replaceAll(">", "&gt;");
		result = result.replaceAll("\"", "&quot;");
	}
	return result;
}

</script>

<body>
<!-- wrap -->
<div class="wrap">

	<!-- header -->
	<header id="header">
		<!-- container -->
		<div class="container_header">
			<!-- logo -->
			<div class="img_logo">
				<a href="<%=request.getContextPath()%>/piboard"><h1>개인정보 검출관리 센터</h1></a>
				
				<%-- <c:choose>
					<c:when test="${memberInfo.USER_GRADE == 0}">
						<a href="<%=request.getContextPath()%>picenter_manager"><h1>개인정보 검출관리 센터</h1></a>
					</c:when>
					<c:when test="${memberInfo.USER_GRADE == 1}">
						<a href="<%=request.getContextPath()%>/picenter_manager"><h1>개인정보 검출관리 센터</h1></a>
					</c:when>
					<c:when test="${memberInfo.USER_GRADE == 2}">
						<a href="<%=request.getContextPath()%>/picenter_manager"><h1>개인정보 검출관리 센터</h1></a>
					</c:when>
					<c:when test="${memberInfo.USER_GRADE == 3}">
						<a href="<%=request.getContextPath()%>/picenter_manager"><h1>개인정보 검출관리 센터</h1></a>
					</c:when>
					<c:when test="${memberInfo.USER_GRADE == 4}">
						<a href="<%=request.getContextPath()%>/picenter_server"><h1>개인정보 검출관리 센터</h1></a>
					</c:when>
					<c:when test="${memberInfo.USER_GRADE == 5}">
						<a href="<%=request.getContextPath()%>/picenter_server"><h1>개인정보 검출관리 센터</h1></a>
					</c:when>
					<c:when test="${memberInfo.USER_GRADE == 6}">
						<a href="<%=request.getContextPath()%>/picenter_server"><h1>개인정보 검출관리 센터</h1></a>
					</c:when>
					<c:when test="${memberInfo.USER_GRADE == 7}">
						<a href="<%=request.getContextPath()%>/approval/pi_search_approval_list"><h1>개인정보 검출관리 센터</h1></a>
					</c:when>
					<c:otherwise>
						<a href="<%=request.getContextPath()%>/piboard"><h1>개인정보 검출관리 센터</h1></a>
					</c:otherwise>
				</c:choose> --%>
				<div class="logo_text">
					<div><b style="font-size:17px;">PICenter</b></div>
				<div style="position: absolute; top: 20px; font-size: 12px;">개인정보 검출관리 센터</div>
				</div>
			</div>
			
			<!-- nav -->
			<nav id="nav">
				<!-- gnb -->
				<h2 class="ir">업무메뉴</h2>
			  <ul class="gnb_menu clear">
			    <c:forEach items="${headerList}" var="item" varStatus="status">
			    	<%-- <li><a href="#">${!status.first}</a></li> --%>
		    		<c:choose>
			    		<c:when test="${item.SUB_NO == 0}">
			    			<c:if test="${!status.first}">
					    		</li>
					    		</ul>
					    		</li>
					    	</c:if>
					    	<c:choose>
					    		<c:when test="${item.HEADER_NO == 1}">
					    			<c:choose>
					    				<c:when test="${item.IDX == 23}">
						    			<li>
						    			<a href="<%=request.getContextPath()%>/piboard" style="width: 160px;">${item.NAME}</a>
				    					<ul class="gnb_sub_menu_dash" style="background-color: rgb(255, 255, 255);">
				    					<li>
				    					</c:when>
				    					<c:when test="${item.IDX == 26}">
						    			<li>
						    			<a href="<%=request.getContextPath()%>/picenter_manager" style="width: 160px;">${item.NAME}</a>
				    					<ul class="gnb_sub_menu_dash" style="background-color: rgb(255, 255, 255);">
				    					<li>
				    					</c:when>
				    					<c:when test="${item.IDX == 27}">
						    			<li>
						    			<a href="<%=request.getContextPath()%>/picenter_server" style="width: 160px;">${item.NAME}</a>
				    					<ul class="gnb_sub_menu_dash" style="background-color: rgb(255, 255, 255);">
				    					<li>
				    					</c:when>
				    				</c:choose>
					    		</c:when>
					    		<c:when test="${item.HEADER_NO == 2}">
					    			<li>
					    			<a href="javascript:void(0);" style="width: 160px;">${item.NAME}</a>
			    					<ul class="gnb_sub_menu_policy" style="background-color: rgb(255, 255, 255);">
			    					<li>
					    		</c:when>
					    		<c:when test="${item.HEADER_NO == 3}">
					    			<li>
					    			<a href="javascript:void(0);" style="width: 160px;">${item.NAME}</a>
			    					<ul class="gnb_sub_menu_target" style="background-color: rgb(255, 255, 255);">
			    					<li>
					    		</c:when>
					    		<c:when test="${item.HEADER_NO == 4}">
					    			<li>
					    			<a href="javascript:void(0);" style="width: 160px;">${item.NAME}</a>
		        					<ul class="gnb_sub_menu_search" style="background-color: rgb(255, 255, 255);">
			    					<li>
					    		</c:when>
					    		<c:when test="${item.HEADER_NO == 5}">
			    					<li>
					    			<a href="javascript:void(0);" style="width: 160px;">${item.NAME}</a>
			    					<ul class="gnb_sub_menu_detection" style="background-color: rgb(255, 255, 255);">
			    					<li>
					    		</c:when>
					    		<c:when test="${item.HEADER_NO == 6}">
			    					<li>
					    			<a href="javascript:void(0);" style="width: 160px;">${item.NAME}</a>
			    					<ul class="gnb_sub_menu_community" style="background-color: rgb(255, 255, 255);">
			    					<li>
					    		</c:when>
					    		<c:when test="${item.HEADER_NO == 7}">
			    					<li>
					    			<a href="javascript:void(0);" style="width: 160px;">${item.NAME}</a>
			    					<ul class="gnb_sub_menu_user" style="background-color: rgb(255, 255, 255);">
			    					<li>
					    		</c:when>
					    	</c:choose>
			    		</c:when>
			    		<c:otherwise>
			    			<a href="${item.URL}" >${item.NAME}</a>
			    		</c:otherwise>
		    		</c:choose>
		    		<c:if test="${status.end}">
			    		</li>
			    		</ul>
			    		</li>
			    	</c:if>
			    </c:forEach>
			  </ul>
			</nav>
			<!-- nav -->
			<div class="user">
				<div class="member_area" style="right: 25px;">
					<!-- <p class="memberInfo">IT 보안모듈 홍길동 과장</p> -->
					<!-- <p class="memberInfo" style="float: left; margin-left: 40px; font-size: 12px;" id="sessionTimeCheck">(30:00)</p> -->
					<c:if test="${memberInfo.USER_GRADE == 9}">
					<p class="memberInfo" style="float: right; margin-right: 25px; font-size: 12px;">
						<button id="changeUser" style="vertical-align: top;">사용자 변경</button>
					</p>
					</c:if>
					<p class="memberInfo" style="float: right; margin-right: 25px; font-size: 12px;" id="user_Information"></p>
					<%-- <p class="memberInfo" style="float: right; margin-right: 15px;" id="user_Information">${memberInfo.USER_NAME}(${memberInfo.USER_NO})</p> --%>
					<img class="logOutImg Logout" src="${pageContext.request.contextPath}/resources/assets/images/setting_icon.png" style="top: -1px; right: -5px;" id="user_setting"  title="사용자 정보">
				</div>
				<img class="logOutImg Logout" src="${pageContext.request.contextPath}/resources/assets/images/logout.png" id="btnLogout" title="Log-Out">
				<!-- 보안관리자(9), 서비스운영자/관리자(4,5), 서버운영자(6), 직책자(7)  -->
			</div>
		</div>
		
		<!-- container -->
	</header>
	<!-- header -->
	
<div id="userSettingDatePopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 400px; padding: 10px; background: #f9f9f9; top: 55%;">
		<img class="CancleImg" id="btnCancleUserSettingDatePopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">사용자 정보 수정</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" id="div_update_user" style="height: 297px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						 <tr>
							<th>사용자 ID</th>
							<td>${memberInfo.USER_NO}
							</td>
						</tr>
						<tr>
							<th>사용자명</th>
							<td colspan="2">	
								<input type="text" id="changeUserSettingNM" style="width: 196px; padding-left:10px; text-align: left;" value="${memberInfo.USER_NAME}" >
							</td>
						</tr>
						<tr>
							<th>
								비밀번호변경
								<img alt="" src="${pageContext.request.contextPath}/resources/assets/images/question_icon.png" style="width: 15px; position: absolute; top: 159px; left: 110px;" id="questionIcon">
							</th>
							<td colspan="2">	
								<input type="password" id="changeUserSettingpassword" style="width: 196px; padding-left:10px; text-align: left;" value="" >
								
								<div id="passwordQuestion"style="height: 62px; width: 222px;padding: 10px;background: rgb(255,255,255); box-shadow: rgb(221 221 221) 2px 2px 5px;
																 border: 1px solid #cdcdcd; top: 41%;right: 32px;position: absolute; z-index: 999; display: none;">
									<p style="color: #55555;">
										 - 8자리 이상 <br>
										 - 숫자/영문자/특수문자를 1개 이상
									</p>
								</div>
							</td>
						</tr>
						<!-- <tr>
							<th></th>
							<td colspan="2">	
								<p style="color: #9E9E9E;">
									 - 8자리 이상 <br>
									 - 숫자/영문자/특수문자를 1개 이상
								</p>
							</td>
						</tr> -->
						<tr>
							<th>비밀번호확인</th>
							<td colspan="2">	
								<input type="password" id="checkUserSettingpassword" style="width: 196px; padding-left:10px; text-align: left;" value="" >
							</td>
						</tr>
						<tr>
							<th>전화번호변경</th>
							<td colspan="2">	
								<input type="text" id="changeUserSettingPhoneNM" style="width: 196px; padding-left:10px; text-align: left;" value="${memberInfo.USER_PHONE}" >
							</td>
						</tr>
						<tr>
							<th>이메일변경</th>
							<td><input type="text" id="changeUserSettingEmail" style="width: 196px; padding-left:10px; text-align: left;" value="${memberInfo.USER_EMAIL}" >
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<c:if test="${memberInfo.USER_GRADE == 9}">
					<button type="button" id="btnUserSMSFlag" style="float: left;">SMS인증 활성화</button>
				</c:if>
				<button type="button" id="btnUserSettingDateSave">저장</button>
				<button type="button" id="btnUserSettingDateCancel">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- <div id="sessionUpdatePop" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 400px; padding: 10px; background: #f9f9f9; top: 63%;">
		<div class="popup_top" style="background: #f9f9f9; height: 50px; line-height: 50px;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">자동로그아웃 안내</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 106px; background: #fff; border: 1px solid #c8ced3; font-size: 13px;">
				약 30분 동안 서비스 이용이 없어 <span id="sessionSelectCheck" style="color: #FF7A00; font-weight: bold;"></span>초 후<br>
				로그아웃 됩니다.
				<br><br>
				이용 시간을 연장하시겠습니까?
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnsessionUpdate" onclick="btnSessionUpdate();">연장</button>
				<button type="button" id="btnsessionClose">닫기</button>
			</div>
		</div>
	</div>
</div> -->

<div id="popClose" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 103px; width: 400px; padding: 10px; background: #f9f9f9; top: 71%;">
	<img class="CancleImg" id="btnCanclePopClose" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">세션 만료 안내</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 41px; background: #fff; border: 1px solid #c8ced3; font-size: 13px;">
				세션이 만료 되어 다시 로그인해 주세요.
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 7px 0; margin: 0;">
				<button type="button" id="btnPopClose">확인</button>
			</div>
		</div>
	</div>
</div>
