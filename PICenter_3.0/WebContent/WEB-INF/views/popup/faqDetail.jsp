<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>FAQ 상세정보</title>

<link href="${pageContext.request.contextPath}/resources/assets/css/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<!-- Publish JS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui-PIC.js" type="text/javascript"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.ui-deps.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.js"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/jquery.jqGrid.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/i18n/grid.locale-kr.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/wickedpicker.js"></script>

<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />

<!-- Application Common Functions  -->
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<!-- Publish CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset-PIC.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design-PIC.css" />
<%@ include file="../../include/session.jsp"%>
<style>
body{
	width: auto;
}
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	html{
		overflow: auto !important;
	}
	body{
		width: auto !important;
	}
}
h3{
	font-size: 22px;
}
.container{
	margin: 0;
}
#faqPop{
	background-color: #23282c;
	color: white;
	height: 60px;
	line-height: 60px;
	padding: 0 20px;
}
#btnfaqUpdate, #btnfaqDelete,
#btnfaqSave, #btnfaqCancel{
	font-size: 12px;
	border: 1px solid #cdcdcd;
}
#faqTitle{
	padding-left: 1px;
}
#Content{
	width: 1017px; 
	height: 400px; 
	margin-top: 10px;
	margin-bottom: 10px; 
	font-size: 12px; 
	resize: none;
}
#faqUpdateCon{
	width: 1017px; 
	height: 400px; 
	margin-top: 10px; 
	margin-bottom: 10px; 
	font-size: 12px; 
	resize: none; 
	display: none;
}
/*댓글*/

.rWriter {
	display: inline-block;
	vertical-align: top;
	font-size: 12px;
	font-weight: bold;
}

.rDate {
	display: inline-block;
}

.rContent{
	margin: 10px 0;
	height: 99px;
}

.replyBtnArea {
	text-align: right;
}

.replyUpdateContent {
	margin: 10px 0;
	font-size: 12px;
	height: 100px;
	resize: none;
	width: 100%;
}

.reply-row {
	padding: 15px 0;
	padding-top: 0px;
}

#replyfont {
	font-weight: bold;
}

#replyContentArea {
	padding: 0;
	width: 100%;
}

#replyContentArea>textarea {
	resize: none;
	width: 100.75%;
	height: 150px;
}

#replyBtnArea {
	width: 100px;
	text-align: center;
}

.rDate {
	float: right;
}
.replyList{
 	width: 100%;
}

#replyListArea {
	list-style-type: none;
}
.btnSize{padding-right: 5px;}
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	.container{
		height: 890px !important;
	}
	.faq_popup_content{
		margin: 0 8px 15px 8px;
	}
}

</style>

</head>
<body>
	<div class="container" style="width: 100% !important; height: auto !important; padding: 15px;">
		<h3 style="padding-top: 5px; padding-left: 10px;">FAQ</h3>
		<div id="content magin_t25">
			<div id="faqTitilePop">
				<div class="faq_popup_content">
					<table class="faq_popup_tbl">
						<colgroup>
							<col width="15%">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>제목</th>
								<td>
									<p id="faqTitle">${faqMap.FAQ_TITLE}</p>
									<input type="hidden" id="faqUpdateTitle" value="${faqMap.FAQ_TITLE}">
								</td>
							</tr>
							<tr>
								<th>작성자</th>
								<td>${faqMap.USER_NAME}</td>
							</tr>
							<tr>
								<th>작성일</th>
								<td>${faqMap.FAQ_CREATE_DT}</td>
							</tr>
							<tr>
								<th style="padding-bottom: 365px;">내용</th>
								<td style="padding-bottom: 0;">
									<textarea id="Content" readonly rows="10">${faqMap.FAQ_CONTENT}</textarea>
									<textarea id="faqUpdateCon" rows="10">${faqMap.FAQ_CONTENT}}</textarea>
								</td>
							</tr>
							<tr>
								<th style="border: 0 none;"></th>
								<td style="padding-bottom: 20px; border: 0 none;">
									<%-- <c:if test="${memberInfo.USER_NO == faqMap.USER_NO || memberInfo.USER_GRADE == 9 }"> --%>
									<c:if test="${memberInfo.USER_NO == faqMap.USER_NO || memberInfo.USER_GRADE == 9}"> 
										<div  class="popup_btn" style="float: right;">
											<div id="insertbtn" class="btn_area" style="padding-right: 0;">
												<c:if test="${memberInfo.USER_NO == faqMap.USER_NO}">
													<button type="button" id="btnfaqUpdate">수정</button>
												</c:if>
												<button type="button" id="btnfaqDelete">삭제</button>
											</div>
											<div id="savetbtn" class="btn_area" style="padding-right: 0; display: none;">
												<button type="button" id="btnfaqSave">저장</button>
												<button type="button" id="btnfaqCancel">취소</button>
											</div>
										</div>
									</c:if>
								</td>
							</tr>
							<tr>
								<th style="padding-bottom: 115px;">댓글</th>
								<td>
									<div id="reply-area ">
										<!-- 댓글 작성 부분 -->
										<div class="replyWrite">
											<br>
											<table>
												<tr class="text-center">
													<td id="replyContentArea" style="border-top: none;">
														<textArea id="replyContent"></textArea>
														<input type="hidden" value="${memberInfo.USER_NO}" id="reply_user">
														<input type="hidden" value="${memberInfo.USER_GRADE}" id="reply_user_grade">
													</td>
													<td id="replyBtnArea btn-color1" style="border-top: none;">
														<button class="btn_down" id="addReply" style="width: 71.45px; font-size: 12px; color: #555;" onclick="addReply();">등록</button>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th style="border: 0 none;"></th>
								<td style="border: 0 none;">
									<!-- 댓글 출력 부분 -->
									<div class="replyList mt-5 pt-2">
										<ul id="replyListArea">
										</ul>
									</div>
									<%-- <%@ include file="../faq/faqReply.jsp"%> --%>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

//FAQ 수정
$("#btnfaqUpdate").click(function(){
	
	var bascifaq = $("#Content").val();
	var test = $("#faqUpdateTitle").val();
	
	$("#faqTitle").hide();
	$("#faqUpdateTitle").prop("type", "text");
	
	var faqTitle = "${faqMap.FAQ_TITLE}";
	$("#faqUpdateTitle").prop("value", ReplaceHtmlTag(faqTitle));
	
	$("#faqUpdateTitle").css("font-size", "12px");
	$("#faqUpdateTitle").css("width", "1017px");
	
	$("#insertbtn").hide();
	$("#savetbtn").show();
	
	$("#Content").hide();
	$("#faqUpdateCon").show();
	$("#faqUpdateCon").val(bascifaq);
	
});

// FAQ 수정 저장
$("#btnfaqSave").click(function(){
	
	$("#faqTitle").hide();
	$("#faqUpdateTitle").prop("type", "text");
	$("#faqUpdateTitle").css("font-size", "12px");
	$("#faqUpdateTitle").css("width", "1017px");
	
	$("#insertbtn").hide();
	$("#savetbtn").show();
	
	var postData = {
			faq_title : $("#faqUpdateTitle").val(),
			faq_con : $("#faqUpdateCon").val(),
			user_no : '${memberInfo.USER_NO}',
			faq_id : '${faqMap.FAQ_NO}'
    }
	console.log(postData);
	$.ajax({
   		type: "POST",
   		url: "/faq/faqUpdate",
   		async : false,
   		data : postData,
   		dataType : "JSON",
   	 	success: function (resultMap) {
	        if (resultMap.resultCode != 0) {
	        	
		        alert("FAQ 수정 실패 :"+resultMap.resultMessage);
		    } else if (resultMap.resultCode == 0) {
		    	<%-- // 화면 동적 변화  --%>
		    	var postData = {};
		    		<%-- opener.$("#faqGrid").setGridParam({
		    		url:"<%=request.getContextPath()%>/faq/faqList", 
		    		postData : postData, 
		    		datatype:"json"
		    		}).trigger("reloadGrid");
		    		location.reload(); --%>
		    		// 부모창 새로 고침 
		    		opener.parent.location.reload();
		    		// 현재 팝업 새로 고침 
		    		// window.location.href = "${getContextPath}/popup/faqDetail/" + '${faqMap.FAQ_NO}'; 
		    		location.reload();
		    		alert("FAQ 수정 성공");
		    }
	    },
	    error: function (error) {
			alert("ERROR : " + error);
	    }
   	});
});


$("#btnfaqCancel").click(function(){
	
	$("#faqTitle").show();
	$("#faqUpdateTitle").prop("type", "hidden");
	
	$("#insertbtn").show();
	$("#savetbtn").hide();
	
	$("#Content").show();
	$("#faqUpdateCon").hide();
	
});
	
// FAQ 삭제
$("#btnfaqDelete").click(function(){
	
	if(confirm("정말로 삭제하시겠습니까?")){
		var postData = {
				user_no : '${memberInfo.USER_NO}',
				faq_id : '${faqMap.FAQ_NO}'
	    }
		
		$.ajax({
	   		type: "POST",
	   		url: "/faq/faqDelete",
	   		async : false,
	   		data : postData,
	   		dataType : "JSON",
	   		success: function (resultMap) {
		    	console.log(resultMap);
		        if (resultMap.resultCode != 0) {
		        	
			        alert("FAQ 삭제 실패 : " + resultMap.resultMessage);
			        
			    } else if (resultMap.resultCode == 0) {
			    	var postData = {};
			    	<%-- opener.$("#faqGrid").setGridParam({
			    		url:"<%=request.getContextPath()%>/faq/faqList", 
			    		postData : postData, 
			    		datatype:"json" 
			    		}).trigger("reloadGrid"); --%>
			    		
			    		// 부모창 새로 고침 
			    		opener.parent.location.reload();
			    	
			    	alert("FAQ 삭제 성공");
			    	window.close();
			    }
		    },
		    error: function (error) {
				alert("ERROR : " + error);
		    }
	   	});
	}
	
});



// 댓글 영역 -------------------------------------------------- 
//현재 게시글 번호
const faq_no = ${faqMap.FAQ_NO};
const loginUser = $("#reply_user").val() ;
const loginUserGrade = $("#reply_user_grade").val() ;
// 수정 전 댓글 요소를 저장할 변수 (댓글 수정 시 사용)
let beforeReplyRow;
//-----------------------------------------------------------------------------------------
$(document).ready(function(){
	selectReplyList();
});

//해당 게시글 댓글 목록 조회
function selectReplyList(){
	
	$.ajax({ 
		url : "${getContextPath}/faq/list",
		data : {"faq_no" : faq_no},
		type : "POST",
		dataType : "JSON",
		success : function(rList){
	       $("#replyListArea").html("");
	       
	       	$.each(rList, function(index, item){
	          
	          var li = $("<li>").addClass("reply-row");
	          
	          var replyCon = item.REPLY_CON;
	          
	          console.log(rList[index].CREATE_DT);
	          
	          // 작성자, 작성일
	          var div = $("<div>").css("margin-top", "10px");
	          var rWriter = $("<p>").addClass("rWriter").text(item.USER_NAME);
		      var rDate = $("<p>").addClass("rDate").text("작성일 : " + item.CREATE_DT);
		      var userNo = $('<input/>', {type: 'hidden', id: 'userNo_'+item.REPLY_NO, value:item.USER_NAME});
		      var createDt = $('<input/>', {type: 'hidden', id: 'createDt_'+item.REPLY_NO, value:item.CREATE_DT });
	          div.append(rWriter).append(rDate).append(userNo).append(createDt)
	          
	          replyCon = replyCon.replace("\n", "<br>"); 
	          
	          // 댓글 내용
	          var rContent = $("<p>").addClass("rContent").attr("id", "text_"+item.REPLY_NO).html(replyCon).css("margin", "11px 0 10px 1px");
	          
	          // 대댓글, 수정, 삭제 버튼 영역
	          var replyBtnArea = $("<div>").addClass("replyBtnArea");
	          
	          // --------------------- 로그인한 회원과 작성한 회원의 번호 비교
	          if(item.USER_NO == loginUser){
		          var showUpdate = $("<button>").addClass("btn_down").text("수정").css({"margin-right": "3px", "font-size": "12px", "color": "#555"}).attr("onclick", "showUpdateReply("+ item.REPLY_NO +", this)");
	          }
	          if(item.USER_NO == loginUser || loginUserGrade == 9 )
		          var deleteReply = $("<button>").addClass("btn_down").text("삭제").css({"margin-right": "3px", "font-size": "12px", "color": "#555"}).attr("onclick", "deleteReply("+item.REPLY_NO+")");
	        
	          li.append(div).append(rContent).append(replyBtnArea);
	          replyBtnArea.append(showUpdate).append(deleteReply);
	          // 합쳐진 댓글을 화면에 배치
	          $("#replyListArea").append(li);
	       });
		},
		error : function(){
			console.log("댓글 목록 조회 실패");
		}
		
	});
}

//-----------------------------------------------------------------------------------------
//댓글 등록
function addReply()	{
	
	// 작성된 댓글 내용 얻어오기
	const replyContent = $("#replyContent").val();
		
	if(replyContent.trim() == ""){ // 작성된 댓글이 없을 경우
		alert("댓글 작성 후 클릭해주세요.");
	}else{
		
		$.ajax({ 
			url : "${contextPath}/faq/insertReply", 
			type : "POST",
			data : { "user_no" : loginUser,
					 "faq_no" : faq_no,
					 "reply_con" : replyContent },
					 success: function (resultMap) {
				        if (resultMap.resultCode != 0) {
					        alert("댓글 등록 실패 : " + resultMap.resultMessage);
					    } else if (resultMap.resultCode == 0) {
					    	alert("댓글 등록 성공");
					    	$("#replyContent").val("");
					    	selectReplyList();
					    }
					  },
			error : function(){
				console.log("댓글 등록 실패");
			}
		});
	}
}	
// -----------------------------------------------------------------------------------------
//댓글 수정 폼
function showUpdateReply(reply_no, el){
	
	// 이미 열려있는 댓글 수정 창이 있을 경우 닫아주기
	if($(".replyUpdateContent").length > 0){
		$(".replyUpdateContent").eq(0).parent().html(beforeReplyRow);
	}
		
	// 댓글 수정화면 출력 전 요소를 저장해둠.
	beforeReplyRow = $(el).parent().parent().html();
	
	// 작성되어있던 내용(수정 전 댓글 내용) 
	var beforeContent = $("#text_"+reply_no).html();
	
	beforeContent = beforeContent.replace(/<br>/g, "\n");
	
	beforeContent = ReplaceHtmlTag(beforeContent);
	
	// 기존 댓글 영역을 삭제하고 textarea를 추가
	$(el).parent().prev().remove();
	const userNo = $("#userNo_"+reply_no).val()
	const createDt = $("#createDt_"+reply_no).val()
	
	
	var textarea = $("<textarea>").addClass("replyUpdateContent").attr("rows", "3").val(beforeContent);
	$(el).parent().before(textarea);
	
	// 수정 버튼
	var updateReply = $("<button>").addClass("btn_down").css({"margin-right": "3px", "font-size": "12px", "color": "#555"}).text("수정 ").attr("onclick", "updateReply(" + reply_no + ", this)");
	
	// 취소 버튼
	var cancelBtn = $("<button>").addClass("btn_down").text(" 취소").css({"margin-right": "3px", "font-size": "12px", "color": "#555"}).attr("onclick", "updateCancel(this)");
	
	var replyBtnArea = $(el).parent();
	
	$(replyBtnArea).empty(); 
	$(replyBtnArea).append(updateReply); 
	$(replyBtnArea).append(cancelBtn); 
}
//-----------------------------------------------------------------------------------------
//댓글 수정 취소 시 원래대로 돌아가기
function updateCancel(el){
	$(el).parent().parent().html( beforeReplyRow );
}
//-----------------------------------------------------------------------------------------
//댓글 수정
function updateReply(reply_no, el){
	
	// 수정된 댓글 내용
	const replyContent = $(el).parent().prev().val();
	
	$.ajax({
		url : "${contextPath}/faq/updateReply",
		type : "POST",
		data : {"reply_no" : reply_no,
				"reply_con" : replyContent },
		success : function(resultMap){
			 if (resultMap.resultCode != 0) {
			        alert("댓글 수정 실패 : " + resultMap.resultMessage);
			    } else if (resultMap.resultCode == 0) {
			    	alert("댓글 수정 성공");
			    	selectReplyList();
			    }
		},
		error : function(){
			console.log("댓글 수정 실패");
		}
		
	});
	
	
}
//-----------------------------------------------------------------------------------------
//댓글 삭제
function deleteReply(reply_no){
	if(confirm("정말로 삭제하시겠습니까?")){
		var url = "${contextPath}/faq/deleteReply";
		
		$.ajax({
			url : url,
			data : {"reply_no" : reply_no},
			success : function(resultMap){
				 if (resultMap.resultCode != 0) {
				        alert("댓글 삭제 실패 : " + resultMap.resultMessage);
				    } else if (resultMap.resultCode == 0) {
				    	alert("댓글 삭제 성공");
				    	selectReplyList();
				    }
			}, error : function(){
				console.log("ajax 통신 실패");
			}
		});
	}
}

function ReplaceHtmlTag(cellvalue) {
	
	var result = cellvalue;
	if(cellvalue != null) {
		result = result.replaceAll("&amp;","&");
		result = result.replaceAll("&lt;", "<");
		result = result.replaceAll("&gt;", ">");
		result = result.replaceAll("&quot;", "\"");
	}
	return result;
}
</script>
</html>
