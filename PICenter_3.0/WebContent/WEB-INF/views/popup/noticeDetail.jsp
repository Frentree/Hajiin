
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>공지사항 상세정보</title>

<link
	href="${pageContext.request.contextPath}/resources/assets/css/ui.fancytree.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/assets/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />

<!-- Publish JS -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>
<script type="text/ecmascript"
	src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui-PIC.js"
	type="text/javascript"></script>

<script type="text/ecmascript"
	src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.ui-deps.js"></script>
<script type="text/ecmascript"
	src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.js"></script>

<script type="text/ecmascript"
	src="${pageContext.request.contextPath}/resources/assets/jqgrid/jquery.jqGrid.min.js"></script>
<script type="text/ecmascript"
	src="${pageContext.request.contextPath}/resources/assets/jqgrid/i18n/grid.locale-kr.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/js/wickedpicker.js"></script>

<link rel="stylesheet" type="text/css" media="screen"
	href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />

<!-- Application Common Functions  -->
<script type="text/ecmascript"
	src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<!-- Publish CSS -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/css/reset-PIC.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/css/design-PIC.css" />
<%@ include file="../../include/session.jsp"%>
<style>
body{
	width: auto;
}
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	body{
		width: auto !important;
	}
}
h3 {
	font-size: 22px;
}
.container{
	margin: 0;
}
#noticePop {
	background-color: #23282c;
	color: white;
	height: 60px;
	line-height: 60px;
	padding: 0 20px;
}
#noticeTitle {
	padding-top: 1px;
	padding-left: 1px;
}
#btnNoticeUpdate, #btnNoticeDelete,
#btnNoticeSave, #btnNoticeCancel,
#btnNoticeTop {
	font-size: 12px;
	border: 1px solid #cdcdcd;
}
#Content{
	width: 997px;
	height: 377px;
	font-size: 12px;
	margin-top: 12px;
	resize: none;
}
#noticeUpdateCon{
	width: 997px;
	height: 377px;
	font-size: 12px;
	margin-top: 12px;
	resize: none;
	display: none;
}
</style>
</head>
<body>
	<div class="container" style="width: 100% !important; height: 100% !important; padding: 0;">
		<h3 style="padding-top: 5px; padding-left: 10px;">공지사항</h3>
		<div id="content magin_t25">
			<div class="notice_popup_content" style="height: 615px;">
				<table class="notice_popup_tbl">
					<colgroup>
						<col width="15%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr id="notice_CHK_tbl" style="display: none;">
							<th>중요</th>
							<td>
								<c:if test="${noticeMap.NOTICE_CHK == 1 }">
									<input type="checkbox" id="notice_CHK" value="1">
								</c:if>
								<c:if test="${noticeMap.NOTICE_CHK == 0 }">
									<input type="checkbox" id="notice_CHK" value="0" checked>
								</c:if>
							</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>
								<p id="noticeTitle">${noticeMap.NOTICE_TITLE}</p>
								<input type="hidden" id="noticeUpdateTitle" value="${noticeMap.NOTICE_TITLE}">
							</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${noticeMap.USER_NAME}</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td>${noticeMap.REGDATE}</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
								<c:if test="${fileChk eq 1}">
									<div id ="selectFile">
										<img style="float: left; padding-top: 5px;" alt="" src="<%=request.getContextPath()%>/resources/assets/images/file.png">
										<form id="downloadFileForm" action="<%=request.getContextPath()%>/download/file" method="post">
											<input id="downloadFile" type="hidden" name="filename" value="${noticeMap.FILE_NAME}">
											<input id="downloadRealFile" type="hidden" name="realfilename" value="${noticeMap.REAL_FILE_NAME}">
											<input type="submit" style="background-color: white; font-size: 12px; border:0px; cursor:pointer;" value="${noticeMap.FILE_NAME}"> 
										</form>
									</div>
								</c:if>
								<form id="uploadFileForm" method="post" enctype="multipart/form-data" style="display: none;">
									<input type="file" id="uploadFile" name="uploadFile" style="width: 997px; padding-left: 10px; display: none;" />
									<button type="button" id="clickFileBtn" style="padding: 5px 5px 5px 0; font-size: 12px;">파일 수정</button>
									<input type="text" id="updateFileNm" style="width: 941px; font-size: 12px;" readonly>
									<input type="hidden" id="updateFileNum" value="${noticeMap.NOTICE_FILE_ID}">
									
								</form>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea id="Content" readonly rows="8">${noticeMap.NOTICE_CON}</textarea>
								<textarea id="noticeUpdateCon" rows="8">${noticeMap.NOTICE_CON}</textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<c:if test="${memberInfo.USER_GRADE == 9}">
					<div class="popup_btn" style="position: relative; left: 15px; float: right;">
						<div id="insertbtn" class="btn_area" style="padding: 43px 0;">
							<button type="button" id="btnNoticeUpdate">수정</button>
							<button type="button" id="btnNoticeDelete">삭제</button>
						</div>
						<div id="save_btn" class="btn_area" style="padding: 43px 0; display: none;">
							<button type="button" id="btnNoticeSave">저장</button>
							<button type="button" id="btnNoticeCancel">취소</button>
						</div>
					</div>
				</c:if>
			</div>
			<progress id="progressBar" value="0" max="100" style="width:98%; display: none; position: absolute; margin-left: 8px; margin-top: 6px;"></progress>
		</div>
	</div>
</body>
<script type="text/javascript">
// 수정 버튼 클릭 이벤트
$("#btnNoticeUpdate").click(function(){
	
	var basciNotice = $("#Content").val();

	$("#notice_CHK_tbl").css("display", "table-row");
	$(".notice_popup_content").css("height", "655px");

	$("#noticeTitle").hide();
	$("#noticeUpdateTitle").prop("type", "text");
	
	var noticeTitleDate = "${noticeMap.NOTICE_TITLE}";
	$("#noticeUpdateTitle").prop("value", ReplaceHtmlTag(noticeTitleDate));
	
	
	$("#noticeUpdateTitle").css("font-size", "12px");
	$("#noticeUpdateTitle").css("width", "997px");
	
	$("#insertbtn").hide();
	$("#save_btn").show();
	
	$("#selectFile").hide();
	$("#uploadFileForm").show();
	
	$("#Content").hide();
	$("#noticeUpdateCon").show();
	$("#noticeUpdateCon").val(basciNotice);
	
	$("#progressBar").show();
	
	
	$("#clickFileBtn").click(function(){
		$("#uploadFile").click();
	});
	
	var loadFileNm = "${noticeMap.FILE_NAME}";
	$("#updateFileNm").val(loadFileNm);
	
	$("#uploadFile").change(function(){
		var checkFileNm = $("#uploadFile").val();
		
		var filelength = checkFileNm.lastIndexOf('\\');
		var fileNm = checkFileNm.substring(filelength+1, checkFileNm.length);
		
		$("#updateFileNm").val(fileNm);
	});
	
});
// 공지사항 수정 저장
$("#btnNoticeSave").click(function(){

	$("#noticeTitle").hide();
	$("#noticeUpdateTitle").prop("type", "text");
	$("#noticeUpdateTitle").css("font-size", "12px");
	$("#noticeUpdateTitle").css("width", "997px");
	
	$("#insertbtn").hide();
	$("#save_btn").show();
	
	if($("#notice_CHK").is(":checked")){
		$("#notice_CHK").val("0");
	}else{
		$("#notice_CHK").val("1");
	}
		
	var postData = {
			notice_chk : $("#notice_CHK").val(),
			notice_title : $("#noticeUpdateTitle").val(),
			notice_con : $("#noticeUpdateCon").val(),
			user_no : '${memberInfo.USER_NO}',
			notice_id : '${noticeMap.IDX}'
    }
	console.log(postData);
	
	var form = $('#uploadFileForm')[0]
    var data = new FormData(form);
	$.ajax({
	        type: "POST",
	        enctype: 'multipart/form-data',
	        url: "<%=request.getContextPath()%>/download/upload",
	        data: data,
	        processData: false,
	        contentType: false,
	        //cache: false,
	        //timeout: 600000,
	        xhr: function() { //XMLHttpRequest 재정의 가능
				var xhr = $.ajaxSettings.xhr();
				xhr.upload.onprogress = function(e) { //progress 이벤트 리스너 추가
					var percent = e.loaded * 100 / e.total;
					setProgress(percent);
				};
				return xhr;
			}, 
	        success: function (result) {
	        	
	        	$('#btnNoticeSave').prop('disabled', false);
	        	if(result.resultCode == -1){
	        		alert(result.resultMassage);
	        		return;
	        	}
	        	
	        	var postData = {
        			notice_chk : $("#notice_CHK").val(),
	        		notice_title : $("#noticeUpdateTitle").val(),
	        		notice_con : $("#noticeUpdateCon").val(),
	        		user_no : '${memberInfo.USER_NO}',
	        		notice_id : '${noticeMap.IDX}',
	        		// file_number : $("#updateFileNum").val()
	        		file_number : result.fileNumber
	        	};
	        	
	        	console.log(postData);
	        	
	       		$.ajax({
	       			type: "POST",
	       	   		url: "/user/noticeUpdate",
	       	   		async : false,
	       	   		data : postData,
	       	   		dataType : "JSON",
	       	   	 	success: function (resultMap) {
	       		        if (resultMap.resultCode != 0) {
	       		        	
	       			        alert("공지사항 수정 실패 : " + resultMap.resultMessage);
	       			        
	       			    } else if (resultMap.resultCode == 0) {
	       			    	
	       			    	var postData = {};
	       			    	<%-- opener.$("#noticeGrid").setGridParam({
	       			    		url:"<%=request.getContextPath()%>/user/noticeList", 
	       			    		postData : postData, 
	       			    		datatype:"json" 
	       			    		}).trigger("reloadGrid"); --%>
	       			    	// 부모창 새로 고침 
       			    		opener.parent.location.reload();
       			    		// 현재 팝업 새로 고침 
       			    		// window.location.href = "${getContextPath}/popup/faqDetail/" + '${noticeMap.IDX}'; 
	       			    	
	       			    	location.reload();
	       			    	alert("공지사항 수정 성공");
	       			    }
	       		    },
	       		    error: function (request, status, error) {
	       				alert("ERROR : " + error);
	       		    }
	       		}); 

	            setProgress(0 / 1);
	        	
	        },
	        error: function (e) {
	            $('#btnNoticeSave').prop('disabled', false);
	            alert("파일 업로드 실패하였습니다.");
	            setProgress(0 / 1);
	            return;
	        }
	        
	    });
	
	<%-- $.ajax({
   		type: "POST",
   		url: "/user/noticeUpdate",
   		async : false,
   		data : postData,
   		dataType : "JSON",
   	 	success: function (resultMap) {
	    	console.log(resultMap);
	        if (resultMap.resultCode != 0) {
	        	
		        alert("공지사항 수정 실패 : " + resultMap.resultMessage);
		        
		    } else if (resultMap.resultCode == 0) {
		    	
		    	var postData = {};
		    	opener.$("#noticeGrid").setGridParam({
		    		url:"<%=request.getContextPath()%>/user/noticeList", 
		    		postData : postData, 
		    		datatype:"json" 
		    		}).trigger("reloadGrid");
		    	
		    	location.reload();
		    	alert("공지사항 수정 성공");
		    	
		    	
		    }
	    },
	    error: function (error) {
			alert("ERROR : " + error);
	    }
   	}); --%>
});

$("#btnFileDownload").click(function(){
	var postData = {
		filename : $("#downloadFile").val(),
		realfilename : $("#downloadRealFile").val(),
    };
	
	$.ajax({
		type: "POST",
		url: "/download/file",
		async : false,
		data : postData,
	    cache: false,
	    xhrFields: {
	        responseType: "blob",
	    },
	    success: function (resultMap) {
	    	
	    },
	    error: function (request, status, error) {
			alert("ERROR : " + error);
	    }
	}).done(function (blob, status, xhr) {
        // check for a filename
        var fileName = "";
        var disposition = xhr.getResponseHeader("Content-Disposition");

        if (disposition && disposition.indexOf("attachment") !== -1) {
            var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
            var matches = filenameRegex.exec(disposition);

            if (matches != null && matches[1]) {
                fileName = decodeURI(matches[1].replace(/['"]/g, ""));
            }
        }

        // for IE
        if (window.navigator && window.navigator.msSaveOrOpenBlob) {
            window.navigator.msSaveOrOpenBlob(blob, fileName);
        } else {
            var URL = window.URL || window.webkitURL;
            var downloadUrl = URL.createObjectURL(blob);

            if (fileName) {
                var a = document.createElement("a");

                // for safari
                if (a.download === undefined) {
                    window.location.href = downloadUrl;
                } else {
                    a.href = downloadUrl;
                    a.download = fileName;
                    document.body.appendChild(a);
                    a.click();
                }
            } else {
                window.location.href = downloadUrl;
            }
        }
    }); 

});


$("#btnNoticeCancel").click(function(){
	
	$("#noticeTitle").show();
	$("#noticeUpdateTitle").prop("type", "hidden");
	$("#notice_CHK_tbl").css("display", "none");
	$(".notice_popup_content").css("height", "615px");
	
	$("#insertbtn").show();
	$("#save_btn").hide();
	
	$("#selectFile").show();
	$("#uploadFileForm").hide();
	
	$("#Content").show();
	$("#noticeUpdateCon").hide();
	
	$("#progressBar").hide();
	
});
	
// 공지사항 삭제
$("#btnNoticeDelete").click(function(){
	if(confirm("정말로 삭제하시겠습니까?")){
		var postData = {
				user_no : '${memberInfo.USER_NO}',
				notice_id : '${noticeMap.IDX}'
	    }
		
		$.ajax({
	   		type: "POST",
	   		url: "/user/noticeDelete",
	   		async : false,
	   		data : postData,
	   		dataType : "JSON",
	   		success: function (resultMap) {
		    	console.log(resultMap);
		        if (resultMap.resultCode != 0) {
			        alert("공지사항 삭제 실패 : " + resultMap.resultMessage);
			        
			    } else if (resultMap.resultCode == 0) {
			    	
			    	var postData = {};
			    	<%-- opener.$("#noticeGrid").setGridParam({
			    		url:"<%=request.getContextPath()%>/user/noticeList", 
			    		postData : postData, 
			    		datatype:"json" 
			    		}).trigger("reloadGrid"); --%>
		    		// 부모창 새로 고침 
		    		opener.parent.location.reload();
			    	alert("공지사항 삭제 성공");
			    	window.close();
			    }
		    },
		    error: function (error) {
				alert("ERROR : " + error);
		    }
	   	});
	}
	
});

var $progressBar = $("#progressBar");
function setProgress(per) {
	$progressBar.val(per);
}

function createFile(cellvalue, options, rowObject) {
	var rowID = options['rowId'];
	var checkboxID = "gridChk" + rowID;
	if (rowObject['FILE_CHK'] == "1"){
		return "<img href='#' src='<%=request.getContextPath()%>/resources/assets/images/file.png' />";
	}
	else { 
		return '';
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
