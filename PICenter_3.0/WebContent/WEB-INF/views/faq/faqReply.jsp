<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style>
/*댓글*/

.rWriter {
	display: inline-block;
	vertical-align: top;
	font-size: 1.2em;
	font-weight: bold;
}

.rDate {
	display: inline-block;
}

.rContent, .replyBtnArea {
	height: 100%;
	width: 100%;
}

.replyBtnArea {
	text-align: right;
}

.replyUpdateContent {
	resize: none;
	width: 100%;
}

.reply-row {
	padding: 15px 0;
	padding-top: 0px;
}

.replyWrite>table {
	width: 90%;
	align: center;
}

#replyfont {
	font-weight: bold;
}

#addReply {
	border: 3px solid gray;
	font-weight: bold;
	padding: 10px;
}

#replyContentArea {
	width: 90%;
}

#replyContentArea>textarea {
	resize: none;
	width: 100%;
}

#replyBtnArea {
	width: 100px;
	text-align: center;
}

.rDate {
	font-size: 1.2em;
	color: gray;
}

#replyListArea {
	list-style-type: none;
}
.btnSize{padding-right: 5px;}
</style>
<div id="reply-area ">
	<!-- 댓글 작성 부분 -->
	<div class="replyWrite">
		<br>
		<table align="center" >
			<tr class="text-center">
				<td id="replyContentArea">
					<textArea rows="3" id="replyContent"></textArea>
					<input type="hidden" value="${memberInfo.USER_NO}" id="reply_user">
				</td>
				<td id="replyBtnArea btn-color1">
					<button class="btn btn-color1 rfs" id="addReply" onclick="addReply();">
						댓글<br>등록
					</button>
				</td>
			</tr>
		</table>
	</div>
	<!-- 댓글 출력 부분 -->
	<div class="replyList mt-5 pt-2">
		<ul id="replyListArea">
		</ul>
	</div>

</div>

<script type="text/javascript"> 
// 현재 게시글 번호
const faq_no = ${faqMap.FAQ_NO};
const loginUser = $("#reply_user").val()
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
	          var div = $("<div>");
	          var rWriter = $("<p>").addClass("rWriter").text(item.USER_NAME);
		      var rDate = $("<p>").addClass("rDate").text("작성일 : " + item.CREATE_DT);
		      
		      var userNo = $('<input/>', {type: 'hidden', id: 'userNo_'+item.REPLY_NO, value:item.USER_NAME});
		      var createDt = $('<input/>', {type: 'hidden', id: 'createDt_'+item.REPLY_NO, value:item.CREATE_DT });
	          div.append(rWriter).append(rDate).append(userNo).append(createDt)
	          
	          replyCon = replyCon.replace("\n", "<br>"); 
	          
	          // 댓글 내용
	          var rContent = $("<p>").addClass("rContent").attr("id", "text_"+item.REPLY_NO).html(replyCon);
	          
	          // 대댓글, 수정, 삭제 버튼 영역
	          var replyBtnArea = $("<div>").addClass("replyBtnArea");
	          
	          // --------------------- 로그인한 회원과 작성한 회원의 번호 비교
	          if(item.USER_NO == loginUser){
		          var showUpdate = $("<button>").addClass("btn btn-outline-info  ml-1 btnSize").text("수정").attr("onclick", "showUpdateReply("+ item.REPLY_NO +", this)");
		          var deleteReply = $("<button>").addClass("btn btn-outline-info  ml-1 ").text("삭제").attr("onclick", "deleteReply("+item.REPLY_NO+")");
	          }
	        
	          li.append(div).append(rContent).append(replyBtnArea).append(showUpdate).append(deleteReply);
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
	
	// 기존 댓글 영역을 삭제하고 textarea를 추가
	// $(el).parent().prev().remove();
	const userNo = $("#userNo_"+reply_no).val()
	const createDt = $("#createDt_"+reply_no).val()
	
	 var div = $("<div>");
	 var rWriter = $("<p>").addClass("rWriter").text(userNo);
     var rDate = $("<p>").addClass("rDate").text("작성일 : "+createDt);
	
	var textarea = $("<textarea>").addClass("replyUpdateContent").attr("rows", "3").val(beforeContent);
	$(el).parent().before(div.append(rWriter).append(rDate))
	$(el).parent().before(textarea);
	
	// 수정 버튼
	var updateReply = $("<button>").addClass("btn btn-outline-info ml-1 mb-4 btnSize").text("수정 ").attr("onclick", "updateReply(" + reply_no + ", this)");
	
	// 취소 버튼
	var cancelBtn = $("<button>").addClass("btn btn-outline-info ml-1 mb-4 ").text(" 취소").attr("onclick", "updateCancel(this)");
	
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

</script>
</body>

</html>