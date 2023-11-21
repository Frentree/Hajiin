<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>
<style>
.user_info th {
	width: 26%;
}
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	.sch_area{
		top: 0px !important;
		left: 5px !important;
	}
	.list_sch{
		right: 1px !important;
		top: -34px !important;
	}
	#rangeNm, #policyNm, #updateRangeNm, #updatePolicyNm{
		width: 174px !important;
	}
}
</style>

<section>
	<!-- container -->
	<div class="container">
		<%-- <%@ include file="../../include/menu.jsp"%> --%>
		<h3>PC 정책</h3>
		<!-- content -->
		<div class="content magin_t25">
			<table class="user_info" style="display: inline-table; width: 510px;">
				<tbody>
					<tr>
						<th style="text-align: center; width:60px; border-radius: 0.25rem;">정책 명</th>
						<td style="width:351px;">
							<p style="margin-bottom: 5px;"><input type="text" id="searchKey" style="font-size: 13px; line-height: 2; padding-left: 5px; width: 100%;" placeholder="정책명을 입력하세요."/></p>
							<input type="button" name="button" class="btn_look" id="btnSearch" style="margin-top: -27px; margin-right: 5px;">
			            </td>
			        </tr>
			    </tbody>
			</table>
			<div class="list_sch" style="margin-top: 24px;">
				<div class="sch_area" style="margin-bottom: 10px;">
					<button type="button" class="btn_down" id="btn_new" class="btn_new">신규정책 생성</button>
				</div>
			</div>
			<div class="grid_top" style="height: 100%; width: 100%; padding-top:10px;">
				<div class="left_box2" style="height: 94%; max-height: 700px; overflow: hidden;">
   					<table id="topNGrid"></table>
   				 	<div id="topNGridPager"></div>
   				</div>
			</div>
			
		</div>
	</div>
	
	<div id="newNetPolicyPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="width: 455px; height: 200px; padding: 10px; background: #f9f9f9; left: 54%; top: 55%;">
		<img class="CancleImg" id="btnCancleNewNetPolicyPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">신규정책 생성</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="background: #fff; width: 455px; height: 350px; border: 1px solid #c8ced3; overflow: auto;">
					<table class="user_info" style="width: 100%; border: none;">
						<caption>신규 스캔</caption>
						<tbody id="policyBody">
							<tr>
								<th>적용</th>
								<td>
									<input type="radio" name="policyRange" value="0" checked="checked"> 네트워크
									<input type="radio" name="policyRange" value="1"> 그룹
									<input type="radio" name="policyRange" value="2"> PC
									<input type="radio" name="policyRange" value="3"> OneDrive
								</td>
							</tr>
							<tr>
								<th>범위</th>
								<td colspan="3">
									<input type="text" id="rangeNm" value="" readonly="readonly" placeholder="범위가 선택되지 않았습니다" style="padding-left: 5px;"> 
									<button type="button" id="btnRangChoice" class="btn_down">선택</button>
									<input type="hidden" id="rangeId" value=""> 
									<input type="hidden" id="targetId" value=""> 
									<input type="hidden" id="rangeOneDriveNm" value=""> 
									<input type="hidden" id="rangeType" value=""> 
								</td>
							</tr>
							<tr>
								<th>검색정책</th>
								<td colspan="3">
									<input type="text" id="policyNm" value=""  readonly="readonly" placeholder="정책이 선택되지 않았습니다" style="padding-left: 5px;">  
									<button type="button" id="btnPoilcyChoice" class="btn_down">선택</button>
									<input type="hidden" id="policyId" value=""> 
								</td>
							</tr>
							<tr id="scanDay_tbl">
								<th>검색요일</th>
								<td>
									<div id="scanDay" style="display: inline;">
										<input type="radio" id="scanEvery" name="scanDay" value="9"> 매일
										<input type="radio" name="scanDay" value="1"> 월
										<input type="radio" name="scanDay" value="2"> 화
										<input type="radio" name="scanDay" value="3"> 수
										<input type="radio" name="scanDay" value="4"> 목
										<input type="radio" name="scanDay" value="5"> 금
										<input type="radio" name="scanDay" value="6"> 토
										<input type="radio" name="scanDay" value="7"> 일
									</div>
								</td>
							</tr>
							<tr>
								<th>스캔트레이스로그</th>
								<td>
									<input type="checkbox" name="btnTrace" id="btnTrace" value="Y">
									<!-- <div id="traceDay" style="display: inline;">
										<input type="radio" id="traceEvery" name="traceDay" value="9"> 매일
										<input type="radio" name="traceDay" value="1"> 월
										<input type="radio" name="traceDay" value="2"> 화
										<input type="radio" name="traceDay" value="3"> 수
										<input type="radio" name="traceDay" value="4"> 목
										<input type="radio" name="traceDay" value="5"> 금
									</div> -->
								</td>
							</tr>
							<tr id="drm_CHK">
								<th>DRM</th>
								<td>
									<input type="checkbox" name="btnDRM" id="btnDRM" value="S">
									<input type="hidden" name="btnDRM" id="btnDRM_Hidden" value="C">
								</td>
							</tr>
							<tr id="time_Chk">
								<th>검색실행시간</th>
								<td colspan="3">
									<button type="button" id="btnTimeCreate" class="btn_down">추가</button>
									<button type="button" id="btnTimeRemove" class="btn_down">제거</button>
									<input type="hidden" value="1" id="policyTime">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div id="acesssBtn" class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" id="btnNewPopupSave" >저장</button> <!-- 네트워크, 그룹, pc -->
					<button type="button" id="btnNewPopupSave2" >저장</button> <!-- OneDrive -->
					<button type="button" id="btnNewPopupCencel" >취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="netPolicyPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="width: 455px; height: 200px; padding: 10px; background: #f9f9f9; left: 54%; top: 55%;">
		<img class="CancleImg" id="btnCancleNetPolicyPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">PC정책 상세정보</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="background: #fff; width: 455px; height: 325px; border: 1px solid #c8ced3; overflow: auto;">
					<table class="user_info" style="width: 100%; border: none;">
						<caption>신규 스캔</caption>
						<tbody id="netPolicyBody">
							<tr>
								<th>적용</th>
								<td id="netChk">
									<input type="radio" name="netPolicyRange" value="0" checked="checked"> 네트워크
									<input type="radio" name="netPolicyRange" value="1"> 그룹
									<input type="radio" name="netPolicyRange" value="2"> PC
									<input type="radio" name="netPolicyRange" value="3"> OneDrive
								</td>
							</tr>
							<tr>
								<th>범위</th>
								<td colspan="3" id="netRangeNm">
									<input type="hidden" id="netRangeId" value=""> 
									<input type="hidden" id="netRangeType" value=""> 
								</td>
							</tr>
							<tr>
								<th>검색정책</th>
								<td colspan="3" id="netPolicyNm">
									<input type="hidden" id="netPolicyId" value=""> 
								</td>
							</tr>
							<tr id="netScanDay_tbl">
								<th>검색요일</th>
								<td colspan="3" id="netScanDay">
								</td>
							</tr>
							<tr>
								<th>스캔트레이스로그</th>
								<td colspan="3" id="netTrace">
								</td>
							</tr>
							<tr id="net_drm_CHK">
								<th>DRM</th>
								<td colspan="3" id="netDRM">
								</td>
							</tr>
							<tr id="net_time_CHK">
								<th>검색실행시간</th>
								<td colspan="3">
									<input type="hidden" value="1" id="netPolicyTime">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div id="acesssBtn" class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" id="btnNetPopupClose" >닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="updatePolicyPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="width: 455px; height: 200px; padding: 10px; background: #f9f9f9; left: 54%; top: 55%;">
		<img class="CancleImg" id="btnCancleUpdatePolicyPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">PC정책 수정</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="background: #fff; width: 455px; height: 390px; border: 1px solid #c8ced3; overflow: auto;">
					<table class="user_info" style="width: 100%; border: none;">
						<caption>신규 스캔</caption>
						<tbody id="updatePolicyBody">
							<tr>
								<th>적용</th>
								<td id="netUpdateChk">
									<input type="radio" id="update_net_chk" name="updatePolicyRange" value="0" > 네트워크
									<input type="radio" id="update_group_chk" name="updatePolicyRange" value="1"> 그룹
									<input type="radio" id="update_pc_chk" name="updatePolicyRange" value="2"> PC
									<input type="radio" id="update_oneDrive_chk" name="updatePolicyRange" value="3"> OneDrive
								</td>
							</tr>
							<tr>
								<th>범위</th>
								<td colspan="3">
									<input type="text" id="updateRangeNm" value="" readonly="readonly" placeholder="범위가 선택되지 않았습니다" style="padding-left: 5px;">
									<button type="button" id="btnUpdateRangChoice" class="btn_down">선택</button>
									<input type="hidden" id="update_net_Type_chk" value=""> 
									<input type="hidden" id="updateBeforeRangeId" value=""> 
									<input type="hidden" id="updateBeforeType" value=""> 
									<input type="hidden" id="updateRangeId" value=""> 
									<input type="hidden" id="updateOneDriveRangeNm" value=""> 
									<input type="hidden" id="updateRangeType" value=""> 
									<input type="hidden" id="updateRangeTargetId" value=""> 
								</td>
							</tr>
							<tr>
								<th>검색정책</th>
								<td colspan="3">
								<input type="text" id="updatePolicyNm" value=""  readonly="readonly" placeholder="정책이 선택되지 않았습니다" style="padding-left: 5px;">
									<button type="button" id="btnUpdatePoilcyChoice" class="btn_down">선택</button>  
									<input type="hidden" id="updatePolicyId" value=""> 
								</td>
							</tr>
							<tr id="updateScanDay_tbl">
								<th>검색요일</th>
								<td>
									<div id="updateScanDay" style="display: inline;">
										<input type="radio" id="updateScanEvery" name="updateScanDay" value="9"> 매일
										<input type="radio" name="updateScanDay" id="updateScanMon" value="1"> 월
										<input type="radio" name="updateScanDay" id="updateScanTue" value="2"> 화
										<input type="radio" name="updateScanDay" id="updateScanWed" value="3"> 수
										<input type="radio" name="updateScanDay" id="updateScanThu" value="4"> 목
										<input type="radio" name="updateScanDay" id="updateScanFri" value="5"> 금
										<input type="radio" name="updateScanDay" id="updateScanSat" value="6"> 토
										<input type="radio" name="updateScanDay" id="updateScanSun" value="7"> 일
									</div>
								</td>
							</tr>
							<tr>
								<th>스캔트레이스로그</th>
								<td colspan="3">
									<input type="checkbox" id="traceCheck" name="traceCheck" value="Y">
									<!-- <div id="traceChkDay" style="display: inline;">
										<input type="radio" id="traceChkEvery" name="traceChkDay" value="9"> 매일
										<input type="radio" name="traceChkDay" id="traceChkMon" value="1"> 월
										<input type="radio" name="traceChkDay" id="traceChkTue" value="2"> 화
										<input type="radio" name="traceChkDay" id="traceChkWed" value="3"> 수
										<input type="radio" name="traceChkDay" id="traceChkThu" value="4"> 목
										<input type="radio" name="traceChkDay" id="traceChkFri" value="5"> 금
									</div> -->
								</td>
							</tr>
							<tr id="update_drm_CHK">
								<th>DRM</th>
								<td colspan="3">
									<input type="checkbox" id="drmCheck" name="drmCheck">
								</td>
							</tr>
							<tr id="update_time_CHK">
								<th>검색실행시간</th>
								<td colspan="3">
									<button type="button" id="btnTimeUpdateCreate" class="btn_down">추가</button>
									<button type="button" id="btnTimeUpdateRemove" class="btn_down">제거</button>
									<input type="hidden" value="1" id="updatePolicyTime">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div id="updateAcesssBtn" class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" id="btnUpdatePopup" >수정</button>
					<button type="button" id="btnUpdatePopup2" >수정</button>
					<button type="button" id="btnUpdatePopupClose" >닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 검색 상태 버튼 클릭 팝업 -->
	<div id="searchStatusPopup" class="popup_layer" style="display:none"> 
		<div class="popup_box" id="popup_searchStatus" style="height: 140px; width: 750px; padding: 10px; background: #f9f9f9; left: 41%; top: 55%;">
		<img class="CancleImg" id="btnCancleSearchStatusPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;" id="policyTypeName">PC검색 상태</h1>
			</div>
			<div class="popup_content">
				<div class="content-table" style="background: #fff; padding: 10px; margin-top: 10px; border: 1px solid #c8ced3;">
					<p id='searchStatus_txt' style='padding: 14px 0; font-size: 14px; display: none;'>대상이 존재하지 않습니다.</p>
					<table class="popup_tbl" id="searchStatus_tbl">
						<%-- <colgroup>
							<col width="70%">
							<col width="30%">
						</colgroup> --%>
						<tbody id="details_detail">
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div id="acesssBtn" class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" id="btnSearchStatusPopupClose" >닫기</button>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- section -->
<!-- section -->

<!-- 그룹 선택 버튼 클릭 팝업 -->
<div id="taskGroupWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
	border-top: 2px solid #2f353a; box-shadow: 0 2px 5px #ddd; display:none">
	<ul>
		<li class="status">
			<button id="pauseScheduleAll">보기</button></li>
		<li class="status">
			<button id="restartScheduleAll">수정</button></li>
		<li class="status">
			<button id="stopScheduleAll">삭제</button></li>
		<li class="status">
			<button id="PCsearchStatusAll">PC검색 상태</button></li>
		<li class="status">
			<button id="closeScheduleAll">닫기</button></li>
		<!-- <li class="status">
			<button id="confirmScheduleAll">확인</button></li> -->
	</ul>
</div>
<!-- 그룹 선택 버튼 클릭 팝업 종료 -->

<%@ include file="../../include/footer.jsp"%>



<script>

$(document).ready(function () {
	
	fn_drawTopNGrid();
	$("#topNGrid").setGridParam({url:"<%=request.getContextPath()%>/search/selectPCPolicy", postData : "", datatype:"json" }).trigger("reloadGrid");

	$(document).click(function(e){
		$("#taskGroupWindow").hide();
		//$("#taskWindow").hide();
		//$("#viewDetails").hide(); 
	});
	
});

function fn_drawTopNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	$("#topNGrid").jqGrid({
		<%-- url: "<%=request.getContextPath()%>/target/selectAdminServerFileTopN", --%>
		datatype: "local",
	   	mtype : "POST",
		colNames:[
			'정책ID', '정책종류NO', 'AP_NO', '종류', '종류ID', 'LOCATIONID' , '망/그룹/PC명', '검색정책ID', '검색정책명', '시간', 'PC 갯수', '등록일', '', '스캔트레이스로그 주기', '스캔트레이스로그 체크', 'DRM', 'SCANDAY'
		],
		colModel: [
			{ index: 'NET_ID', 			name: 'NET_ID', width:0, hidden: true},
			{ index: 'TYPE', 			name: 'TYPE', width:0, hidden: true},
			{ index: 'AP_NO', 			name: 'AP_NO', width:0, hidden: true},
			{ index: 'TYPE_NM', 		name: 'TYPE_NM', width:20, align: 'center'},
			{ index: 'LOCATION_ID', 	name: 'LOCATION_ID', width:20, align: 'center', hidden: true},
			{ index: 'NET_TYPE_ID', 	name: 'NET_TYPE_ID', width:0, hidden: true},
			{ index: 'NET_TYPE_NM', 	name: 'NET_TYPE_NM', width:80, align: 'center'},
			{ index: 'POLICY_ID', 		name: 'POLICY_ID', width:0, hidden: true},
			{ index: 'POLICY_NAME', 	name: 'POLICY_NAME', width:80, align: 'center'},
			{ index: 'SCHEDULE_TIME', 	name: 'SCHEDULE_TIME', width:0, hidden: true},
			{ index: 'PC_COUNT', 		name: 'PC_COUNT', width:10, align: 'center'},
			{ index: 'REGDATE', 		name: 'REGDATE', width:30, align: 'center'},
			{ index: 'VIEW', 			name: 'VIEW', width:10, align: 'center', formatter:createView, exportcol : false, sortable: false},
			{ index: 'DAY', 			name: 'DAY', width:0, hidden: true},
			{ index: 'TRACE', 			name: 'TRACE', width:0, hidden: true},
			{ index: 'DRM_STATUS', 		name: 'DRM_STATUS', width:0, hidden: true},
			{ index: 'SCANDAY', 		name: 'SCANDAY', width:0, hidden: true}
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 581,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:25,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#topNGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onCellSelect : function(rowid,celname,value,iRow,iCol) {
	  		var NET_TYPE_ID = $(this).getCell(rowid, 'NET_TYPE_ID');
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data) {
			//console.log(data);
			$(".gridSubSelBtn").on("click", function(e) {
		  		e.stopPropagation();
				
				$("#topNGrid").setSelection(event.target.parentElement.parentElement.id);
				// 조건에 따라 Option 변경
				//var status = ".status-" + $("#targetGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_STAT');
				$(".status").css("display", "none"); 
				$(".status").css("display", "block");
				$(".manage-schedule").css("display", "block");

				var offset = $(this).parent().offset();
				$("#taskGroupWindow").css("left", (offset.left - $("#taskGroupWindow").width()) + 55 + "px");
				// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
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
}

$('#searchKey').keyup(function(e) {
	if (e.keyCode == 13) {
		 search_policy();
	}        
});

$("#btnSearch").click(function(e){
	 search_policy();
});

/* 신규정책 생성 시작 */
$("#btn_new").click(function(e){
	$('input[name=policyRange][value=0]').prop('checked',true);
	$("#rangeNm").val("");
	$("#policyNm").val("");
	$("#btnTrace").prop("checked", true);
	$("#btnDRM").prop("checked", true);
	$("#traceEvery").prop("checked", true);
	$("#scanEvery").prop("checked", true);
	$("#traceDay").css("display", "inline");
	$("#drm_CHK").css("display","");
	$("#time_Chk").css("display","");
	$("#newNetPolicyPopup").show();
	
	$("#btnNewPopupSave").show();
	$("#btnNewPopupSave2").hide();
});

$("input:radio[name='policyRange']").on('change', function(){
	var value = $(this).val();
	$("#rangeNm").val("");
	$("#rangeId").val("");
	$("#policyNm").val("");
	
	
	if(value == 3){
		$("#btnNewPopupSave2").show();
		$("#btnNewPopupSave").hide();
		
		$("#drm_CHK").css("display","none");
		$("#time_Chk").css("display","none");
		$("#scanDay_tbl").css("display","none");
		$("input:radio[name='scanDay']").prop("checked", false);
		$(".dataTime").hide();
	}else {
		$("#btnNewPopupSave2").hide();
		$("#btnNewPopupSave").show();
		
		$("#drm_CHK").css("display","");
		$("#time_Chk").css("display","");
		$("#scanDay_tbl").css("display","");
		$("#scanEvery").prop("checked", true);
		$(".dataTime").show();
	}
});

/* $("input:checkbox[name='btnTrace']").on('change', function(){
	if($("#btnTrace").is(":checked")){
		$("#traceDay").css("display", "inline");
		$("#traceEvery").prop("checked", true);
	}else{
		$("#traceDay").css("display", "none");
		$("input:radio[name='traceDay']").prop("checked", false);
	}
});

$("input:checkbox[name='traceCheck']").on('change', function(){
	if($("#traceCheck").is(":checked")){
		$("#traceChkDay").css("display", "inline");
		$("#traceChkEvery").prop("checked", true);
	}else{
		$("#traceChkDay").css("display", "none");
		$("input:radio[name='traceChkDay']").prop("checked", false);
	}
}); */

// 신규정책 생성 
$("#btnNewPopupSave").click(function(e){
	/* 범위 */
	var type = $('input[name="policyRange"]:checked').val(); 	// 네트워크, 그룹, pc
	var rangeId = $("#rangeId").val(); 							// 대상의 아이디 (네트워크=net_id, 그룹= insa_code, pc=target_id)
	var rangeNm = $("#rangeNm").val(); 							// 이름
	var rangeType = $("#rangeType").val(); 						// pc일 경우 호스트 ap_no 구분 용
	var trace = $('input[name="btnTrace"]:checked').val(); 		// 스캔 트레이스 로그
	/* var day = $('input[name="traceDay"]:checked').val(); 		// 스캔 트레이스 로그 생성일 */
	var drm = $('input[name="btnDRM"]:checked').val(); 			// drm status
	var policyId = $("#policyId").val(); 						// 검색 정책
	var policyTime = $("#policyTime").val(); 					// 검색 시간
	var scanday = $('input[name="scanDay"]:checked').val(); 	// 검색 요일
	
	if(trace !=  "Y"){
		trace = "N";
		day = null;
	}
	
	if(drm != "S"){
		drm = "C";
	}
	if(rangeId == '') {
		alert("범위를 선택하지 않았습니다.");
		return;
	}
	if(policyId == '') {
		alert("검색정책을 선택하지 않았습니다.");
		return;
	}
	if(policyTime == 1) {
		alert("검색 시작 시간을 설정하지 않았습니다.");
		return;
	}
	
	/* 검색 실행 시간 추가 */
	var timeArr = [];
	for(var i = 1; i < policyTime; i++){
		var times = $("#start_hour"+ i +" option:selected").val();
		timeArr.push(((parseInt(times) < 10) ? '0'+times : times) + ":00");
	}
	
	var uniqueArr = timeArr.filter(function(item, idx, self){
		return self.indexOf(item) == idx;
	})
	
	if(timeArr.length != uniqueArr.length) {
	  alert("중복된 시간이 존재합니다. 다시 확인해 주세요.");
	  return;
	}
	
	var postData = {
		"type" : type,
		"rangeId" : rangeId,
		"rangeNm" : rangeNm,
		"rangeType" : rangeType,
		"trace" : trace,
		/* "day" : day, */
		"drm" : drm,
		"policyId" : policyId,
		"timeArr" : timeArr,
		"scanday" : scanday
	};
	
	console.log(postData);
	
	var message = "신규 정책을 생성하시겠습니까?";
	
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/insertNetPolicy",
			async : false,
			traditional : true,
			data : postData,
		    success: function (resultMap) {
		    	alert("PC 정책이 생성되었습니다.");
		    	var postData = {};
		    	$("#topNGrid").setGridParam({
		    		url:"<%=request.getContextPath()%>/search/selectPCPolicy", 
		    		postData : postData, 
		    		datatype:"json" 
	    		}).trigger("reloadGrid");
		    	$("#policyTime").val("1");
		    	$(".dataTime").remove();
		    	$("#newNetPolicyPopup").hide();
		    },
		    error: function (request, status, error) {
				alert("Server Error : " + error);
				$("#newNetPolicyPopup").hide();
		        console.log("ERROR : ", error);
		    }
		});
	}	 
	
});

// OneDrive 정책 생성
$("#btnNewPopupSave2").click(function(e){
	/* 범위 */
	var type = $('input[name="policyRange"]:checked').val(); 	// 원드라이브 = 3
	var rangeId = $("#rangeId").val(); 							// 대상의 아이디 (location_id)
	var rangeNm = $("#rangeNm").val(); 							// 이름 ( ""외 0건)
	var rangeOneDriveNm = $("#rangeOneDriveNm").val(); 			// 이름 (생략 없는 모든 대상)
	var rangeType = $("#rangeType").val(); 						// pc일 경우 호스트 ap_no 구분 용
	var trace = $('input[name="btnTrace"]:checked').val(); 		// 스캔 트레이스 로그
	// var day = $('input[name="traceDay"]:checked').val(); 		// 스캔 트레이스 로그 생성일
	var policyId = $("#policyId").val(); 						// 검색 정책
	var targetId = $("#targetId").val(); 						// target_id
	
	var rangeIdArry = rangeId.split(",");
	var rangeNmArry = rangeOneDriveNm.split(",");
	
	if(trace !=  "Y"){
		trace = "N"
		// day = null;
	}
	
	if(rangeId == '') {
		alert("범위를 선택하지 않았습니다.");
		return;
	}
	if(policyId == '') {
		alert("검색정책을 선택하지 않았습니다.");
		return;
	}
	
	var postData = {
		"type" : type,
		"rangeId" : JSON.stringify(rangeIdArry),
		"rangeNm" : rangeNm,
		"targetId" : targetId,
		"rangeOneDriveNm" : JSON.stringify(rangeNmArry),
		"rangeType" : rangeType,
		"trace" : trace,
		/* "day" : day, */
		"policyId" : policyId
	};
	
	console.log(postData);
	
	var message = "신규 정책을 생성하시겠습니까?";
	
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/insertOneDrivePolicy",
			async : false,
			traditional : true,
			data : postData,
		    success: function (resultMap) {
		    	alert("PC 정책이 생성되었습니다.");
		    	var postData = {};
		    	$("#topNGrid").setGridParam({
		    		url:"<%=request.getContextPath()%>/search/selectPCPolicy", 
		    		postData : postData, 
		    		datatype:"json" 
	    		}).trigger("reloadGrid");
		    	$("#policyTime").val("1");
		    	$(".dataTime").remove();
		    	$("#newNetPolicyPopup").hide();
		    },
		    error: function (request, status, error) {
				alert("Server Error : " + error);
				$("#newNetPolicyPopup").hide();
		        console.log("ERROR : ", error);
		    }
		});
	}	 
	
});

$("#btnNewPopupCencel").click(function(e){
	setNewSetting();
	
	$("#newNetPolicyPopup").hide();
});

$("#btnCancleNewNetPolicyPopup").click(function(e){
	setNewSetting();
	
	$("#newNetPolicyPopup").hide();
});

$("#btnTimeCreate").click(function(e){
	var slotTime = $("#policyTime").val();
	$("#policyBody").append(setStartdtm());
	$("#policyTime").val(parseInt(slotTime)+1);
	
});

$("#btnTimeRemove").click(function(e){
	var slotTime = $("#policyTime").val();
	
	if(parseInt(slotTime) > 1){
		$("#slotTime"+(parseInt(slotTime)-1)).remove();
		$("#policyTime").val(parseInt(slotTime)-1);
	}
});

$("#btnTimeUpdateCreate").click(function(e){
	var row = $("#topNGrid").getGridParam("selrow");
	
	var net_id = $("#topNGrid").getCell(row, "NET_ID");
	var type = $("#topNGrid").getCell(row, "TYPE");
	var rangeNm = $("#topNGrid").getCell(row, "NET_TYPE_NM");
	var policyNm = $("#topNGrid").getCell(row, "POLICY_NAME");
	var scheduleTime = $("#topNGrid").getCell(row, "SCHEDULE_TIME");
	
	var time = parseInt($("#updatePolicyTime").val()) + 1;
	$("#updatePolicyTime").val(time);
	
	var html = "";
		html += "<tr class='dataTime' id='slotUpdateTime" + time + "'><th> 검색 시간" + time + "</th>";
		html += "<td colspan=3>";
		html += "<select name='update_select_hour' id='update_select_hour"+time+"' >"
		for(var i=0; i<24; i++){
			var hour = (parseInt(i));
			var str_hour = (parseInt(hour) < 10) ? '0'+hour : hour
			html += "<option value=\""+hour+"\" "+(hour == parseInt(time)? 'selected': '')+">"+(hour < 10 ? "0" + hour : hour)+"</option>"
		}
		html += "</select> : "
		html += "<input type='text' id='update_minutes" + time + "' value='00' readonly='readonly' style='width:37px;'>";
		html += "</td>";
		html += "</tr>"
	
	$("#updatePolicyBody").append(html);
	
	
});

$("#btnTimeUpdateRemove").click(function(e){
	var slotUpdateTime = $("#updatePolicyTime").val();
	
	if(parseInt(slotUpdateTime) > 0){
		$("#slotUpdateTime"+(parseInt(slotUpdateTime))).remove();
		$("#updatePolicyTime").val(parseInt(slotUpdateTime)-1);
	}
});

// 망 범위 선택
$("#btnRangChoice").click(function(e){
	var netid = $('input[name=policyRange]:checked').val();
	var netType = "insert";
	
	var pop_url = "${getContextPath}/popup/netList";
	var winWidth = 760;
	var winHeight = 0;
	if(netid == 3 ){
		winHeight = 595;
	}else{
		winHeight = 565;
	}
	
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
	var pop = window.open(pop_url,netid,popupOption);
	
	var newForm = document.createElement('form');
	newForm.method='POST';
	newForm.action=pop_url;
	newForm.name='newForm';
	newForm.target=netid;
	
	var net_id = document.createElement('input');
	net_id.setAttribute('type','hidden');
	net_id.setAttribute('name','netid');
	net_id.setAttribute('id','netid');
	net_id.setAttribute('value',netid);
	
	var net_type = document.createElement('input');
	net_type.setAttribute('type','hidden');
	net_type.setAttribute('name','netType');
	net_type.setAttribute('id','netType');
	net_type.setAttribute('value',netType);
	
	newForm.appendChild(net_id);
	newForm.appendChild(net_type);
	
	document.body.appendChild(newForm);
	newForm.submit();
	
	document.body.removeChild(newForm);
});

// 정책 버튼 선택
$("#btnPoilcyChoice").click(function(e){
	
	var pop_url = "${getContextPath}/popup/policyList";
	var winWidth = 1535;
	var winHeight = 525;
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
	var pop = window.open(pop_url,'',popupOption);
});


/* 신규정책 생성 종료 */
function setStartdtm(){
	var today = new Date();
	today.setHours(today.getHours() + 1);
	var hours = today.getHours();
	var minutes = today.getMinutes();
	const year = today.getFullYear(); 
	const month = today.getMonth() + 1; 
	const date = today.getDate();

	var start_ymd = '';
	var start_hour = '';
	var start_minutes = '';
	var time = $("#policyTime").val();
	var html = "";
	html += "<tr class='dataTime' id='slotTime"+ time +"'><th> 검색 시간" + time + "</th>";
	html += "<td colspan=3>";
	html += "<select name='start_hour' id='start_hour"+time+"' >"
	for(var i=0; i<24; i++){
		var hour = (parseInt(i));
		var str_hour = (parseInt(hour) < 10) ? '0'+hour : hour
		html += "<option value=\""+hour+"\" "+(hour == parseInt(time)? 'selected': '')+">"+(hour < 10 ? "0" + hour : hour)+"</option>"
	}
	html += "</select> : "
	
	html += "<input type='text' id='start_minutes"+time+"' value='00' readonly='readonly' style='width:37px;'>";
	
	html += "</td></tr>"
	
	return html;
}


function search_policy(){
	var postData = {"net_nm": $('#searchKey').val()}
	$("#topNGrid").setGridParam({url:"<%=request.getContextPath()%>/search/selectPCPolicy", postData : postData, datatype:"json" }).trigger("reloadGrid");
}

function getFormatDate(oDate)
{
    var nYear = oDate.getFullYear();           // yyyy 
    var nMonth = (1 + oDate.getMonth());       // M 
    nMonth = ('0' + nMonth).slice(-2);         // month 두자리로 저장 action

    var nDay = oDate.getDate();                // d 
    nDay = ('0' + nDay).slice(-2);             // day 두자리로 저장

    return nYear + '-' + nMonth + '-' + nDay;
}

var createType = function(cellvalue, options, rowObject) {
	return cellvalue != null ? cellvalue : "<span style=\"color:red\">미설정</span>"; 
};

var createView = function(cellvalue, options, rowObject) {
	var status = rowObject.STATUS;
	var result = "";
	
	result = "<button type='button' style='padding-top: 4px; padding-bottom:4px;' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>";
	
	
	return result; 
};

$("#pauseScheduleAll").click(function(){
	var row = $("#topNGrid").getGridParam("selrow");
	
	var net_id = $("#topNGrid").getCell(row, "NET_ID");
	var type = $("#topNGrid").getCell(row, "TYPE");
	var rangeNm = $("#topNGrid").getCell(row, "NET_TYPE_NM");
	var policyNm = $("#topNGrid").getCell(row, "POLICY_NAME");
	var scheduleTime = $("#topNGrid").getCell(row, "SCHEDULE_TIME");
	var trace = $("#topNGrid").getCell(row, "TRACE");
	var day = $("#topNGrid").getCell(row, "DAY");
	var drm = $("#topNGrid").getCell(row, "DRM_STATUS");
	var scanday = $("#topNGrid").getCell(row, "SCANDAY");
	
	console.log(type);
	
	$.ajax({
		type: "POST",
		url: "/search/selectPCPolicyTime",
		async : false,
		data: {
			net_id : net_id
		},
		dataType: "json",
	    success: function (resultMap) {
	    	console.log(resultMap);
	    	var time = $("#netPolicyTime").val();
	    	var html = "";
	    	$.each(resultMap, function(index, item) {
	    		html += "<tr class='dataTime' id='slotScheduleTime"+ time +"'><th> 검색 시간" + (index + 1) + "</th>";
	    		html += "<td colspan=3>" + item.SCHEDULE_TIME + "</td>";
	    		html += "</tr>"
	    	});
	    	$("#netPolicyBody").append(html);
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	$("#netRangeNm").html(rangeNm);
	$("#netPolicyNm").html(policyNm);
	
	if(trace == 'Y'){
		$("#netTrace").html("ON");
		/* if(day == '9'){
			$("#netTrace").html("ON " + "(매일)");
		}else if(day == '1'){
			$("#netTrace").html("ON " + "(월요일)");
		}else if(day == '2'){
			$("#netTrace").html("ON " + "(화요일)");
		}else if(day == '3'){
			$("#netTrace").html("ON " + "(수요일)");
		}else if(day == '4'){
			$("#netTrace").html("ON " + "(목요일)");
		}else if(day == '5'){
			$("#netTrace").html("ON " + "(금요일)");
		} */
	}else{
		$("#netTrace").html("OFF");
	}
	
	if(scanday == '9'){
		$("#netScanDay").html("매일");
	}else if(scanday == '1'){
		$("#netScanDay").html("월요일");
	}else if(scanday == '2'){
		$("#netScanDay").html("화요일");
	}else if(scanday == '3'){
		$("#netScanDay").html("수요일");
	}else if(scanday == '4'){
		$("#netScanDay").html("목요일");
	}else if(scanday == '5'){
		$("#netScanDay").html("금요일");
	}else if(scanday == '6'){
		$("#netScanDay").html("토요일");
	}else if(scanday == '7'){
		$("#netScanDay").html("일요일");
	}
	
	if(drm == "C"){
		$("#netDRM").html("OFF");
	}else{
		$("#netDRM").html("ON");
	}
	
	if(type == 0){
		$("#netChk").html("망");
		$('input[name=netPolicyRange]').attr("type", "hidden");
		$("#net_drm_CHK").css("display", "");
		$("#net_time_CHK").css("display", "");
		$("#netScanDay_tbl").css("display", "");
	}else if(type == 1){
		$("#netChk").html("그룹");
		$('input[name=netPolicyRange]').attr("type", "hidden");
		$("#net_drm_CHK").css("display", "");
		$("#net_time_CHK").css("display", "");
		$("#netScanDay_tbl").css("display", "");
	}else if(type == 2){
		$("#netChk").html("PC");
		$('input[name=netPolicyRange]').attr("type", "hidden");
		$("#net_drm_CHK").css("display", "");
		$("#net_time_CHK").css("display", "");
		$("#netScanDay_tbl").css("display", "");
	}else if(type == 3){
		$("#netChk").html("OneDrive");
		$('input[name=netPolicyRange]').attr("type", "hidden");
		$("#net_drm_CHK").css("display", "none");
		$("#net_time_CHK").css("display", "none");
		$("#netScanDay_tbl").css("display", "none");
	}
	
	$("#netPolicyPopup").show();
	
});

$("#btnNetPopupClose").click(function(){
	$(".dataTime").remove();
	$("#netPolicyPopup").hide();
});

$("#btnCancleNetPolicyPopup").click(function(){
	$(".dataTime").remove();
	$("#netPolicyPopup").hide();
});

$("#restartScheduleAll").click(function(){
	var row = $("#topNGrid").getGridParam("selrow");
	
	var type_nm			= $("#topNGrid").getCell(row, "TYPE_NM");
	var type			= $("#topNGrid").getCell(row, "TYPE");
	
	var net_id 			= $("#topNGrid").getCell(row, "NET_ID");
	var net_type_id 	= $("#topNGrid").getCell(row, "NET_TYPE_ID");
	var location_id 	= $("#topNGrid").getCell(row, "LOCATION_ID");
	var type	 		= $("#topNGrid").getCell(row, "TYPE");
	var rangeNm 		= $("#topNGrid").getCell(row, "NET_TYPE_NM");
	var policyId 		= $("#topNGrid").getCell(row, "POLICY_ID");
	var policyNm 		= $("#topNGrid").getCell(row, "POLICY_NAME");
	var scheduleTime 	= $("#topNGrid").getCell(row, "SCHEDULE_TIME");
	var trace 			= $("#topNGrid").getCell(row, "TRACE");
	var day 			= $("#topNGrid").getCell(row, "DAY");
	var drm 			= $("#topNGrid").getCell(row, "DRM_STATUS");
	var ap_no 			= $("#topNGrid").getCell(row, "AP_NO");
	var scanday			= $("#topNGrid").getCell(row, "SCANDAY");
	
	$("#netUpdateChk").html(type_nm);
	$("#update_net_Type_chk").val(type);
	$('input[name=updatePolicyRange]').attr("type", "hidden");
	
	$("#updateBeforeType").val(type); 
	$("#updateBeforeRangeId").val(net_type_id);
	if(type == 3) {
		$("#updateRangeId").val(location_id);
	}else {
		$("#updateRangeId").val(net_type_id);
	}
	$("#updateRangeType").val(ap_no);
	$("#updateRangeNm").val(rangeNm);
	$("#updatePolicyId").val(policyId);
	$("#updateOneDriveRangeNm").val(rangeNm);
	$("#updateRangeTargetId").val(net_type_id);
	$.ajax({
		type: "POST",
		url: "/search/selectPCPolicyTime",
		async : false,
		data: {
			net_id : net_id
		},
		dataType: "json",
	    success: function (resultMap) {
	    	console.log(resultMap);
	    	var time = $("#updatePolicyTime").val();
	    	var length = resultMap.length;
	    	$("#updatePolicyTime").val(length);
	    	var html = "";
	    	$.each(resultMap, function(index, item) {
	    		console.log(item.SCHEDULE_TIME);
		    	var update_dtm = item.SCHEDULE_TIME;
		    	var update_hour = '';
		    	var update_minutes = '';
		    	if(update_dtm != null && update_dtm != ''){
		    		update_hour = update_dtm.substr(0,2);
		    		update_minutes = update_dtm.substr(3,4);
		    	} 
	    		html += "<tr class='dataTime' id='slotUpdateTime" + (index + 1) + "'><th> 검색 시간" + (index + 1) + "</th>";
	    		html += "<td colspan=3>";
	    		html += "<select name='update_select_hour' id='update_select_hour"+(index + 1)+"' >"
    			for(var i=0; i<24; i++){
    				var hour = (parseInt(i));
    				var str_hour = (parseInt(hour) < 10) ? '0'+hour : hour
    				html += "<option value=\""+hour+"\" "+(hour == parseInt(update_hour)? 'selected': '')+">"+(hour < 10 ? "0" + hour : hour)+"</option>"
    			}
    			html += "</select> : "
   				html += "<input type='text' id='update_minutes" + (index + 1) + "' value='00' readonly='readonly' style='width:37px;'>";
	    		html += "</td>";
	    		html += "</tr>"
	    	});
	    	$("#updatePolicyBody").append(html);
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	$("#updateRangeNm").val(rangeNm);
	$("#updatePolicyNm").val(policyNm);
	
	if(trace =='Y'){
		$("#traceCheck").prop("checked", true);
		// $("#traceChkDay").css("display", "inline");
	}else{
		$("#traceCheck").prop("checked", false);
		// $("#traceChkDay").css("display", "none");
	}
	
	/* if(day == '9'){
		$("#traceChkEvery").prop("checked", true);
	}else if(day == '1'){
		$("#traceChkMon").prop("checked", true);
	}else if(day == '2'){
		$("#traceChkTue").prop("checked", true);
	}else if(day == '3'){
		$("#traceChkWed").prop("checked", true);
	}else if(day == '4'){
		$("#traceChkThu").prop("checked", true);
	}else if(day == '5'){
		$("#traceChkFri").prop("checked", true);
	}else {
		$("input:radio[name='traceChkDay']").prop("checked", false);
		$("#traceChkDay").css("display", "none");
	} */
	
	if(scanday == '9'){
		$("#updateScanEvery").prop("checked", true);
	}else if(scanday == '1'){
		$("#updateScanMon").prop("checked", true);
	}else if(scanday == '2'){
		$("#updateScanTue").prop("checked", true);
	}else if(scanday == '3'){
		$("#updateScanWed").prop("checked", true);
	}else if(scanday == '4'){
		$("#updateScanThu").prop("checked", true);
	}else if(scanday == '5'){
		$("#updateScanFri").prop("checked", true);
	}else if(scanday == '6'){
		$("#updateScanSat").prop("checked", true);
	}else if(scanday == '7'){
		$("#updateScanSun").prop("checked", true);
	}
	
	if(drm == "C"){
		$("#drmCheck").prop("checked", false);
	}else{
		$("#drmCheck").prop("checked", true);
	}
	
	if(type == 0){
		$("#update_net_chk").prop("checked", true);
		$("#update_drm_CHK").css("display", "");
		$("#update_time_CHK").css("display", "");
		$("#updateScanDay_tbl").css("display", "");
		
		$("#btnUpdatePopup2").hide();
		$("#btnUpdatePopup").show();
	}else if(type == 1){
		$("#update_group_chk").prop("checked", true);
		$("#update_drm_CHK").css("display", "");
		$("#update_time_CHK").css("display", "");
		$("#updateScanDay_tbl").css("display", "");
		
		$("#btnUpdatePopup2").hide();
		$("#btnUpdatePopup").show();
	}else if(type == 2){
		$("#update_pc_chk").prop("checked", true);
		$("#update_drm_CHK").css("display", "");
		$("#update_time_CHK").css("display", "");
		$("#updateScanDay_tbl").css("display", "");
		
		$("#btnUpdatePopup2").hide();
		$("#btnUpdatePopup").show();
	}else if(type == 3){
		$("#update_oneDrive_chk").prop("checked", true);
		$("#update_drm_CHK").css("display", "none");
		$("#update_time_CHK").css("display", "none");
		drm = null;
		$("#updateScanDay_tbl").css("display", "none");
		
		$("#btnUpdatePopup").hide();
		$("#btnUpdatePopup2").show();
	}
	
	$("#updatePolicyPopup").show();
	
});

$("input:radio[name='updatePolicyRange']").on('change', function(){
	var value = $(this).val();
	$("#updateRangeNm").val("");
	$("#rangeId").val("");
	$("#updatePolicyNm").val("");
	
	if(value == 3){
		$(".dataTime").hide();
		$("#update_drm_CHK").hide();
		$("#update_time_CHK").hide();
		
		$("#btnUpdatePopup2").show();
		$("#btnUpdatePopup").hide();
	}else {
		$(".dataTime").show();
		$("#update_drm_CHK").show();
		$("#update_time_CHK").show();
		
		$("#btnUpdatePopup2").hide();
		$("#btnUpdatePopup").show();
	}
});


$("#btnUpdatePopup").click(function(e){
	/* 범위 */
	var row = $("#topNGrid").getGridParam("selrow");
	
	var beforeType= $("#updateBeforeType").val();// 기존 네트워크, 그룹, pc
	var beforeRangeId = $("#updateBeforeRangeId").val();// 기존 대상의 아이디 (네트워크=net_id, 그룹= insa_code, pc=target_id)
	
	var type = beforeType; // 네트워크, 그룹, pc
	var rangeId = $("#updateRangeId").val(); // 대상의 아이디 (네트워크=net_id, 그룹= insa_code, pc=target_id)
	var rangeNm = $("#updateRangeNm").val(); // 이름
	var rangeType = $("#updateRangeType").val(); // pc일 경우 호스트 ap_no 구분 용
	var ap_no = $("#topNGrid").getCell(row, "AP_NO"); // 기존 ap_no
	
	var net_id = $("#topNGrid").getCell(row, "NET_ID"); // 정책 아이디
	var trace = $('input[name="traceCheck"]:checked').val(); // 스캔 트레이스 로그
	// var day = $('input[name="traceChkDay"]:checked').val(); // 스캔 트레이스 로그 생성일
	var drm = $("#drmCheck").is(":checked") ? "S" : "C"; // drm status
	var scanday = $('input[name="updateScanDay"]:checked').val(); // 검색요일
	
	if(trace !=  "Y"){
		trace = "N"
		// day = null
	}
	
	if(drm != "S"){
		drm = "C"
	}
	
	if($("#rangeType").val() != ''){
		ap_no = $("#rangeType").val();
	}
	
	
	/* 검색 정책 */
	var policyId = $("#updatePolicyId").val();
	
	/* 시간 */
	var policyTime = $("#updatePolicyTime").val();
	
	if(rangeId == '') {
		alert("범위를 선택하지 않았습니다.");
		return;
	}
	
	if(policyId == '') {
		alert("검색정책을 선택하지 않았습니다.");
		return;
	}
	
	if(policyTime == 0) {
		alert("검색 시작 시간을 설정하지 않았습니다.");
		return;
	}
	
	/* 검색 실행 시간 추가 */
	var timeArr = [];
	for(var i = 1; i <= policyTime; i++){
		var times = $("#update_select_hour"+ i +" option:selected").val();
		timeArr.push(((parseInt(times) < 10) ? '0'+times : times) + ":00");
	}

	var uniqueArr = timeArr.filter(function(item, idx, self){
		return self.indexOf(item) == idx;
	})
	
	if(timeArr.length != uniqueArr.length) {
	  alert("중복된 시간이 존재합니다. 다시 확인해 주세요.");
	  return;
	}
	
	var postData = {
		"type" : type,
		"beforeRangeId" : beforeRangeId,
		"beforeType" : beforeType,
		"rangeId" : rangeId,
		"rangeNm" : rangeNm,
		"rangeType" : rangeType,
		"ap_no" : ap_no,
		"net_id" : net_id,
		"policyId" : policyId,
		"trace" : trace,
		/* "day" : day, */
		"drm" : drm,
		"timeArr" : timeArr,
		"scanday" : scanday
	};
	
	
	console.log(postData);
	
	var message = "정책을 수정하시겠습니까?";
	
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/updateNetPolicy",
			async : false,
			traditional : true,
			data : postData,
		    success: function (resultMap) {
		    	alert("PC 정책이 수정되었습니다.");
		    	var postData = {};
		    	$("#topNGrid").setGridParam({
		    		url:"<%=request.getContextPath()%>/search/selectPCPolicy", 
		    		postData : postData, 
		    		datatype:"json" 
	    		}).trigger("reloadGrid");
		    	$(".dataTime").remove();
		    	$("#updatePolicyPopup").hide();
		    },
		    error: function (request, status, error) {
				alert("Server Error : " + error);
				$("#updatePolicyPopup").hide();
		        console.log("ERROR : ", error);
		    }
		});
	}	 
});

// OneDrive 정책 수정
$("#btnUpdatePopup2").click(function(e){
	/* 범위 */
	var row = $("#topNGrid").getGridParam("selrow");
	
	var beforeType= $("#updateBeforeType").val();					// 기존 네트워크, 그룹, pc
	var beforeRangeId = $("#updateBeforeRangeId").val();			// 기존 대상의 아이디 (네트워크=net_id, 그룹= insa_code, pc=target_id)
	
	var type = beforeType;	// 네트워크, 그룹, pc
	var rangeId = $("#updateRangeId").val(); 						// 대상의 아이디 (location_id)
	var rangeNm = $("#updateRangeNm").val(); 						// 이름 ( ""외 0건)
	var rangeOneDriveNm = $("#updateOneDriveRangeNm").val(); 	 	// 이름 (생략 없는 모든 대상)
	var rangeType = $("#updateRangeType").val(); 					// pc일 경우 호스트 ap_no 구분 용
	var ap_no = $("#topNGrid").getCell(row, "AP_NO"); 				// 기존 ap_no
	
	var net_id = $("#topNGrid").getCell(row, "NET_ID"); 			// 정책 아이디
	var trace = $('input[name="traceCheck"]:checked').val(); 		// 스캔 트레이스 로그
	// var day = $('input[name="traceChkDay"]:checked').val(); 		// 스캔 트레이스 로그 생성일
	var policyId = $("#updatePolicyId").val();						// 검색 정책
	
	var targetId = $("#updateRangeTargetId").val();						// 검색 정책
	
	var rangeIdArry = rangeId.split(",");
	var rangeNmArry = rangeOneDriveNm.split(",");
	
	if(trace !=  "Y"){
		trace = "N"
		// day = null
	}
	
	if($("#rangeType").val() != ''){
		ap_no = $("#rangeType").val();
	}
	
	/* 시간 */
	
	if(rangeId == '') {
		alert("범위를 선택하지 않았습니다.");
		return;
	}
	
	if(policyId == '') {
		alert("검색정책을 선택하지 않았습니다.");
		return;
	}
	
	var postData = {
		"net_id" : net_id,
		"type" : type,
		"beforeRangeId" : beforeRangeId,
		"beforeType" : beforeType,
		"rangeId" : JSON.stringify(rangeIdArry),
		"rangeNm" : rangeNm,
		"rangeOneDriveNm" : JSON.stringify(rangeNmArry),
		"rangeType" : rangeType,
		"targetId" : targetId,
		"trace" : trace,
		/* "day" : day, */
		"policyId" : policyId
	};
	
	
	console.log(postData);
	
	var message = "정책을 수정하시겠습니까?";
	
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/updateOneDrivePolicy",
			async : false,
			traditional : true,
			data : postData,
		    success: function (resultMap) {
		    	alert("PC 정책이 수정되었습니다.");
		    	var postData = {};
		    	$("#topNGrid").setGridParam({
		    		url:"<%=request.getContextPath()%>/search/selectPCPolicy", 
		    		postData : postData, 
		    		datatype:"json" 
	    		}).trigger("reloadGrid");
		    	$(".dataTime").remove();
		    	$("#updatePolicyPopup").hide();
		    },
		    error: function (request, status, error) {
				alert("Server Error : " + error);
				$("#updatePolicyPopup").hide();
		        console.log("ERROR : ", error);
		    }
		});
	}	 
});

$("#btnUpdatePopupClose").click(function(){
	$(".dataTime").remove();
	$("#updatePolicyPopup").hide();
});

$("#btnCancleUpdatePolicyPopup").click(function(){
	$(".dataTime").remove();
	$("#updatePolicyPopup").hide();
});

$("#stopScheduleAll").click(function(){
	
	var row = $("#topNGrid").getGridParam("selrow");
	var net_id = $("#topNGrid").getCell(row, "NET_ID");
	var type = $("#topNGrid").getCell(row, "TYPE");
	var group_id = $("#topNGrid").getCell(row, "NET_TYPE_ID");
	var ap_no = $("#topNGrid").getCell(row, "AP_NO");
	
	var message = "정말 삭제하시겠습니까?";
	
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/deletePCPolicy",
			async : false,
			data: {
				net_id : net_id,
				type : type,
				group_id : group_id,
				ap_no : ap_no
			},
			dataType: "json",
		    success: function (resultMap) {
		    	if (resultMap.resultCode == 0) {
		        	alert("삭제를 완료하였습니다.");
		        	var postData = {};
		        	$("#topNGrid").setGridParam({
			    		url:"<%=request.getContextPath()%>/search/selectPCPolicy", 
			    		postData : postData, 
			    		datatype:"json" 
		    		}).trigger("reloadGrid");
			    } else {
			        alert("삭제를 실패하였습니다.");
			    }
		    },
		    error: function (request, status, error) {
		        console.log("ERROR : ", error);
		    }
		});
	}
	
});

//수정 팝업 망 범위 선택
$("#btnUpdateRangChoice").click(function(e){
	/* var netid = $('input[name=updatePolicyRange]:checked').val(); */
	var netid = $("#update_net_Type_chk").val();
	var netType = "update";
	
	var pop_url = "${getContextPath}/popup/netList";
	var winWidth = 760;
	var winHeight = 0;
	if(netid == 3 ){
		winHeight = 595;
	}else{
		winHeight = 565;
	}
	
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
	var pop = window.open(pop_url,netid,popupOption);
	
	var newForm = document.createElement('form');
	newForm.method='POST';
	newForm.action=pop_url;
	newForm.name='newForm';
	newForm.target=netid;
	
	var net_id = document.createElement('input');
	net_id.setAttribute('type','hidden');
	net_id.setAttribute('name','netid');
	net_id.setAttribute('id','netid');
	net_id.setAttribute('value',netid);
	
	var net_type = document.createElement('input');
	net_type.setAttribute('type','hidden');
	net_type.setAttribute('name','netType');
	net_type.setAttribute('id','netType');
	net_type.setAttribute('value',netType);
	
	newForm.appendChild(net_id);
	newForm.appendChild(net_type);
	
	document.body.appendChild(newForm);
	newForm.submit();
	
	document.body.removeChild(newForm);
});

// 수정 팝업 정책 버튼 선택
$("#btnUpdatePoilcyChoice").click(function(e){
	
	var pop_url = "${getContextPath}/popup/policyList";
	var winWidth = 1535;
	var winHeight = 570;
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
	var pop = window.open(pop_url,'',popupOption);
	/* popList.push(pop);
	sessionUpdate(); */
	
	/* var newForm = document.createElement('form');
	newForm.method='POST';
	newForm.action=pop_url;
	newForm.name='newForm';
	newForm.target=netid;
	
	var data = document.createElement('input');
	data.setAttribute('type','hidden');
	data.setAttribute('name','netid');
	data.setAttribute('id','netid');
	data.setAttribute('value',netid);
	
	newForm.appendChild(data);
	document.body.appendChild(newForm);
	newForm.submit(); 
	
	document.body.removeChild(newForm);*/
});

function setNewSetting() {
	$("#rangeNm").val("");
	$("#rangeId").val("");
	
	$("#policyId").val("");
	$("#policyNm").val("");
	
	$("#policyTime").val("1");
	$(".dataTime").remove();
	$('input[name=policyRange][value=0]').prop('checked',true);
};

$("#PCsearchStatusAll").click(function(e){
	var row = $("#topNGrid").getGridParam("selrow");
	var net_id = $("#topNGrid").getCell(row, "NET_ID");
	var location_id = $("#topNGrid").getCell(row, "LOCATION_ID");
	var type = $("#topNGrid").getCell(row, "TYPE");
	
	if(type == 3){
		$("#policyTypeName").html("OneDrive 검색 목록")
	}else {
		$("#policyTypeName").html("PC검색 상태")
	}
	
	
	
	
	$("#searchStatusPopup").show();
	$.ajax({
		type: "POST",
		url: "/search/selectPCSearchStatus",
		async : false,
		data : {
			net_id : net_id,
			location_id : location_id,
			type : type
		},
	    success: function (result) {
	    	console.log(result);
	    	if(result.length == 0){
	    		$("#searchStatus_txt").css('display', 'block');
	    		$("#searchStatus_tbl").css('display','none');
	    		$(".content-table").css('width', '750px');
	    		$(".content-table").css('height', '70px');
	    		$("#popup_searchStatus").css('left', '47%');
	    		$("#popup_searchStatus").css('top', '68%');
	    	}else{
	    		$("#searchStatus_txt").css('display', 'none');
	    		$("#searchStatus_tbl").css('display', 'table');
	    		$(".content-table").css('width', '750px');
	    		$(".content-table").css('height', '290px');
	    		$("#popup_searchStatus").css('left', '47%');
	    		$("#popup_searchStatus").css('top', '60%');
		    	var details = "";
		    	details += "<tr style=\"height: 45px;\">";
		    	
		    	if(type == 3){
		    		$("#popup_searchStatus").css('width', '545px');
		    		$(".content-table").css('width', '545px');
		    		$("#popup_searchStatus").css('left', '50%');
			    	details += "	<th width=\"100%\">이름</th>";
		    	}else {
			    	details += "	<th width=\"70%\">이름</th>";
			    	details += "	<th width=\"30%\">상태</th>";
		    	}
		    	
		    	/* details += "	<th>진행율</th>"; */ 
		    	details += "</tr>";
		    	$.each(result, function(index, item) {
		    		var statusKR;
		    		if(item.SCHEDULE_STATUS == 'cancelled'){
		    			statusKR = '검색취소';
		    		} else if(item.SCHEDULE_STATUS == 'scheduled'){
		    			statusKR = '검색대기';
		    		}else if(item.SCHEDULE_STATUS == 'failed'){
		    			statusKR = '검색실패';
		    		}else if(item.SCHEDULE_STATUS == 'scanning'){
		    			statusKR = '검색중';
		    		}else if(item.SCHEDULE_STATUS == 'paused'){
		    			statusKR = '검색일시정지';
		    		}else if(item.SCHEDULE_STATUS == 'completed'){
		    			statusKR = '검색완료';
		    		}else if(item.SCHEDULE_STATUS == 'stopped'){
		    			statusKR = '검색정지';
		    		}else if(item.SCHEDULE_STATUS == 'stalled'){
		    			statusKR = '검색멈춤';
		    		}else if(item.SCHEDULE_STATUS == 'paused'){
		    			statusKR = '검색정지';
		    		}else if(item.SCHEDULE_STATUS == 'deactivated'){
		    			statusKR = '검색비활성';
		    		}else if(item.SCHEDULE_STATUS == 'queued'){
		    			statusKR = '검색대기';
		    		}else if(item.SCHEDULE_STATUS == 'interrupted'){
		    			statusKR = '검색중단';
		    		}else if(item.SCHEDULE_STATUS == null){
		    			statusKR = '';
		    		}
		    		details += "<tr style=\"height: 45px;\">";
			    	details += "	<td style=\"text-align: left; padding-left: 0;\">"+item.NAME+"</td>";
			    	if(type != 3){
				    	details += "	<td id=\"status_"+index+"\" style=\"text-align: center; padding-left: 0;\">"+statusKR+"</td>";
			    	}
			    	/* if(item.SCHEDULE_STATUS == 'scanning'){
			    		details += "<td data-indx="+index+" data-targetid="+item.TARGET_ID+" data-apno="+item.AP_NO+" data-id="+item.RECON_SCHEDULE_ID+" data-status="+statusKR+">" ;
			    		details += "<img src=\"${pageContext.request.contextPath}/resources/assets/images/scanning.gif\" style=\"margin-left: 47px;\ cursor:pointer;\" class=\"statusChoiseBtn\" width=\"15px;\">"; 
			    		details += "</td>";
			    		
			    		//details += "<button type='button' style=\"text-align: center; width: 54px; margin: 3px 17px 3px 42px; font-size: 0.6vw;\" class=\"statusChoiseBtn\">선택</button>"+"</td>";
			    	}else{
			    		details += "<td style=\"text-align: center; height: 25px; padding-left: 0;\">"+""+"</td>"
			    	} */
			    	details += "</tr>";
		    	});
		    	$("#details_detail").html(details);
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("정보를 불러오는데 실패하였습니다.");
	        console.log("ERROR : ", error);
	    }
	});
});

$("#btnSearchStatusPopupClose").click(function(e){
	$("#searchStatusPopup").hide();
});

$("#btnCancleSearchStatusPopup").click(function(e){
	$("#searchStatusPopup").hide();
});

</script>

</body>
</html>