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
	<title>개인정보 검출관리 센터</title>
	
	<link rel="icon" href="data:,">
	
	<!-- <title>NH농협중앙회 서버내 개인정보 검색 시스템</title> -->
	<!-- Publish CSS -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset-PIC.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design-PIC.css" />

	<!-- Publish JS -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>

	<!-- Application Common Functions  -->
	<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
	
</head>

<style>
	input:-ms-input-placeholder{
		color: #b1b3b5 !important;
		border-bottom: 1px solid #444 !important; 
		border-right: 1px solid #444 !important;
	}
</style>

<body>
	<!-- wrap -->
	<div class="wrap_login">
		<div class="img_logo" style="margin-top: 1px;">
			<h1>PIMC</h1>
		</div>
		<div class="container_login">
			<div class="login_box" style="overflow-y: auto;">
				<div class="text_box">
					<h1 style="font-size: 36px; line-height: 1;">PICenter</h1>
					<p style="padding-top: 10px; padding-left: 25%; font-size: 13px;">Personal Information Center</p>
					<div class="sub_text_box">
						<p style="font-size: 13px; padding-left: 15px;">개인정보 검출관리센터</p>
						<p style="font-size: 13px; padding-left: 15px;">개인정보보호법 준수를 위해 서버 등의 시스템 내에 존재하는 <br> 불필요한 개인정보를 검출 및 관리하는 시스템 입니다.</p>
					</div>
				</div>
				<div class="input_box" style="padding-left: 39px;">
					<h2 style="text-align: left;">Login<span style="font-size: 14px; color: #ccc;">/로그인</span></h2>
					<p style="padding-top: 100px;">ID</p>
					<input type="text" id="user_id" value="" placeholder="아이디를 입력하세요."><br/>
					<p>PASSWORD</p>
					<input type="password" id="user_pw" value="" style="margin-bottom: 3px;" placeholder="패스워드를 입력하세요.">
					<!-- <p style="color: #ccc;">최초 로그인 ID/PW는 사번/사번 입니다.</p> -->
					<input type="hidden" id="user_grade" value="">
					<!-- <button type="button" class="btn-request" id="loginSMS" style="border-radius: 0;">인증요청</button>
					<input type="text" id="sms_code" placeholder="인증번호를 입력하세요." class="ip-otp" style="padding-left: 120px; margin-top: 20px;">
					<p style="display: inline; position: relative; bottom: 54px; left: 125px;" id="smsTime">03:00</p> -->
					<button type="button" id="loginID" class="btn_login" style="margin-top: 40px;" >Login</button>
					<div class="footer_copyright">
						㈜프렌트리 All Rights Reserved
					</div>
				</div>
			</div>
		</div>

	<!-- 팝업창 - sms인증 -->
	<div id="authSMSPopup" class="popup_layer" style="display:none">
		<div id="smsPopupBox" class="popup_box" style="height: 160px;  width: 460px; left: 53%; top: 63%;">
			<div class="popup_top">
				<h1>패스워드 변경</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="height: 180px;">
					<!-- <h2>세부사항</h2>  -->
					<table class="popup_tbl">
						<colgroup>
							<col width="30%">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>인증번호</th>
								<td><input style="width: 170px;" type="text" id="authSms" value="" class="edt_sch">
								<p style="display: inline; padding-left:10px;" id="smsTime">03:00</p>
								</td>
							</tr>
							<tr >
								<td colspan="2">
									<div class="btn_area">
										<button type="button" id="btnSmsRe">재전송</button>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div class="btn_area">
					<button type="button" id="btnSmsCommit">확인</button>
					<button type="button" id="btnSmsCancel">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 팝업창 - SMS인증 팝업 종료 -->

	<!-- 팝업창 - 패스워드 초기화 -->
	<div id="passwordResetPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="height: 200px;  width: 400px; left: 55%;top: 65%; padding: 10px; background: #f9f9f9;">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">패스워드 초기화</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="height: 155px; background: #fff; border: 1px solid #c8ced3;">
					<img class="CancleImg" id="btnCanclePwdResetPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
					<!-- <h2>세부사항</h2>  -->
					<table class="popup_tbl">
						<colgroup>
							<col width="30%">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>ID</th>
								<td><input style="width: 238px; padding-left: 10px; border: 1px solid #c8ced3 !important;" type="text" id="employeeID" value="" class="edt_sch" placeholder="아이디를 입력하세요"></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input style="width: 238px; padding-left: 10px; border: 1px solid #c8ced3 !important;" type="text" id="name" value="" class="edt_sch" placeholder="이름을 입력하세요"></td>
							</tr>
							<tr>
								<th>
									<button class="btn_down" type="button" id="btnAuth" style="margin: 0; padding: 0; width: 96px; font-size: 12px;">인증요청</button>
									<p style="display: inline; position: absolute; bottom: 69px; left: 340px; z-index: 1;" id="smsAuthTime">03:00</p>
								</th>
								<td>
									<input style="width: 238px; padding-left: 10px; border: 1px solid #c8ced3 !important;" placeholder="인증번호를 입력하세요" type="text" id="authNum" value="" class="edt_sch">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" id="btnPasswordReset">초기화</button>
					<button type="button" id="btnPasswordResetCancel">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 팝업창 - 패스워드 초기화 종료 -->
	
</div>

<!-- 초기화 패스워드 변경 모달 -->
<div id="passwordChangePopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px;  width: 400px; padding: 10px; top: 65%; left: 55%; background: #f9f9f9;">
	<img class="CancleImg" id="btnCanclePwdChangePopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">패스워드 변경</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 155px; background: #fff; border: 1px solid #c8ced3;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>현재패스워드</th>
							<td><input style="width: 238px; padding-left: 10px;" type="password" id="oldPasswd" value="" class="edt_sch"></td>
						</tr>
						<tr>
							<th>변경패스워드</th>
							<td><input style="width: 238px; padding-left: 10px;" type="password" id="newPasswd" value="" class="edt_sch"></td>
						</tr>
						<tr>
							<th>변경패스워드확인</th>
							<td><input style="width: 238px; padding-left: 10px;" type="password" id="newPasswd2" value="" class="edt_sch"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnResetPasswordChangeSave">저장</button>
				<button type="button" id="btnResetPasswordChangeCancel">취소</button>
			</div>
		</div>
	</div>
</div>
	<!-- wrap -->

<!-- 계정 해제 신청 모달  -->
<div id="lockMemberPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 145px;  width: 400px; padding: 10px; background: #f9f9f9; top: 72%;">
	<img class="CancleImg" id="btnCancleLockMemberPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">계정 잠금 안내</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 69px; background: #fff; border: 1px solid #c8ced3; font-size: 13px; padding-top: 14px;">
				장기 미사용<span style="color: #FF7A00; font-weight: bold;">(3개월)</span>하여 자동 잠금처리 되었습니다. <br> 
				계정을 이용하실 경우 신청 버튼을 통해 관리자게에 요청해주세요.
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnLockMemberRequest">신청</button>
				<button type="button" id="btnLockMemberClose">닫기</button>
			</div>
		</div>
	</div>
</div>

<div id="lockMemberAccountPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 230px;  width: 400px; padding: 10px; background: #f9f9f9; top: 68%;">
	<img class="CancleImg" id="btnCancleLockMemberAccountPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">계정 잠금 해제 신청</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 156px; background: #fff; border: 1px solid #c8ced3; font-size: 13px; padding-top: 14px;">
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>아이디</th>
							<td><input type="text" id="lockMemberNo" value="" class="edt_sch" style="width: 300px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly></td>
						</tr>
						<tr>
							<th>사유</th>
							<td>
								<textarea id="lockMemberReson" rows="4" cols="44" style="resize: none; margin-top: 7px; width: 300px;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnAccountLockMemberRequest">신청</button>
				<button type="button" id="btnAccountLockMemberClose">닫기</button>
			</div>
		</div>
	</div>
</div>
	
</body>

<script type="text/javascript">

var passwordRules = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{1,50}).{8,50}$/;
var intervalID;
var invalidPassword = 0;
var user_grade = 0;
var position = '';

$(document).ready(function () {

	// 쿠키에 저장된 아이디 정보
	$('#user_id').val(getCookie("PiBoardUserNo"));
	// 아이디 입력시 발생하는 이벤트
	$('#user_id').keyup(function(e) {
		// 엔터 입력시 id값이 아무것도 없으면 id입력창에 포커스
		if (e.keyCode == 13) {
		    if ($('#user_id').val() == "") {
		    	$("#user_id").focus();
		    	return;
			} // 아이디 입력되어 있으면 패스워드에 포커스
		    $("#user_pw").focus();
	    }
	});
	// 패스워드 입력시 발생하는 이벤트
	$('#user_pw').keyup(function(e) {
		// 엔터 입력시 pw값이 아무것도 없으면 pw입력창에 포커스
		if (e.keyCode == 13) {
		    if ($('#user_pw').val() == "") {
		    	$("#user_pw").focus();
		    	return;
			} // 패스워드 입력되어 있으면 ID로 로그인 버튼 클릭
		    $("#loginID").click();
	    }        
	});
	// 아이디로 로그인 버튼 클릭시 발생하는 이벤트
	$("#loginID").click(function(){
		// 패스워드 오입력 횟수 5회 미만
		if (invalidPassword >= 5) return;
		// id value 비어 있을 경우, 포커스 되며 경고창 나옴
		if (isNull($("#user_id").val().trim())) {
			$("#user_id").focus();
			alert("아이디를 입력하세요");
			return;
		}
		// pw value 비어 있을 경우, 포커스 되며 경고창 나옴
		if (isNull($("#user_pw").val().trim())) {
			$("#user_pw").focus();
			alert("패스워드를 입력하세요");
			return;
		}
		
		// pw value 비어 있을 경우, 포커스 되며 경고창 나옴
		/* if (isNull($("#sms_code").val().trim())) {
			$("#sms_code").focus();
			alert("인증요처인증번호를 입력하세요");
			return;
		} */
		
		var postData = {
			user_no : $("#user_id").val(),
			password : $("#user_pw").val(),
			sms_code : $("#sms_code").val()
		};
		
		$.ajax({
			type: "POST",
			url: "/login",
			async : false,
			data : postData,
		    success: function (resultMap) {

		    	if(resultMap.resultCode == -4){
			    		alert(resultMap.resultMessage);
			    		$("#sms_code").val("");
			    		$("#smsTime").html("03:00");
			    		
			    		clearInterval(timer);
				   	     $("#authSMSPopup").hide();
				   	     $('#btnAuth').removeAttr("disabled");
				   	     $('#loginSMS').removeAttr("disabled");
				   	     $('#loginSMS').css("background", "#000");
				   	     $('#loginSMS').css("cursor", "pointer");
				   	     
				   	     $('.btn_chk').attr("disabled","disabled");
				   	     isRunning = false;
			    		
			    		return;
			    	}else if(resultMap.resultCode == -2){
			    		$("#passwordChangePopup").show();
			    		return;
			    	}else if(resultMap.resultCode == -8){
			    		console.log(resultMap.resultMessage);
			    		$("#lockMemberPopup").show();
			    		
			    	}else if (resultMap.resultCode != 0) {
						alert(resultMap.resultMessage);
/* 						alert("아이디 또는 패스워드가 일치하지 않습니다. 다시 확인해주시기 바랍니다. \n관련 문의처 : 보안운영실(02-6400-8842)"); */
			        	return;
				    }
			    	
			        if(resultMap.resultCode == 0){
			        	user_grade = resultMap.user_grade;
			        	position = resultMap.member.JIKWEE;
			        	var id = $("#user_id").val();
			        	var password = $("#user_pw").val();
			        	if(id == password){
			        		setPassword();
			        	} else {
			        		successLogin();
			        	}
			        }
			    
		    },
		    error: function (request, status, error) {
				alert("ERROR : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	$("#pw_reset").on("click", function(e) {
		$("#employeeID").val("");
		$("#name").val("");
		$("#phoneNumber").val("");
		$("#codeNumber").val("");
		$("#authNum").val("");
		$.ajax({
			type: "POST",
			url: "/user/SMSFlag",
			async : false,
			//data : postData,
		    success: function (resultMap) {
		    	console.log("test");
		    	console.log(resultMap);
		    	 if(resultMap.result == "N"){
		    		alert("SMS인증이 비활성화 되어있습니다.");
		    	}else {
		    		$("#passwordResetPopup").show();
		    	}
		    },
		    error: function (request, status, error) {
				alert("ERROR : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	$("#btnPasswordResetCancel").on("click", function(e) {
		
        var postData = {
                user_no : $("#employeeID").val(),
                user_name : $("#name").val()
            };
        $.ajax({
            type: "POST",
            url: "/reset_sms_code",
            async : false,
            data : postData,
            success: function (resultMap) {
                
            },
            error: function (request, status, error) {
                alert("ERROR : " + error);
                console.log("ERROR : ", error);
            }
        });
		
		$("#passwordResetPopup").hide();
    	var leftSec = 180;
    	clearInterval(timer);
    	isRunning = false;
		//startTimer(leftSec, display);
		$("#authNum").val("");
		$("#smsAuthTime").html("03:00");
	});
	
	$("#btnCanclePwdResetPopup").on("click", function(e) {
		$("#passwordResetPopup").hide();
		
		var leftSec = 180;
    	clearInterval(timer);
    	isRunning = false;
		//startTimer(leftSec, display);
		$("#authNum").val("");
		$("#smsAuthTime").html("03:00");
	});
	
	$("#btnCanclePwdChangePopup").on("click", function(e) {
		alert('패스워드 초기화 후 초기화된 패스워드를 변경해야 로그인 가능합니다.');
		removeSession();
		$("#oldPasswd").val("");
      	$("#newPasswd").val("");
      	$("#newPasswd2").val("");
		$("#passwordChangePopup").hide();
		
		var leftSec = 180;
		clearInterval(timer);
    	isRunning = false;
    	$("#sms_code").val("");
	});
	
	$("#btnCancleLockMemberPopup").on("click", function(e) {
		$("#lockMemberPopup").hide();
	});
	
	$("#btnCancleLockMemberAccountPopup").on("click", function(e) {
		$("#lockMemberAccountPopup").hide();
	});
	
	// 아이디로 SMS로그인 버튼 클릭시 발생하는 이벤트
	$("#loginSMS").click(function(){
		// 패스워드 오입력 횟수 5회 미만
		if (isNull($("#user_id").val())) {
			$("#user_id").focus();
			alert("아이디를 입력하세요");
			return;
		}
		// pw value 비어 있을 경우, 포커스 되며 경고창 나옴
		if (isNull($("#user_pw").val().trim())) {
			$("#user_pw").focus();
			alert("패스워드를 입력하세요");
			return;
		}
		
    	var display = $('#smsTime');
    	var leftSec = 180;
    	
		var postData = {
			user_no : $("#user_id").val(),
			password : $("#user_pw").val()
		};
		
		$.ajax({
			type: "POST",
			url: "/loginsms",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	if(resultMap.resultCode == -4) {
		    		alert(resultMap.resultMessage);
		    		return;
		    	}else if(resultMap.resultCode == -9){
		    		alert(resultMap.resultMessage);
		    		return;
		    	}else if(resultMap.resultCode == -10){
		    		alert(resultMap.resultMessage);
		    		return;
		    	}else if (resultMap.resultCode != 0) {
					alert("아이디/패스워드가 존재하지 않습니다. 다시 확인 해주세요.");
		        	return;
			    }
		    	
		        $('#loginSMS').attr("disabled","disabled");
		        $('#loginSMS').css("background", "#ccc");
		        $('#loginSMS').css("cursor", "default");
		    	// 남은 시간
		    	// 이미 타이머가 작동중이면 중지
		    	if (isRunning){
		    		// clearInterval(timer);
		    		// display.html("");
		    		startTimer(leftSec, display);
		    		$("#sms_code").val("");
		    	}else{
		    		clearInterval(timer);
		    		display.html("");
		    		startTimer(leftSec, display);
		    		$("#sms_code").val("");
		    	}
				
		    	alert("인증번호를 발송하였습니다.");
		    	/* 
		    	$("#authSms").val("");
	        	var display = $('#smsTime');
	        	var leftSec = 90;
	        	// 남은 시간
	        	// 이미 타이머가 작동중이면 중지
	        	if (isRunning){
	        		clearInterval(timer);
	        		display.html("");
	        		startTimer(leftSec, display);
	        	}else{
	        		startTimer(leftSec, display);
	        	} 
	        	*/
			    
		    },
		    error: function (request, status, error) {
				alert("ERROR : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	//  패스워드 초기화 인증번호 발송
	$("#btnAuth").click(function(){
		if (isNull($("#employeeID").val())) {
			$("#employeeID").focus();
			alert("아이디를 입력하세요.");
			return;
		}
		
		if($("#name").val().trim() == ""){
			alert("이름을 입력하세요.");
			return;
		}
		
		var display = $('#smsAuthTime');
    	var leftSec = 180;
		var postData = {
			user_no : $("#employeeID").val(),
			user_name : $("#name").val()
		};
		
		$.ajax({
			type: "POST",
			url: "/resetnum",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	console.log(resultMap);
		    	if(resultMap.resultCode == -4) {
		    		alert(resultMap.resultMessage);
		    		return;
		    	}else if(resultMap.resultCode = -10){
		    		alert(resultMap.resultMessage);
		    		return;
		    	}else if (resultMap.resultCode != 0) {
					alert("사용자 정보가 없거나 일치하지 않습니다.");
		        	return;
			    }

		        $('#btnAuth').css("background","#D9D9D9");
		        $('#btnAuth').attr("disabled","disabled");
		        $('#btnAuth').css("cursor", "default");
		        $('#btnAuth').css("color", "#fff");
		    	// 남은 시간
		    	// 이미 타이머가 작동중이면 중지
		    	if (isRunning){
		    		// clearInterval(timer);
		    		// display.html("");
		    		startTimer(leftSec, display);
		    		$("#authNum").val("");
		    	}else{
		    		display.html("");
		    		startTimer(leftSec, display);
		    		$("#authNum").val("");
		    	}
		    	
		    	alert("인증번호를 발송하였습니다.");
			    
		    },
		    error: function (request, status, error) {
				alert("ERROR : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	$("#btnPasswordReset").click(function(){
		
		if($("#employeeID").val().trim() == ""){
			alert("아이디를 입력하세요.");
			return;
		}
		
		if($("#name").val().trim() == ""){
			alert("이름을 입력하세요.");
			return;
		}

		if (isNull($("#authNum").val())) {
			$("#authNum").focus();
			alert("인증 요청을 진행해주세요.");
			return;
		}
		
		var postData = {
			user_no : $("#employeeID").val(),
			sms_code : $("#authNum").val(),
			user_name : $("#name").val()
		};
		
		$.ajax({
			type: "POST",
			url: "/resetPwd",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	
		    	console.log(resultMap);
		    	if(resultMap.resultCode == -10) {
		    		alert(resultMap.resultMessage);
		    		return;
		    	}else if (resultMap.resultCode != 0) {
			        alert("인증 번호가 다릅니다. 다시 인증해주세요.");
			        $("#authNum").val("");
		        	return;
			    }
		    	
		        if(resultMap.resultCode == 0){
		        	alert("패스워드가 초기화 되었습니다.");
		        	$("#authNum").val("");
		        	
		        	$("#passwordResetPopup").hide();
		        }
			    
		    },
		    error: function (request, status, error) {
		    	alert("인증번호 인증 실패하셨습니다. ");
		    }
		});
	});
	
	$("#btnResetPasswordChangeCancel").on("click", function(e) {
		alert('패스워드 초기화 후 초기화된 패스워드를 변경해야 로그인 가능합니다.');
		removeSession();
		$("#oldPasswd").val("");
      	$("#newPasswd").val("");
      	$("#newPasswd2").val("");
		$("#passwordChangePopup").hide();
		
		var leftSec = 180;
		clearInterval(timer);
    	isRunning = false;
    	$("#sms_code").val("");
	});
	
	$("#btnResetPasswordChangeSave").click(function(){
		
		var oldPassword = $("#oldPasswd").val();
		var newPasswd = $("#newPasswd").val();
		var newPasswd2 =  $("#newPasswd2").val();
		var user_no =  $("#user_id").val();

		if (oldPassword == "") {
			$("#oldPasswd").focus();
			alert("현재 패스워드를 입력하십시요");
			return;
		}
		
		if (newPasswd == "") {
			$("#newPasswd").focus();
			alert("변경 패스워드를 입력하십시요");
			return;
		}
		
		if (newPasswd2 == "") {
			$("#newPasswd2").focus();
			alert("변경 패스워드확인을 입력하십시요");
			return;
		}
		
		if (oldPassword == newPasswd) {
			$("#newPasswd").focus();
			alert("현재 패스워드와 변경 패스워드를 다르게 입력하십시요.");
			return;
		}
		
		if (newPasswd != newPasswd2) {
			$("#newPasswd").focus();
			alert("변경 패스워드와 패스워드확인이 일치하지 않습니다.");
			return;
		}
		
		if (!passwordRules.test(newPasswd)) {
			$("#newPasswd").focus();
			alert("패스워드는 숫자/영문자/특수문자를 1개 이상, 8자 이상입력하십시요.");
			return;
		}

		var postData = {oldPassword : oldPassword, newPasswd : newPasswd, user_no : user_no};		
		$.ajax({
			type: "POST",
			url: "/changeResetPwd",
			async : false,
			data : postData,
		    success: function (resultMap) {
		        if (resultMap.resultCode != 0) {
			        alert("패스워드 변경실패 : " + resultMap.resultMessage);
			        removeSession();
		        	return;
			    }
				alert("패스워드가 변경되었습니다.");
		      	$("#passwordChangePopup").hide();
		      	$("#oldPasswd").val("");
		      	$("#newPasswd").val("");
		      	$("#newPasswd2").val("");
		      	successLogin();
		    },
		    error: function (request, status, error) {
				alert("패스워드 변경실패 : " + error);
		        console.log("패스워드 변경실패 : ", error);
		        removeSession();
		    }
		});
		
	});
	
	$("#btnLockMemberRequest").on("click", function(e) {
		var user_no = $("#user_id").val();
		
		$("#lockMemberNo").val(user_no);
		
		$("#lockMemberPopup").hide();
		$("#lockMemberAccountPopup").show();
	});
	
	 $("#btnAccountLockMemberRequest").on("click", function(e) {
		 
		var unlock_reson = $("#lockMemberReson").val().trim();
		
		if(unlock_reson == ""){
			alert("계정 잠금 해제 사유를 기입하세요.");
			return;
		}
		
		var postData = {
				user_no : $("#user_id").val(),
				lock_staus : 2,
				unlock_reson : unlock_reson
			};
		
		$.ajax({
			type: "POST",
			url: "/lockMemberRequest",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	if(resultMap.resultCode == -4){
		    		alert(resultMap.resultMessage)
		    	}else{
			        alert("계정 해제 신청이 접수되었습니다.");
			        $("#lockMemberReson").val("");
			        $("#lockMemberAccountPopup").hide();
		    	}
		    },
		    error: function (request, status, error) {
		        console.log("계정 해제 신청 접수 실패: ", error);
		        removeSession();
		    }
		});
		
	}); 
	
	$("#btnLockMemberClose").on("click", function(e) {
		$("#lockMemberPopup").hide();
	});
	
	$("#btnAccountLockMemberClose").on("click", function(e) {
		$("#lockMemberReson").val("");
		$("#lockMemberAccountPopup").hide();
	});
	

    $("#loginSSO").click(function(){
    	
    	var postData = {};
    	
    	/* $.ajax({
			type: "POST",
			url: "/accountMemberSSO",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	console.log(resultMap);
		    	if(resultMap.resultCode == -9){
		    		alert(resultMap.resultMessage);
		    	}else if(resultMap.resultCode == -8){
		    		console.log(resultMap.resultMessage);
		    		$("#lockMemberPopup").show();
		    	}
		    },
		    error: function (request, status, error) {
		        console.log("계정 해제 신청 접수 실패: ", error);
		        removeSession();
		    }
		}); */
    	
    	<%
    	/* 
    	 * jsp name : sso link.jsp
    	   Copyright (c) 1994-2008 SKTelecom, Inc.
    	   All rights reserved.
    	   본 프로그램은 Tnet 프로젝트에서 진행하는 SSO 업무에 필요한 파일
    	   Proxy 대상 시스템의 SSO연계를 위한 link 페이지 임
    	*/

    		String sServerSessionID = request.getHeader("SM_SERVERSESSIONID");
    		String userid=request.getHeader("SM_USER");
    		sServerSessionID = (sServerSessionID != null) ? sServerSessionID.trim() : "";
    	%>
    	<%-- 
    	document.sso.action = "http://tnetproxy.sktelecom.com:18068/login.jsp";
		document.sso.authinform.value = "<%=sServerSessionID%>";
		document.sso.selAction.value = "S";
		document.sso.submit(); --%>
		window.location.href = 'http://tnetssoproxy.sktelecom.com:8081/proxy/sso_pimclink.jsp';
		
		<%-- $("#sso").attr("action", "http://tnetssoproxy.sktelecom.com:8081/proxy/sso_pimclink.jsp");
		$("#authinform").attr("value", "<%=sServerSessionID%>");
		$("#selAction").attr("value", "S");
		$("#sso").submit();  --%>
		
    });
    
    <%
	if(userid != null) {
%>
	    <%-- var postData = {
				user_no : "<%=userid%>",
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
		}); --%>
		
		var newForm = $('<form></form>'); //set attribute (form) 
		newForm.attr("name","newForm"); 
		newForm.attr("method","post"); 
		newForm.attr("action","https://pimc.sktelecom.com/sso_link"); 
		//newForm.attr("target","_blank"); 
		
		// create element & set attribute (input) 
		newForm.append($('<input/>', {type: 'hidden', name: 'userid', value:'<%=userid%>' })); 
		// append form (to body) 
		newForm.appendTo('body'); 
		// submit form 
		newForm.submit();
	<%
		}
	%>
	/* SKT Tnet SSO 로그인 종료 */
	<%--  $("#loginHeader").click(function(){
		alert('<%=userid%>');
		alert('${user_id}');
	});  --%>
    
}); //$(document).ready

function setPassword(){
	$("#oldPasswd").val("");
	$("#newPasswd").val("");
	$("#newPasswd2").val("");
	 
	$("#passwordChangePopup").show();
}

$("#btnPasswordChangeSave").on("click", function(e) {
	var oldPassword = $("#oldPasswd").val();
	var newPasswd = $("#newPasswd").val();
	var newPasswd2 =  $("#newPasswd2").val();

	if (oldPassword == "") {
		$("#oldPasswd").focus();
		alert("현재 패스워드를 입력하십시요");
		return;
	}
	
	if (newPasswd == "") {
		$("#newPasswd").focus();
		alert("변경 패스워드를 입력하십시요");
		return;
	}
	
	if (newPasswd2 == "") {
		$("#newPasswd2").focus();
		alert("변경 패스워드확인을 입력하십시요");
		return;
	}
	
	if (oldPassword == newPasswd) {
		$("#newPasswd").focus();
		alert("현재 패스워드와 변경 패스워드를 다르게 입력하십시요.");
		return;
	}
	
	if (newPasswd != newPasswd2) {
		$("#newPasswd").focus();
		alert("변경 패스워드와 패스워드확인이 일치하지 않습니다.");
		return;
	}
	
	if (!passwordRules.test(newPasswd)) {
		$("#newPasswd").focus();
		alert("패스워드는 숫자/영문자/특수문자를 1개 이상, 8자 이상입력하십시요.");
		return;
	}

	var postData = {oldPassword : oldPassword, newPasswd : newPasswd};		
	$.ajax({
		type: "POST",
		url: "/changeAuthCharacter",
		async : false,
		data : postData,
	    success: function (resultMap) {
	        if (resultMap.resultCode != 0) {
		        alert("패스워드 변경실패 : " + resultMap.resultMessage);
		        removeSession();
	        	return;
		    }
			alert("패스워드가 변경되었습니다.");
	      	$("#passwordChangePopup").hide();
	      	successLogin();
	    },
	    error: function (request, status, error) {
			alert("패스워드 변경실패 : " + error);
	        console.log("패스워드 변경실패 : ", error);
	        removeSession();
	    }
	});
});
$("#btnPasswordChangeCancel").on("click", function(e) {
	alert('최초 로그인 시 기본 설정된 패스워드를 변경해야 로그인 가능합니다.');
	removeSession();
	$("#passwordChangePopup").hide();
});

$("#btnSmsCommit").on("click", function(e) {
	if($("#authSms").val().trim() == ""){
		alert("인증번호를 입력해주세요.");
		
		return;
	}
	
	var postData = {
		user_no : $("#user_id").val(),
		sms_code : $("#authSms").val()
	};
	$.ajax({
		type: "POST",
		url: "/submitSmsLogin",
		async : false,
		data : postData,
	    success: function (resultMap) {
	        if (resultMap.resultCode != 0) {
		        alert("인증 번호가 다릅니다. 다시 인증해주세요.");
		        //$("#authSMSPopup").hide();
		        $("#authSms").val("");
		        removeSession();
	        	return;
		    }
	        if(resultMap.resultCode == 0){
	        	user_grade = resultMap.user_grade;
	        	position = resultMap.member.JIKWEE;
	        	alert("인증이 완료되었습니다.");
	        	successLogin();
	        }
	    },
	    error: function (request, status, error) {
			alert("인증번호 인증 실패하셨습니다. ");
	    }
	});
});

$("#btnSmsRe").on("click", function(e) {
	var postData = {
		user_no : $("#user_id").val(),
	};
	$.ajax({
		type: "POST",
		url: "/sms_login_resend",
		async : false,
		data : postData,
	    success: function (resultMap) {
	        if (resultMap.resultCode != 0) {
		        alert("인증 번호가 다릅니다. 다시 인증해주세요.");
		        //$("#authSMSPopup").hide();
		        $("#authSms").val("");
		        removeSession();
	        	return;
		    }
	        if(resultMap.resultCode == 0){
	        	alert("인증번호를 재발송 하였습니다.");
	        	$("#authSms").val("");
	        	var display = $('#smsTime');
	        	var leftSec = 180;
	        	// 남은 시간
	        	// 이미 타이머가 작동중이면 중지
	        	if (isRunning){
	        		clearInterval(timer);
	        		display.html("");
	        		startTimer(leftSec, display);
	        	}else{
	        		startTimer(leftSec, display);
	        	}
	        }
	    },
	    error: function (request, status, error) {
			alert("인증번호 인증 발송에 실패하였습니다.");
	    }
	});
});

$("#btnSmsCancel").on("click", function(e) {
	var postData = {
		user_no : $("#user_id").val(),
	};
	$.ajax({
		type: "POST",
		url: "/sms_login_cancel",
		async : false,
		data : postData,
	    success: function (resultMap) {
	        if (resultMap.resultCode != 0) {
		        alert("인증 번호가 다릅니다. 다시 인증해주세요.");
		        //$("#authSMSPopup").hide();
		        $("#authSms").val("");
		        removeSession();
	        	return;
		    }
	        if(resultMap.resultCode == 0){
	        	$("#authSms").val("");
	        	$("#authSMSPopup").hide();
	        }
	    },
	    error: function (request, status, error) {
			alert("인증번호 인증 발송에 실패하였습니다.");
	    }
	});
});


var timer = null;
var isRunning = false;

function successLogin(){
	var user_no = $("#user_id").val();
    if ($('input:checkbox[name="save"]').is(":checked")) {
        setCookie("PiBoardUserNo", user_no, 7); // 7일 동안 쿠키 보관
    }
	else {
    	deleteCookie("PiBoardUserNo"); // 7일 동안 쿠키 보관
	}
  
    document.location.href = "<%=request.getContextPath()%>/";
}

function startTimer(count, display) {
    
	/* alert("인증번호를 발송하였습니다."); */
	
	var minutes, seconds;
    timer = setInterval(function () {
	    minutes = parseInt(count / 60, 10);
	    seconds = parseInt(count % 60, 10);
	
	    minutes = minutes < 10 ? "0" + minutes : minutes;
	    seconds = seconds < 10 ? "0" + seconds : seconds;
	
	    display.html(minutes + ":" + seconds);
	
	    // 타이머 끝
	    if (--count < 0) {
	     clearInterval(timer);
	     alert("인증 시간이 초과되었습니다.\n다시 진행해주세요.");
	     $("#authSMSPopup").hide();
	     //display.html("시간초과");
	     
	     $('#btnAuth').removeAttr("disabled");
	     $('#loginSMS').removeAttr("disabled");
	     $('#loginSMS').css("background", "#000");
	     $('#loginSMS').css("cursor", "pointer");
	     $('#btnAuth').css("background", "#fff");
	     $('#btnAuth').css("cursor", "pointer");
	     $('#btnAuth').css("color", "#000");
	     
	     $('.btn_chk').attr("disabled","disabled");
	     isRunning = false;
   		}
	}, 1000);
     isRunning = true;
}
/*
 function successSMS(){
	 var winRef;	
	var sms_url = "${getContextPath}/sms_login";
	var winWidth = 400;
	var winHeight = 300;
	
	// 팝업을 가운데 위치시키기 위해 아래와 같이 값 구하기
    //var _left = Math.ceil(( window.screen.width - _width )/2);
    //var _top = Math.ceil(( window.screen.height - _height )/2);
    var xPos = (document.body.offsetWidth/2) - (winWidth/2);
    xPos += window.screenLeft;
    var yPos = (document.body.offsetHeight/2) - (winHeight/2);

	//var popupOption= "width="+winWidth+", height="+winHeight + ", scrollbars=no, resizable=no"; 	
	var popupOption= "width="+winWidth+", height="+winHeight + ", scrollbars=no, resizable=yes, left=" + xPos + ", top="+ yPos; 	
	window.open(sms_url,"",popupOption); 
    
     $("#smsPopupBox").offset().left = xPos;
    $("#smsPopupBox").offset().top = yPos; 
	 
    var display = $('#smsTime');
	var leftSec = 90;
	// 남은 시간
	// 이미 타이머가 작동중이면 중지
	if (isRunning){
		clearInterval(timer);
		display.html("");
		startTimer(leftSec, display);
	}else{
		startTimer(leftSec, display);
	}
	
	$("#authSMSPopup").show();
} */


function removeSession(){
	var postData = {};
	$.ajax({
		type: "POST",
		url: "/logout",
		async : false,
		data : postData,
	    success: function (resultMap) {
	    },
	    error: function (request, status, error) {
			alert("ERROR : " + error);
	        console.log("ERROR : ", error);
	    }
	});
}
</script>
</html>
