<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<style>
	#pcAdminPopup .ui-jqgrid tr.ui-row-ltr td{
		cursor: pointer;
	}
	#input_targetUserGridPager .ui-pg-input{
		margin: 2px 5px 5px;
	}
	.ui-jqgrid tr.ui-row-ltr td{
		cursor: pointer;
	}
	#sch_bar_sort *{
		text-align-last: center;
		text-align: center;
	}
</style>
		<section>
			<!-- container -->
				<div class="container" style="height: 1167px;">
					<%-- <%@ include file="../../include/menu.jsp"%> --%>
					<h3>라이선스 관리</h3>
					<p class="container_comment" style="position: absolute; top: 32px; left: 187px; font-size: 13px; color: #9E9E9E;">라이선스 사용량 조회 화면입니다.</p>
					<!-- content -->
					<div class="content magin_t25" style="height: 1071px;">
						<div id="lisk_serach" style="float: left; margin-right: 10px;">
							<table class="user_info narrowTable" style="width: 364px;">
								<tbody>
									<tr>
										<th style="text-align: center; border-radius: 0.25rem;">조회</th>
				             			     <td>
				                				 <input type="text" style="width: 274px; padding-left: 5px;" size="10" id="targetSearch" placeholder="검색어를 입력하세요.">
				                			 </td>
				                		<td>
				                    		 <input type="button" name="button" class="btn_look_approval" id="btn_sch_target" style="margin-top: 5px;">
				                    	</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div>
							<table class="user_info approvalTh" style="width: 25%; min-width: 240px;" id="totalTable">
								<tbody>
									<tr>
										<td style="width: 22.3vw;">
											<input type="month" id="fromDate" class="allDateSearch" style="text-align: center;  width:194px;" readonly="readonly" value="${fromDate}" >
											<span class="allDateSearch">~</span>
											<input type="month" id="toDate" style="text-align: center;  width:194px;" readonly="readonly" value="${toDate}">
											<input type="hidden" id="date" style="text-align: center;  width:194px;" readonly="readonly" value="" >
											<input type="button" name="button" class="btn_look_approval" id="btnSearch" style="margin-top: 7px; margin-right: 4px;">
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						 <div class="list_sch" style="position: relative; right: 4px; bottom: 26px;">
		                    <div class="sch_area">
								<button type="button" class="btn_down" id="btnExcelDownload">다운로드</button>
		                    </div>
		                </div> 
		                <div id="exportTotalLicense" style="display: none;"></div>
		                <div id="exportsearchLicense" style="display: none;"></div>
						<div class="content_left" style="width: 364px; float: left; height: 1084px;">
							<!-- <h3 style="display:inline; padding: 0;" id="title1">그룹조회</h3> -->
							<div class="left_box" style=" height: calc( 100% - 81px ); margin-top: 6px;">
								<div id="selectLicenseGroup"></div>
							</div>
						</div>
						<div class="content_middle" style="width: 1400px; height: 341px; float: left; padding-left: 10px; margin-top: -21px;">
							<div class="mid_box" style="border: 1px solid #c8ced3; width: 1390px; height: calc( 100% - 6px ); border-radius: 0.25rem; "> 
								<input id="select_status" type="hidden">
								<!-- <div id="total_status" style="position: absolute; z-index: 10; right: 81px; top: 126px;">
									<select id="total_license_status" name="total_license_status" style="width: 81px; font-size: 12px; padding-left: 5px;">
	                            		<option value="TB" selected>TB</option>
	                                    <option value="GB" >GB</option>
	                                    <option value="byte" >byte</option>
	                            	</select>
								</div> -->
								<div id="total_bar_graph" style="width: 100%; height: 100%;"></div>
								<div id='none_total_bar' class='none_data'><!-- 대상에 사용된 라이선스가 존재하지 않습니다. --></div>
							</div>
						</div>	
						<div class="content_middle" style="width: 1400px; height: 334px; float: left;  padding-left: 10px; ">
							<div class="mid_box" style="border: 1px solid #c8ced3; width: 692px; height: calc( 100% - 6px ); margin-right: 6px; border-radius: 0.25rem; float: left;"> 
								<div id="top_license_graph" style="width: 100%; height: 100%;"></div>
								<div id='none_top' class='none_data'><!-- 대상에 사용된 라이선스가 존재하지 않습니다. --></div>
							</div>
							<div class="mid_box" style="border: 1px solid #c8ced3; width: 692px; height: calc( 100% - 6px ); border-radius: 0.25rem; float: left;">  
								<div id="bottom_license_graph" style="width: 100%; height: 100%;"></div>
								<div id='none_bottom' class='none_data'></div>
							</div>
						</div>	
						<div class="content_middle" style="width: 1400px; height: 341px; float: left;  padding-left: 10px;">
							<div class="mid_box" style="border: 1px solid #c8ced3; width: 1390px; height: calc( 100% - 16px ); border-radius: 0.25rem; margin: 3px 0 9px 0; "> 
								<div id="server_bar_graph" style="width: 100%; height: 100%;"></div>
								<div id='none_server' class='none_data'><!-- 대상에 사용된 라이선스가 존재하지 않습니다. --></div>
							</div>
						</div>	
					<div>
				</div>
			<!-- container -->
		</section>
		<!-- section -->

<%@ include file="../../include/footer.jsp"%>
<script type="text/javascript">
var group_name = "시스템 별";
var xbar = 5 ;// 세로바 가로 길이제한(스크롤)
var ybar = 8 ; // 가로바 세로 길이제한(스크롤)
$(document).ready(function() {
	
	$('#selectLicenseGroup').jstree({
		// List of active plugins
		"core" : {
		    "animation" : 0,
		    "check_callback" : true,
			"themes" : { "stripes" : false },
			"data" : ${licenseList},
		},
		"types" : {
		    "#" : {
		      "max_children" : 1,
		      "valid_children" : ["root"]
		    },
		    "default" : {
		      "valid_children" : ["default","file"]
		    },
		    "file" : {
		      "icon" : "glyphicon glyphicon-file",
		      "valid_children" : []
		    }
		},
		'search': {
	        'case_insensitive': false,
	        'show_only_matches' : true,
	        "show_only_matches_children" : true
	    },
	    'checkbox' : {
	        'three_state': false
	    },
		'plugins' : [/* "contextmenu" */,"search",
			"types",
			"unique",
			/* "checkbox", */
			"changed"],
	}).bind("loaded.jstree", function(e, data) {
		
		graphData($("#selectLicenseGroup").jstree(true)._model.data);
		pie_graphData($("#selectLicenseGroup").jstree(true)._model.data);
		
		$("#selectLicenseGroup").jstree("open_node", "all");
	}).bind('select_node.jstree', function(evt, result, x) {
    	var id = result.node.id;
    	var name =  result.node.text;
    	var arrJiju = [];
    	var arrProject = [];
    	
		if(id == "all"){
			group_name = "시스템 별";
			graphData($("#selectLicenseGroup").jstree(true)._model.data);
			pie_graphData($("#selectLicenseGroup").jstree(true)._model.data);
			
			$("#selectLicenseGroup").jstree("open_node", "all");
    	}

    	if(result.node.data.team != 0 && id != "all"){
    		pie_name = name.split("(");
        	
        	if(pie_name.length > 0){
        		group_name = pie_name[0];
        	}
        	
        	if(result.node.data.type == 0){
        		var data_size =  formatSizeUnits(result.node.data.usage);
        		var data_diff_size =  formatSizeUnits(result.node.data.diff_usage);
        		var parent_name =  result.node.data.parent_name;
        		
        		if(data_size > 0){
	        		var data = {
	          			"NAME" : group_name,
               			"DATA_USAGE" : data_size,
        				"DATA_DIFF_USAGE" : data_diff_size,
        				"PARENT_NAME" : parent_name
	          		};
	          		
	          		if(result.node.data.team == 1) {
	          			arrProject.push(data);
	          		} else {
	          			arrJiju.push(data);
	          		}
        		}
        	}

        	$.each(result.node.children_d, function(key, val){
        		
        		var nodeData = $("#selectLicenseGroup").jstree(true).get_node(val);
        		var team = "";
        		var usage = "";
        		var diff_usage = "";
        		var name = nodeData.text.split("(");;
        		var parent_name = "";
        		
        		if(name.length > 0){
        			name = name[0];
        		}else{
        			name = nodeData.text;
        		}
        		
        		if(nodeData.data == null){
        			return true;
        		}

        		if(nodeData.data.team == 0) {
        			return true;
        		}
        		
        		if(nodeData.data.type == 1){
        			return true;
        		}
        		
        		if(nodeData.data.team != null){
        			team = nodeData.data.team;
        		}else {
        			return true;
        		}
        		
        		if(nodeData.data.usage != null){
        			usage = nodeData.data.usage;
        		}
        		if(nodeData.data.diff_usage != null){
        			diff_usage = nodeData.data.diff_usage;
        		}
        		
        		if(usage == 0){
        			return true;
        		}
        		
        		if(nodeData.data.parent_name != null){
        			parent_name = nodeData.data.parent_name;
        		}
        		
        		if(parent_name != ""){
        	 		name = parent_name + " / " + name;
        	 	}
        		
        		var data_size = formatSizeUnits(usage);
        		var data_diff_size = formatSizeUnits(diff_usage);
        		
        		if(data_size > 0){
        			var data = {
               			"NAME" : name,
               			"DATA_USAGE" : data_size,
        				"DATA_DIFF_USAGE" : data_diff_size,
        				"PARENT_NAME" : parent_name
               		};
               		
               		var data2 = {};
               		
               		if(team == 1) {
               			arrProject.push(data);
               		} else {
               			arrJiju.push(data);
               		}	
        		}
        	});

        	top_license_graph(arrJiju);
        	bottom_license_graph(arrProject);
        	
        	pie_graphData(result.node.children_d)
    	}
    	
    });
	// top_bar_graph(2, null);
	// bottom_bar_graph(1, null);
	// pie_graph(1, null);
	setSelectDate();
	select_month_bar_graph();
});
    	
$("#btnSearch").click(function(e){
	
	var oToday = new Date();
	var month = oToday.getMonth();
	var searchType = 0;
	
	if($("#selectDay").val() == "totalLicense"){
		if($("#toDate").val() == null){
			alert("일자를 지정 후 검색해주세요.");
			return;
		}
		searchType = 1;
	}else{
		searchType = 2;
	}

	if($("#toDate").val() == "" || $("#fromDate").val() == ""){
	    alert("모든 일자를 지정 후 검색해주세요.");
	    return;
    }
	
	/* if($("#toDate").val() > getFormatDate(oToday)){
		alert("오늘 이전의 일자를 선택해주세요.");
		return;
	} */
	
	if($("#fromDate").val() > $("#toDate").val()){
		alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
		return;
	}
	
	var postData = {
			toDate : $("#toDate").val(),
			fromDate : $("#fromDate").val()
	};

	$.ajax({
		type: "POST",
		url: "/group/searchLicenseList",
		async : false,
		data: postData,
		dataType: "json",
		success: function (resultMap) {
	    	
			if(resultMap.resultCode == -1){
				console.log("검색 실패");	    		
        		return;
        	}
			
        	var data = JSON.parse(resultMap.data);
        	$('#selectLicenseGroup').jstree(true).settings.core.data = data;
        	$('#selectLicenseGroup').jstree(true).refresh();
        	
        	graphData(data, 0);
        	pie_graphData(data);
        	select_month_bar_graph();
	    },
	    error: function (request, status, error) {
	        console.log("request : ", request);
	        console.log("status : ", status);
	        console.log("ERROR : ", error);
	    }
	});
});		
    		
$("#btnExcelDownload").click(function(e){
	excelDownload();
});

function getFormatDate(oDate) {
	var nYear = oDate.getFullYear(); // yyyy 
	var nMonth = (1 + oDate.getMonth()); // M 
	nMonth = ('0' + nMonth).slice(-2); // month 두자리로 저장 

	//var nDay = oDate.getDate(); // d 
	//nDay = ('0' + nDay).slice(-2); // day 두자리로 저장

	//return nYear + '_' + nMonth + '_' + nDay;
	return nYear + '-' + nMonth;
}

function getFormatDate2(oDate) {
	var nYear = oDate.getFullYear(); // yyyy 
	var nMonth = (1 + oDate.getMonth()); // M 
	nMonth = ('0' + nMonth).slice(-2); // month 두자리로 저장 

	//var nDay = oDate.getDate(); // d 
	//nDay = ('0' + nDay).slice(-2); // day 두자리로 저장

	//return nYear + '_' + nMonth + '_' + nDay;
	return nYear + '_' + nMonth;
}


function setSelectDate() {

/* 	$("#fromDate").datepicker({
        dateFormat: 'yy-mm',
		changeMonth: true,
	    changeYear: true,
	    showButtonPanel: true,
	    onClose: function(dateText, inst) {  
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val(); 
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val(); 
            $(this).datepicker('setDate', new Date(year, month, 1));
            $(".ui-datepicker-calendar").css("display","none");
        }
    });
	
	$("#fromDate").focus(function () {
		$(".ui-datepicker-calendar").css("display","none");
		$("#ui-datepicker-div").position({
			  my: "center top",
			  at: "center bottom",
			  of: $(this)
		});
	}); */
	
	$("#fromDate").monthpicker({
		monthNames: ['01월', '02월', '03월', '04월', '05월', '06월',
        '07월', '08월', '09월', '10월', '11월', '12월'],
        monthNamesShort: ['01월', '02월', '03월', '04월', '05월', '06월', '07월', '08월', '09월', '10월', '11월', '12월'],
        //showOn: "button",
        //buttonImage: "../../Images/Goods/calendar.jpg",
        //buttonImageOnly: true,
        changeYear: false,
        yearRange: 'c-2:c+2',
        dateFormat: 'yy-mm'
        });
	
	$("#toDate").monthpicker({
		monthNames: ['01월', '02월', '03월', '04월', '05월', '06월',
        '07월', '08월', '09월', '10월', '11월', '12월'],
        monthNamesShort: ['01월', '02월', '03월', '04월', '05월', '06월', '07월', '08월', '09월', '10월', '11월', '12월'],
        //showOn: "button",
        //buttonImage: "../../Images/Goods/calendar.jpg",
        //buttonImageOnly: true,
        changeYear: false,
        yearRange: 'c-2:c+2',
        dateFormat: 'yy-mm'
        });
	 
	
	/* $("#toDate").datepicker({
        dateFormat: 'yy-mm',
		changeMonth: true,
	    changeYear: true,
	    showButtonPanel: true,
	    onClose: function(dateText, inst) {  
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val(); 
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val(); 
            $(this).datepicker('setDate', new Date(year, month, 1));
            $(".ui-datepicker-calendar").css("display","none");
        }
    });
	
	$("#toDate").focus(function () {
		$(".ui-datepicker-calendar").css("display","none");
		$("#ui-datepicker-div").position({
			  my: "center top",
			  at: "center bottom",
			  of: $(this)
		});
	}); */
/* 
    $("#toDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm'
    });  */

	/*  var oToday = new Date();
	$("#toDate").val(getFormatDate(oToday));
	var toDate = $("#toDate").val();  */ 
	
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
        dateFormat: 'yyyy-mm',
		yearRange: 'c-5:c+5'
	});  
	
});


function graphData(data, type){
	var arrJiju = [];
	var arrProject = [];
	var count = 0;
	
	$.each(data, function(key, val){
		// 갯수 limit 

		var team = "";
		var usage = "";
		var diff_usage = "";
		var name = val.text;
		var parent_name = "";
		
		if(val.data == null){
			return true;
		}
		if(val.data.team == 0) {
			return true;
		}
		if(val.data.type == 1){
			return true;
		}
		if(val.data.team != null){
			team = val.data.team;
		}else {
			return true;
		}
		if(val.data.parent_name != null){
			parent_name = val.data.parent_name;
		}
		if(name != null ){
			name = name.split("(");
			if(name.length > 0){
				name = name[0];
			}else{
				name = val.text;
			} 
		}
		
	 	if(parent_name != ""){
	 		name = parent_name + " / " + name;
	 	}
		if(val.data.usage != null){
			usage = val.data.usage;
		}
		if(val.data.diff_usage != null){
			diff_usage = val.data.diff_usage;
		}
		if(usage == 0){
			return true;
		}
		
		var data_size = formatSizeUnits(usage);
		var data_diff_size = formatSizeUnits(diff_usage);
		
		if(data_size > 0){
			var data = {
				"NAME" : name,
				"DATA_USAGE" : data_size,
				"DATA_DIFF_USAGE" : data_diff_size,
				"PARENT_NAME" : parent_name
			};
			
			if(team == 1) {
				arrProject.push(data);
			}else if(team == 2) {
				arrJiju.push(data);
			}
			
			count++;
		}
	});

	top_license_graph(arrJiju);
	bottom_license_graph(arrProject);
}

function pie_graphData(result){
	var arrHost = [];
    
    var before_key = "";
	
	$.each(result, function(key, val){
		
		var nodeData = $("#selectLicenseGroup").jstree(true).get_node(val);
		var usage = "";
		var diff_usage = "";
		var name = nodeData.text;
		
		if(nodeData.data == null){
			return true;
		}

		if(nodeData.data.team != 0){
			return true;
		}
		
		if(nodeData.data.usage != null){
			usage = nodeData.data.usage;
		}
		if(nodeData.data.diff_usage != null){
			diff_usage = nodeData.data.diff_usage;
		}
		
		if(nodeData.data.stype != 1){
			return true;
		}
		
		if(name != null){
			name = name.split("(");
			if(name.length > 0){
				name = name[0];
			}else{
				name = nodeData.text;
			}
		}
		
		if(usage == 0){
			return true;
		}
		
		var data_size = formatSizeUnits(usage);
		var data_diff_size = formatSizeUnits(diff_usage);
		
		if(data_size > 0){
			var data = {
				"NAME" : name,
				"DATA_USAGE" : data_size,
				"DATA_DIFF_USAGE" : data_diff_size
			};
			arrHost.push(data);
		}
		
	});
	server_bar_graph(arrHost);
}

function formatSizeUnits(bytes){
	
	// bytes = (bytes / 1073741824).toFixed(2)
	/* 
	if      (bytes >= 1073741824) { bytes = (bytes / 1073741824).toFixed(2) + " GB"; }
	else if (bytes >= 1048576)    { bytes = (bytes / 1048576).toFixed(2) + " MB"; }
	else if (bytes >= 1024)       { bytes = (bytes / 1024).toFixed(2) + " KB"; }
	else if (bytes > 1)           { bytes = bytes + " bytes"; }
	else if (bytes == 1)          { bytes = bytes + " byte"; }
	else                          { bytes = "0 bytes"; } */
	
	bytes = parseFloat((bytes / 1073741824).toFixed(2));
	
	if(bytes < 0.00){
		bytes == 0;
	}
	return bytes
};




function formatSizeTB(bytes){
	return (bytes / 1099511627776).toFixed(2) + " TB";
};
function formatSizeGB(bytes){
	return  (bytes / 1073741824).toFixed(2) + " GB";
};


function top_license_graph(result) {
	$("#none_top").html("");
	
	var x = 0;
	var bar_graph_10 = 0;
	var bar_graph_50 = 100;
	
	$.each(result, function(key, value){
		if(value.DATA_USAGE <= 0){
			x++;
		}		
	});

	if(result == '' || result.length == 0 || result.length == x){
		$('#none_top').html("대상에 사용된 라이선스가 존재하지 않습니다.");
	}
	 
	var name = [];
	var data_usage = [];
	var diff_data_usage = [];

	result.sort(function(a, b) { // 이름 정렬
		var upperCaseA = b.NAME.toUpperCase();
		var upperCaseB = a.NAME.toUpperCase();
		 
		if(upperCaseA < upperCaseB) return 1;
		if(upperCaseA > upperCaseB) return -1;
		if(upperCaseA === upperCaseB) return 0;
	}); 
	
	
	if(result.length != x){
		$.each(result, function(key, value){
		    $.each(value, function(key, value){
	    		if(key == "DATA_USAGE") data_usage.push(value);
	    		if(key == "DATA_DIFF_USAGE") diff_data_usage.push(value);
		    	if(key == "NAME") name.push(value);
		    });
		}); 
	};
	
	if(data_usage.length > xbar){
		bar_graph_10 = 10; // 세로
		bar_graph_50 = 50; // 가로 
		
		if(data_usage.length < 10){
			bar_graph_50 = 50;
		}else if(data_usage.length < 20){
			bar_graph_50 = 30;
		}else if(data_usage.length < 30){
			bar_graph_50 = 20;
		}else if(data_usage.length < 40){
			bar_graph_50 = 15;
		}else if(data_usage.length < 70){
			bar_graph_50 = 10;
		}else{
			bar_graph_50 = 5;
		}
		
	} 
	
	var echartbar = echarts.init(document.getElementById('top_license_graph'));
	echartbar.setOption({
		  tooltip: {
			    trigger: 'axis',
			    axisPointer: {
		            type: 'shadow'
		        }
			  }, 
			  textStyle: {
					fontFamily: 'NotoSansR',
					fontSize: 14
				},
			  title: {
			    text: '계열사별 사용량',
			    /* subtext: '기본 단위 : GB', */
			    left: 'center'
			 },
			  dataZoom: [ // 가로 스크롤 (계열사 별 Bar 그래프)
					 {
				        type: 'slider',
				        xAxisIndex: 0,
				        filterMode: 'weakFilter',
				        height: bar_graph_10,
				        bottom: bar_graph_10,
				        start: 0,
				        end: bar_graph_50,
				        handleSize: 0,
				        showDetail: false
				      },
				      {
				        type: 'inside',
				        id: 'insideX',
				        xAxisIndex: 0,
				        filterMode: 'weakFilter',
				        start: 0,
				        end: 26,
				        zoomOnMouseWheel: false,
				        moveOnMouseMove: true,
				        moveOnMouseWheel: true
				      }
				    ],
			  legend: {
				data: ['사용량', '누적 사용량'],
			 	left : 0
			  },
			  xAxis: [
			    {
			      type: 'category',
			      data: name,
			      axisLabel: {
		                interval:0,
		                rotate: 20, // 기울기
		                formatter: function (value) {
		                    if (value.length > 15) {
		                    value = value.substring(0, 9) + "...";
		                    }
		                    return value;
		                }
	              },
			      axisPointer: {
			        type: 'shadow'
			      }
			    }
			  ],
			  yAxis: {
			        type: 'value',
			        boundaryGap: [0, 0.01],
			        axisLabel: {
			            formatter: '{value} GB'
			          }
			    },
			  series: [
			    	{
				      name: '사용량',
				      type: 'bar',
			          barWidth: 50,
				      color : ['#038FDA'],
				      data: diff_data_usage,
				      itemStyle: {
			                normal: {
			                    label: {
			                        show: true,
			                        position: 'top',
			                        color: '#000',
			                        formatter: '{c}GB',
									fontSize: 9
			                    }
			                }
			            }
				    },
				    {
					      name: '누적 사용량',
					      type: 'bar',
				          barWidth: 50,
					      color : ['#CC0F2E'],
					      data: data_usage,
					      itemStyle: {
				                normal: {
				                    label: {
				                        show: true,
				                        position: 'top',
				                        color: '#000',
				                        formatter: '{c}GB',
										fontSize: 9
				                    }
				                }
				            }
				    },
			]
	});
};

function bottom_license_graph(result) {
	
	$('#none_bottom').html("");
	var x = 0;
	var bar_graph_10 = 0;
	var bar_graph_50 = 100;
	
	$.each(result, function(key, value){
		if(value.DATA_USAGE <= 0){
			x++;
		}		
	});

	if(result == '' || result.length == 0 || result.length == x){
		$('#none_bottom').html("대상에 사용된 라이선스가 존재하지 않습니다.");
	}
	 
	var name = [];
	var data_usage = [];
	var diff_data_usage = [];

	result.sort(function(a, b) { // 이름 정렬
		var upperCaseA = b.NAME.toUpperCase();
		var upperCaseB = a.NAME.toUpperCase();
		 
		if(upperCaseA < upperCaseB) return 1;
		if(upperCaseA > upperCaseB) return -1;
		if(upperCaseA === upperCaseB) return 0;
	}); 
	
	
	if(result.length != x){
		$.each(result, function(key, value){
		    $.each(value, function(key, value){
	    		if(key == "DATA_USAGE") data_usage.push(value);
	    		if(key == "DATA_DIFF_USAGE") diff_data_usage.push(value);
		    	if(key == "NAME") name.push(value);
		    });
		}); 
	};
	
	if(data_usage.length > xbar){
		bar_graph_10 = 10; // 세로
		bar_graph_50 = 50; // 가로 
		
		if(data_usage.length < 10){
			bar_graph_50 = 50;
		}else if(data_usage.length < 20){
			bar_graph_50 = 30;
		}else if(data_usage.length < 30){
			bar_graph_50 = 20;
		}else if(data_usage.length < 40){
			bar_graph_50 = 15;
		}else if(data_usage.length < 70){
			bar_graph_50 = 10;
		}else{
			bar_graph_50 = 5;
		}
		
	} 
	
	var echartbar = echarts.init(document.getElementById('bottom_license_graph'));
	echartbar.setOption({
		  tooltip: {
			    trigger: 'axis',
			    axisPointer: {
		            type: 'shadow'
		        }
			  },
			  textStyle: {
					fontFamily: 'NotoSansR',
					fontSize: 14
				},
			  title: {
			    text: '프로젝트별 사용량',
			    /* subtext: '기본 단위 : GB', */
			    left: 'center'
			 },
			  dataZoom: [ // 가로 스크롤 (계열사 별 Bar 그래프)
					 {
				        type: 'slider',
				        xAxisIndex: 0,
				        filterMode: 'weakFilter',
				        height: bar_graph_10,
				        bottom: bar_graph_10,
				        start: 0,
				        end: bar_graph_50,
				       handleSize: 0,
				        showDetail: false
				      },
				      {
				        type: 'inside',
				        id: 'insideX',
				        xAxisIndex: 0,
				        filterMode: 'weakFilter',
				        start: 0,
				        end: 26,
				        zoomOnMouseWheel: false,
				        moveOnMouseMove: true,
				        moveOnMouseWheel: true
				      }
				    ],
			  legend: {
				data: ['사용량', '누적 사용량'],
			 	left : 0
			  },
			  xAxis: [
			    {
			      type: 'category',
			      data: name,
			      axisLabel: {
		                interval:0,
		                rotate: 20, // 기울기
		                formatter: function (value) {
		                    if (value.length > 15) {
		                    value = value.substring(0, 9) + "...";
		                    }
		                    return value;
		                }
	              },
			      axisPointer: {
			        type: 'shadow'
			      }
			    }
			  ],
			  yAxis: {
			        type: 'value',
			        boundaryGap: [0, 0.01],
			        axisLabel: {
			            formatter: '{value} GB'
			          }
			    },
			  series: [
			    	{
			    		name: '사용량',
					    type: 'bar',
				        barWidth: 50,
					    color : ['#038FDA'],
					    data: diff_data_usage,
					    itemStyle: {
					    	normal: {
					    		label: {
				                	show: true,
				                    position: 'top',
				                    color: '#000',
				                    formatter: '{c}GB',
									fontSize: 9
				                    }
			    				}
				            }
				    },
				    {
			    		name: '누적 사용량',
					    type: 'bar',
				        barWidth: 50,
				        color : ['#CC0F2E'],
					    data: data_usage,
					    itemStyle: {
					    	normal: {
					    		label: {
				                	show: true,
				                    position: 'top',
				                    color: '#000',
				                    formatter: '{c}GB',
									fontSize: 9
				                    }
			    				}
				            }
				    },
				]
	});
};

function total_bar_graph(result) {
	
	$('#none_total_bar').remove();
	var x = 0;
	/* var select_status = $("select[name='total_license_status']").val(); */
	var select_status = "TB";
	
	/* var bar_graph_10 = 0;
	var bar_graph_50 = 100; */
	
	$.each(result, function(key, value){
		if(value.DATA_USAGE <= 0){
			x++;
		}		
	});

	if(result == '' || result.length == 0 || result.length == x){
		$('#none_total_bar').html("대상에 사용된 라이선스가 존재하지 않습니다.");
	}
	 
	var name = [];
	var data_usage = [];
	var diff_data_usage = [];

	result.sort(function(a, b) { // 이름 정렬
		var upperCaseA = b.NAME.toUpperCase();
		var upperCaseB = a.NAME.toUpperCase();
		 
		if(upperCaseA < upperCaseB) return 1;
		if(upperCaseA > upperCaseB) return -1;
		if(upperCaseA === upperCaseB) return 0;
	}); 
	
	
	if(result.length != x){
		$.each(result, function(key, value){
		    $.each(value, function(key, value){
	    		if(key == "DATA_USAGE") data_usage.push(value);
	    		if(key == "DATA_DIFF_USAGE") diff_data_usage.push(value);
		    	if(key == "NAME") name.push(value);
		    });
		}); 
	};
	
	/* if(data_usage.length > xbar){
		bar_graph_10 = 10; // 세로
		bar_graph_50 = 50; // 가로 
		
		if(data_usage.length < 10){
			bar_graph_50 = 50;
		}else if(data_usage.length < 20){
			bar_graph_50 = 30;
		}else if(data_usage.length < 30){
			bar_graph_50 = 20;
		}else if(data_usage.length < 40){
			bar_graph_50 = 15;
		}else if(data_usage.length < 70){
			bar_graph_50 = 10;
		}else{
			bar_graph_50 = 5;
		}
	} */  
	
	var echartbar = echarts.init(document.getElementById('total_bar_graph'));
	echartbar.setOption({
		  tooltip: {
			    trigger: 'axis',
			    axisPointer: {
		            type: 'shadow'
		        }
			  }, 
			  textStyle: {
					fontFamily: 'NotoSansR',
					fontSize: 14
				},
			  title: {
			    text: '라이선스 사용량',
			    /* subtext: '기본 단위 : TB', */
			    left: 'center'
			 },
			  legend: {
				data: ['사용량', '누적 사용량'],
			 	left : 0
			  },
			  xAxis: [
			    {
			      type: 'category',
			      data: name,
			      axisLabel: {
		                interval:0,
		                rotate: 20, // 기울기
		                formatter: function (value) {
		                    if (value.length > 15) {
		                    value = value.substring(0, 9) + "...";
		                    }
		                    return value;
		                }
	              },
			      axisPointer: {
			        type: 'shadow'
			      }
			    }
			  ],
			  yAxis: {
			        type: 'value',
			        boundaryGap: [0, 0.01],
			        axisLabel: {
			            formatter: '{value} '+ select_status
			          }
			    },
			  series: [
			    	{
				      name: '사용량',
				      type: 'bar',
				      color : ['#038FDA'],
                      barWidth: 30, 
				      data: diff_data_usage,
				      itemStyle: {
			                normal: {
			                    label: {
			                        show: true,
			                        position: 'top',
			                        color: '#000',
			                        formatter: '{c}',
			    					fontSize: 9
			                    }
			                }
			            }
				    },
				    { 
					      name: '누적 사용량',
					      type: 'bar',
					      color : ['#CC0F2E'],
	                      barWidth: 30,
					      data: data_usage,
					       itemStyle: {
				                normal: {
				                    label: {
				                        show: true,
				                        position: 'top',
				                        color: '#000',
				                        formatter: '{c}',
				    					fontSize: 9
				                    }
				                }
				            } 
				    },
			]
	});
};

function server_bar_graph(result) {
	$('#none_server').html("");
	var x = 0;
	var bar_graph_10 = 0;
	var bar_graph_50 = 100;

	$.each(result, function(key, value){
		if(value.DATA_USAGE <= 0){
			x++;
		}		
	});

	if(result == '' || result.length == 0 || result.length == x){
		$('#none_server').html("대상에 사용된 라이선스가 존재하지 않습니다.");
	}
	 
	var name = [];
	var data_usage = [];
	var diff_data_usage = [];

	result.sort(function(a, b) { // 이름 정렬
		var upperCaseA = b.NAME.toUpperCase();
		var upperCaseB = a.NAME.toUpperCase();
		 
		if(upperCaseA < upperCaseB) return 1;
		if(upperCaseA > upperCaseB) return -1;
		if(upperCaseA === upperCaseB) return 0;
	}); 
	
	
	if(result.length != x){
		$.each(result, function(key, value){
		    $.each(value, function(key, value){
	    		if(key == "DATA_USAGE") data_usage.push(value);
	    		if(key == "DATA_DIFF_USAGE") diff_data_usage.push(value);
		    	if(key == "NAME") name.push(value);
		    });
		}); 
	};
	
	if(data_usage.length > xbar){
		bar_graph_10 = 10; // 세로
		bar_graph_50 = 50; // 가로 
		
		if(data_usage.length < 10){
			bar_graph_50 = 50;
		}else if(data_usage.length < 20){
			bar_graph_50 = 30;
		}else if(data_usage.length < 30){
			bar_graph_50 = 20;
		}else if(data_usage.length < 40){
			bar_graph_50 = 15;
		}else if(data_usage.length < 70){
			bar_graph_50 = 10;
		}else{
			bar_graph_50 = 5;
		}
	} 
	
	var echartbar = echarts.init(document.getElementById('server_bar_graph'));
	echartbar.setOption({

		  tooltip: {
			    trigger: 'axis',
			    axisPointer: {
		            type: 'shadow'
		        }
			  },
			  textStyle: {
					fontFamily: 'NotoSansR',
					fontSize: 14
				},
			  title: {
			    text: '시스템별 사용량',
			    /* subtext: '기본 단위 : GB', */
			    left: 'center'
			 },
			  dataZoom: [ // 가로 스크롤 (계열사 별 Bar 그래프)
					 {
				        type: 'slider',
				        xAxisIndex: 0,
				        filterMode: 'weakFilter',
				        height: bar_graph_10,
				        bottom: bar_graph_10,
				        start: 0,
				        end: bar_graph_50,
				       handleSize: 0,
				        showDetail: false
				      },
				      {
				        type: 'inside',
				        id: 'insideX',
				        xAxisIndex: 0,
				        filterMode: 'weakFilter',
				        start: 0,
				        end: 26,
				        zoomOnMouseWheel: false,
				        moveOnMouseMove: true,
				        moveOnMouseWheel: true
				      }
				    ],
			  legend: {
				data: ['사용량', '누적 사용량'],
			 	left : 0
			  },
			  xAxis: [
			    {
			      type: 'category',
			      data: name,
			      axisLabel: {
		                interval:0,
		                rotate: 20, // 기울기
		                formatter: function (value) {
		                    if (value.length > 15) {
		                    value = value.substring(0, 9) + "...";
		                    }
		                    return value;
		                }
	              },
			      axisPointer: {
			        type: 'shadow'
			      }
			    }
			  ],
			  yAxis: {
			        type: 'value',
			        boundaryGap: [0, 0.01],
			        axisLabel: {
			            formatter: '{value} GB'
			          }
			    },
			  series: [
			    	{
			    		name: '사용량',
					    type: 'bar',
				        barWidth: 50,
					    color : ['#038FDA'],
					    data: diff_data_usage,
					    itemStyle: {
					    	normal: {
					    		label: {
				                	show: true,
				                    position: 'top',
				                    color: '#000',
				                    formatter: '{c}GB',
									fontSize: 9
				                    }
			    				}
				            }
				    },
				    {
			    		name: '누적 사용량',
					    type: 'bar',
				        barWidth: 50,
				        color : ['#CC0F2E'],
					    data: data_usage,
					    itemStyle: {
					    	normal: {
					    		label: {
				                	show: true,
				                    position: 'top',
				                    color: '#000',
				                    formatter: '{c}GB',
									fontSize: 9
				                    }
			    				}
				            }
				    },
				]
	});
};

/* 	
	const zoomSize = 6;
	echartdoughnut.on('click', function (params) {
		  console.log(data_name[Math.max(params.dataIndex - zoomSize / 2, 0)]);
		  echartdoughnut.dispatchAction({
		    type: 'dataZoom',
		    startValue: data_name[Math.max(params.dataIndex - zoomSize / 2, 0)],
		    endValue:
		    	data_name[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
		  });
		}); */
		

// 서버 명 검색
var to = true;
$('#btn_sch_target').on('click', function(){
	
    var v = $('#targetSearch').val();
	console.log(v);
	
	if(to) { clearTimeout(to); }
    to = setTimeout(function () {
      $('#selectLicenseGroup').jstree(true).search(v);
    }, 250);
});
$('#targetSearch').keyup(function (e) {
	var v = $('#targetSearch').val();
	if (e.keyCode == 13) {
    	
    	if(to) { clearTimeout(to); }
        to = setTimeout(function () {
          $('#selectLicenseGroup').jstree(true).search(v);
        }, 250);
    }
});

function excelDownload() {
	
	var oToday = new Date();
	var searchType = 0;
	
	if($("#selectDay").val() == "totalLicense"){
		if($("#toDate").val() == null){
			alert("일자를 지정 후 검색해주세요.");
			return;
		}
		searchType = 1;
	}else{
		/* if($("#toDate").val() == "" || $("#fromDate").val() == ""){
			alert("모든 일자를 지정 후 검색해주세요.");
			return;
		} */
		searchType = 2;
	}
	
	/* if($("#toDate").val() == getFormatDate(oToday)){
		alert("사용량을 조회 중입니다. 오늘 이전의 일자를 선택해주세요.");
		return;
	}
	
	if($("#toDate").val() > getFormatDate(oToday)){
		alert("오늘 이전의 일자를 선택해주세요.");
		return;
	} */
	
	if($("#fromDate").val() > $("#toDate").val()){
		alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
		return;
	}

	var _model = $("#selectLicenseGroup").jstree('get_selected',true);
	
	if(_model != '' ){
		if(_model[0].data != null){
			if(_model[0].data.type == 1){
				var parent =  ( $("#selectLicenseGroup").jstree(true).get_node(_model[0].id) ).parent;
				_model = $("#selectLicenseGroup").jstree(true).get_node(parent);
			}
		}
	}
	var target_id = [];
	var group_name = "";

	if(_model != '' ){
		if(_model.length > 0){
			target_id = _model[0].children_d;
			group_name = _model[0].text.split("(")[0];
		}else{
			target_id = _model.children_d;
			group_name = _model.text.split("(")[0];
		}
	}
	
	var oPostDt = {};
	oPostDt["toDate"] = $("#toDate").val();
	oPostDt["fromDate"] = $("#fromDate").val();
	oPostDt["searchType"] = searchType;
	oPostDt["TARGET_ID"] = JSON.stringify(target_id);
	oPostDt["GROUP_NAME"] = group_name;
	
	
	$.ajax({
		type: "POST",
		url: "/group/licenseExcelList",
		async : false,
		data: oPostDt,
		dataType: "json",
		success: function (resultMap) {
			// executeReportDownload(result);
			var serverTitle = '<tr>';
			serverTitle += '<th>서버명</th>';
			serverTitle += '<th>PIC 상위그룹</th>';
			serverTitle += '<th>PIC 하위그룹</th>';
			serverTitle += '<th>Recon 그룹</th>';
			serverTitle += '<th>전월 누적사용량(byte)</th>';
			serverTitle += '<th>전월 누적사용량(GB)</th>';
			serverTitle += '<th>전월 누적사용량(TB)</th>';
			serverTitle += '<th>전월</th>';
			serverTitle += '<th>금월 누적사용량(byte)</th>';
			serverTitle += '<th>금월 누적사용량(GB)</th>';
			serverTitle += '<th>금월 누적사용량(TB)</th>';
			serverTitle += '<th>금월</th>';
			serverTitle += '<th>금월 사용량(byte)</th>';
			serverTitle += '<th>금월 사용량(GB)</th>';
			serverTitle += '<th>금월 사용량(TB)</th>';
			serverTitle += '</tr>';
			serverTitle += '<tr>';
			
			var groupTitle = '<tr>';
			groupTitle += '<th>구분</th>';
			groupTitle += '<th>PIC 상위그룹</th>';
			groupTitle += '<th>PIC 하위그룹</th>';
			groupTitle += '<th>Recon 그룹</th>';
			groupTitle += '<th>전월 누적사용량(byte)</th>';
			groupTitle += '<th>전월 누적사용량(GB)</th>';
			groupTitle += '<th>전월 누적사용량(TB)</th>';
			groupTitle += '<th>전월</th>';
			groupTitle += '<th>금월 누적사용량(byte)</th>';
			groupTitle += '<th>금월 누적사용량(GB)</th>';
			groupTitle += '<th>금월 누적사용량(TB)</th>';
			groupTitle += '<th>금월</th>';
			groupTitle += '<th>금월 사용량(byte)</th>';
			groupTitle += '<th>금월 사용량(GB)</th>';
			groupTitle += '<th>금월 사용량(TB)</th>';
			groupTitle += '</tr>';
			groupTitle += '<tr>';
			var table = "";

			
			for(var i =0; i < 4; i++){
				var result;
				if(i < 2){ //그룹
					table += '<table id="groupLicense'+i+'"><tbody>';
					table += groupTitle;
					
					if(i == 0) {
						result = resultMap.gList;
					} else {
						result = resultMap.gpList;
					}
					
					
					$.each(result, function(i, item){
				    	 table += '<td>' + item.TEAM + '</td>';
				    	 table += '<td>' + item.PIC_UP_GROUP + '</td>';
				    	 table += '<td>' + item.PI_PARENT_GROUP + '</td>';
				    	 table += '<td>' + item.RECON_GROUP + '</td>';
				    	 table += '<td>' + item.PAST_BYTE + '</td>';
				    	 table += '<td>' + item.PAST_GB + '</td>';
				    	 table += '<td>' + item.PAST_TB + '</td>';
				    	 table += '<td>' + item.PAST_DATE + '</td>';
				    	 table += '<td>' + item.NOW_BYTE + '</td>';
				    	 table += '<td>' + item.NOW_GB + '</td>';
				    	 table += '<td>' + item.NOW_TB + '</td>';
				    	 table += '<td>' + item.NOW_DATE + '</td>';
				    	 table += '<td>' + item.USAGE_BYTE + '</td>';
				    	 table += '<td>' + item.USAGE_GB + '</td>';
				    	 table += '<td>' + item.USAGE_TB + '</td>';
				    	 table += '</tr><tr>';
				 		
				 	});
				} else {
					table += '<table id="serverLicense'+i+'"><tbody>';
					table += serverTitle;
					

					if(i == 2) {
						result = resultMap.sList;
					} else {
						result = resultMap.spList;
					}
					
					$.each(result, function(i, item){
				    	 table += '<td>' + item.HOST_NAME + '</td>';
				    	 table += '<td>' + item.PIC_UP_GROUP + '</td>';
				    	 table += '<td>' + item.PI_PARENT_GROUP + '</td>';
				    	 table += '<td>' + item.RECON_GROUP + '</td>';
				    	 table += '<td>' + item.PAST_BYTE + '</td>';
				    	 table += '<td>' + item.PAST_GB + '</td>';
				    	 table += '<td>' + item.PAST_TB + '</td>';
				    	 table += '<td>' + item.PAST_DATE + '</td>';
				    	 table += '<td>' + item.NOW_BYTE + '</td>';
				    	 table += '<td>' + item.NOW_GB + '</td>';
				    	 table += '<td>' + item.NOW_TB + '</td>';
				    	 table += '<td>' + item.NOW_DATE + '</td>';
				    	 table += '<td>' + item.USAGE_BYTE + '</td>';
				    	 table += '<td>' + item.USAGE_GB + '</td>';
				    	 table += '<td>' + item.USAGE_TB + '</td>';
				    	 table += '</tr><tr>';
				 		
				 	});
				}

			     table += '</tr></tbody></table>';
			}
		     
		    $("#exportsearchLicense").html(table);
	    },
	    error: function (request, status, error) {
	        console.log("request : ", request);
	        console.log("status : ", status);
	        console.log("ERROR : ", error);
	    }
	});
	
	/* $.ajax({
		type: "POST",
		url: "/group/licenseGroupExcelList",
		async : false,
		data: oPostDt,
		dataType: "json",
		success: function (resultMap) {
			// executeReportDownload(result);
			console.log(resultMap);
			var serverTitle = '<tr>';
			serverTitle += '<th>서버명</th>';
			serverTitle += '<th>PIC 상위그룹</th>';
			serverTitle += '<th>PIC 하위그룹</th>';
			serverTitle += '<th>Recon 그룹</th>';
			serverTitle += '<th>전월 누적사용량(byte)</th>';
			serverTitle += '<th>전월 누적사용량(GB)</th>';
			serverTitle += '<th>전월 누적사용량(TB)</th>';
			serverTitle += '<th>전월</th>';
			serverTitle += '<th>금월 누적사용량(byte)</th>';
			serverTitle += '<th>금월 누적사용량(GB)</th>';
			serverTitle += '<th>금월 누적사용량(TB)</th>';
			serverTitle += '<th>금월</th>';
			serverTitle += '<th>금월 사용량(byte)</th>';
			serverTitle += '<th>금월 사용량(GB)</th>';
			serverTitle += '<th>금월 사용량(TB)</th>';
			serverTitle += '</tr>';
			serverTitle += '<tr>';
			
			var groupTitle = '<tr>';
			groupTitle += '<th>구분</th>';
			groupTitle += '<th>PIC 상위그룹</th>';
			groupTitle += '<th>PIC 하위그룹</th>';
			groupTitle += '<th>Recon 그룹</th>';
			groupTitle += '<th>전월 누적사용량(byte)</th>';
			groupTitle += '<th>전월 누적사용량(GB)</th>';
			groupTitle += '<th>전월 누적사용량(TB)</th>';
			groupTitle += '<th>전월</th>';
			groupTitle += '<th>금월 누적사용량(byte)</th>';
			groupTitle += '<th>금월 누적사용량(GB)</th>';
			groupTitle += '<th>금월 누적사용량(TB)</th>';
			groupTitle += '<th>금월</th>';
			groupTitle += '<th>금월 사용량(byte)</th>';
			groupTitle += '<th>금월 사용량(GB)</th>';
			groupTitle += '<th>금월 사용량(TB)</th>';
			groupTitle += '</tr>';
			groupTitle += '<tr>';
			
			for(var i =0; i < 4; i++){
				var table;
				var result;
				if(i < 2){ //그룹
					table = '<table id="groupLicense'+i+'"><tbody>';
					table += groupTitle;
					
					if(i == 0) {
						result = resultMap.gList;
					} else {
						result = resultMap.gpList;
					}
					
					
					$.each(result, function(i, item){
				    	 table += '<td>' + item.TEAM + '</td>';
				    	 table += '<td>' + item.PIC_UP_GROUP + '</td>';
				    	 table += '<td>' + item.PI_PARENT_GROUP + '</td>';
				    	 table += '<td>' + item.RECON_GROUP + '</td>';
				    	 table += '<td>' + item.PAST_BYTE + '</td>';
				    	 table += '<td>' + item.PAST_GB + '</td>';
				    	 table += '<td>' + item.PAST_TB + '</td>';
				    	 table += '<td>' + item.PAST_DATE + '</td>';
				    	 table += '<td>' + item.NOW_BYTE + '</td>';
				    	 table += '<td>' + item.NOW_GB + '</td>';
				    	 table += '<td>' + item.NOW_TB + '</td>';
				    	 table += '<td>' + item.NOW_DATE + '</td>';
				    	 table += '<td>' + item.USAGE_BYTE + '</td>';
				    	 table += '<td>' + item.USAGE_GB + '</td>';
				    	 table += '<td>' + item.USAGE_TB + '</td>';
				    	 table += '</tr><tr>';
				 		
				 	});
				} else {
					table = '<table id="serverLicense'+i+'"><tbody>';
					table += serverTitle;
					

					if(i == 0) {
						result = resultMap.sList;
					} else {
						result = resultMap.spList;
					}
					
					$.each(result, function(i, item){
				    	 table += '<td>' + item.HOST_NAME + '</td>';
				    	 table += '<td>' + item.PIC_UP_GROUP + '</td>';
				    	 table += '<td>' + item.PI_PARENT_GROUP + '</td>';
				    	 table += '<td>' + item.RECON_GROUP + '</td>';
				    	 table += '<td>' + item.PAST_BYTE + '</td>';
				    	 table += '<td>' + item.PAST_GB + '</td>';
				    	 table += '<td>' + item.PAST_TB + '</td>';
				    	 table += '<td>' + item.PAST_DATE + '</td>';
				    	 table += '<td>' + item.NOW_BYTE + '</td>';
				    	 table += '<td>' + item.NOW_GB + '</td>';
				    	 table += '<td>' + item.NOW_TB + '</td>';
				    	 table += '<td>' + item.NOW_DATE + '</td>';
				    	 table += '<td>' + item.USAGE_BYTE + '</td>';
				    	 table += '<td>' + item.USAGE_GB + '</td>';
				    	 table += '<td>' + item.USAGE_TB + '</td>';
				    	 table += '</tr><tr>';
				 		
				 	});
				}

			     table += '</tr></tbody></table>';
			}
		     
		     
		     
		    $("#exportTotalLicense").html(table);
	    },
	    error: function (request, status, error) {
	        console.log("request : ", request);
	        console.log("status : ", status);
	        console.log("ERROR : ", error);
	    }
	}); */
	
	executeReportDownload();
	
}
/* function executeReportDownload(resultList) {
	
	
	var result = "구분, Recon그룹 , PIC 그룹, IP, 호스트명, 사용량(GB), 사용량(byte)\r\n";
	var host_name = "";
	
	console.log(resultList);
	
	$.each(resultList, function(i, item){
		result += item.TEAM + "," + item.RECON_NAME + "," + item.NAME + "," + item.AGENT_CONNECTED_IP + "," + item.HOST_NAME + "," + formatSizeUnits2(item.DATA_USAGE) + "," + item.DATA_USAGE + "\r\n";
		
		host_name = item.GROUP_NAME;
	});
	
	var oToday = new Date();
	today =  getFormatDate2(oToday);
	
	var blob = new Blob(["\ufeff"+result], {type: "text/csv;charset=utf-8"});
	
	if(navigator.msSaveBlob){
		window.navigator.msSaveOrOpenBlob(blob, host_name + '라이선스_사용량_'+today+".csv");
	}else{
		var downloadLink = document.createElement("a");
		var url = URL.createObjectURL(blob);
		downloadLink.href = url;
		downloadLink.download = host_name +'라이선스_사용량_'+today+".csv";
		
		document.body.appendChild(downloadLink);
		downloadLink.click();
		document.body.removeChild(downloadLink);
	} 
} */

function select_month_bar_graph(){
	var postData = {
      toDate : $("#toDate").val(),
      fromDate : $("#fromDate").val(),
   }; 
   
   $.ajax({
      type: "POST",
      url: "/target/selectLicenseDetail",
      async : false,
      data: postData,
      dataType: "json",
      success: function (resultMap) {
         console.log("라이선스 총용량");
         monthBarGraph(resultMap);
         if(resultMap.resultCode == -1){
            console.log("검색 실패");             
              return;
           }
       },
       error: function (request, status, error) {
           console.log("request : ", request);
           console.log("status : ", status);
           console.log("ERROR : ", error);
       }
   });
}
function monthBarGraph(resultMap){
	var month = [];
	/* var select_status = $("select[name='total_license_status']").val(); */
	var select_status = "TB";
	
	$.each(resultMap.data, function(key, val){
		
		var data_size = "";
		var data_diff_size = "";
		var name = "";
		
		if(select_status == "GB"){
			data_size = val.PRESENT_GB;
			data_diff_size = val.DIFF_GB;
		}else if(select_status == "TB"){
			data_size = val.PRESENT_TB;
			data_diff_size = val.DIFF_TB;
		}else if(select_status == "byte"){
			data_size = val.PRESENT_BYTE;
			data_diff_size = val.DIFF_BYTE;
		}
		name = val.REGDATE;
		
		var data = {
			"NAME" : name,
			"DATA_USAGE" : data_size,
			"DATA_DIFF_USAGE" : data_diff_size
		};
		
		month.push(data);
	});
	
	total_bar_graph(month);
}

function executeReportDownload(){ 
	   var today = new Date();
	   var dd = today.getDate();
	   var mm = today.getMonth()+1;
	   var yyyy = today.getFullYear();
	   if(dd<10) {
	       dd='0'+dd
	   } 

	   if(mm<10) {
	       mm='0'+mm
	   } 

	   today = yyyy + "" + mm + dd;
	   
	   workBook = XLSX.utils.book_new();
	   
	    XLSX.utils.book_append_sheet(workBook , XLSX.utils.table_to_sheet(document.getElementById('groupLicense0'), {raw:true}), "그룹 라이선스 사용량"); 
	    XLSX.utils.book_append_sheet(workBook , XLSX.utils.table_to_sheet(document.getElementById('groupLicense1'), {raw:true}), "PIC그룹 라이선스 사용량"); 
	    XLSX.utils.book_append_sheet(workBook , XLSX.utils.table_to_sheet(document.getElementById('serverLicense2'), {raw:true}), "서버 라이선스 사용량"); 
	    XLSX.utils.book_append_sheet(workBook , XLSX.utils.table_to_sheet(document.getElementById('serverLicense3'), {raw:true}), "PIC서버 라이선스 사용량"); 
	    XLSX.writeFile(workBook,  '라이선스_사용량관리_' + today + '.xlsx', { bookType: 'xlsx', type: 'binary' }); 
	}

$("#total_license_status").on("change", function(){
	select_month_bar_graph();
});
</script>
</body>
</html>