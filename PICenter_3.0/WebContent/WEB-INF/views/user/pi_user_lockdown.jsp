<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<style>

@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	.popup_tbl td input {
		width: 200px !important;
	}
	.popup_tbl td input[type="date"]{
		width: 160px !important;
	}
}
</style>
		<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>타겟 관리</h3>
					<p class="location">사용자 관리 > 사용자 관리</p>
				</div>
			</div>
		</div>
		<!-- 업무타이틀(location)-->

		<!-- section -->
		<section>
			<!-- container -->
		<div class="container">
		<h3>사용자 현황</h3>
		<p style="position: absolute; top: 33px; left: 172px; font-size: 14px; color: #9E9E9E;">장기(3개월) 미사용으로 계정이 잠긴 사용자 화면입니다. </p>
		<%-- <%@ include file="../../include/menu.jsp"%> --%>
			<!-- content -->
			<div class="content magin_t25">
				<div class="grid_top">
					<!-- user info -->
					<table class="user_info narrowTable" style="width: 45%; display: inline-block;">
	                    <caption>사용자정보</caption>
	                    <tbody>
	                        <tr>
	                            <th style="text-align: center; border-radius: 0.25rem;">신청 여부</th>
	                            <td style="width:250px">
	                            	<select id="sch_aut" name="sch_aut" style="width:186px; font-size: 14px; padding-left: 5px;">
	                                	<option value="" selected>전체</option>
	                                    <option value="0" >미신청</option>
	                                    <option value="1" >사용자 신청</option>
	                                    <option value="2" >담당자 신청</option>
									</select>
	                            </td>
	                            <th style="text-align: center;">사용자 ID</th>
	                            <td style="width:250px;">
	                                <input type="text" style="width: 186px; padding-left: 5px;" size="10" id="sch_id" placeholder="사용자ID를 입력하세요.">
	                            </td>
	                           	<td rowspan="3" style="width: 51px;">
	                           		<input type="button" name="button" class="btn_look_approval" id="sch_search">
	                           	</td>
	                        </tr>
	                        <tr>
	                        	<th style="text-align: center;">사용자명</th>
	                            <td style="width:250px;">
	                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="sch_userName" placeholder="사용자명을 입력하세요.">
	                            </td>
	                            <th style="text-align: center;">팀명</th>
	                            <td>
	                            	<input type="text" style="width: 186px; padding-left: 5px;" size="20" id="sch_teamName" placeholder="팀명을 입력하세요.">
	                            </td>
	                        </tr>
	                    </tbody>
                	</table>
					<!-- list -->
					<div class="grid_top" style="margin-top: 10px;">
						<table style="width: 100%;">
							<caption>검출 리스트</caption>
							<colgroup>
								<col width="*"/>
								<col width="500px"/>
							</colgroup>
							<tr>
								<!-- <td><h3 style="padding: 0;">사용자 현황</h3></td> -->
								<td style="text-align: right; padding: 0px;">
								<c:if test="${memberInfo.USER_GRADE == '9'}">
									<!-- <button class="btn_new" type="button" id="btnDateTime" style="padding: 0 10px; margin: 0px;">계정기간 설정</button> -->
									<button class="btn_down" type="button" id="btnTeamCreate" style="padding: 0 10px; margin: 0px;"> 팀 추가 </button>
									<!-- <button class="btn_new" type="button" id="btnManagerRegist" style="padding: 0 10px; margin: 0px;"> 결재자 등록 </button> -->
									<button class="btn_down" type="button" id="btnAccountCreate" style="padding: 0 10px; margin: 0px;"> 사용자 등록 </button>
								</c:if>
								</td>
							</tr>
						</table>

						<div class="left_box2" style="overflow: hidden; max-height: 555px; height: 555px; margin-top: 10px;">
		   					<table id="userGrid"></table>
		   					<div id="userGridPager"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
			<!-- container -->
		</section>
		<!-- section -->
	<%@ include file="../../include/footer.jsp"%>

<!-- <div id="taskGroupWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
	border-top: 2px solid #2f353a; box-shadow: 0 2px 5px #ddd; display:none">
	<ul>
		<li class="status" id="btnMemberLock" style="display: none">
			<button >잠금 해제</button></li>
		<li class="status" id="btnAccountPopClose" >
			<button >닫기</button></li>
	</ul>
</div> -->
<div id="memberLockPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 382px; width: 485px; left: 52%; padding: 10px; background: #f9f9f9;">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">사용자 잠김 해제</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 248px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="25%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>사용자 ID</th>
							<td><input type="text" id="lockMemberNo" value="" class="edt_sch" style="width: 300px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly></td>
						</tr>
						<tr>
						<th>사용자명</th>
							<td><input type="text" id="lockMemberNm" value="" class="edt_sch" style="width: 300px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly></td>
						</tr>
						<tr>
							<th>담당자</th>
							<td><input type="text" id="LockMemberManager" value="" class="edt_sch" style="width: 233px; padding-left: 10px;" readonly>
								
								<button type="button" id="lockMemberbtn" style="width: 63px">선택</button></td>
						</tr>
						<tr>
							<th>사유</th>
							<td>
								<textarea id="lockMemberReson" rows="4" cols="44" style="resize: none; margin-top: 7px;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnMemberLock">신청</button>
				<button type="button" id="btnAccountPopClose">취소</button>
			</div>
		</div>
	</div>
</div>




<script type="text/javascript">

console.log("${memberInfo}");

var USER_PHONE = null;

$(document).ready(function () {
	
	$(document).click(function(e){
		$("#taskGroupWindow").hide();
	});	
	
	$("#lockMemberbtn").click(function() {
		userListWindows("lockMember");
	});

	$("#jikweeSelect").select2({
		width: 196
	});
	$("#teamSelect").select2({
		width: 196
	});

	var gridWidth = $("#userGrid").parent().width();
	var gridHeight = 465;
	$("#userGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
			colNames:['사용자 ID', '사용자명', '이메일', '전화번호', '직급', '팀명', '등록일자', '계정시작일', '계정만료일', '마지막사용일' ,'관리자', '관리자', '계정잠김',  '해제 신청', '계정 잠금 신청'],
			colModel:[ 
			{ index: 'USER_NO', 			name: 'USER_NO', 			width: 120,	align: 'center'},
			{ index: 'USER_NAME',			name: 'USER_NAME',			width: 200, align: 'center'},
			{ index: 'USER_EMAIL',			name: 'USER_EMAIL', 		width: 200, align: 'center'},
			{ index: 'USER_PHONE',			name: 'USER_PHONE', 		width: 200, align: 'center'},
			{ index: 'JIKGUK',				name: 'JIKGUK',				width: 120, align: 'center'},
			{ index: 'TEAM_NAME',			name: 'TEAM_NAME',			width: 200, align: 'center'},
			{ index: 'REGDATE',				name: 'REGDATE', 			width: 200, align: 'center'},
			{ index: 'STARTDATE',			name: 'STARTDATE', 			width: 200, align: 'center'},
			{ index: 'ENDDATE',				name: 'ENDDATE', 			width: 200, align: 'center'},
			{ index: 'LOGINDATE',			name: 'LOGINDATE', 			width: 200, align: 'center'},
			{ index: 'USER_GRADE',			name: 'USER_GRADE', 		width: 200, align: 'center', hidden: true},
			{ index: 'OLD_USER_GRADE',		name: 'OLD_USER_GRADE', 	width: 200, align: 'center', hidden: true},
			{ index: 'LOCK_ACCOUNT',		name: 'LOCK_ACCOUNT', 		width: 200, align: 'center', hidden: true},
			{ index: 'MEMBER_STATUS',		name: 'MEMBER_STATUS', 		width: 200, align: 'center', formatter:createView},
			{ index: 'LOCK_STATUS',			name: 'LOCK_STATUS', 		width: 200, align: 'center', hidden: true},
		],
		width: gridWidth,
		height: gridHeight,
		loadonce: true, // this is just for the demo
		viewrecords: true, // show the current page, data rang and total records on the toolbar
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 50, // 행번호 열의 너비	
		rowNum:100,
	   	rowList:[10,50,100],
	    search: true,			
		pager: "#userGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	  		
	  	},
	  	afterEditCell: function(rowid, cellname, value, iRow, iCol){
            //I use cellname, but possibly you need to apply it for each checkbox       
			if (cellname == 'USER_GRADE'){
			    $("#userGrid").saveCell(iRow,iCol);
			}
		},
		onCellSelect: function(rowid,icol,cellcontent,e) {
			if (icol == 0) return;
			
			if(icol == 14){
	    		$("#memberLockPopup").hide();
	    		return;
	    	}
			var LOCK_STATUS = $(this).getCell(rowid, 'LOCK_STATUS');
			
		}, 
		loadComplete: function(data) {
			$(".gridSubSelBtn").on("click", function(e) {
				
		  		e.stopPropagation();
				
				$("#userGrid").setSelection(event.target.parentElement.parentElement.id);
				
				/* var row = $("#userGrid").getGridParam("selrow");
				var user_no = $("#userGrid").getCell(row, "USER_NO");
				var lock_status = $("#userGrid").getCell(row, "LOCK_STATUS");

				$(".manage-schedule").css("display", "block");

				var offset = $(this).parent().offset();
				$("#taskGroupWindow").css("left", (offset.left - $("#taskGroupWindow").width()) + 17 + "px");
				// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
				$("#taskGroupWindow").css("top", offset.top + $(this).height() + "px");

				var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
				var taskBottom = Number($("#taskGroupWindow").css("top").replace("px","")) + $("#taskGroupWindow").height();

				if (taskBottom > bottomLimit) { 
					$("#taskGroupWindow").css("top", Number($("#taskGroupWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
				}
				
				if(lock_status != 0){
					$("#btnMemberLock").show();
				}else{
					$("#btnMemberLock").hide();
				} */
				
				var row = $("#userGrid").getGridParam("selrow");
				var user_no = $("#userGrid").getCell(row, "USER_NO");
				var user_name = $("#userGrid").getCell(row, "USER_NAME");
				
				$("#lockMemberNo").val(user_no);
				$("#lockMemberNm").val(user_name);
				
				$("#memberLockPopup").show();
				
			});
	    },
	    gridComplete : function() {
	    }
	}).filterToolbar({
		  autosearch: true,
		  stringResult: true,
		  searchOnEnter: true,
		  defaultSearch: "cn"
	});

	var postData = {
		userNo : $("#userNo").val(),
		userName : $("#userName").val(),
		fromDate : $("#date1").val(),
		toDate : $("#date2").val() 
	};
	$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/selectLockManagerList", postData : postData, datatype:"json" }).trigger("reloadGrid");

	$("#btnChangePwd").on("click", function(e) {
		$("#oldPasswd").val("");
		$("#newPasswd").val("");
		$("#newPasswd2").val("");
		
		$("#passwordChangePopup").show();
	});

});

$("#sch_id").keyup(function(e){
    if (e.keyCode == 13) {
    	fnc_search();
    }
});

$("#sch_userName").keyup(function(e){
    if (e.keyCode == 13) {
    	fnc_search();
    }
});

$("#sch_teamName").keyup(function(e){
    if (e.keyCode == 13) {
    	fnc_search();
    }
});
$('#sch_search').on('click', function(){
	fnc_search();
});

function fnc_search(){
	var postData = {
		sch_aut: $("select[name='sch_aut']").val(),
		sch_id: $('#sch_id').val(),
		sch_userName: $('#sch_userName').val(),
		sch_teamName: $('#sch_teamName').val(),
	}
	
	console.log(postData);
	
	$("#memberLockPopup").hide();
	$("#userGrid").setGridParam({url:"/user/selectLockManagerList", postData : postData, datatype:"json" }).trigger("reloadGrid");
}

var isRunning = false;

var createView = function(cellvalue, options, rowObject) {

	var lock_status = rowObject.LOCK_STATUS;
	
	if(lock_status == 1){
		return "<button type='button' class='gridSubSelBtn' name='gridSubSelBtn' >해제</button>"; 
	}else if(lock_status == 2){
		return  "진행중";
	}else{
		return  "";
	}
	
};

function userListWindows(info){
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

$("#btnMemberLock").click(function(){
	
	var row = $("#userGrid").getGridParam("selrow");
	var user_no = $("#userGrid").getCell(row, "USER_NO");
	var unlock_reson = $("#lockMemberReson").val();
	
	$("#memberLockPopup").show();
	
	 var delChk = confirm("'"+user_no + "' 사용자 잠금 해제 신청 하시겠습니까?");
	
	var postData = {
			user_no : user_no,
			unlock_reson : unlock_reson,
			lock_staus : 2
		};
	
	 if(delChk){
		$.ajax({
			type: "POST",
			url: "/unlockMemberRequestManager",
			async : false,
			data : postData,
		    success: function (resultMap) {
				if(resultMap.resultCode == 0){
					alert("'" + user_no + "'" +resultMap.resultMessage);
					$("#lockMemberReson").val("");
					$("#memberLockPopup").hide();
					$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/selectLockManagerList", postData : postData, datatype:"json" }).trigger("reloadGrid");
				}else{
					alert("사용자 잠금 해제 신청 실패 : ");
				}
		    },
		    error: function (request, status, error) {
				alert("사용자 잠금 해제 실패 신청 : " + error);
		        console.log("사용자 잠금 해제 신청 실패 : ", error);
		    }
		}); 
	} 
	
});
$("#btnAccountPopClose").click(function(){
	$("#lockMemberReson").val("");
	$("#memberLockPopup").hide();
});

</script>
	
</body>
</html>