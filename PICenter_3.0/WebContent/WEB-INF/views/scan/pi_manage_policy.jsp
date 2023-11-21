<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>


		<!-- section -->
		<section>
			<!-- container -->
			<div class="container minMenu">
			<%-- <%@ include file="../../include/menu.jsp"%> --%>
				<h3>정책관리</h3>
				<!-- content -->
				<div class="content magin_t25">
					<div class="location_area">
						<p class="location">스캔관리 > 망별정책설정</p>
					</div>
					<div class="left_area2" style="height: 730px;">
						<input type="hidden" id="ap_no">
						<input type="hidden" id="ap_name">
						<div class="left_box2" style="overflow: hidden; min-height: 730px; height: 730px;">
		   					<div class="search_area bold">
								<input type="text" id="txt_host" value="" style="width: 320px" placeholder="호스트 이름을 입력하세요.">
								<button type="button" id="btn_search" style="right: -12px;">검색</button>
							</div>
							<div id="targetHig" style="height: 100%">
			   					<table id="targetGrid"></table>
			   					<div id="targetGridPager"></div>
		   					</div>
						</div>
					</div>
					
					<div class="grid_top" style="margin-left: 350px; height: 100%;">
						<h3 style="padding: 0;">정책 설정</h3> 
						<div class="list_sch" style="top: 0;">
							<div class="sch_area">
								<button type="button" id="btnDataTypeBtn" class="btn_down">개인정보 유형 저장</button>
							</div>
						</div>
						<div class="left_box2" style="height: 400px; overflow: hidden;">
		   					<table id="policyGrid"></table>
		   				</div>
					</div>
				</div>
			</div>
			<!-- container -->
			
		</section>
		<!-- section -->


<div id="taskWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
	border-top: 2px solid #222222; box-shadow: 2px 2px 5px #ddd; display:none">
	<ul>
		<!-- <li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-cancelled status-deactivated status-failed">
			<button id="viewBtn" >보기</button></li> -->
		<li  class="status status-completed status-scheduled status-paused status-stopped status-failed">
			<button id="updateBtn">수정 </button></li>
			<!-- 
		<li class="status status-scheduled status-scanning">
			<button id="modifySchedule" >수정</button></li>
			 -->
		<li class="status status-completed status-scheduled status-scanning status-paused status-stopped">
			<button id="deleteBtn">삭제</button></li>
	</ul>
</div>
	
<div id="popup_manageSchedule" class="popup_layer" style="display:none;">
	<div class="popup_box" id="popup_box" style="height: 60%; width: 60%; left: 40%; top: 33%; right: 40%; ">
	</div>
</div>	

<%@ include file="../../include/footer.jsp"%>
 
<script type="text/javascript">

function ifConnect (cellvalue, options, rowObject) {
	switch (rowObject["AGENT_CONNECTED"]) {
	case '1':
		return '<img src="<%=request.getContextPath()%>/resources/assets/images/icon_con.png" value="1" />';
		break;
	case '0':
		return '<img src="<%=request.getContextPath()%>/resources/assets/images/icon_dicon.png" value="0" />';
	    break;
    default :
    	return '<img src="<%=request.getContextPath()%>/resources/assets/images/icon_dicon.png" />';
    break;
    }
}

// 호스트 검색 fn
function fn_search() {
	var postData = {host : $("#txt_host").val()};
	
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/target/pi_target_list", postData : postData, datatype:"json" }).trigger("reloadGrid");
	console.log(postData);
}

$(document).ready(function () {
	$('#btn_search').click(function() {
		fn_search();
	});
});
 
$(document).ready(function () {
	//var gridWidth = $("#targetGrid").parent().width();
	var gridHeight = $("#targetHig").parent().height()-119;
	$("#targetGrid").jqGrid({
// 		url: 'data.json',
		url: "<%=request.getContextPath()%>/scan/getApList",
		postData : {}, 
		datatype:"json", 
//		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['망 이름','apno'],
		colModel: [      
			{ index: 'AP_NAME', 		name: 'AP_NAME', 		width: 300 },
			{ index: 'AP_NO', 			name: 'AP_NO', hidden: true}
		],
		loadonce: true, // this is just for the demo
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: 300,
		height: gridHeight,
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:25,
	   	rowList:[25,50,100],			
		pager: "#targetGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {
	  		var ap_no = $(this).jqGrid('getCell', rowid, 'AP_NO')
	  		$('#ap_no').val(ap_no);
	  		$('#ap_name').val($(this).jqGrid('getCell', rowid, 'AP_NAME'));
	  		setPolicyForm(ap_no);
	  	},
		loadComplete: function(data) {
			
			fn_drawPolicyGrid(); 
			
			console.log(data);
			
	    },
	    gridComplete : function() {
	    }
	});
	
	$("#targetGridPager_left").css("display", "none");
	$("#targetGridPager_right").css("display", "none");

//	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/target/pi_target_list", postData : postData, datatype:"json" }).trigger("reloadGrid");

});

function fn_drawPolicyGrid() {
	var gridWidth = $("#policyGrid").parent().width();
	$("#policyGrid").jqGrid({
		url: "<%=request.getContextPath()%>/target/selectAdminServerFileTopN",
		datatype: "local",
	   	mtype : "POST",
	   	colNames:['아이디','개인정보유형명', '타입 유형명카피','주민등록번호','주민체크','주민갯수',
			'외국인등록번호','외국인체크','외국인갯수',
			'운전면허번호','운전체크', '운전갯수',
			'여권번호','여권체크','여권갯수',
			'계좌번호','계좌체크','계좌갯수',
			'카드번호','카드체크', '카드갯수',
			'전화번호','전화체크','전화갯수',
			'휴대전화번호','휴대전화체크','휴대전화갯수',
			'OCR', 'OCR체크', '중복허용1', '중복허용체크', 'VOICE'],
		colModel: [      
			{ index: 'DATATYPE_ID', 				name: 'DATATYPE_ID',				width:1, align:'center', hidden:true},
			{ index: 'DATATYPE_LABEL_COPY',			name: 'DATATYPE_LABEL_COPY',		width: 200, align: 'left'},
			{ index: 'DATATYPE_LABEL',				name: 'DATATYPE_LABEL',				width: 150, align: 'left', hidden: true},
			{ index: 'RRN_CHK', 					name: 'RRN_CHK', 					width: 120, align: 'center'},
			{ index: 'RRN', 						name: 'RRN', 						width: 0, align: 'center', hidden: true},
			{ index: 'RRN_CNT', 					name: 'RRN_CNT', 					width: 0, align: 'center', hidden: true},
			{ index: 'FOREIGNER_CHK', 				name: 'FOREIGNER_CHK', 				width: 120, align: 'center'},
			{ index: 'FOREIGNER', 					name: 'FOREIGNER', 					width: 0, align: 'center', hidden: true},
			{ index: 'FOREIGNER_CNT', 				name: 'FOREIGNER_CNT', 				width: 0, align: 'center', hidden: true},
			{ index: 'DRIVER_CHK', 					name: 'DRIVER_CHK', 				width: 120, align: 'center'},
			{ index: 'DRIVER', 						name: 'DRIVER', 					width: 0, align: 'center', hidden: true},
			{ index: 'DRIVER_CNT', 					name: 'DRIVER_CNT', 				width: 0, align: 'center', hidden: true},
			{ index: 'PASSPORT_CHK', 				name: 'PASSPORT_CHK', 				width: 120, align: 'center'},
			{ index: 'PASSPORT', 					name: 'PASSPORT', 					width: 0, align: 'center', hidden: true},
			{ index: 'PASSPORT_CNT', 				name: 'PASSPORT_CNT', 				width: 0, align: 'center', hidden: true},
			{ index: 'ACCOUNT_CHK', 				name: 'ACCOUNT_CHK', 				width: 120, align: 'center'},
			{ index: 'ACCOUNT', 					name: 'ACCOUNT', 					width: 0, align: 'center', hidden: true},
			{ index: 'ACCOUNT_CNT', 				name: 'ACCOUNT_CNT', 				width: 0, align: 'center', hidden: true },
			{ index: 'CARD_CHK', 					name: 'CARD_CHK', 					width: 120, align: 'center'},
			{ index: 'CARD', 						name: 'CARD', 						width: 0, align: 'center', hidden: true},
			{ index: 'CARD_CNT', 					name: 'CARD_CNT', 					width: 0, align: 'center', hidden: true },
			{ index: 'LOCAL_PHONE_CHK', 			name: 'LOCAL_PHONE_CHK', 			width: 120, align: 'center'},
			{ index: 'LOCAL_PHONE', 				name: 'LOCAL_PHONE', 				width: 0, align: 'center', hidden: true},
			{ index: 'LOCAL_PHONE_CNT', 			name: 'LOCAL_PHONE_CNT', 			width: 0, align: 'center', hidden: true},
			{ index: 'MOBILE_PHONE_CHK', 			name: 'MOBILE_PHONE_CHK', 			width: 120, align: 'center'},
			{ index: 'MOBILE_PHONE', 				name: 'MOBILE_PHONE', 				width: 0, align: 'center', hidden: true},
			{ index: 'MOBILE_PHONE_CNT', 			name: 'MOBILE_PHONE_CNT', 			width: 0, align: 'center', hidden: true},
			{ index: 'OCR_CHK', 					name: 'OCR_CHK', 					width: 50, align: 'center'},
			{ index: 'OCR', 						name: 'OCR', 						width: 0, align: 'center', hidden: true},
			{ index: 'DUP_CHK', 					name: 'DUP_CHK', 					width: 50, align: 'center', hidden: true},
			{ index: 'DUP', 						name: 'DUP', 						width: 0, align: 'center', hidden: true},
			{ index: 'VOICE', 						name: 'VOICE', 						width: 0, align: 'center', hidden: true},
		],
		loadonce:true,
		autowidth: true,
		shrinkToFit: false,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		//width: gridWidth,
		height: 300,
		rownumbers : false, // 행번호 표시여부
		//rownumWidth : 35, // 행번호 열의 너비	
		//rowNum:20,
		//rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		//pager: "#topNGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  		
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data) {
			//console.log(data);
			fn_drawPolicyForm();
	    },
	    gridComplete : function() {
	    }
	});
}

function numberChange(ele) {
	ele.value = ele.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
}

function change(ele, row) {
	if(ele.checked){
		$("#"+ele.value+"_cnt"+row).val("1");
		$("#"+ele.value+"_cnt"+row).prop('disabled', false);
	}else {
		$("#"+ele.value+"_cnt"+row).val("");
		$("#"+ele.value+"_cnt"+row).prop('disabled', true);
	}
}

var isCreateProfile = true;
function fn_drawPolicyForm(){
	var rowId = $("#policyGrid").getGridParam("reccount");
	
	if(!isCreateProfile){
		alert("개인정보 유형 생성중입니다.");
		return;
	}
	isCreateProfile = false;
	
	var rowData = {
		"DATATYPE_ID": " ",
		"DATATYPE_LABEL_COPY": "<input type='text' name='datatypeName"+rowId+"' id='datatypeName"+rowId+"' value='' style='width: 100%;'>",
		"DATATYPE_LABEL": " ",
		"RRN_CHK": "<input type='checkbox' id='chk_rrn' name='chk_dataType"+rowId+"' class='chk_lock' onchange='change(this,"+rowId+")' value='rrn'>"
		+ " <input type='text' id='rrn_cnt"+rowId+"' size='4' oninput='numberChange(this)'>",
		"RRN": " ",
		"RRN_CNT": " ",
		"FOREIGNER_CHK": "<input type='checkbox' id='chk_frn' name='chk_dataType"+rowId+"' class='chk_lock' onchange='change(this,"+rowId+")' value='frn'>"
		+ " <input type='text' id='frn_cnt"+rowId+"' size='4' oninput='numberChange(this)'>",
		"FOREIGNER": " ",
		"FOREIGNER_CNT": " ",
		"DRIVER_CHK": "<input type='checkbox' id='chk_dri' name='chk_dataType"+rowId+"' class='chk_lock' onchange='change(this,"+rowId+")' value='dri'>"
		+ " <input type='text' id='dri_cnt"+rowId+"' size='4' oninput='numberChange(this)'>",
		"DRIVER": " ",
		"DRIVER_CNT": " ",
		"PASSPORT_CHK": "<input type='checkbox' id='chk_pas' name='chk_dataType"+rowId+"' class='chk_lock' onchange='change(this,"+rowId+")' value='pas'>"
		+ " <input type='text' id='pas_cnt"+rowId+"' size='4' oninput='numberChange(this)'>",
		"PASSPORT": " ",
		"PASSPORT_CNT": " ",
		"ACCOUNT_CHK": "<input type='checkbox' id='chk_acc' name='chk_dataType"+rowId+"' class='chk_lock' onchange='change(this,"+rowId+")' value='acc'>"
		+ " <input type='text' id='acc_cnt"+rowId+"' size='4' oninput='numberChange(this)'>",
		"ACCOUNT": " ",
		"ACCOUNT_CNT": " ",
		"CARD_CHK": "<input type='checkbox' id='chk_card' name='chk_dataType"+rowId+"' class='chk_lock' onchange='change(this,"+rowId+")' value='card'>"
		+ " <input type='text' id='card_cnt"+rowId+"' size='4' oninput='numberChange(this)'>",
		"CARD": " ",
		"CARD_CNT": " ",
		"LOCAL_PHONE_CHK": "<input type='checkbox' id='chk_local' name='chk_dataType"+rowId+"' class='chk_lock' onchange='change(this,"+rowId+")' value='local'>"
		+ " <input type='text' id='local_cnt"+rowId+"' size='4' oninput='numberChange(this)'>",
		"LOCAL_PHONE": " ",
		"LOCAL_PHONE_CNT": " ",
		"MOBILE_PHONE_CHK": "<input type='checkbox' id='chk_mob' name='chk_dataType"+rowId+"' class='chk_lock' onchange='change(this,"+rowId+")' value='mob'>"
		+ " <input type='text' id='mob_cnt"+rowId+"' size='4' oninput='numberChange(this)'>",
		"MOBILE_PHONE": " ",
		"MOBILE_PHONE_CNT": " ",
		"OCR_CHK": "<input type='checkbox' id='chkOcr"+rowId+"' name='chkOcr"+rowId+"' class='chk_lock' />",
		"OCR": " ",
		"DUP_CHK": "<input type='checkbox' id='chk_dup"+rowId+"' name='chk_dup"+rowId+"' class='chk_lock' />",
		"DUP": " ",
		"VOICE": "0",
		"BUTTON": "<button type='button' class='gridSubSelBtn' name='updateProfileBtn' onclick='careteProfile("+rowId+")'>생성</button>"
		+"<button type='button' class='gridSubSelBtn' name='cancelProfileBtn' onclick='createProfileCencel("+rowId+")'>취소</button>",
	};
	$("#policyGrid").addRowData(rowId+1, rowData, 'first');
}

function setPolicyForm(ap_no){
	var postData = {
		ap_no : ap_no
	};
	$.ajax({
		type: "POST",
		url: "/scan/getPolicyByApno",
		async : false,
		data : postData,
	    success: function (item) {
	    	console.log(item)
	    	$('#datatypeName0').val(item.DATATYPE_LABEL)
	    	if(item.RRN == '1'){		// 주민번호
	    		$("#chk_rrn").prop("checked",true);
	    		$("#rrn_cnt0").val(item.RRN_CNT);
	    		$("#rrn_cnt0").prop('disabled', false);
	    	} else {
	    		$("#chk_rrn").prop("checked",false);
	    		$("#rrn_cnt0").val("");
	    		$("#rrn_cnt0").prop('disabled', true);
	    	}
	    	if(item.FOREIGNER == '1'){	// 외국인번호
	    		$("#chk_frn").prop("checked",true);
	    		$("#frn_cnt0").val(item.FOREIGNER_CNT);
	    		$("#frn_cnt0").prop('disabled', false);
	    	} else {
	    		$("#chk_frn").prop("checked",false);
	    		$("#frn_cnt0").val("");
	    		$("#frn_cnt0").prop('disabled', true);
	    	}
	    	if(item.DRIVER == '1'){		// 운전면허번호
	    		$("#chk_dri").prop("checked",true);
	    		$("#dri_cnt0").val(item.DRIVER_CNT);
	    		$("#dri_cnt0").prop('disabled', false);
	    	} else {
	    		$("#chk_dri").prop("checked",false);
	    		$("#dri_cnt0").val("");
	    		$("#dri_cnt0").prop('disabled', true);
	    	}
	    	if(item.PASSPORT == '1'){	// 여권번호
	    		$("#chk_pas").prop("checked",true);
	    		$("#pas_cnt0").val(item.PASSPORT_CNT);
	    		$("#pas_cnt0").prop('disabled', false);
	    	} else {
	    		$("#chk_pas").prop("checked",false);
	    		$("#pas_cnt0").val("");
	    		$("#pas_cnt0").prop('disabled', true);
	    	}
	    	if(item.ACCOUNT == '1'){	// 계좌번호
	    		$("#chk_acc").prop("checked",true);
	    		$("#acc_cnt0").val(item.ACCOUNT_CNT);
	    		$("#acc_cnt0").prop('disabled', false);
	    	} else {
	    		$("#chk_acc").prop("checked",false);
	    		$("#acc_cnt0").val("");
	    		$("#acc_cnt0").prop('disabled', true);
	    	}
	    	if(item.CARD == '1'){		// 카드번호
	    		$("#chk_card").prop("checked",true);
	    		$("#card_cnt0").val(item.CARD_CNT);
	    		$("#card_cnt0").prop('disabled', false);
	    	} else {
	    		$("#chk_card").prop("checked",false);
	    		$("#card_cnt0").val("");
	    		$("#card_cnt0").prop('disabled', true);
	    	}
	    	if(item.LOCAL_PHONE == '1'){// 주민번호
	    		$("#chk_local").prop("checked",true);
	    		$("#local_cnt0").val(item.LOCAL_PHONE_CNT);
	    		$("#local_cnt0").prop('disabled', false);
	    	} else {
	    		$("#chk_local").prop("checked",false);
	    		$("#local_cnt0").val("");
	    		$("#local_cnt0").prop('disabled', true);
	    	}
	    	if(item.MOBILE_PHONE == '1'){	// 주민번호
	    		$("#chk_mob").prop("checked",true);
	    		$("#mob_cnt0").val(item.MOBILE_PHONE_CNT);
	    		$("#mob_cnt0").prop('disabled', false);
	    	} else {
	    		$("#chk_mob").prop("checked",false);
	    		$("#mob_cnt0").val("");
	    		$("#mob_cnt0").prop('disabled', true);
	    	}
	    },
	    error: function (request, status, error) {
			alert("Server Error : " + error);
	        console.log("ERROR : ", error);
	    }
	});
}

$('#btnDataTypeBtn').on('click', function(){
	var ap_no = $('#ap_no').val();
	var datatype_name = $('#datatypeName0').val();
	
	var datatypeArr = new Array(); 
	var cntArr = new Array(); 
	$('[name=chk_dataType0]').each(function(i, element){
	    if (element.checked) {
		    var id = $(element).val();
		    datatypeArr.push(id);
		    cntArr.push($("#" + id+"_cnt0").val());
	    }
    });
	if(ap_no == ''){
		alert('망 유형을 선택해야합니다.')
		return false;
	}
	if (isNull(datatype_name)) {
		alert("저장할 유형명을 입력하세요.");
		return;
	}
	if(datatypeArr.length == 0){
		alert('개인정보를 선택 해주세요.')
		return false;
	}
	
	var profileArr = datatypeArr.toString();
	var profileCntArr = cntArr.toString();
	console.log("profileArr : " + profileArr);
	
	var ocr = $("#chkOcr0").is(":checked") ? "1" : "0";
	var capture = "1";
	
	var message = $('#ap_name').val() + "의 모든 검색 정책을 변경 하시겠습니까?";
	if (confirm(message)) {
		var postData = {
				ap_no : ap_no,
				datatype_name : datatype_name,
				profileArr : profileArr, 
				cntArr : profileCntArr, 
				ocr : ocr,
				capture : capture
		};
		$.ajax({
			type: "POST",
			url: "/scan/insertPolicy",
			async : false,
			data : postData,
		    success: function (item) {
		    	console.log(item)
		    	if(item.resultCode == 201){
		    		alert($('#ap_name').val() + '에 검색 정책을 적용 하였습니다.')
		    	} else {
		    		alert($('#ap_name').val() + '의 검색 정책 변경을 실패하였습니다.')
		    	}
		    },
		    error: function (request, status, error) {
				alert("Server Error : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	}
})


</script>



</body>
</html>