<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>
<style>
.user_info th {
	width: 17%;
}
#left_datatype th, #left_datatype td {
	padding: 0;
}
.ui-jqgrid tr.ui-row-ltr td{
	cursor: pointer;
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
}
</style>

<section>
	<!-- container -->
	<div class="container">
		<%-- <%@ include file="../../include/menu.jsp"%> --%>
		<h3>검색 정책</h3>
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
			<div class="list_sch" style="margin-top: 25px;">
				<div class="sch_area">
					<button type="button" class="btn_down" id="btn_new" class="btn_new">신규정책 생성</button>
				</div>
			</div>
			<div class="grid_top" style="height: 325px; width: 100%; padding-top:10px;">
				<div class="left_box2" style="height: 420px; overflow: hidden;">
   					<table id="topNGrid"></table>
   				 	<div id="topNGridPager"></div>
   				</div>
			</div>
			<div class="grid_top" style="width: 50%; height: 340px; bottom: 50px; float: left;">
				<table class="user_info" style="width: 100%; height: 100%; float: left;">
					<caption>정책 상세 정보</caption>
					<colgroup>
						<col width="20%">
						<col width="5%">
						<col width="75%">
					</colgroup>
					<tbody>
						<tr style="height: 25%;">
							<th style="border-bottom: 1px solid #c8ced3; border-radius: 0.25rem 0 0 0;">개인정보 유형 명</th>
							<td>-</td>
							<td id="right_datatype_name"></td>
						</tr>
						<tr style="height: 75%;">
							<th>개인정보유형</th>
							<td>-</td>
							<!-- <td id="left_datatype_name"></td> -->
							<td><table id="left_datatype" style="width: 90%;"></table></td>
						</tr>
					</tbody>
				</table> 
			</div>
			<div class="grid_top" style="width: 50%; height: 340px; bottom: 50px; float: right; padding-left:20px;">
				<table class="user_info" style="width: 100%; height: 100%; float: right;">
					<caption>정책 상세 정보</caption>
					<colgroup>
						<col width="25%">
						<col width="5%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr style="height: 38px;">
							<th class="borderB">정책명</th>
							<td>-</td>
							<td id="right_policy_name"></td>
						</tr>
						<!-- <tr>
							<th class="borderB">정책 시작 시간</th>
							<td>-</td>
							<td id="right_start_time"></td>
							<td><input type="radio" name="start" checked="checked">바로시작</td>
						</tr> -->
						<!-- <tr>
							<th class="borderB">검색 정지 시간</th>
							<td>-</td>
							<td id="right_stop_time"></td>
						</tr> -->
						<tr style="height: 38px;">
							<th class="borderB">개인정보 유형</th>
							<td>-</td>
							<td id="btn_datatype_area">
							</td>
						</tr>
						<tr style="height: 38px;">
							<th class="borderB" style="border-radius: 0.25rem 0 0 0;">정책 접근 가능 유저</th>
							<td>-</td>
							<td id="view_user">
							</td>
						</tr>
						<tr style="height: 38px;">
							<th class="borderB">전체 공개</th>
							<td>-</td>
							<td>
								<input type="checkbox" style="display: none;" id="right_enable"/>
							</td>
						</tr>
						<tr style="height: 38px;">
							<th class="borderB">주기</th>
							<td>-</td>
							<td id="right_cycle">
							</td>
						</tr>
						<tr style="height: 38px;">
							<td colspan="3" style="text-align: right;" id="right_td_save">
								<!-- <button class="btn_down" type="button" id="btnSave" name="btnSave">수정/삭제</button>  -->
							</td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" id="datatype_id" value=""/>
				<input type="hidden" id="std_id" value=""/>
				<input type="hidden" id="idx" value=""/>
			</div>
		</div>
	</div>
	<!-- container -->
	
	<div id="datatype_pop" class="popup_layer" style="display:none">
		<div class="popup_box" style="height: 447px; width: 1300px; left:33%; top:50%; padding: 10px; background: #f9f9f9;">
		<img class="CancleImg" id="btnCancleDataTypePop" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="left_box2" style="height: auto; min-height: 200px; overflow: hidden; margin-top: 40px;">
				<table id="datatypeGrid"></table>
				<div id="datatypeGridPager"></div>
			</div>
			<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnSaveDatatype">변경</button>
				<button type="button" id="btnCancelChangeDatatype">취소</button>
			</div>
		</div>
		</div>
	</div>
	<div id="accessUserPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="height: 200px; width: 400px; padding: 10px; background: #f9f9f9;">
		<img class="CancleImg" id="btnCancleAccessUserPopup" onClick="btnAccessCancel()" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">정책 접근 가능 유저</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="height: 180px; background: #fff; border: 1px solid #c8ced3; padding: 0 0 0 10px;">
					<!-- <h2>세부사항</h2>  -->
					<textarea id="accesUser" class="edt_sch" style="width: 100%; height: 100%; background: #fff; border: none; resize: none; overflow-y: auto;"></textarea>
				</div>
			</div>
			<div class="popup_btn">
				<div id="acesssBtn" class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" onClick="btnAccessSave()">저장</button>
					<button type="button" onClick="btnAccessCancel()">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- <div id="accessSelectUserPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="height: 200px; width: 400px; padding: 10px; background: #f9f9f9;">
			<div class="popup_top" style="background: #f9f9f9; height: 50px; line-height: 50px;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">정책 접근 가능 유저</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="height: 180px; background: #fff; border: 1px solid #c8ced3; padding: 0 0 0 10px;">
					<textarea id="selectUser-box" class="edt_sch" style="width: 100%; height: 100%; border: none; resize: none;" readonly></textarea>
				</div>
			</div>
			<div class="popup_btn">
				<div class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" id="btnAccessSelectUserChangeCancel">닫기</button>
				</div>
			</div>
		</div>
	</div> -->
</section>
<!-- section -->
<!-- section -->
<%@ include file="../../include/footer.jsp"%>
<script>

$(document).ready(function () {
	fn_drawTopNGrid();
	search_policy();
	$("input:checkbox[name='action']").attr("disabled", "disabled");
	
	$("#btnUpdateUser").on("click", function(e) {
		// accessUserPopup
		$("#accessUserPopup").show();
	});
	
	$("#btnCancleAccessUserPopup").on("click", function(e) {
		// accessUserPopup
		$("#accessUserPopup").hide();
	});
	
});

var gridWidth = $("#datatypeGrid").parent().width();
var gridHeight = 410;
$("#datatypeGrid").jqGrid({
	//url: 'data.json',
	datatype: "local",
   	mtype : "POST",
   	ajaxGridOptions : {
		type    : "POST",
		async   : true
	},
	colNames:['','아이디','총아이디','개인정보유형명', '타입 유형명카피',
		'주민등록번호','주민체크','주민갯수','주민중복',
		'외국인등록번호','외국인체크','외국인갯수','외국인중복',
		'운전면허번호','운전체크', '운전갯수','운전중복',
		'여권번호','여권체크','여권갯수','여권중복',
		'계좌번호','계좌체크','계좌갯수','계좌중복',
		'카드번호','카드체크', '카드갯수','카드중복',
		'전화번호','전화체크','전화갯수','전화중복',
		'이메일','이메일체크','이메일갯수','이메일중복',
		'휴대전화번호','휴대전화체크','휴대전화갯수','휴대전화중복',
		'OCR', 'OCR체크', '증분검사CHK', '증분검사', 'VOICE', '작업'],
	colModel: [      
		{ index: 'CHKBOX', 		name: 'CHKBOX',		width: 10,  align: 'center', editable: true, edittype: 'checkbox', 
			editoptions: { value: '1:0' }, formatoptions: { disabled: false }, formatter: createRadio
		},
		{ index: 'DATATYPE_ID', 				name: 'DATATYPE_ID',				width:1, align:'center', hidden:true},
		{ index: 'STD_ID', 						name: 'STD_ID',				width:1, align:'center', hidden:true},
		{ index: 'DATATYPE_LABEL_COPY',			name: 'DATATYPE_LABEL_COPY',		width: 100, align: 'left'},
		{ index: 'DATATYPE_LABEL',				name: 'DATATYPE_LABEL',				width: 100, align: 'left', hidden: true},
		{ index: 'RRN_CHK', 					name: 'RRN_CHK', 					width: 40, align: 'left', sortable: false },
		{ index: 'RRN', 						name: 'RRN', 						width: 40, align: 'left', hidden: true},
		{ index: 'RRN_CNT', 					name: 'RRN_CNT', 					width: 40, align: 'left', hidden: true},
		{ index: 'RRN_DUP', 					name: 'RRN_DUP', 					width: 40, align: 'left', hidden: true},
		{ index: 'FOREIGNER_CHK', 				name: 'FOREIGNER_CHK', 				width: 40, align: 'left', sortable: false },
		{ index: 'FOREIGNER', 					name: 'FOREIGNER', 					width: 40, align: 'left', hidden: true},
		{ index: 'FOREIGNER_CNT', 				name: 'FOREIGNER_CNT', 				width: 40, align: 'left', hidden: true},
		{ index: 'FOREIGNER_DUP', 				name: 'FOREIGNER_DUP', 				width: 40, align: 'left', hidden: true},
		{ index: 'DRIVER_CHK', 					name: 'DRIVER_CHK', 				width: 40, align: 'left', sortable: false },
		{ index: 'DRIVER', 						name: 'DRIVER', 					width: 40, align: 'left', hidden: true},
		{ index: 'DRIVER_CNT', 					name: 'DRIVER_CNT', 				width: 40, align: 'left', hidden: true},
		{ index: 'DRIVER_DUP', 					name: 'DRIVER_DUP', 				width: 40, align: 'left', hidden: true},
		{ index: 'PASSPORT_CHK', 				name: 'PASSPORT_CHK', 				width: 40, align: 'left', sortable: false },
		{ index: 'PASSPORT', 					name: 'PASSPORT', 					width: 40, align: 'left', hidden: true},
		{ index: 'PASSPORT_CNT', 				name: 'PASSPORT_CNT', 				width: 40, align: 'left', hidden: true},
		{ index: 'PASSPORT_DUP', 				name: 'PASSPORT_DUP', 				width: 40, align: 'left', hidden: true},
		{ index: 'ACCOUNT_CHK', 				name: 'ACCOUNT_CHK', 				width: 40, align: 'left', sortable: false },
		{ index: 'ACCOUNT', 					name: 'ACCOUNT', 					width: 40, align: 'left', hidden: true},
		{ index: 'ACCOUNT_CNT', 				name: 'ACCOUNT_CNT', 				width: 40, align: 'left', hidden: true },
		{ index: 'ACCOUNT_DUP', 				name: 'ACCOUNT_DUP', 				width: 40, align: 'left', hidden: true },
		{ index: 'CARD_CHK', 					name: 'CARD_CHK', 					width: 40, align: 'left', sortable: false },
		{ index: 'CARD', 						name: 'CARD', 						width: 40, align: 'left', hidden: true},
		{ index: 'CARD_CNT', 					name: 'CARD_CNT', 					width: 40, align: 'left', hidden: true },
		{ index: 'CARD_DUP', 					name: 'CARD_DUP', 					width: 40, align: 'left', hidden: true },
		{ index: 'LOCAL_PHONE_CHK', 			name: 'LOCAL_PHONE_CHK', 			width: 40, align: 'left', sortable: false, hidden: true },
		{ index: 'LOCAL_PHONE', 				name: 'LOCAL_PHONE', 				width: 40, align: 'left', hidden: true},
		{ index: 'LOCAL_PHONE_CNT', 			name: 'LOCAL_PHONE_CNT', 			width: 40, align: 'left', hidden: true},
		{ index: 'LOCAL_PHONE_DUP', 			name: 'LOCAL_PHONE_DUP', 			width: 40, align: 'left', hidden: true},
		{ index: 'EMAIL_CHK', 					name: 'EMAIL_CHK', 					width: 40, align: 'left', sortable: false },
		{ index: 'EMAIL', 						name: 'EMAIL', 						width: 40, align: 'left', hidden: true},
		{ index: 'EMAIL_CNT', 					name: 'EMAIL_CNT', 					width: 40, align: 'left', hidden: true},
		{ index: 'EMAIL_DUP', 					name: 'EMAIL_DUP', 					width: 40, align: 'left', hidden: true},
		{ index: 'MOBILE_PHONE_CHK', 			name: 'MOBILE_PHONE_CHK', 			width: 40, align: 'left', sortable: false },
		{ index: 'MOBILE_PHONE', 				name: 'MOBILE_PHONE', 				width: 40, align: 'left', hidden: true},
		{ index: 'MOBILE_PHONE_CNT', 			name: 'MOBILE_PHONE_CNT', 			width: 40, align: 'left', hidden: true},
		{ index: 'MOBILE_PHONE_DUP', 			name: 'MOBILE_PHONE_DUP', 			width: 40, align: 'left', hidden: true},
		{ index: 'OCR_CHK', 					name: 'OCR_CHK', 					width: 40, align: 'left', sortable: false, hidden: true},
		{ index: 'OCR', 						name: 'OCR', 						width: 40, align: 'left', hidden: true},
		{ index: 'RECENT', 						name: 'RECENT', 					width: 40, align: 'center', sortable: false, hidden: true },
		{ index: 'RECENT_CHK', 					name: 'RECENT_CHK', 				width: 40, align: 'center'},
		{ index: 'VOICE', 						name: 'VOICE', 						width: 40, align: 'left', hidden: true},
		{ index: 'BUTTON', 						name: 'BUTTON',						width: 40, align: 'left', sortable: false, hidden: true },
		
	],
	viewrecords: true, // show the current page, data rang and total records on the toolbar
	width: gridWidth,
	height: gridHeight,
	loadonce: true, // this is just for the demo
   	autowidth: true,
	shrinkToFit: false,
	rownumbers : false, // 행번호 표시여부
	rownumWidth : 30, // 행번호 열의 너비	
	rowNum:15,
   	rowList:[15,30,50],			
	pager: "#datatypeGridPager",
	//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	  	
  	},
  	ondblClickRow: function(nRowid, icol, cellcontent, e){
  		
  	},
	loadComplete: function(data) {
		var ids = $("#datatypeGrid").getDataIDs();
        $.each(ids, function(idx, rowId) {
            rowData = $("#datatypeGrid").getRowData(rowId) ;
            $("#datatypeGrid").setCell(rowId, 'DATATYPE_LABEL_COPY', rowData.DATATYPE_LABEL);
            
            var html = ""; 
            	
            html = "<input type='checkbox' disabled='disabled' "+((rowData.RRN == 1)?"checked='checked'":"")+">&nbsp;";
        	html += "<input type='checkbox' disabled='disabled' "+((rowData.RRN_DUP == 1)?"checked='checked'":"")+">&nbsp;";
        	html += (rowData.RRN_CNT > 0)? rowData.RRN_CNT : '';
        	$("#datatypeGrid").setCell(rowId, 'RRN_CHK', html);
          
            html = "<input type='checkbox' disabled='disabled' "+((rowData.FOREIGNER == 1)?"checked='checked'":"")+">&nbsp;";
        	html += "<input type='checkbox' disabled='disabled' "+((rowData.FOREIGNER_DUP == 1)?"checked='checked'":"")+">&nbsp;";
        	html += (rowData.FOREIGNER_CNT > 0)? rowData.FOREIGNER_CNT : '';
        	$("#datatypeGrid").setCell(rowId, 'FOREIGNER_CHK', html);
            
            html = "<input type='checkbox' disabled='disabled' "+((rowData.DRIVER == 1)?"checked='checked'":"")+">&nbsp;";
        	html += "<input type='checkbox' disabled='disabled' "+((rowData.DRIVER_DUP == 1)?"checked='checked'":"")+">&nbsp;";
         	html += (rowData.DRIVER_CNT > 0)? rowData.DRIVER_CNT : '';
        	$("#datatypeGrid").setCell(rowId, 'DRIVER_CHK', html);
            
            html = "<input type='checkbox' disabled='disabled' "+((rowData.PASSPORT == 1)?"checked='checked'":"")+">&nbsp;";
        	html += "<input type='checkbox' disabled='disabled' "+((rowData.PASSPORT_DUP == 1)?"checked='checked'":"")+">&nbsp;";
        	html += (rowData.PASSPORT_CNT > 0)? rowData.PASSPORT_CNT : '';
        	$("#datatypeGrid").setCell(rowId, 'PASSPORT_CHK', html);
        	
            html = "<input type='checkbox' disabled='disabled' "+((rowData.ACCOUNT == 1)?"checked='checked'":"")+">&nbsp;";
        	html += "<input type='checkbox' disabled='disabled' "+((rowData.ACCOUNT_DUP == 1)?"checked='checked'":"")+">&nbsp;";
        	html += (rowData.ACCOUNT_CNT > 0)? rowData.ACCOUNT_CNT : '';
        	$("#datatypeGrid").setCell(rowId, 'ACCOUNT_CHK', html);
            
            html = "<input type='checkbox' disabled='disabled' "+((rowData.CARD == 1)?"checked='checked'":"")+">&nbsp;";
        	html += "<input type='checkbox' disabled='disabled' "+((rowData.CARD_DUP == 1)?"checked='checked'":"")+">&nbsp;";
        	html += (rowData.CARD_CNT > 0)? rowData.CARD_CNT : '';
        	$("#datatypeGrid").setCell(rowId, 'CARD_CHK', html);
        	
            html = "<input type='checkbox' disabled='disabled' "+((rowData.LOCAL_PHONE == 1)?"checked='checked'":"")+">&nbsp;";
        	html += "<input type='checkbox' disabled='disabled' "+((rowData.LOCAL_PHONE_DUP == 1)?"checked='checked'":"")+">&nbsp;";
        	html += (rowData.LOCAL_PHONE_CNT > 0)? rowData.LOCAL_PHONE_CNT : '';
        	$("#datatypeGrid").setCell(rowId, 'LOCAL_PHONE_CHK', html);
        	
        	html = "<input type='checkbox' disabled='disabled' "+((rowData.EMAIL == 1)?"checked='checked'":"")+">&nbsp;";
         	html += "<input type='checkbox' disabled='disabled' "+((rowData.EMAIL_DUP == 1)?"checked='checked'":"")+">&nbsp;";
         	html += (rowData.EMAIL_CNT > 0)? rowData.EMAIL_CNT : '';
         	$("#datatypeGrid").setCell(rowId, 'EMAIL_CHK', html);
            
            html = "<input type='checkbox' disabled='disabled' "+((rowData.MOBILE_PHONE == 1)?"checked='checked'":"")+">&nbsp;";
        	html += "<input type='checkbox' disabled='disabled' "+((rowData.MOBILE_PHONE_DUP == 1)?"checked='checked'":"")+">&nbsp;";
        	html += (rowData.MOBILE_PHONE_CNT > 0)? rowData.MOBILE_PHONE_CNT : '';
        	$("#datatypeGrid").setCell(rowId, 'MOBILE_PHONE_CHK', html);
            
            /* if(rowData.OCR == 1) $("#targetGrid").setCell(rowId, 'OCR_CHK', "<img src='${pageContext.request.contextPath}/resources/assets/images/img_check.png' />");
            else $("#targetGrid").setCell(rowId, 'OCR_CHK', '<p></p>'); */
            html = "<input type='checkbox' disabled='disabled' "+((rowData.OCR == 1)?"checked='checked'":"")+">&nbsp;";
            $("#datatypeGrid").setCell(rowId, 'OCR_CHK', html);
            
            html = "<input type='checkbox' disabled='disabled' "+((rowData.RECENT == 1)?"checked='checked'":"")+">&nbsp;";
            $("#datatypeGrid").setCell(rowId, 'RECENT_CHK', html);
            
            $("#datatypeGrid").setCell(rowId, 'BUTTON', "<button type='button' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>");
            
            if(rowData.DATATYPE_ID == $('#datatype_id').val()){
            	$("#gridRadio_" + rowData.DATATYPE_ID).prop('checked', true);
            }
        });
		
		$(".gridSubSelBtn").on("click", function(e) {
	  		e.stopPropagation();
			
			$("#datatypeGrid").setSelection(event.target.parentElement.parentElement.id);
			
			var offset = $(this).parent().offset();
			$("#taskWindow").css("left", (offset.left - $("#taskWindow").width()) + "px");
			// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
			$("#taskWindow").css("top", offset.top + $(this).height() + "px");

			var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
			var taskBottom = Number($("#taskWindow").css("top").replace("px","")) + $("#taskWindow").height();

			if (taskBottom > bottomLimit) { 
				$("#taskWindow").css("top", Number($("#taskWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
			}
			$("#taskWindow").show();
		}); 
		
    },
    gridComplete : function() {
    }
});

function createRadio(cellvalue, options, rowObject) {
	//var value = options['rowId'];
	var value = rowObject['DATATYPE_ID'];
	var str = '<input type="radio" name="gridRadio" data-rowid="'+options['rowId']+'" value="' + rowObject['DATATYPE_ID'] + '" id="gridRadio_' + value + '">';
    return str;
}
function fn_drawTopNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	$("#topNGrid").jqGrid({
		<%-- url: "<%=request.getContextPath()%>/target/selectAdminServerFileTopN", --%>
		datatype: "local",
	   	mtype : "POST",
		colNames:[
			'개인정보유형', '','정책명','개인정보 유형','개인정보 유형1', 'datatype_id', 'std_id', 'comment', 'cycle', 'action', 'enabled', 'view_user', 'start_dtm', 'from_hour', 'from_minu', 'to_hour', 'to_minu', 'policy_type',
			'recent'
		],
		colModel: [
			 
			{ index: 'DATATYPE', 		name: 'DATATYPE', 	editable: true, hidden: true },
			{ index: 'IDX', 			name: 'IDX', 	editable: true, width: 200, hidden: true },
			{ index: 'NAME', 			name: 'NAME', 	editable: true, width: 200 },
			//{ index: 'OWNER', 		name: 'OWNER', 	width: 100, align: "center" },
			{ index: 'TYPE', 			name: 'TYPE', 	width: 200, formatter:createType},
			{ index: 'TYPE1', 			name: 'TYPE1', 	width: 200, hidden: true },
			{ index: 'DATATYPE_ID', 	name: 'DATATYPE_ID', 	width: 200, hidden: true},
			{ index: 'STD_ID', 			name: 'STD_ID', 	width: 200, hidden: true},
			{ index: 'COMMENT', 		name: 'COMMENT', 	width: 200, hidden: true},
			{ index: 'CYCLE', 			name: 'CYCLE', 	width: 200, hidden: true},
			{ index: 'ACTION', 			name: 'ACTION', 	width: 200, hidden: true},
			{ index: 'ENABLED', 		name: 'ENABLED', 	width: 200, hidden: true},
			{ index: 'VIEW_USER', 		name: 'VIEW_USER', 	width: 200, hidden: true},
            { index: 'START_DTM',         name: 'START_DTM',     width: 200, hidden: true},
			{ index: 'PAUSE_FROM', 		name: 'PAUSE_FROM', 	width: 200, hidden: true},
			{ index: 'PAUSE_FROM_MINU', name: 'PAUSE_FROM_MINU', 	width: 200, hidden: true},
			{ index: 'PAUSE_TO', 		name: 'PAUSE_TO', 	width: 200, hidden: true},
			{ index: 'PAUSE_TO_MINU', 	name: 'PAUSE_TO_MINU', 	width: 200, hidden: true},
			{ index: 'POLICY_TYPE', 	name: 'POLICY_TYPE', 	width: 200, hidden: true},
			{ index: 'RECENT', 			name: 'RECENT', 	width: 200, hidden: true}
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 230,
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
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {
	  		var rowData = $(this).getRowData(rowid);
	  		
	  		setDetails(rowid);
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data) {
			//console.log(data);
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
})

function search_policy(){
	var postData = {name: $('#searchKey').val()}
	$("#topNGrid").setGridParam({url:"<%=request.getContextPath()%>/search/getPolicy", postData : postData, datatype:"json" }).trigger("reloadGrid");
}

function setDetails(rowid){
	var policy_name = $('#topNGrid').getCell(rowid, 'NAME');
	var type = $('#topNGrid').getCell(rowid, 'TYPE1');
	var comment = $('#topNGrid').getCell(rowid, 'COMMENT');
	var enabled = $('#topNGrid').getCell(rowid, 'ENABLED');
	var action = $('#topNGrid').getCell(rowid, 'ACTION');
	var view_user = $('#topNGrid').getCell(rowid, 'VIEW_USER');
	var policy_type = $('#topNGrid').getCell(rowid, 'POLICY_TYPE');
	
	//alert(policy_name)
	$('#left_policy_name').text(policy_name);
	$('#right_policy_name').text(policy_name);
	$('#right_datatype_name').text(type);
	$('#right_datatype_name').text(type);
	
	var view_user_detail = "";
	view_user_detail = '<label style="position: relative;">서버운영 관계자</label>';

	$('#accesUser').val(view_user.replace(/ /gi, "").replace(/,/gi, "\n"));
	$('#view_user').html(view_user_detail);
	$('#right_td_save').html('<button class="btn_down" type="button" style="height: 26px;" onclick="btn_modify(\''+rowid+'\')">수정/삭제</button> ');
	$('#datatype_id').val($('#topNGrid').getCell(rowid, 'DATATYPE_ID'))
	$('#std_id').val($('#topNGrid').getCell(rowid, 'STD_ID'));
	$('#idx').val($('#topNGrid').getCell(rowid, 'IDX'))
	$('#btn_datatype_area').html('')
	
	
	
	// 개인정보 유형 
	var datatype = setDatatype($('#topNGrid').getRowData(rowid));
	
	$('#left_datatype').html(datatype);
	
	var cycle = setCycle($('#topNGrid').getRowData(rowid));
	$('#right_cycle').html(cycle);
	
	// 전체 공개
	$('#right_enable').attr('disabled', 'disabled')
	if(policy_type == 1) {
		if(enabled == 1){
			$('#right_enable').css('display', '');
			$('#right_enable').prop('checked', 'checked');
		}else {
			$('#right_enable').css('display', '');
			$('#right_enable').prop('checked', '');
		}
	}else {
		$('#right_enable').css('display', 'none');
		$('#right_enable').prop('checked', '');
	}
	
	if(policy_type == 1) {
		$("#action").css('display', 'none');
	}else {
		$("#action").css('display', '');
		
	}

	$("input:checkbox[name='action']").prop("checked", false);
	$("input:checkbox[name='action'][value='"+action+"']").prop("checked", true);
	$("input:checkbox[name='action']").attr("disabled", "disabled");
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
function setStartdtm(rowData){
	var start_dtm = rowData.START_DTM;
	var start_ymd = '';
	var start_hour = '';
	var start_minutes = '';
	if(start_dtm != null && start_dtm != ''){
		start_ymd = start_dtm.substr(0,10);
		start_hour = start_dtm.substr(11,2);
		start_minutes = start_dtm.substr(14,2);
	} else {
		var oToday = new Date();
		start_ymd = getFormatDate(oToday);
	}
	
	var html = "";
	html += "<input type='date' id='start_ymd' style='text-align: center; height: 27px;' value='"+start_ymd+"' disabled='disabled'>&nbsp;";

	html += "<select name=\"start_hour\" id=\"start_hour\" disabled='disabled'>"
	for(var i=0; i<24; i++){
		var hour = (parseInt(i));
		html += "<option value=\""+hour+"\" "+(hour == parseInt(start_hour)? 'selected': '')+">"+hour+"</option>"
	}
	html += "</select> : "

	html += "<select name=\"start_minutes\" id=\"start_minutes\" disabled='disabled'>"
	for(var i=0; i<60; i++){
		var minutes = parseInt(i)
		html += "<option value=\""+minutes+"\" "+(minutes == parseInt(start_minutes)? 'selected': '')+">"+minutes+"</option>"
	}
	html += "</select>"
	return html;
}


function setStopdtm(rowData){
	var pause_from = rowData.PAUSE_FROM;
	var pause_from_minu = rowData.PAUSE_FROM_MINU;
	var pause_to = rowData.PAUSE_TO;
	var pause_to_minu = rowData.PAUSE_TO_MINU;
	var start_hour = '';
	var start_minutes = '';
	var stop_hour = '';
	var stop_minutes = '';
	var chk = 0;
	var sel_chk = 0;
	if(pause_from != null && pause_from != ''){
		start_hour = pause_from / 60 / 60;
		start_minutes = pause_from_minu / 60;
		stop_hour = pause_to / 60 / 60;
		stop_minutes = pause_to_minu / 60;
		sel_chk = 1;
	}
	
	if(rowData != null && rowData != ''){
		chk = 1;
	}
	
	var html = "";
	html += "<input type='checkbox' "+(sel_chk == 1 ?  'checked' : '') +" id='stop_chk'  "+(chk == 1 ?  'disabled' : '' ) +"/>&nbsp;&nbsp;시작 : &nbsp;";

	html += "<select name=\"start_hour\" id=\"from_time_hour\" disabled='disabled'>"
	for(var i=0; i<24; i++){
		var hour = (parseInt(i));
		html += "<option value=\""+hour+"\" "+(hour == parseInt(start_hour)? 'selected': '')+">"+hour+"</option>"
	}
	html += "</select> : "

	html += "<select name=\"start_minutes\" id=\"from_time_minutes\" disabled='disabled'>"
	for(var i=0; i<60; i++){
		var minutes = parseInt(i)
		html += "<option value=\""+minutes+"\" "+(minutes == parseInt(start_minutes)? 'selected': '')+">"+minutes+"</option>"
	}
	html += "</select>"
	html += "&nbsp;&nbsp;~&nbsp;&nbsp;정지 : &nbsp;";

	html += "<select name=\"start_hour\" id=\"to_time_hour\" disabled='disabled'>"
	for(var i=0; i<24; i++){
		var hour = (parseInt(i));
		html += "<option value=\""+hour+"\" "+(hour == parseInt(stop_hour)? 'selected': '')+">"+hour+"</option>"
	}
	html += "</select> : "

	html += "<select name=\"start_minutes\" id=\"to_time_minutes\" disabled='disabled'>"
	for(var i=0; i<60; i++){
		var minutes = parseInt(i)
		html += "<option value=\""+minutes+"\" "+(minutes == parseInt(stop_minutes)? 'selected': '')+">"+minutes+"</option>"
	}
	html += "</select>"

	
	return html;
}


function setCycle(rowData){
	var cycle = rowData.CYCLE;
	
	var html = "";
	html += "<select name=\"cycle\" id=\"cycle\" disabled=\"disabled\">"
	html += "	<option value=\"0\" "+((cycle == 0)? 'selected': '')+">한번만</option>"
	html += "	<option value=\"1\" "+((cycle == 1)? 'selected': '')+">매일</option>"
	html += "	<option value=\"2\" "+((cycle == 2)? 'selected': '')+">매주</option>"
	html += "	<option value=\"3\" "+((cycle == 3)? 'selected': '')+">매월</option>"
	html += "</select>"
	
	return html;
}

function setDatatype(rowData){
	
	console.log(rowData.DATATYPE);
	
	var html = "<table>";
	
	html += "<tr>"
	html += "	<th style=\"width: 18%;\">주민등록번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.RRN == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.RRN_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.RRN_CNT > 0)? rowData.RRN_CNT : '';
	html += "	</td>"
	html += "	<th style=\"width: 18%;\">외국인등록번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.FOREIGNER == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.FOREIGNER_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.FOREIGNER_CNT > 0)? rowData.FOREIGNER_CNT : '';
	html += "	</td>"
	html += "	<th style=\"width: 18%;\">운전면허번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.DRIVER == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.DRIVER_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.DRIVER_CNT > 0)? rowData.DRIVER_CNT : '';
	html += "	</td>"
	html += "</tr>"
	html += "<tr>"
	html += "	<th style=\"width: 18%;\">여권번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.PASSPORT == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.PASSPORT_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.PASSPORT_CNT > 0)? rowData.PASSPORT_CNT : '';
	html += "	</td>"
	html += "	<th style=\"width: 18%;\">계좌번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.ACCOUNT == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.ACCOUNT_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.ACCOUNT_CNT > 0)? rowData.ACCOUNT_CNT : '';
	html += "	</td>"
	html += "	<th style=\"width: 18%;\">카드번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.CARD == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.CARD_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.CARD_CNT > 0)? rowData.CARD_CNT : '';
	html += "	</td>"
	html += "</tr>"
	html += "<tr>"
	html += "	<th>이메일</th>"
	html += "	<td><input type='checkbox' disabled='disabled' "+((rowData.EMAIL == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.EMAIL_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.EMAIL_CNT > 0)? rowData.EMAIL_CNT : '';
	html += "	</td>"
	html += "	<th>휴대전화번호</th>"
	html += "	<td><input type='checkbox' disabled='disabled' "+((rowData.MOBILE_PHONE == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.MOBILE_PHONE_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.MOBILE_PHONE_CNT > 0)? rowData.MOBILE_PHONE_CNT : '';
	html += "	</td>"
	html += "	<th>증분검사</th>"
	html += "	<td><input type='checkbox' disabled='disabled' "+((rowData.RECENT == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	</td>"
	html += "</tr>"
	html += "</table>"
	  		
	return html;
}

function btn_modify(rowid){
	//alert(rowid)
	var rowData = $('#topNGrid').getRowData(rowid);
	//$('#left_datatype').find('input').removeAttr("disabled");
	$('#right_days').find('input').removeAttr("disabled");
	$('#cycle').removeAttr("disabled");
	$('#right_enable').removeAttr("disabled");
	
	/* $('#right_comment').html("<input type='text' id='comment' value='"+rowData['COMMENT']+"'/>"); */
	$('#right_policy_name').html("<input placeholder='정책명을 입력하세요.' type='text' id='policy_name' value='"+rowData['NAME']+"'/>");
	
	var btn_area = "<button class='btn_down' style='height:26px' type='button' onclick='modifyPolicy()'>수정</button>&nbsp;";
	btn_area += "<button class='btn_down' style='height:26px; margin-right: 2px;' type='button' onclick='deletePolicy(\""+rowData['IDX']+"\")'>삭제</button>";
	btn_area += "<button class='btn_down' style='height:26px' type='button' onclick='setDetails(\""+rowid+"\")'>취소</button>";
	$('#right_td_save').html(btn_area);
	//$('#right_start_time').find('*').removeAttr("disabled");
	//$('#right_stop_time').find('*').removeAttr("disabled");
	$("input:checkbox[name='action']").removeAttr("disabled");
	
	$('#btn_datatype_area').html('<button class="btn_down" style="font-size: 11px; height: 27px;" type="button" onclick="btn_datatype(\''+rowid+'\')">개인정보유형변경</button>');
	
	
	var btn_acess = '<button type="button" onClick="btnAccessSave()">저장</button> ';
	btn_acess += '<button type="button" onClick="btnAccessCancel('+rowid+')">취소</button>';

	$("#acesssBtn").html(btn_acess);
	$('#accesUser').removeAttr("disabled");
	
	var	view_user_content = '<div id="selectUser" style=" padding-right: 5px; float:left;">';
		view_user_content += '<label for="check_server" style="padding-right: 5px; line-height: 26px;">서버</label>' ;
	 	
	$("#view_user").html(view_user_content);
	if(rowData.POLICY_TYPE == 1){
		$("input:radio[name='acessUser']:radio[value='server']").prop("checked", true);
		$("#action").css('display', 'none');
	}else if(rowData.POLICY_TYPE == 2){
		$("input:radio[name='acessUser']:radio[value='pc']").prop("checked", true);
		$("#action").css('display', '');
		$("#accessible_pc_btn").show();
	} 
}

function accessible_server(){
	$("#accessible_pc_btn").hide();
	$("#accessible_pc").hide();
	$("#action").css('display', 'none');
	$("input:checkbox[name='action']").each(function() {
	      if(this.value == 0){//checked 처리된 항목의 값
	    	  this.checked = true; //checked 처리
	      } else {
	    	  this.checked = false; //checked 처리
	      }

	});
	$("#right_enable").css('display', '');
	$('#right_enable').prop('checked', '');
	$("#accessible_server").show();
}
function accessible_pc_btn(){
	$("#accessible_pc_btn").show();
	$("#accessible_pc").show();
	$("#action").css('display', '');
	$("#right_enable").css('display', 'none');
	$('#right_enable').prop('checked', '');
	$("#accessible_server").hide();
}


function btn_datatype(rowid){
	//alert(rowid);
	var postData = {name : ''};
	$("#datatypeGrid").setGridParam({url:"<%=request.getContextPath()%>/search/getProfile", postData : postData, datatype:"json" }).trigger("reloadGrid");
	$('#datatype_pop').show();
}

function btn_userSelect(){
	//alert(rowid);
	
	$("#accesUser").attr("disabled", "disabled");
	$("#acesssBtn").html("<button type='button' onClick='btnAccessExit()'>닫기</button>");
	$('#accessUserPopup').show();
	
}

//정책 접근 가능 유저 닫기 버튼
function btnAccessExit(){
	$("#accessUserPopup").hide();
}

//정책 접근 가능 유저 저장 버튼
function btnAccessSave(){
	$("#accessUserPopup").hide();
}

//정책 접근 가능 유저 취소 버튼
function btnAccessCancel(rowid){
	var view_user = $('#topNGrid').getCell(rowid, 'VIEW_USER');
	
	if($('#accesUser').val().trim() != ""  && view_user != null){
		$('#accesUser').val(view_user.replace(/ /gi, "").replace(/,/gi, "\n"));
	}
	
	if(view_user == null){
		$('#accesUser').val("");
	}

	$("#accessUserPopup").hide();
}

function btn_userUpdate(){
	//var view_user = $('#topNGrid').getCell(rowid, 'VIEW_USER');
	
	//console.log(view_user);
	//$('#accesUser').text(view_user.replace(/ /gi, "").replace(/,/gi, "\n"));
	
	$('#accessUserPopup').show();
}


$('#btnCancelChangeDatatype').on('click', function(){
	$('#datatype_pop').hide();
})

$('#btnCancleDataTypePop').on('click', function(){
	$('#datatype_pop').hide();
})

$('#btnSaveDatatype').on('click', function(){
	/* console.log($("input:radio[name=gridRadio]:checked").val())
	console.log($("input:radio[name=gridRadio]:checked").data('rowid')) */
	var rowid = $("input:radio[name=gridRadio]:checked").data('rowid');
	var rowData = $('#datatypeGrid').getRowData(rowid);
	var html = setDatatype(rowData)
	//console.log()
	
	$('#left_datatype').html(html);
	$('#right_datatype_name').text(rowData.DATATYPE_LABEL);
	$('#datatype_id').val(rowData.DATATYPE_ID);
	$('#std_id').val(rowData.STD_ID);
	$('#datatype_pop').hide();
})

$('#btn_new').on('click', function(){
	$('#right_policy_name').html("<input type='text'placeholder='정책명을 입력하세요.' id='policy_name' value='' style='padding-left: 10px;'/>");
	$('#left_policy_name').text('');
	$('#right_datatype_name').text('');
	$('#btn_datatype_area').html('<button class="btn_down" style="font-size: 11px; height: 27px;" type="button" onclick="btn_datatype(\'\')">개인정보유형변경</button>');
	
	var	view_user_content = '<div id="selectUser" style=" padding-right: 5px; float:left;">';
		view_user_content += '<label for="check_server" style="padding-right: 5px; line-height: 26px;">서버</label>' ;
	$('#view_user').html(view_user_content);
	$('#right_td_save').html('<button class="btn_down" type="button" style="height: 27px;" onclick="btn_insertPolicy()">생성</button> ');
	$('#datatype_id').val('');
	$('#std_id').val('');
	$("#accesUser").val('');
	$('#right_enable').removeAttr("disabled");
	$('#right_enable').css('display', '');
	$('#right_enable').prop('checked', '');
	var btn_acess = '<button type="button" onClick="btnAccessSave()">저장</button> ';
	btn_acess += '<button type="button" onClick="btnAccessCancel()">취소</button>';

	$("#acesssBtn").html(btn_acess);
	$('#accesUser').removeAttr("disabled");
	
	$("#action").css('display', '');
	$("input:checkbox[name='action']").removeAttr("disabled");

	$("input:checkbox[name='action']").each(function() {
	      if(this.value == 0){//checked 처리된 항목의 값
	    	  this.checked = true; //checked 처리
	      } else {
	    	  this.checked = false; //checked 처리
	      }

	});
	
	$('#left_datatype').html('');
	
	$('#right_cycle').html('');
	$('#left_disable').text('');
	
	var cycle = "";
	cycle += "<select name=\"cycle\" id=\"cycle\" >"
	cycle += "	<option value=\"0\">한번만</option>"
	cycle += "	<option value=\"1\">매일</option>"
	cycle += "	<option value=\"2\">매주</option>"
	cycle += "	<option value=\"3\">매월</option>"
	cycle += "</select>"
	$('#right_cycle').html(cycle);
})

function deletePolicy(idx){
	var datatype_id = $("#datatype_id").val();
	var postData = {
		idx: idx,
		datatype_id : datatype_id
	};
	console.log(postData);
	var message = "정말 삭제하시겠습니까?";
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/deletePolicy",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	console.log("asdf");
		    	console.log(resultMap);
		        if (resultMap.resultCode == 0) {
		        	alert("삭제를 완료하였습니다.");
		        	search_policy();
		        	initDetails();
			    } else if(resultMap.resultCode == -9) {
			        alert("삭제 할 수 없는 정책 입니다.");
			    } else {
			        alert("삭제를 실패하였습니다.");
			    }
		    },
		    error: function (request, status, error) {
				alert("Server Error : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	}
}

function modifyPolicy(){
	var comment = $('#comment').val();
	var policy_name = $('#policy_name').val();
	/* 
	var start_ymd = $('#start_ymd').val();
	var start_hour = $('#start_hour').val();
	var start_minutes = $('#start_minutes').val(); 
	*/
	var cycle = $('#cycle').val();
	var action = 0;
	var datatype_id = $('#datatype_id').val();
	var std_id = $('#std_id').val();
	//var pause_chk = ($('#stop_chk').is(':checked')? '1': '0');
	var pause_chk = 0;
	var enabled = ($('#right_enable').is(':checked')? '1': '0');
	var idx = $('#idx').val();
	
	//var start_dtm = start_ymd + ' ' + String(start_hour) + ':' + String(start_minutes)
	var start_dtm = "2022-01-01 23:59";
	
	
	var from_time_hour = null;
	var from_time_minutes = null;
	var to_time_hour = null;
	var to_time_minutes = null;
	var pause_days = null;
	var userArr = new Array();
	var policy_type = null;

	if(policy_name == ""){
		alert("정책명을 입력해주세요.");
		return;
	}
	
	if(datatype_id == ""){
		alert("개인정보 유형을 선택하여주세요.");
		return;
	}
	
	if(pause_chk == 1) {
		from_time_hour = $('#from_time_hour').val() * 60 * 60;
		from_time_minutes = $('#from_time_minutes').val() * 60;
		to_time_hour = $('#to_time_hour').val() * 60 * 60;
		to_time_minutes = $('#to_time_minutes').val() * 60;
		
		var from_time = from_time_hour + from_time_minutes;
		var to_time = to_time_hour + to_time_minutes;
		
		if(from_time == to_time) {
			alert("검색 정지 시작 시간과 끝 시간을 다르게 설정해주세요");
			return;
		}
		pause_days = 62;
	}
	
	$("input:checkbox[name='action']").each(function() {
	   if(this.checked){//checked 처리된 항목의 값
	   	action = this.value;
	   } 
	});
	
	// 정책 접근 가능 유저 = 서버
	policy_type = 1;
	action = 0;
	
	
	var postData = {
		idx: idx,
		policy_name: policy_name,
		comment: comment,
		start_dtm: start_dtm,
		cycle: cycle,
		datatype_id: datatype_id,
		std_id: std_id,
		enabled: enabled,
		from_time_hour: from_time_hour,
		from_time_minutes: from_time_minutes,
		to_time_hour: to_time_hour,
		to_time_minutes: to_time_minutes,
		pause_days: pause_days,
		action: action,
		user: userArr.join(", "),
		policy_type: policy_type 
	};
	var message = "수정하시겠습니까?";
	
	console.log("postData");
	console.log(postData);
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/modifyPolicy",
			async : false,
			data : postData,
		    success: function (resultMap) {
		        if (resultMap.resultCode == 0) {
		        	alert("수정하였습니다.");
		        	<%-- var postData = {};
		        	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/getProfile", postData : postData, datatype:"json" }).trigger("reloadGrid"); --%>
		        	search_policy();
		        	initDetails();
			    } else {
			        alert("실패하였습니다.");
			    }
		    },
		    error: function (request, status, error) {
				alert("Server Error : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	}
	
}

function btn_insertPolicy(){
	var comment = $('#comment').val();
	var policy_name = $('#policy_name').val();
	/* var start_ymd = $('#start_ymd').val();
	var start_hour = $('#start_hour').val();
	var start_minutes = $('#start_minutes').val(); */
	var cycle = $('#cycle').val();
	var action = 0;
	var datatype_id = $('#datatype_id').val();
	var std_id = $('#std_id').val();
	var enabled = ($('#right_enable').is(':checked')? '1': '0');
	//var pause_chk = ($('#stop_chk').is(':checked')? '1': '0');
	var pause_chk = 0;
	var from_time_hour = null;
	var from_time_minutes = null;
	var to_time_hour = null;
	var to_time_minutes = null;
	var pause_days = null;
	var userArr = new Array();
	
	if(policy_name == ""){
		alert("정책명을 입력해주세요.");
		return;
	}
	
	if(datatype_id == ""){
		alert("개인정보 유형을 선택하여주세요.");
		return;
	}
	
	if(pause_chk == 1) {
		from_time_hour = $('#from_time_hour').val() * 60 * 60;
		from_time_minutes = $('#from_time_minutes').val() * 60;
		to_time_hour = $('#to_time_hour').val() * 60 * 60;
		to_time_minutes = $('#to_time_minutes').val() * 60;
		
		var from_time = from_time_hour + from_time_minutes;
		var to_time = to_time_hour + to_time_minutes;
		
		if(from_time == to_time) {
			alert("검색 정지 시작 시간과 끝 시간을 다르게 설정해주세요");
			return;
		}
		pause_days = 62;
	}
	
	//var start_dtm = start_ymd + ' ' + String(start_hour) + ':' + String(start_minutes)
	var start_dtm = "2022-01-01 23:59";
	
	$("input:checkbox[name='action']").each(function() {
	   if(this.checked){//checked 처리된 항목의 값
	   	action = this.value;
	   } 
	});
	
	policy_type = 1;
	action = 0;
	
	var postData = {
		policy_name: policy_name,
		comment: comment,
		start_dtm: start_dtm,
		cycle: cycle,
		datatype_id: datatype_id,
		std_id: std_id,
		enabled: enabled,
		from_time_hour: from_time_hour,
		from_time_minutes: from_time_minutes,
		to_time_hour: to_time_hour,
		to_time_minutes: to_time_minutes,
		pause_days: pause_days,
		action: action,
		user: userArr.join(", "),
		policy_type: policy_type
	};
	
	console.log(postData)
	var message = "신규정책을 생성하시겠습니까?";
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/insertPolicy",
			async : false,
			data : postData,
		    success: function (resultMap) {
		        if (resultMap.resultCode == 0) {
		        	alert("생성하였습니다.");
		        	var postData = {};
		        	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/getProfile", postData : postData, datatype:"json" }).trigger("reloadGrid");
		        	search_policy();
		        	initDetails();
			    } else {
			        alert("생성하였습니다.");
			    }
		    },
		    error: function (request, status, error) {
				alert("Server Error : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	}
}

function initDetails(){
	$('#left_policy_name').text('');
	$('#left_datatype').html('');
	$('#left_disable').html('');
	/* $('#right_comment').html(''); */
	$('#right_policy_name').html('');
	$('#right_policy_name').html('');
	$('#right_datatype_name').html('');
	//$('#right_start_time').html('');
	//$('#right_stop_time').html('');
	$('#btn_datatype_area').html('');
	$('#right_cycle').html('');
	$('#view_user').html('');
	$('#right_enable').prop("checked", "");
	$('#right_enable').css("display", "none");

	$('#right_td_save').html('');
	$("input:checkbox[name='action']").attr("disabled", "disabled");
	
	$("input:checkbox[name='action']").each(function() {
	      if(this.value == 0){//checked 처리된 항목의 값
	    	  this.checked = true; //checked 처리
	      } else {
	    	  this.checked = false; //checked 처리
	      }

	});
}

var createType = function(cellvalue, options, rowObject) {
	//return '<img src="/resources/assets/images/img_check.png" style="cursor: pointer;" name="gridSubSelBtn" class="gridSubSelBtn" value=" 선택 "></a>';
	return cellvalue != null ? cellvalue : "<span style=\"color:red\">미설정</span>"; 
};

$("input:checkbox[name='action']").on('change', function(){
	var value = $(this).val();
	$("input:checkbox[name='action']").prop("checked", false)
	
	$("input:checkbox[name='action'][value='"+value+"']").prop("checked", true)
})
</script>

</body>
</html>