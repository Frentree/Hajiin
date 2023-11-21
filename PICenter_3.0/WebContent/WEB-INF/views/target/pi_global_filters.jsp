<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/xlsx.full.min.js"></script>
<style>
h4 {
	margin : 5px 0;
	font-size: 0.8vw;
}
#filtersGrid * *{
	overflow: hidden;
	white-space: nowrap; 
	text-overflow: ellipsis; 
}
.ui-jqgrid tr.ui-row-ltr td{
	cursor: pointer;
}
#insertfiltersTitle::placeholder{
	color: #9E9E9E;
}
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	.list_sch{
		top: 41px !important;
	}
}
</style>
	<section id="section">
		<div class="container">
			<h3>예외 관리</h3>
			<div class="content magin_t25">
				<table class="user_info" style="display: inline-table; width: 1000px;">
					<caption>예외 관리</caption>
					<tbody>
						<tr>
                            <th style="text-align: center; width:63px; border-radius: 0.25rem;">범위</th>
							<td style="width: 110px;">
								<p style="width: 70px; margin-bottom: 5px;">
								<select id="selectList" name="selectList" style="width: 100px;">
									<option value="" selected disabled>미 선택</option>
									<c:forEach items="${apServerList}" var="item" varStatus="status">
										<option value="${item.AP_NO}">${item.NETWORK}</option>
									</c:forEach>
								</select>
							</td>
                            <th style="text-align: center; width:63px; padding: 5px; border-radius: 0.25rem;">대상</th>
							<td style="width: 210px;">
								<p style="width: 100px; margin-bottom: 5px;">
								<input type="text" style="width: 200px; font-size: 12px; padding-left: 5px;" size="10" id="host_name" placeholder="대상을 입력하세요.">
							</td>
							<th style="text-align: center; width:63px; padding: 5px;">경로</th>
							<td>
								<p style="width: 100%; margin-bottom: 5px;">
								<input type="text" style="width: 94%; font-size: 12px; padding-left: 5px;" size="20" id="path" placeholder="경로를 입력하세요.">
								<input type="button" name="button" class="btn_look_approval" id="btnSearch" style="margin-top: 5px; margin-right: 5px;">
							</td>
						</tr>
					</tbody>
				</table>
				<div class="list_sch" style="margin-top: 24px;">
					<div class="sch_area">
						<button type="button" class="btn_down" id="filtersInsert" class="btn_new">예외 등록</button>
						<button type="button" class="btn_down" id="filtersAllInsert" class="btn_new">예외 일괄 등록</button>
						<!-- <button type="button" class="btn_down" id="btn_download_file" class="btn_new">파일 다운로드</button> -->
					</div>
                    	
                </div>
				<div class="left_box2" style="height: auto; min-height: 665px; overflow: hidden; width:59vw; margin-top: 10px;">
					<table id="filtersGrid"></table>
					<div id="filtersGridPager"></div>
				</div>
			</div>
		</div>
	</section>
	
	<!------------------ 예외 등록 및 수정 팝업 ------------------>
	<div id="filtersPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="width: 440px; height: 200px; padding: 10px; background: #f9f9f9; left: 55%; top: 60%;">
		<img class="CancleImg" id="btnCanclefiltersPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;" id="popUpName"></h1>
			</div>
			<div class="popup_content">
				<input type="hidden" id="popUpStatus" value="">
				<div class="content-box" style="background: #fff; width: 420px; border: 1px solid #c8ced3; overflow: auto;">
					<table class="user_info" style="width: 100%; border: none;">
						<tbody id="netPolicyBody">
							<tr>
								<th>
									범위
									<input type="hidden" id="updateApNo">
								</th>
								<td colspan="3" id="updateApNoList">
									<select id="selectInsertList" name="selectInsertList" style="width: 285px;">
										<option value="" selected disabled>미 선택</option>
										<c:forEach items="${apServerList}" var="item" varStatus="status">
											<option value="${item.AP_NO}">${item.NETWORK}</option>
										</c:forEach>
									</select>
								</td>
								<td colspan="3" id="updateApNoName"></td>
							</tr>
							<tr>
								<th>대상</th>
								<td colspan="2" id="selectedExcepServer"></td>
								<td class="btn_area" style="text-align: right;">
	                                <button type="button" id="btnGroupSerachPopup" style="margin-bottom: 0px;  width: 73px;">검색</button>
	                                <input type="hidden" id="insert_target_id" value=""> 
	                                <input type="hidden" id="update_filter_id" value=""> 
	                            </td>
							</tr>
							<tr>
								<th style="vertical-align: top;">경로</th>
								<td colspan="3" >
									<textarea rows="11" cols="40" id="inputExcepPath" style="width: 285px; white-space: pre; resize: none; color: #000"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div  class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" style="display: none;" id="btnfiltersSave">등록</button>
					<button type="button" style="display: none;" id="btnUpdateFilterPopupSave">등록</button>
					<button type="button" id="btnfiltersCancel">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!------------------ 예외 등록 및 수정 팝업 종료 ------------------>
	
	<!------------------ 예외 일괄 등록  팝업 ------------------>
	<div id="filtersAllPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="width: 1200px; height: 540px; padding: 10px; background: #f9f9f9; left: 33%; top: 51%;">
		<img class="CancleImg" id="btnCancleExcelPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">예외 일괄 등록</h1>
				<p style="position: absolute; top: 6px; left: 140px; font-size: 12px; color: #9E9E9E;">예외 등록은 최대 50개까지 가능합니다.</p>
				<p style="position: absolute; top: 19px; left: 140px; font-size: 12px; color: #9E9E9E;">PIMC에서 제공하는 형식이 아닌 다른 형식으로 업로드시 생성이 불가합니다.</p>
			</div>
			<div class="popup_content">
				<div class="content-box" style="background: #fff; width: 100%; height:457px; border: 1px solid #c8ced3; overflow: auto;">
					<table class="popup_tbl" style="width: 100%;">
						<colgroup>
							<col width="10%">
							<col width="90%">
						</colgroup>
						<tbody>
							<tr>
								<th>파일 다운로드</th>
								<td>
									<form id="btnDownLoadXlsx" action="<%=request.getContextPath()%>/download/downloadExcel" method="post" style="width: 49px; padding: 0px;">
										<input id="downloadFile" type="hidden" name="filename" value="PIMC_예외_관리.xlsx">
										<input id="downloadRealFile" type="hidden" name="realfilename" value="global_filters_ver1.xlsx">
										<input type="submit" id="btnExcelDown" value="다운로드"> 
									</form>
								</td>
							</tr>
						</tbody>
					</table>
					<table class="popup_tbl2" style="width: 100%;">
						<colgroup>
							<col width="10%">
							<col width="90%">
						</colgroup>
						<tbody >
							<tr>
								<th>
									파일 업로드
								</th>
								<td>
									<button type="button" id="clickimportBtn">파일선택</button>
									<input type="file" id="importExcel" name="importExcel" style="width: 955px; padding-left: 10px; display: none; ">
									<input type="text" id="importExcelNm" style="width: 925px; font-size: 12px; margin: 0 0 0 7px;" readonly="">
								</td>
							</tr>
						</tbody>
					</table>
					<div class="content-table" style="width: 100%; height: 340px; padding: 0;">
						<table class="popup_tbl" style="width: 100%;">
							<colgroup>
								<col width="2%">
								<col width="18%">
								<col width="20%">
								<col width="60%">
							</colgroup>
							<tbody id="import_filters_excel">
								<tr height="45px;" >
									<th></th>
									<th>범위</th>
									<th>대상</th>
									<th>경로</th>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="popup_btn">
				<div class="btn_area" style="padding: 10px 0; margin: 0;" id="filterBtn">
				</div>
			</div>
		</div>
	</div>
	<!------------------ 예외 일괄 등록 팝업 종료 ------------------>
	
	<!------------------ 예외 조회 팝업 ------------------>
	<div id="glovalFilterDetailPop" class="popup_layer" style="display:none">
		<div class="popup_box" style="width: 440px; height: 200px; padding: 10px; background: #f9f9f9; left: 55%; top: 60%;">
		<img class="CancleImg" id="btnCancleDetailFilterPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">예외 상세정보</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="background: #fff; width: 420px; border: 1px solid #c8ced3; overflow: auto;">
					<table class="user_info" style="width: 100%; border: none;">
						<tbody id="netPolicyBody">
							<tr>
								<th>대상</th>
								<td colspan="3" id="filter_id"></td>
							</tr>
							<tr>
								<th>범위</th>
								<td colspan="3" id="filter_range"></td>
							</tr>
							<tr>
								<th style="vertical-align: top;">경로</th>
								<td colspan="3" id="filter_path">
									<textarea rows="11" cols="40" id="filter_path_list" style="border:none; resize: none; color: #000" readonly="readonly">
									</textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" id="btnDetailFilterPopup" >닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!------------------ 예외 조회 팝업 종료 ------------------>

	<!-- 그룹 선택 버튼 클릭 팝업 -->
	<div id="taskGroupWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
		border-top: 2px solid #2f353a; box-shadow: 0 2px 5px #ddd; display:none">
		<ul>
			<li class="status">
				<button id="globalFilterShow">조회</button></li>
			<li class="status">
				<button id="globalFilterUpdate">수정</button></li>
			<li class="status">
				<button id="glbalFilterDelete">삭제</button></li>
			<li class="status">
				<button id="closeFilterPop">닫기</button></li>
		</ul>
	</div>
		<div id="popup_manageSchedule" class="popup_layer" style="display:none;">
		<div class="popup_box" id="popup_box" style="height: 60%; width: 60%; left: 40%; top: 33%; right: 40%; ">
		</div>
	</div>
	<%@ include file="../../include/footer.jsp"%>

<script type="text/javascript"> 

$(document).ready(function () {

	var gridWidth = $("#filtersGrid").parent().width();
	var gridHeight = 585;
	
	$(document).click(function(e){
		$("#taskGroupWindow").hide();
	});
	
	$("#filtersGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['filter_id', '대상', '타입', '경로', 'apply_to', '', 'status', 'network'],
		colModel: [      
			{ index: 'id', 				name: 'id',				width: 0, 	align: 'left', 		hidden:true},
			{ index: 'host_name', 		name: 'host_name',		width: 10, 	align: 'center'},
			{ index: 'type',			name: 'type',			width: 10, 	align: 'center'},
			{ index: 'expression', 		name: 'expression',		width: 75, 	align: 'left',	 	formatter:formatPath},
			{ index: 'apply_to', 		name: 'apply_to', 		width: 0, 	align: 'center', 	hidden:true},
			{ index: 'view', 			name: 'view', 			width: 5, 	align: 'center', 	formatter:createView, exportcol : false},
			{ index: 'status', 			name: 'status', 		width: 0, 	align: 'center', 	hidden:true},
			{ index: 'network', 		name: 'network', 		width: 2, 	align: 'center', 	hidden:true},
		],
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight,
		loadonce: true, // this is just for the demo
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 30, // 행번호 열의 너비	
		rowNum:25,
		rowList:[25,50,100],			
		pager: "#filtersGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	  	
	  	},
	  	ondblClickRow: function(nRowid, icol, cellcontent, e){
	  	},
	  	onCellSelect: function(rowid,icol,cellcontent,e) {
        	$("#pathWindow").hide();
            
            e.stopPropagation();
            var host_name = $(this).getCell(rowid, 'host_name');
            var expression = $(this).getCell(rowid, 'expression');
            var target_id = $(this).getCell(rowid, 'id');
        },
		loadComplete: function(data) {
			
			$(".gridSubSelBtn").on("click", function(e) {
		  		e.stopPropagation();
				$("#filtersGrid").setSelection(event.target.parentElement.parentElement.id);
		
				var offset = $(this).parent().offset();
				$("#taskGroupWindow").css("left", (offset.left - $("#taskGroupWindow").width()) + 55 + "px");
				$("#taskGroupWindow").css("top", offset.top + $(this).height() + "px");
		
				var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
				var taskBottom = Number($("#taskGroupWindow").css("top").replace("px","")) + $("#taskGroupWindow").height();
		
				if (taskBottom > bottomLimit) { 
					$("#taskGroupWindow").css("top", Number($("#taskGroupWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
				}
				$("#taskGroupWindow").show();
			});
		},
		gridComplete : function() {
		}
	});
	
	// 엔터 입력시 발생하는 이벤트
	// 대소문자 구분함
	$('#host_name, #path').keyup(function(e) {
		if (e.keyCode == 13) {
		    $("#btnSearch").click();
	    }        
	});
	
	// 대상 선택 팝업
	$('#btnGroupSerachPopup').on('click', function(){
		var popStatus = $("#popUpStatus").val();
		openPop(popStatus);
	});
	
	// 검색 조회
	$("#btnSearch").click(function(e){
		
		if( $("select[name='selectList']").val() == null){
			alert("범위가 선택 되지 않았습니다.");
			return;
		}
		
		var postData = {
				status : $("select[name='selectList']").val(),
				host_name : $("#host_name").val(),
				path : $("#path").val() };

		$("#filtersGrid").setGridParam({
			url:"<%=request.getContextPath()%>/excepter/glovalFilterDetail", 
			postData : postData, 
			datatype:"json" 
			}).trigger("reloadGrid");
	})
	
	// 등록 팝업
	$("#filtersInsert").click(function(e){
		$("#popUpName").html("예외 등록");
		$("#popUpStatus").val("insert");
		
		// 예외 수정 화면과 변경(저장 버튼)
		$("#btnUpdateFilterPopupSave").hide();
		$("#btnfiltersSave").show();
		
		// 예외 수정 화면과 변경(서버)
		$("#updateApNoName").hide();
		$("#updateApNoList").show();
		
		$("#filtersPopup").show();
	})
	
	// 일괄 등록 팝업
	$("#filtersAllInsert").click(function(e){
		$("#filtersAllPopup").show();
	})
});

function openPop(info){
	var apno = "";
	
	if(info == "insert"){
		apno = $("select[name='selectInsertList']").val();
	}else if(info == "update"){
		apno = $("#updateApNo").val();
	}
	
	if(apno == "" || apno == null){
		alert("범위가 선택 되지 않았습니다.");
		return;
	}
	
	var pop_url = "${getContextPath}/popup/filterUserList";
	
	var id = "filterUser"
	var winWidth = 700;
	var winHeight = 565;
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
	var pop = window.open(pop_url,id,popupOption);
	var newForm = document.createElement('form');
	newForm.method='POST';
	newForm.action=pop_url;
	newForm.name='newForm';
	newForm.target=id;
	
	var data = document.createElement('input');
	data.setAttribute('type','hidden');
	data.setAttribute('name','info');
	data.setAttribute('value',info);
	
	var ap_no = document.createElement('input');
	ap_no.setAttribute('type','hidden');
	ap_no.setAttribute('name','apno');
	ap_no.setAttribute('id','apno');
	ap_no.setAttribute('value',apno);
	
	newForm.appendChild(data);
	newForm.appendChild(ap_no);
	
	document.body.appendChild(newForm);
	newForm.submit();
	
	document.body.removeChild(newForm);
}


// 예외 등록
$("#btnfiltersSave").on("click", function(e) {
    fnSaveExceptionRegist();
});

// 예외 수정
$("#btnUpdateFilterPopupSave").on("click", function(e) {
	fnUpdateExceptionRegist();
});

$("#btnfiltersCancel").click(function(){
	$("#filtersPopup").hide();
	clearText();
});

// 조회 버튼 클릭
$("#globalFilterShow").click(function(){
	
	var row = $("#filtersGrid").getGridParam("selrow");
	
	var host_name = $("#filtersGrid").getCell(row, "host_name");
	var expression = $("#filtersGrid").getCell(row, "expression");
	var status = $("#filtersGrid").getCell(row, "status");
	var network = $("#filtersGrid").getCell(row, "network");
	
	$("#filter_id").html(host_name);
	$("#filter_range").html(network);
	var path = expression.replaceAll(", ", "\n");
	$("#filter_path_list").val(path);
	
	$("#popUpStatus").val('insert');
	$("#glovalFilterDetailPop").show();
});

// 수정 버튼 클릭
$("#globalFilterUpdate").click(function(){
	
	var row = $("#filtersGrid").getGridParam("selrow");
	
	var filter_id = $("#filtersGrid").getCell(row, "id");
	var host_name = $("#filtersGrid").getCell(row, "host_name");
	var expression = $("#filtersGrid").getCell(row, "expression");
	var status = $("#filtersGrid").getCell(row, "status");
	var apply_to = $("#filtersGrid").getCell(row, "apply_to");
	var network = $("#filtersGrid").getCell(row, "network");
	
	$("#popUpName").html("예외 수정")
	
	// $("#selectInsertList").val(status).prop("selected", true);
	// 수정은 서버 변경 불가
	$("#updateApNo").val(status)
	$("#updateApNoList").hide();
	
	$("#updateApNoName").html(network)
	$("#updateApNoName").show();
	
	$("#selectedExcepServer").html(host_name);
	$("#insert_target_id").val(apply_to);
	$("#update_filter_id").val(filter_id);
	
	$("#btnfiltersSave").hide();
	$("#btnUpdateFilterPopupSave").show();
	
	var path = expression.replaceAll(", ", "\n");
	$("#inputExcepPath").val(path);
	
	$("#popUpStatus").val('update');
	$("#filtersPopup").show();
});

$("#btnCancleUpdateFilterPopup").click(function(){
	$("#glovalFilterUpdatePop").hide();
});
$("#btnUpdateFilterPopup").click(function(){
	$("#glovalFilterUpdatePop").hide();
});


$("#btnCancleDetailFilterPopup").click(function(){
	$("#glovalFilterDetailPop").hide();
});
$("#btnDetailFilterPopup").click(function(){
	$("#glovalFilterDetailPop").hide();
});

$("#closeFilterPop").click(function(){
	$("#taskGroupWindow").hide();
});

$("#btnCanclefiltersPopup").click(function(){
	$("#filtersPopup").hide();
	clearText();
});

$("#btnCancleDetailfiltersPopup").click(function(){
	$("#filterDetailPopup").hide();
});

$("#btnCancleExcelPopup").click(function(){
	setNewSetting2();
});

$("#glbalFilterDelete").click(function(){
	
	var result = confirm("해당 예외를 삭제하시겠습니까?");
	
	var row = $("#filtersGrid").getGridParam("selrow");
	var id = $("#filtersGrid").getCell(row, "id");
	var status = $("#filtersGrid").getCell(row, "status");
	
	if(result){
		var oPostDt = {};
	    oPostDt["id"] = id;
	    oPostDt["status"] = status;
		
	    console.log(oPostDt);
	    
		$.ajax({
			type: "POST",
			url: "${getContextPath}/excepter/deleteGlovalFilterDetail",
			async : false,
			data : oPostDt,
			datatype: "json",
			success: function (result) {
				console.log(result);
				
				if(result.resultCode == 0){
			    	alert("경로 예외 삭제가 완료되었습니다.");
				}else{
					alert("경로 예외 삭제가 실패되었습니다.");
					console.log(result.resultMessage);
				} 
				
				$("#filtersPopup").hide();
				clearText();
				var postData = {};
				$("#filtersGrid").setGridParam({
					url:"<%=request.getContextPath()%>/excepter/glovalFilterDetail", 
					postData : postData, 
					datatype:"json" 
					}).trigger("reloadGrid");
				}
		});
	}
	
});

function fnSaveExceptionRegist() 
{
	var pathList = "";
	var path = $("#inputExcepPath").val();
	if(!isNull(path)) path = path.split("\n");
	
	if($("#selectedExcepServer").html() == null || $("#selectedExcepServer").html() == "" ){
		alert("적용 대상을 선택하세요.");
		return;
	}; 
	
	if( $("select[name='selectInsertList']").val() == null){
		alert("범위가 선택 되지 않았습니다.");
		return;
	}
	
	// 입력된 예외경로 없을시 진행 불가
	if (isNull(path)) {
		alert("예외처리 경로를 입력하세요");
		$("#inputExcepPath").focus();
		return false;
	}
	
	for(i=0 ; i < path.length ; i++){
		if(i == path.length -1){
			pathList += path[i];
		}else{
			pathList += path[i] + "|";
		}
	}
	
	var result = confirm("해당 예외를 등록하시겠습니까?");
	
	if(result){
		var oPostDt = {};
	    oPostDt["status"] = $("select[name='selectInsertList']").val();
	    oPostDt["path_ex"] = pathList;
	    oPostDt["target_id"] = $("#insert_target_id").val();
		
	 	$.ajax({
			type: "POST",
			url: "${getContextPath}/excepter/insertGlovalFilterDetail",
			async : false,
			data : oPostDt,
			datatype: "json",
			success: function (result) {
				console.log(result);
				
				if(result.resultCode == 0){
			    	alert("경로 예외가 완료되었습니다.");
				}else{
					alert("경로 예외가 실패되었습니다.");
					console.log(result.resultMessage);
				} 
				
				$("#filtersPopup").hide();
				clearText();
				
				console.log($("select[name='selectList']").val());
				
				if($("select[name='selectList']").val() != "" && $("select[name='selectList']").val() != null){
					var postData = {status : $("select[name='selectList']").val()};
					$("#filtersGrid").setGridParam({
						url:"<%=request.getContextPath()%>/excepter/glovalFilterDetail", 
						postData : postData, 
						datatype:"json" 
					}).trigger("reloadGrid");
				}
				
			}
		});  
	}
	
	
}

$("#clickimportBtn").click(function(){
	$("#importExcel").click();
});

$("#importExcel").change(function(){
	var checkFileNm = $("#importExcel").val();
	var filelength = checkFileNm.lastIndexOf('\\');
	var fileNm = checkFileNm.substring(filelength+1, checkFileNm.length);
	var resulList = [];
	var CNT = 0;
	let input = event.target;
    let reader = new FileReader();
    reader.onload = function () {
        let data = reader.result;
        let workBook = XLSX.read(data, { type: 'binary' });
        /* workBook.SheetNames.forEach(function (sheetName) { */
            let rows = XLSX.utils.sheet_to_json(workBook.Sheets["예외 등록"]);
            var details = "";
            var expUrl = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
            var excel_length = 0;
            if(rows < 1){
            	alert("올바른 시트가 존재하지 않습니다. 확인 후 다시 시도해 주세요.");
            	return;
            }
      
            
            var total_data = rows.length;
	    	
	    	details += "<tr height=\"45px;\" >";
	    	details +=  "<th></th>";
	    	details +=  "<th>범위</th>";
	    	details +=	"<th>대상</th>";
	    	details +=	"<th>경로</th>";
	    	details += "</tr>";
	    	
	    	if(
	    			rows[0].hasOwnProperty('범위')	
    			 &&	rows[0].hasOwnProperty('대상')	
	    		 &&	rows[0].hasOwnProperty('경로') 		
	    	){
	    		$.each(rows, function(index, item) {
	    			++CNT
	    			if(CNT > 1 && CNT < 52) {
	    				var ap_nm = item.범위;
						var target_id = item.대상;
						var path = item.경로;
						var num = CNT-1;
						
						details += "<tr style=\"height: 45px;\">";
						details += "	<td style=\"text-align: center; padding-left: 0;\">"+num+"</td>";
						details += "	<td style=\"text-align: center; padding-left: 0;\">"+ap_nm+"</td>";
						details += "	<td style=\"text-align: center; padding-left: 0;\">"+target_id+"</td>";
						details += "	<td style=\"text-align: left; padding-left: 0;\">"+path.replaceAll('|', ', ')+"</td>";
						details += "</tr>";
						
						var type; 
						
						resulList.push({"ap_nm" : ap_nm, "target_id" : target_id, "path" : path})
	    			}else if(CNT == 52){
	    				alert("예외 등록은 최대 50개까지 가능합니다.");
	    				return true;
	    			}
				});
	    		
	    		
		    	var btnCss ="<button type=\"button\" id=\"btnNewPopupExcelSave\" style=\"margin-right: 5px\" >저장</button>";
					btnCss +="<button type=\"button\" id=\"btnNewPopupExcelCencel\" >취소</button>";
				$("#filterBtn").html(btnCss)
				
				$("#btnNewPopupExcelCencel").click(function(e){
					$("#importExcel").val("");
					$("#importExcelNm").val("");
					
					var details = "";
					$("#filterBtn").html(details); 
					$("#import_filters_excel").html(details);
					$("#filtersAllPopup").hide();
	        	});
				
				$('#btnNewPopupExcelSave').on('click', function(){
					
	            	var msg = confirm("예외를 등록 하시겠습니까?");
	            	
	            	if(msg){
	            		$.ajax({
	        				type: "POST",
	        				url: "/search/insertGlobalFilter",
	        				//async : false,
	        				data : {
	        					"resulList": JSON.stringify(resulList)
	        				},
	        			    success: function (resultMap) {
	        			    	console.log(resultMap);
	        			    	
	        			    	var postData = null;
	        		        	$("#netGrid").setGridParam({
	        			    		url:"<%=request.getContextPath()%>/search/netList",
	        			    		postData : postData, 
	        			    		datatype:"json" 
	        		    		}).trigger("reloadGrid");
	        			    },
	        			    error: function (request, status, error) {
	        			    	alert("서버 저장이 실패하였습니다.");
	        			        console.log("ERROR : ", error);
	        			        treeArr = [];
	        	    	    	groupArr = [];
	        			    }
	        			});
	            	}
            	});
	    		
	    	}else {
	    		alert("올바른 형식의 엑셀이 아닙니다. 확인 후 다시 시도해 주세요.");
	    		return;
	    	}
	    	
	    	 $("#import_filters_excel").html(details);
	         $("#importExcelNm").val(fileNm);
	    	
       /*  }) */
    };
    reader.readAsBinaryString(input.files[0]);
});

function fnUpdateExceptionRegist() 
{
	var pathList = "";
	var path = $("#inputExcepPath").val();
	if(!isNull(path)) path = path.split("\n");
	
	if($("#selectedExcepServer").html() == null || $("#selectedExcepServer").html() == "" ){
		alert("적용 대상을 선택하세요.");
		return;
	}else if($("#selectedExcepServer").html() == "삭제된 대상"){
		alert("대상을 확인 할 수 없습니다.");
		return;
	};

	  
	// 입력된 예외경로 없을시 진행 불가
	if (isNull(path)) {
		alert("예외처리 경로를 입력하세요");
		$("#inputExcepPath").focus();
		return false;
	}
	
	for(i=0 ; i < path.length ; i++){
		if(i == path.length -1){
			pathList += path[i];
		}else{
			pathList += path[i] + "|";
		}
	}
	
	var oPostDt = {};
    oPostDt["filter_id"] = $("#update_filter_id").val();
    oPostDt["path_ex"] = pathList;
    oPostDt["target_id"] = $("#insert_target_id").val();
    oPostDt["status"] = $("#updateApNo").val();
    
    console.log(oPostDt);
	
 	$.ajax({
		type: "POST",
		url: "${getContextPath}/excepter/updateGlovalFilterDetail",
		async : false,
		data : oPostDt,
		datatype: "json",
		success: function (result) {
			
			if(result.resultCode == 0){
		    	alert("경로 예외가 완료되었습니다.");
			}else{
				alert("경로 예외가 실패되었습니다.");
				console.log(result.resultMessage);
			} 
			$("#filtersPopup").hide();
			
			var postData = {};
			$("#filtersGrid").setGridParam({
				url:"<%=request.getContextPath()%>/excepter/glovalFilterDetail", 
				postData : postData, 
				datatype:"json" 
				}).trigger("reloadGrid");
		}
	});  
	
}


function fnLocationAdd(element, e) 
{
    if (e.keyCode != 13) return;
    if (isNull($(element).val())) return;;

    var excepPath = $(element).val();
    var sTag = "";

    sTag += "<tr style='border:none;'>";
    sTag += "    <th style='padding:2px; background: transparent; overflow:hidden; text-align:left;'>" + excepPath + "</th>";
    sTag += "    <td style='padding:0px; background: transparent; height:23px; width:30px;'>";
    sTag += "        <input type='button' value='X' name='button' style='color:#ba1919; border:0 none; background-color:transparent; cursor:pointer; float:center; height:23px;' onclick='fnLocationRemove(this);'>";
    sTag += "    </td>";
    sTag += "</tr>";

    $("#excepPath").append(sTag);
    $(element).val("");
}

function fnLocationRemove(element) 
{
    var excepPathRmv = $(element).parent("td").parent("tr")[0];
    $(excepPathRmv).remove();
}

function clearText(){
	
	// 범위
	$("#selectInsertList").val("").prop("selected", true);
	
	// 대상
	$("#selectedExcepServer").html("");
	$("#insert_target_id").val("");
	
	// 경로
	$("#inputExcepPath").val("");
	
};

var formatType = function(cellvalue, options, rowObject) {
	var status = cellvalue;

	if(cellvalue == "GROUP"){
		status = '그룹';
	}else if(cellvalue == "TARGET"){
		status = '서버';
	}else if(status == "ALL"){
		status = '전체';
	}
	
	return status; 
};

var createView = function(cellvalue, options, rowObject) {
	result = "<button type='button' style='padding-top: 4px; padding-bottom:4px;' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>";
	return result; 
};
var formatPath = function(cellvalue, options, rowObject) {
	return cellvalue.replaceAll("|", ", ");
};

function setNewSetting2() {
	
	$("#importExcel").val("");
	$("#importExcelNm").val("");
	
	var details = "";
	$("#filterBtn").html(details);
	$("#import_filters_excel").html(details);
	$("#filtersAllPopup").hide();
	
};
</script>
</body>

</html>