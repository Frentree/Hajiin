<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/xlsx.full.min.js"></script>
<style>
.user_info th {
	width: 25%;
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
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

</style>

<section>
	<!-- container -->
	<div class="container">
		<%-- <%@ include file="../../include/menu.jsp"%> --%>
		<h3>네트워크 관리</h3>
		<p class="container_comment" style="position: absolute; top: 34px; left: 187px; font-size: 13px; color: #9E9E9E;">네트워크 대역대 관리를 위한 화면입니다.</p>
		<!-- content -->
		<div class="content magin_t25">
			<table class="user_info" style="display: inline-table; width: 910px;">
				<tbody>
					<tr>
						<th style="text-align: center; width:100px; border-radius: 0.25rem;">구분</th>
						<!-- <td style="padding: 5px 5px 5px 5px;"><input type="text" style="width: 186px; font-size: 12px; padding-left: 5px;" size="10" id="net_type" placeholder="구분을 입력하세요"></td> -->
						<td>
							<p style="width: 230px; margin-bottom: 5px;">
							<select id="net_type" name="net_type" style="width:206px; font-size: 12px; padding-left: 5px;">
                               	<option value="0" selected>전체</option>
                               	<option value="8" >OA</option>
                                <option value="1" >OA(SOC)</option>
                                <option value="2" >OA(N-SOC)</option>
                                <option value="3" >유통망(서비스 ACE/TOP지점)</option>
                                <option value="4" >유통망(대리점)</option>
                                <option value="5" >유통망(F&U/미납센터, PS&M본사)</option>
                                <option value="6" >VDI</option>
                                <option value="7" >VDI(SOC)</option>
							</select>
							</p>
						</td>
						<th style="text-align: center; width:100px; ">상세 구분</th>
						<td>
							<p style="width: 230px; margin-bottom: 5px;">
							<input type="text" style="width: 200px; font-size: 12px; padding-left: 5px;" size="20" id="net_type_class" placeholder="검색어를 입력하세요.">
							</p>
						</td>
						<th style="text-align: center; width:100px; ">IP</th>
						<td>
							<p style="width: 230px; margin-bottom: 5px;">
							<input type="text" style="width: 200px; font-size: 12px; padding-left: 5px;" size="20" id="net_ip" placeholder="IP를 입력하세요.">
                       		<input type="button" name="button" class="btn_look_approval" id="btnSearch" style="margin-top: 5px; margin-right: 5px;">
							</p>
						</td>
					</tr>
					<%-- <tr>
						<th style="text-align: center; width:100px; padding: 5px 5px 5px 5px;" >생성일</th>
						<td>
							<input type="date" id="fromDate" style="text-align: center; width:205px; font-size:12px; value="${fromDate} " >
                            <span style="width: 8%; margin-right: 3px;">~</span>
                            <input type="date" id="toDate" style="text-align: center; width:205px; font-size:12px; value="${toDate}" >
                        </td>
					</tr> --%>
			    </tbody>
			</table>
			<div class="list_sch" style="margin-top: 24px;">
				<div class="sch_area">
					<button type="button" class="btn_down" id="btn_new" class="btn_new">네트워크 생성</button>
					<button type="button" class="btn_down" id="btn_all_new" class="btn_new">네트워크 일괄 생성</button>
					<!-- <button type="button" class="btn_down" id="btn_download_file" class="btn_new">파일 다운로드</button> -->
				</div>
			</div>
			<div class="grid_top" style="height: 100%; width: 100%; padding-top:10px;"> 
				<div class="left_box2" style="height: 94%; max-height: 700px; overflow: hidden;">
   					<table id="netGrid"></table>
					<div id="netGridPager"></div>
   				</div>
			</div>
			
		</div>
	</div>
	
	<div id="updateNetIpPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="width: 345px; height: 200px; padding: 10px; background: #f9f9f9; left: 55%; top: 60%;">
		<img class="CancleImg" id="btnCancleUpdateNetIpPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">네트워크 수정</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="background: #fff; width: 324px; height:234px; border: 1px solid #c8ced3; overflow: auto;">
					<table class="user_info" style="width: 100%; border: none;">
						<caption>net ip 수정</caption>
						<tbody >
							<tr>
								<th>구분</th>
								<td>
									<select id="net_type_update" name="net_type_update" style="width:206px; font-size: 12px; padding-left: 5px;">
										<option value="8" >OA</option>
		                                <option value="1" >OA(SOC)</option>
		                                <option value="2" >OA(N-SOC)</option>
		                                <option value="3" >유통망(서비스 ACE/TOP지점)</option>
		                                <option value="4" >유통망(대리점)</option>
		                                <option value="5" >유통망(F&U/미납센터, PS&M본사)</option>
		                                <option value="6" >VDI</option>
		                                <option value="7" >VDI(SOC)</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>상세 구분</th>
								<td><input type="text" id="updateNetTypeClass" value="" placeholder="" style="padding-left: 5px; width:206px;"></td>
							</tr>
							<tr>
								<th>IP</th>
								<td>
									<input type="text" id="updateNet_Ip" value="" placeholder="" style="padding-left: 5px; width:206px;">
									<input type="text" id="reachNet_Ip" value="" placeholder="" style="padding-left: 5px; width:206px; display: none;">
								</td>
							</tr>
							<tr>
								<th>mask</th>
								<td>
									<input type="input" id="updateNetMask" value="" placeholder="" style="padding-left: 5px; width:206px;">
									<input type="text" id="reachNetMask" value="" placeholder="" style="padding-left: 5px; width:206px; display: none;">
								</td>
							</tr>
							<tr>
								<th>mask_ip</th>
								<td><input type="text" id="updateNetMaskIp" value="" placeholder="" style="padding-left: 5px; width:206px; background-color: rgba(210, 210, 210, 0.35);" readonly></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" id="btnUpdatePopupSave" >저장</button>
					<button type="button" id="btnUpdatePopupCencel" >취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="NewNetIpPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="width: 345px; height: 200px; padding: 10px; background: #f9f9f9; left: 55%; top: 60%;">
		<img class="CancleImg" id="btnCancleNewNetIpPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">네트워크 생성</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="background: #fff; width: 324px; height:234px; border: 1px solid #c8ced3; overflow: auto;">
					<table class="user_info" style="width: 100%; border: none;">
						<caption>신규 스캔</caption>
						<tbody id="netIp">
							<tr>
								<th>구분</th>
								<td>
									<select id="net_type_insert" name="net_type_insert" style="width:206px; font-size: 12px; padding-left: 5px;">
		                                <option value="0" selected disabled>선택</option>
		                                <option value="8" >OA</option>
		                                <option value="1" >OA(SOC)</option>
		                                <option value="2" >OA(N-SOC)</option>
		                                <option value="3" >유통망(서비스 ACE/TOP지점)</option>
		                                <option value="4" >유통망(대리점)</option>
		                                <option value="5" >유통망(F&U/미납센터, PS&M본사)</option>
		                                <option value="6" >VDI</option>
		                                <option value="7" >VDI(SOC)</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>상세 구분</th>
								<td><input type="text" id="NetTypeClass" value="" placeholder="" style="padding-left: 5px; width:206px;"></td>
							</tr>
							<tr>
								<th>ip</th>
								<td><input type="text" id="NetIp" value="" placeholder="" style="padding-left: 5px; width:206px;"></td>
							</tr>
							<tr>
								<th>mask</th>
								<td><input type="number" id="NetMask" value="" placeholder="" style="padding-left: 5px; width:206px;"></td>
							</tr>
							<tr>
								<th>mask_ip</th>
								<td><input type="text" id="NetMaskIp" value="" placeholder="" style="padding-left: 5px; width:206px; background-color: rgba(210, 210, 210, 0.35);" readonly></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" id="btnNewPopupSave" >저장</button>
					<button type="button" id="btnNewPopupCencel" >취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<div id="ipUpLoadPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="width: 1200px; height: 540px; padding: 10px; background: #f9f9f9; left: 33%; top: 51%;">
		<img class="CancleImg" id="btnCancleExcelPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">네트워크 일괄 생성</h1>
				<p style="position: absolute; top: 14px; left: 175px; font-size: 12px; color: #9E9E9E;">PIMC에서 제공하는 형식이 아닌 다른 형식으로 업로드시 생성이 불가합니다.</p>
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
										<input id="downloadFile" type="hidden" name="filename" value="PIMC_네트워크_관리.xlsx">
										<input id="downloadRealFile" type="hidden" name="realfilename" value="net_ver1.xlsx">
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
					<%-- <table class="popup_tbl" id="firstTableRow" style="width: 1138px; ">
						<colgroup>
							<col width="30%">
							<col width="30%">
							<col width="20%">
							<col width="20%">
						</colgroup>
						<tbody >
							<tr height="45px;" >
								<th>구분</th>
								<th>상세</th>
								<th>IP</th>
								<th>mask</th>
							</tr>
						</tbody>
					</table> --%>
					<div class="content-table" style="width: 100%; height: 340px; padding: 0;">
						<table class="popup_tbl" style="width: 100%;">
							<colgroup>
								<col width="30%">
								<col width="30%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<tbody id="import_netList_excel">
								<tr height="45px;" >
									<th>구분</th>
									<th>상세</th>
									<th>IP</th>
									<th>mask</th>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="popup_btn">
				<div class="btn_area" style="padding: 10px 0; margin: 0;" id="netListBtn">
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
			<button id="updateNetIp">수정</button></li>
		<li class="status">
			<button id="deleteNetIp">삭제</button></li>
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
	
	setSelectDate();
	
	fn_drawnetGrid();
	$("#netGrid").setGridParam({url:"<%=request.getContextPath()%>/search/netList",  postData : "", datatype:"json" }).trigger("reloadGrid");

	$(document).click(function(e){
		$("#taskGroupWindow").hide();
		//$("#taskWindow").hide();
		//$("#viewDetails").hide(); 
	});
	
	
	
	 $('#NetMask').focusout(function () {
		 
		var net_ip = $("#NetIp").val().trim();
		var net_mask = $("#NetMask").val().trim();
		var type = "1";
		
		
		$("#NetMaskIp").val(maskIPCalculation(net_ip, net_mask));
		
     });
	 $('#updateNetMask').focusout(function () {
		 
		var net_ip = $("#NetIp").val().trim();
		var net_mask = $("#updateNetMask").val().trim();
		var type = "2";
		
		$("#updateNetMaskIp").val(maskIPCalculation(net_ip, net_mask));
		
     });
	
	
	/* if(net_ip != null && net_ip != "" && net_mask != null && net_mask != "" ){
		
	} */
	
});

function maskIPCalculation(net_ip, net_mask) {
	
	var net_list = [];
	
	for(i=0; i < net_mask ; i++){
		if(i == 7 || i == 15 || i == 23){
			net_list.push(1+".");
		}else{
			net_list.push(1);
		}
	}
	 
	if(net_list.length != 32){
		for(j=net_list.length+1 ; j < 33 ;  j++){
			if(j == 8 || j == 16 || j == 24){
				net_list.push(0+".");
			}else{
				net_list.push(0);
			}
		}
	}
	 
	var net_list2 = net_list.join('');
	var net_list3 = net_list2.split(".");
	
	var mask_ip = parseInt(net_list3[0], 2)+".";
		mask_ip += parseInt(net_list3[1], 2)+".";
		mask_ip += parseInt(net_list3[2], 2)+".";
		mask_ip += parseInt(net_list3[3], 2);
	
	return mask_ip;
		
	/* if(type == 1){
		$("#NetMaskIp").val(mask_ip);
	}else if(type == 2){
		$("#updateNetMaskIp").val(mask_ip);
	} */
	
	
};



function fn_drawnetGrid() {
	
	var gridWidth = $("#netGrid").parent().width();
	$("#netGrid").jqGrid({
		<%-- url: "<%=request.getContextPath()%>/target/selectAdminServerFileTopN", --%>
		datatype: "local",
	   	mtype : "POST",
	   	colNames:['', '구분', '상세 구분', 'IP', 'MASK', 'MASK_IP', 'REGDATE', ''],
		colModel: [
			{ index: 'TYPE', 					name: 'TYPE',					width: 20, align: 'center', hidden:true},
			{ index: 'TYPE_NAME', 				name: 'TYPE_NAME',				width: 20, align: 'center'},
			{ index: 'TYPE_CLASS', 				name: 'TYPE_CLASS',				width: 20, align: 'center', formatter:createClass,},
			{ index: 'IP',						name: 'IP',						width: 30, align: 'center'},
			{ index: 'MASK', 					name: 'MASK', 					width: 10, align: 'center'},
			{ index: 'MASK_IP', 				name: 'MASK_IP', 				width: 30, align: 'center'},
			{ index: 'REGDATE', 				name: 'REGDATE', 				width: 20, align: 'center', hidden:true},
			{ index: 'VIEW', 					name: 'VIEW', 					width:10,  align: 'center', sortable : false, formatter:createView, exportcol : false},
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 585,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:25,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#netGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onCellSelect : function(rowid,celname,value,iRow,iCol) {
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data) {
			//console.log(data);
			$(".gridSubSelBtn").on("click", function(e) {
		  		e.stopPropagation();
				
				$("#netGrid").setSelection(event.target.parentElement.parentElement.id);
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

//엔터 입력시 발생하는 이벤트
$('#net_type, #net_ip').keyup(function(e) {
	if (e.keyCode == 13) {
	    $("#btnSearch").click();
    }        
});

$('#NetMask').keyup(function(e) {
	var net_ip = $("#NetIp").val().trim();
	var net_mask = $("#NetMask").val().trim();
	var type = "1";
	
	if (e.keyCode == 13) {
		$("#NetMaskIp").val(maskIPCalculation(net_ip, net_mask));
    }        
});

$('#updateNetMask').keyup(function(e) {
	var net_ip = $("#NetIp").val().trim();
	var net_mask = $("#updateNetMask").val().trim();
	var type = "2";
	
	if (e.keyCode == 13) {
		$("#updateNetMaskIp").val(maskIPCalculation(net_ip, net_mask));
    }        
});

//검색
$("#btnSearch").click(function(e){
	
	/* 	
	if($("#fromDate").val() > $("#toDate").val()){
        alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
        return;
    } 
	*/
	
	var postData = {
			/* "fromDate" : $("#fromDate").val(),
			"toDate" : $("#toDate").val(), */
			"net_type_class": $('#net_type_class').val(),
			"net_type": $('#net_type').val(),
			"net_ip": $('#net_ip').val()
			}
	
	$("#netGrid").setGridParam({
		url:"<%=request.getContextPath()%>/search/netList", 
		postData : postData, 
		datatype:"json" 
		}).trigger("reloadGrid");
});

// 생성(화면) 버튼 클릭
$("#btn_new").click(function(e){
	$("#NewNetIpPopup").show();
});

$("#btn_all_new").click(function(e){
	$("#ipUpLoadPopup").show();
});

// 생성(모달)/저장 버튼 클릭
$("#btnNewPopupSave").click(function(e){
	var expUrl = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
	
	var type = $("#net_type_insert").val();
	var type_class = $("#NetTypeClass").val().trim();
	var ip = $("#NetIp").val().trim();
	var mask = $("#NetMask").val().trim();
	var mask_ip = $("#NetMaskIp").val().trim();
	
	if(type == 0 || type == null){
		alert("구분이 되지 않았습니다.");
		return;
	}
	/* if(type_class == "" || type_class == null){
		alert("type_class가 지정되지 않았습니다.");
		return;
	} */
	if(ip == "" || ip == null){
		alert("ip가 지정되지 않았습니다.");
		return;
	}
	if (!expUrl.test(ip)) {
		alert("입력하신 값은 IP형식이 아닙니다.");
		return;
	}
	if(mask == "" || mask == null){
		alert("mask가 지정되지 않았습니다.");
		return;
	}
	
 	var type_name;
 	
	switch(type) {
	    case "1": type_name = 'OA(SOC)'; break;
	    case "2": type_name = 'OA(N-SOC)'; break;
	    case "3": type_name = '유통망(서비스 ACE/TOP지점)'; break;
	    case "4": type_name = '유통망(대리점)'; break;
	    case "5": type_name = '유통망(F&U/ 미납센터, PS&M본사)'; break;
	    case "6": type_name = 'VDI'; break;
	    case "7": type_name = 'VDI(SOC)'; break;
	    case "8": type_name = 'OA'; break;
	}
	
	var message = "네트워크를 생성하시겠습니까?";
	
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/insertNetIp",
			async : false,
			data: {
				type : type,
				type_name : type_name,
				type_class : type_class,
				ip : ip,
				mask : mask,
				mask_ip : mask_ip
			},
			dataType: "json",
		    success: function (resultMap) {
		    	
		    	if(resultMap.resultCode == 0){
			    	alert(resultMap.resultMessage);
		    	}else if(resultMap.resultCode == -9){
			    	alert(resultMap.resultMessage);
			    	return;
		    	}else{
		    		alert("네트워크 생성에 실패하였습니다.\n관리자게에 문의하십시오.");
		    	}
		    	
		    	var postData = null;
		    	$("#netGrid").setGridParam({
		    		url:"<%=request.getContextPath()%>/search/netList", 
		    		postData : postData, 
		    		datatype:"json" 
		    		}).trigger("reloadGrid");
		    	
		    },
		    error: function (request, status, error) {
		        console.log("ERROR : ", error);
		    }
		});
		setNewSetting();
		$("#NewNetIpPopup").hide();
	}
	
});

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
            let rows = XLSX.utils.sheet_to_json(workBook.Sheets["네트워크 관리"]);
        	
            var details = "";
            var expUrl = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
            
            if(rows < 1){
            	alert("올바른 시트가 존재하지 않습니다. 확인 후 다시 시도해 주세요.");
            	return;
            }
            
            var mask_cnt = 0;
            var ip_cnt = 0;
            var total_cnt = 0;
            var firstRowChk = false;
            var firstRowChk2 = false;
            var total_data = rows.length;
	    	
	    	details += "<tr height=\"45px;\" >";
	    	details +=  "<th>구분</th>";
	    	details +=	"<th>상세</th>";
	    	details +=	"<th>IP</th>";
	    	details +=	"<th>mask</th>";
	    	details += "</tr>";
	    	
	    	if(
	    			rows[0].hasOwnProperty('IP')	
    			 &&	rows[0].hasOwnProperty('구분')	
	    		 &&	rows[0].hasOwnProperty('상세') 		
	    		 && rows[0].hasOwnProperty('마스크') 
	    	){
	    		$.each(rows, function(index, item) {
	    			
	    			++CNT
	    			if(CNT > 1) {
	    				var ip = item.IP;
						var type_name = item.구분;
						var detail = item.상세;
						var mask = item.마스크;
							firstRowChk = false;
						
						if(ip == '127.0.0.1' && detail == '세부망' && mask == '24' ){
							firstRowChk = true
							firstRowChk2 = true;
						}
						
						
						if(mask == null){
							mask = 0;
						}
						if(!expUrl.test(ip) && mask > 32){
							total_cnt++;
							
						}else if(!expUrl.test(ip)){
							ip_cnt++;
							
						}else if(mask > 32){
							mask_cnt++;
							
						}else if(!firstRowChk){
							
							details += "<tr style=\"height: 45px;\">";
							details += "	<td style=\"text-align: left; padding-left: 0;\">"+type_name+"</td>";
							details += "	<td style=\"text-align: center; padding-left: 0;\">"+detail+"</td>";
							details += "	<td style=\"text-align: center; padding-left: 0;\">"+ip+"</td>";
							details += "	<td style=\"text-align: center; padding-left: 0;\">"+mask+"</td>";
							details += "</tr>";
							
							var type;
							
							switch(type_name) {
							    case 'OA(SOC)': 					type = 1; break;
							    case 'OA(N-SOC)': 					type = 2; break;
							    case '유통망(서비스 ACE/TOP지점)': 		type = 3; break;
							    case '유통망(대리점)': 					type = 4; break;
							    case '유통망(F&U/미납센터,PS&M본사)': 	type = 5; break;
							    case 'VDI':							type = 6; break;
							    case 'VDI(SOC)': 					type = 7; break;
							    case 'OA': 							type = 8; break;
							}
							
							resulList.push({"ip" : ip, "type" : type, "type_name" : type_name, "detail" : detail, "mask" : mask, "mask_ip" : maskIPCalculation(ip, mask)})
						}
	    			}
				});
	    		
	    		if(mask_cnt > 0 && ip_cnt > 0){
		    		alert("올바르지 않은 데이터가 "+total_cnt+"건 존재합니다.");
		    	}else if(mask_cnt > 0){
		    		alert("마스크가 올바르지 않은 IP가 "+mask_cnt+"건 존재합니다.");
		    	}else if(ip_cnt > 0){
		    		alert("올바르지 않은 IP가 "+ip_cnt+"건 존재합니다.");
		    	}
		    	
		    	var btnCss ="<button type=\"button\" id=\"btnNewPopupExcelSave\" style=\"margin-right: 5px\" >저장</button>";
					btnCss +="<button type=\"button\" id=\"btnNewPopupExcelCencel\" >취소</button>";
				$("#netListBtn").html(btnCss)
				
				$("#btnNewPopupExcelCencel").click(function(e){
					$("#importExcel").val("");
					$("#importExcelNm").val("");
					
					var details = "";
					$("#netListBtn").html(details);
					$("#import_netList_excel").html(details);
					$("#ipUpLoadPopup").hide();
	        	});
				
				$('#btnNewPopupExcelSave').on('click', function(){
					
	            	var msg = confirm("아래 목록의 네트워크를 생성하시겠습니까?");
	            	
	            	if(msg){
	            		$.ajax({
	        				type: "POST",
	        				url: "/search/insertNetListIp",
	        				//async : false,
	        				data : {
	        					"resulList": JSON.stringify(resulList)
	        				},
	        			    success: function (resultMap) {
	        			    	console.log(resultMap);
	        			    	
	        			    	var totalRow = rows.length;
	        			    	
	        			    	if(firstRowChk2){
	        			    		totalRow = totalRow-1
	        			    	}
	        			    	
	        			    	
	        			    	if(resultMap.resultCode == 0 && resultMap.resultValue > 0){
	        			    		alert(totalRow + "건의 IP중 " + resultMap.resultValue + "건의 중복 IP를 제외하고 \n네트워크 등록이 완료되었습니다.");
	        			    		setNewSetting2();
	        			    	}else if(resultMap.resultCode == 0){
	        			    		alert("네트워크 등록이 완료되었습니다.");
	        			    		setNewSetting2();
	        			    	}else {
	        			    		alert("네트워크 등록에 문제가 생겼습니다. \n관리자에게 문의해주세요.");
	        			    		return;
	        			    	}
	        			    	
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
	    	
	    	 $("#import_netList_excel").html(details);
	    	 
	    	 
	         $("#importExcelNm").val(fileNm);
	    	
        /* }) */
    };
    reader.readAsBinaryString(input.files[0]);
});


// 취소 버튼 클릭
$("#btnNewPopupCencel").click(function(e){
	setNewSetting();
	$("#NewNetIpPopup").hide();
});
// x 버튼 클릭
$("#btnCancleNewNetIpPopup").click(function(e){
	setNewSetting();
	$("#NewNetIpPopup").hide();
});
$("#btnCancleExcelPopup").click(function(e){
	setNewSetting2();
});
$("#btnNewPopupExcelCencel").click(function(e){
	setNewSetting2();
});


$("#updateNetIp").click(function(e){
	
	var row = $("#netGrid").getGridParam("selrow");
	
	var type = $("#netGrid").getCell(row, "TYPE");
	var type_name = $("#netGrid").getCell(row, "TYPE_NAME");
	var type_class = $("#netGrid").getCell(row, "TYPE_CLASS");
	var ip = $("#netGrid").getCell(row, "IP");
	var mask = $("#netGrid").getCell(row, "MASK");
	var mask_ip = $("#netGrid").getCell(row, "MASK_IP");
	var regdate = $("#netGrid").getCell(row, "REGDATE");
	var view = $("#netGrid").getCell(row, "VIEW");
	
	$("#net_type_update").val(type).prop("selected", true);
	$("#updateNetTypeClass").val(type_class);
	$("#updateNet_Ip").val(ip);
	$("#updateNetMask").val(mask);
	$("#updateNetMaskIp").val(mask_ip);
	
	$("#reachNet_Ip").val(ip);
	$("#reachNetMask").val(mask);
	
	$("#updateNetIpPopup").show();
});

// 수정 - 취소 버튼 클릭
$("#btnUpdatePopupCencel").click(function(e){
	$("#updateNetIpPopup").hide();
});
// 수정 - x 버튼 클릭
$("#btnCancleUpdateNetIpPopup").click(function(e){
	$("#updateNetIpPopup").hide();
});

$("#btnUpdatePopupSave").click(function(e){
	
	var expUrl = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
	
	var type = $("#net_type_update").val();
	var type_class = $("#updateNetTypeClass").val().trim();
	var ip = $("#updateNet_Ip").val().trim();
	var mask = $("#updateNetMask").val().trim();
	var mask_ip = $("#updateNetMaskIp").val().trim();
	
	var reachNet_Ip = $("#reachNet_Ip").val().trim();
	var reachNetMask = $("#reachNetMask").val().trim();
	
	/* if(type_class == "" || type_class == null){
		alert("type_class가 지정되지 않았습니다.");
		return;
	} */
	
	$("#updateNet_Ip").change(function () {
		if(ip == "" || ip == null){
			alert("ip가 지정되지 않았습니다.");
			return;
		}
		if (!expUrl.test(ip)) {
			alert("입력하신 값은 IP형식이 아닙니다.");
			return;
		}
	});
	
	$("#updateNetMaskIp").change(function () {
		if(mask == "" || mask == null){
			alert("mask가 지정되지 않았습니다.");
			return;
		}
	});
	
 	var type_name;
 	
	switch(type) {
	    case "1": type_name = 'OA(SOC)'; break;
	    case "2": type_name = 'OA(N-SOC)'; break;
	    case "3": type_name = '유통망(서비스 ACE/TOP지점)'; break;
	    case "4": type_name = '유통망(대리점)'; break;
	    case "5": type_name = '유통망(F&U/ 미납센터, PS&M본사)'; break;
	    case "6": type_name = 'VDI'; break;
	    case "7": type_name = 'VDI(SOC)'; break;
	    case "8": type_name = 'OA'; break;
	}
	
	var message = "네트워크를 수정하시겠습니까?";
	
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/updateNetIp",
			async : false,
			data: {
				type : type,
				type_name : type_name,
				type_class : type_class,
				ip : ip,
				mask : mask,
				mask_ip : mask_ip,
				reachNet_Ip : reachNet_Ip,
				reachNetMask : reachNetMask
			},
			dataType: "json",
		    success: function (resultMap) {
		    	
		    	if(resultMap.resultCode == 0){
			    	alert(resultMap.resultMessage);
			    	$("#updateNetIpPopup").hide();
			    	
			    	var postData = null;
			    	$("#netGrid").setGridParam({
			    		url:"<%=request.getContextPath()%>/search/netList", 
			    		postData : postData, 
			    		datatype:"json" 
			    		}).trigger("reloadGrid");
		    	}else{
		    		alert("네트워크 수정에 실패하였습니다.\n관리자게에 문의하십시오.");
		    	}
		    	
		    },
		    error: function (request, status, error) {
		        console.log("ERROR : ", error);
		    }
		});
	}
});


var createView = function(cellvalue, options, rowObject) {
	return "<button type='button' style='padding-top: 4px; padding-bottom:4px;' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>";
};

var createClass = function(cellvalue, options, rowObject) {
	
	if(cellvalue == null || cellvalue == ""){
		return '-';
	}else{
		return cellvalue;
	}	
};


$("#deleteNetIp").click(function(){
	
	var row = $("#netGrid").getGridParam("selrow");
	var ip = $("#netGrid").getCell(row, "IP");
	var mask = $("#netGrid").getCell(row, "MASK");
	
	var message = "정말 삭제하시겠습니까?";
	
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/deleteNetIp",
			async : false,
			data: {
				ip : ip,
				mask : mask
			},
			dataType: "json",
		    success: function (resultMap) {
		    	if (resultMap.resultCode == 0) {
		        	alert("삭제를 완료하였습니다.");
		        	var postData = null;
		        	$("#netGrid").setGridParam({
			    		url:"<%=request.getContextPath()%>/search/netList",
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

function setSelectDate() 
{
    $("#fromDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd'
    });

    $("#toDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd'
    });

    var oToday = new Date();
    $("#toDate").val(getFormatDate(oToday));

    var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
    $("#fromDate").val(getFormatDate(oFromDate));
}
function getFormatDate(oDate)
{
    var nYear = oDate.getFullYear();           // yyyy 
    var nMonth = (1 + oDate.getMonth());       // M 
    nMonth = ('0' + nMonth).slice(-2);         // month 두자리로 저장 

    var nDay = oDate.getDate();                // d 
    nDay = ('0' + nDay).slice(-2);             // day 두자리로 저장

    return nYear + '-' + nMonth + '-' + nDay;
}
$(function() { 
	$.datepicker.setDefaults({ 
		closeText: "확인", 
		currentText: "오늘", 
		prevText: '이전 달', 
		nextText: '다음 달', 
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
		dayNames: ['일', '월', '화', '수', '목', '금', '토'], 
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'], 
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
		yearRange: 'c-5:c+5'
	}); 
});

function setNewSetting() {
	$('input[name=net_type_insert][value=0]').prop('checked',true);
	$("#net_type_insert").val("0");
	$("#NetTypeClass").val("");
	$("#NetIp").val("");
	$("#NetMask").val("");
	$("#NetMaskIp").val("");
	
	$("#btnNewPopupSave").show();
	$("#btnPopupSave").hide();
};

function setNewSetting2() {
	
	$("#importExcel").val("");
	$("#importExcelNm").val("");
	
	var details = "";
	$("#netListBtn").html(details);
	$("#import_netList_excel").html(details);
	$("#ipUpLoadPopup").hide();
	
};

</script>

</body>
</html>