<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>

 
		<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>타겟 관리</h3>
					<p class="location">타겟 관리 > 타겟 담당자 관리</p>
				</div>
			</div>
		</div>
		<!-- 업무타이틀(location)-->

		<!-- section -->
		<section>
			<!-- container -->
			<div class="container" >
			<h3>서버 리스트</h3>
			<%-- <%@ include file="../../include/menu.jsp"%> --%>
				<!-- content -->
				<div class="content magin_t25">
					<div class="location_area">
						<p class="location">타겟관리 > 타겟담당자 관리</p>
					</div>
					<div class="left_area2">
						<div class="left_box2" id="grid_h1">
							<div class="search_area bold">
								<input type="text" id="txt_host" value="" style="width: 320px" placeholder="호스트 이름을 입력하세요." onKeypress="javascript:if(event.keyCode==13) fnSearchHost()">
								<button type="button" id="btn_search" style="right: -15px;">검색</button>
							</div>
		   					<div id="div_all" class="select_location" style="overflow-y: auto; overflow-x: auto; background: #ffffff; white-space:nowrap;">
								<table class="tbl_input" id="location_table">
									<tbody>
										<c:set var="motherIdx" value =""></c:set>
										<c:forEach items="${groupList}" var="item" varStatus="status">
											<c:if test="${item.LEVEL == 1}">
												<c:set var="motherIdx" value ="${item.IDX}"></c:set>
											</c:if>
											<tr style="display:none" data-uptidx="${item.UP_IDX}" data-level="${item.LEVEL}" data-mother="${motherIdx}" data-targetcnt="${item.CNT }">
												<th style="padding-top: 10px;"><p id="${item.IDX}" class="sta_tit" style="cursor:pointer; margin-left:${item.LEVEL*10}px; " >${item.NAME}</p></th>
											</tr>
										</c:forEach>
										<script type="text/javascript">
											console.log($('tr[data-level=1]').length)
											$('tr[data-level=1]').each(function(i, val){
												//console.log(val)
												var id = $(val).children('th').children('p').attr('id')
												//console.log('id :: ' + id)
												//console.log($('tr[data-mother='+id+']').length)
												$('tr[data-mother='+id+']').each(function(bel_i, bel_val){
													var targetcnt = $(bel_val).data('targetcnt')
													//console.log('targetcnt :: ' + targetcnt)
													
													if(targetcnt > 0){
														var mother = $(bel_val).data('mother')
														//console.log('mother :: ' + mother)
														$('p#'+id).parent('th').parent('tr').show()
														return false;
													}
												})
											});
										</script>
										<c:if test="${noGroupSize > 0}">
											<tr>
												<th style="padding-top: 10px;"><p id="noGroup" class="sta_tit" style="cursor:pointer; margin-left:10px; " >그룹없음</p></th>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
							<div id="div_search" class="select_location" style="overflow-y: auto; height: 460px;background: #ffffff; display: none;">
								<table id="Tbl_search" class="tbl_input" id="location_table">
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<div class="grid_top" style="margin-left: 350px;">
						<table style="width: 100%;">
							<tr>
								<td><h3 style="padding: 0;">서버 담당자</h3></td>
								<td style="text-align: right; padding: 0px; width: 29vw;">
									<button type="button" class="btn_down" id="btnUpload" style="margin: 0px; padding: 0 30px;">업로드</button>
									<button type="button" class="btn_down" id="btnDownloadExel" style="margin: 0px; padding: 0 30px;">다운로드</button> 
									<button type="button" class="btn_down" id="btnRegistTargetUser" style="margin: 0px; padding: 0 30px;"> 담당자등록 </button>
									<input class=""  type="file" name="uploadFile" id="uploadFile" onchange="uploadSave();" style="display:none;">
								</td>
							</tr>
						</table> 
						<div class="left_box2" id="grid_h2" style="overflow: hidden; min-height: 690px">
		   					<table id="userGrid"></table>
		   					<div id="userGridPager"></div>
		   				</div>
	   				</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->

	<%@ include file="../../include/footer.jsp"%>
	
	
<script type="text/javascript">

var oGrid = $("#userGrid");

function createRadio(cellvalue, options, rowObject) {
	var value = options['rowId'];
    var str = '<input type="radio" name="gridRadio" value="' + value + '">';
    return str;
}

function createCheckbox(cellvalue, options, rowObject) {
	var rowID = options['rowId'];
	var checkboxID = "gridChk" + rowID;
	
	if (rowObject['CHK'] == "1")
		return "<input type='checkbox' id='" + checkboxID + "' value='" + rowID + "' onchange='onGridChkboxChange( event )' checked>"; 
	else 
		return "<input type='checkbox' id='" + checkboxID + "' value='" + rowID + "' onchange='onGridChkboxChange( event )'>";
}

function onGridChkboxChange(e) {
	var e = e || window.event;
	var target = e.target || e.srcElement;

	if (target.checked) {
		$("#userGrid").jqGrid('setCell', target.value, 'CHK', "1");
		$("#userGrid").jqGrid('setCell', target.value, 'CHKBOX', "1");
	}
	else { 
		$("#userGrid").jqGrid('setCell', target.value, 'CHK', "0");
		$("#userGrid").jqGrid('setCell', target.value, 'CHKBOX', "0");
	}
}

$(document).ready(function () {

	var gridWidth = $("#targetGrid").parent().width();
	var gridHeight = 592; //$("#targetGrid").parent().height();
	$("#targetGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['','호스트 이름','아이피','TARGET_ID'],
		colModel: [      
			{ index:'CHK', 			name: 'CHK', 		width:30, 	align: 'center',	editable:true, 	edittype:'radio', 	formatter:createRadio},
			{ index: 'AGENT_NAME', 	name: 'AGENT_NAME', width: 150},
			{ index: 'AGENT_CONNECTED_IP', 	name: 'AGENT_CONNECTED_IP', width: 100, align: 'center' },
			{ index: 'TARGET_ID', 	name: 'TARGET_ID', 	width: 500, hidden : true }
		],
		loadonce: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight,
	   	autowidth: false,
		shrinkToFit: false,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 75, // 행번호 열의 너비	
		rowNum:25,
	   	rowList:[25,50,100],			
		pager: "#targetGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {
			$(".clearsearchclass").click();
			$('input:radio[name=gridRadio]:input[value=' + rowid + ']').prop("checked", true);
			
	  		var postData = {target : $(this).jqGrid('getCell', rowid, 'TARGET_ID')};
			$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectTargetUser", postData : postData, datatype:"json" }).trigger("reloadGrid");
	  	},
		loadComplete: function(data) {
			$("input[name=gridRadio]").change(function() {
				$("#targetGrid").setSelection($(this).val());
			});
			$(this).setSelection(1);
	    },
	    gridComplete : function() {
	    }
	});

	var gridWidth = $("#userGrid").parent().width();
	$("#userGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['','사용여부','담당자','직위','사원번호','팀명','CHK','CHKOLD'],
		colModel: [
			{ index: 'CHKBOX', 		name: 'CHKBOX',		width: 120,  align: 'center', editable: true, edittype: 'checkbox', 
				editoptions: { value: '1:0' }, formatoptions: { disabled: false }, formatter: createCheckbox, stype: 'select',
				searchoptions: { sopt: ['eq'], value: ':전체;1:선택;0:미선택' }, exportcol:false
			},
			{ index: 'CHK_EXCEL', 	name: 'CHK_EXCEL', 	width: 200, hidden : true, exportcol:true },
			{ index: 'USER_NAME', 	name: 'USER_NAME', 	width: 200, editable: true },
			{ index: 'JIKGUK', 		name: 'JIKGUK', 	width: 200 },
			{ index: 'USER_NO', 	name: 'USER_NO', 	width: 200 },
			{ index: 'TEAM_NAME', 	name: 'TEAM_NAME', 	width: 200 },
			{ index: 'CHK', 		name: 'CHK', 		width: 200, hidden : true, exportcol:false },
			{ index: 'CHKOLD', 		name: 'CHKOLD', 	width: 200, hidden : true, exportcol:false }
		],
		id: "USER_NO",
		loadonce:true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 590,
		loadonce: true, // this is just for the demo
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 75, // 행번호 열의 너비	
		rowNum:25,
	   	rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#userGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  	},
	  	afterEditCell: function(rowid, cellname, value, iRow, iCol){
            //I use cellname, but possibly you need to apply it for each checkbox       
			if (cellname == 'CHKBOX'){
			    $("#userGrid").saveCell(iRow,iCol);
			}   
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
	}).filterToolbar({
		  autosearch: true,
		  stringResult: true,
		  searchOnEnter: true,
		  defaultSearch: "cn"
	});

	$("#targetGridPager_left").css("width", "10px");
	$("#targetGridPager_right").css("display", "none");
	// 버튼 Action 설정
	$("#btnRegistTargetUser").click(function() {

		// 선택된 사용자 저장
		var idx = 0;		
		var userList = [];
		var userData = $("#userGrid").jqGrid('getGridParam', 'data');

		for (var i = 0; i < userData.length; i++) {
			var chk = userData[i].CHK;
			var chkold = userData[i].CHKOLD;
			// 담당자로 선택되거나 해제 확인
			if (chk != chkold) {
				var userAssign = {};
				console.log(userData[i])
				userAssign.userNo 		= userData[i].USER_NO;
				userAssign.chk 			= userData[i].CHK;
				userAssign.userName		= userData[i].USER_NAME;
				userList[idx++] = userAssign;	
			}
		}

		if (isNull(userList)) {
			alert("변경된 정보가 없습니다.");
			return;
		}
		// 선택된 TargetID 저장
		/* var rowid = $("#targetGrid").getGridParam("selrow");
		var target = $("#targetGrid").jqGrid('getCell', rowid, 'TARGET_ID');
		var targetName = $("#targetGrid").jqGrid('getCell', rowid, 'AGENT_NAME'); */
		
		var target = $('input[name=checkTarget]:checked').val();
		var targetName = $('input[name=checkTarget]:checked').data('name');
		var ap_no = $('input[name=checkTarget]:checked').data('apno');
		
		var postData = {
				target : target,
				ap_no : ap_no,
				userList : JSON.stringify(userList)
		};

		var message = "Server-" + targetName + "의 담당자를 지정하시겠습니까?";
		if (confirm(message)) {
			$.ajax({
				type: "POST",
				url: "/target/registTargetUser",
				async : false,
				data : postData,
			    success: function (resultMap) {
			        if (resultMap.resultCode != 0) {
				        alert("FAIL : " + resultMap.resultMessage);
			        	console.log(resultMap);
			        	return;
				    }
				    // chk와 chkold 바까 줌.				    
					var userData = $("#userGrid").jqGrid('getGridParam', 'data');
			
					for (var i = 0; i < userData.length; i++) {
						$("#userGrid").jqGrid('setCell', userData[i]._id_, 'CHKOLD', userData[i].CHK);
					}
					
			        alert(targetName + "의 담당자가 지정되었습니다.");
			    },
			    error: function (request, status, error) {
					alert("Server Error : " + error);
			        console.log("ERROR : ", error);
			    }
			});
		}
    });

	$('#btn_search').click(function() {
		<%-- var postData = {host : $("#txt_host").val()};
		$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/target/pi_target_list", postData : postData, datatype:"json" }).trigger("reloadGrid"); --%>
		fnSearchHost();
	});

	$('#btn_search').click();
	
	$("#btnDownloadExel").click(function(){
		downLoadExcel();
	});

    $("#btnUpload").click(function() {
    	event.preventDefault();
    	$('#uploadFile').click();
    });
});

var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!
var yyyy = today.getFullYear();

if(dd<10) {
    dd='0'+dd
} 

if(mm<10) {
    mm='0'+mm
} 

today = yyyy + "" + mm + dd;

// 그리드 상에 체크박스 체크된거 어떻게 다운로드 받을지 결정해야함 
// 설계서상에는 서버리스트도 나오게 해달라고 요구함
// 서버이름, 담당자,직위, 사원번호, 부서명 등

function downLoadExcel()
{
    oGrid.jqGrid("exportToCsv",{
        separator: ",",
        separatorReplace : "", // in order to interpret numbers
        quote : '"', 
        escquote : '"', 
        newLine : "\r\n", // navigator.userAgent.match(/Windows/) ? '\r\n' : '\n';
        replaceNewLine : " ",
        includeCaption : true,
        includeLabels : true,
        includeGroupHeader : true,
        includeFooter: true,
        fileName : "서버_담당자_리스트_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    })
}

var uploadSave = function() { 
	// IE는 input file에 빈컨 넣어도 탄다.
	if ($('input[type=file]').val() == "") {
		return;
	}
	
	var rowid = $("#targetGrid").getGridParam("selrow");
	var target = $("#targetGrid").jqGrid('getCell', rowid, 'TARGET_ID');
	
	// 확장자 확인 추가
	var fileName = $("input[name=uploadFile]")[0].files[0].name;
	var fileExt = fileName.substring(fileName.lastIndexOf(".")+1);
	if(fileExt != "xls" && fileExt != "xlsx" && fileExt != "csv" && fileExt != "txt") {
		alert("업로드 할 수 없는 파일입니다\n(csv 파일만 업로드 할 수 있습니다)");
		return false;
	}
	
	var formData = new FormData();
	formData.append('file', $("input[name=uploadFile]")[0].files[0]);
	formData.append('target_id', target);

	$("#btnUpload").prop("disabled", true);
	$("#jqgrid").jqGrid("clearGridData", true);
	
	$.ajax({
	    type: "POST",
	    enctype: 'multipart/form-data',
	    url: "<%=request.getContextPath()%>/target/targetManagerUpload",
	    data: formData,
	    processData: false,
	    contentType: false,
	    cache: false,
	    timeout: 600000,
	    success: function (message) {	
	        $("#btnUpload").prop("disabled", false);
	        console.log(message);
			if (message.resultCode != 0) {
				alert(message.resultMessage);
			} else {
				alert("업로드가 완료되었습니다");
				var postData = {target : target};
				$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectTargetUser", postData : postData, datatype:"json" }).trigger("reloadGrid");
			}
	    },
	    error: function (e) {
	    	alert("업로드 에러 입니다.</br>관리자에게 문의 하세요");
	        console.log("ERROR : ", e);
	        $("#btnUpload").prop("disabled", false);
	    }
	});
	$('input[type=file]').val("");
}

var aut = "manager"
//그루핑 관련 추가 
$(".sta_tit").on("click", function() {
	var id = $(this).attr('id');
	var tr = $(this).closest('tr');
	var level = tr.data('level');
	var mother = tr.data('mother');
	
	if(id == 'noGroup'){
		if($('tr[data-uptidx="'+id+'"]').is(':visible')){
			$('tr[data-uptidx="'+id+'"]').remove();
		}else{
			$.ajax({
				type: "POST",
				url: "/popup/getTargetList",
				async : false,
				data : {
					noGroup: id,
					aut: aut
				},
				dataType: "text",
			    success: function (resultMap) {
			    	//console.log(resultMap)
			    	var data = JSON.parse(resultMap);
			    	if(data.resultCode == '0'){
			    		var resultList = data.resultData
			    		if(resultList.length > 0){
			    			var html = setLocationList(resultList, 1, id, mother, 'all');
			    			tr.after(html)
			    		}
			    	}
			    },
			    error: function (request, status, error) {
			    	alert("Recon Server에 접속할 수 없습니다.");
			        console.log("ERROR : ", error);
			    }
			});
			return;
		}
		//tr.clear();
	}
	
	if($('tr[data-uptidx="'+id+'"]').is(':visible')){	// 보여지고 있을 때
		var up_id = [id]
		var up_idx = up_id.length
		var flag = true
		while(flag){
			var below_id = []
			up_id.forEach(function(idx){
				console.log(idx)
				$('tr[data-uptidx="'+idx+'"]').each(function(bi, value){
					$('tr[data-uptidx="'+idx+'"][data-flag="target"]').remove();
					$('tr[data-uptidx="'+idx+'"][data-flag="path"]').remove(); 
					$(value).hide();
					var bel_id = $(value).children('th').children('p').attr('id')
					below_id.push(bel_id)
				});
			})
			if(below_id.length < 1){
				flag = false;
			} else {
				up_id = below_id
			}
			
		}
		/* if(level == 1){
			$('tr[data-mother="'+id+'"][data-flag="target"]').remove();
			$('tr[data-mother="'+id+'"][data-flag="path"]').remove();
			$('tr[data-mother="'+id+'"]').hide();
		} else {
			var up_id = [id]
			var up_idx = up_id.length
			var flag = true
			while(flag){
				var below_id = []
				up_id.forEach(function(idx){
					console.log(idx)
					$('tr[data-uptidx="'+idx+'"]').each(function(bi, value){
						$('tr[data-uptidx="'+idx+'"][data-flag="target"]').remove();
						$('tr[data-uptidx="'+idx+'"][data-flag="path"]').remove(); 
						$(value).hide();
						var bel_id = $(value).children('th').children('p').attr('id')
						below_id.push(bel_id)
					});
				})
				if(below_id.length < 1){
					flag = false;
				} else {
					up_id = below_id
				}
				
			}
		} */
		
	} else {											// 안 보여지고 있을 때
		$.ajax({
			type: "POST",
			url: "/popup/getTargetList",
			async : false,
			data : {
				group_id: id,
				aut: aut
			},
			dataType: "text",
		    success: function (resultMap) {
		    	var data = JSON.parse(resultMap);
		    	if(data.resultCode == '0'){
		    		var resultList = data.resultData
		    		if(resultList.length > 0){
		    			var html = setLocationList(resultList, level, id, mother, 'all');
		    			if($('tr[data-uptidx="'+id+'"]').length > 0){
		    				var str_tr = $('tr[data-uptidx="'+id+'"]')[($('tr[data-uptidx="'+id+'"]').length-1)]
		    				var str_id = $(str_tr).children('th').children('p').attr('id')
		    				
		    				var up_id = [str_id]
		    				var flag = true
		    				while(flag){
		    					var below_id = []
		    					up_id.forEach(function(idx){
		    						$('tr[data-uptidx="'+idx+'"]').each(function(bi, value){
		    							var bel_id = $(value).children('th').children('p').attr('id')
		    							below_id.push(bel_id)
		    						});
		    					})
		    					if(below_id.length < 1){
		    						flag = false;
		    						$('p#'+up_id[(up_id.length-1)]).parent().parent().after(html)
		    					} else {
		    						up_id = below_id
		    					}
		    				}
		    			} else {
		    				tr.after(html)
		    			}
		    		}
		    	}
		    },
		    error: function (request, status, error) {
		    	alert("Recon Server에 접속할 수 없습니다.");
		        console.log("ERROR : ", error);
		    }
		});
		$('tr[data-uptidx="'+id+'"][data-flag!="path"]').show();
	}
	
});

$(document).on('click', function(event){
	var target = event.target;
	var tr = target.parentElement.parentElement;
	var data_flag = tr.getAttribute('data-flag')
	if(data_flag == 'target'){
		var target_id = $(target).attr('id')
		var ap_no = $(target).data('apno')
		$(".clearsearchclass").click();
		//$('input:radio[name=gridRadio]:input[value=' +  + ']').prop("checked", true);
		//$('input[name=checkTarget]:input[value=' + target_id + ']').prop("checked", true);
		
		$("input[name=checkTarget][value!="+target_id+"]").each(function(index, val){
			console.log(val)
			$(val).prop("checked", false)
		});
		$("input[name=checkTarget][value="+target_id+"]").prop("checked", true)
		
  		var postData = {
			target : target_id,
			ap_no : ap_no
		};
		$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectTargetUser", postData : postData, datatype:"json" }).trigger("reloadGrid");
	}
});

function setLocationList(locList, level, id, mother, code){
	var html = "";
	var target_id = "";
	var target_name = "";
	locList.forEach(function(item, index) {
		console.log(item)
		if(code == "all"){
			html += "	<tr data-uptidx=\""+id+"\" data-flag=\"target\" data-mother=\""+mother+"\" ondblclick=\"setTargetId(event)\">"
			html += 	"<td style=\"padding-bottom: 0px;\">"
			if(item.AGENT_CONNECTED_IP != null){
				html +=		"<input type=\"checkbox\" name=\"checkTarget\" id=\""+item.TARGET_ID+"\" value=\""+item.TARGET_ID+"\" class=\"sta_tit4\" style=\"margin-left:"+(((level-1)*10))+"px; margin-right: 20px; \" data-name=\""+item.AGENT_NAME+"\" data-apno=\""+item.AP_NO+"\">" + item.AGENT_NAME +" ("+item.AGENT_CONNECTED_IP+")" 
			}else{
				html +=		"<input type=\"checkbox\" name=\"checkTarget\" id=\""+item.TARGET_ID+"\" value=\""+item.TARGET_ID+"\" class=\"sta_tit4\" style=\"margin-left:"+(((level-1)*10))+"px; margin-right: 20px; \" data-name=\""+item.AGENT_NAME+"\" data-apno=\""+item.AP_NO+"\">" + item.AGENT_NAME 
			}
			html +=		"</td>"
			html += "	</tr>"
		} else if (code == "search"){
			html += "	<tr data-flag=\"target\" ondblclick=\"setTargetId(event)\">"
			html += 	"<td style=\"padding-bottom: 0px;\">"
			if(item.AGENT_CONNECTED_IP != null){
				html +=		"<input type=\"checkbox\" name=\"checkTarget\" id=\""+item.TARGET_ID+"\" value=\""+item.TARGET_ID+"\" class=\"sta_tit4\" style=\"margin-left:"+(((level-1)*10))+"px; margin-right: 20px; \" data-name=\""+item.AGENT_NAME+"\" data-apno=\""+item.AP_NO+"\">" + item.AGENT_NAME +" ("+item.AGENT_CONNECTED_IP+")" 
			}else{
				html +=		"<input type=\"checkbox\" name=\"checkTarget\" id=\""+item.TARGET_ID+"\" value=\""+item.TARGET_ID+"\" class=\"sta_tit4\" style=\"margin-left:"+(((level-1)*10))+"px; margin-right: 20px; \" data-name=\""+item.AGENT_NAME+"\" data-apno=\""+item.AP_NO+"\">" + item.AGENT_NAME 
			}
			html +=		"</td>"
			html += "	</tr>"
		}
	})
	return html;
}

function getSearchData(host){
	$.ajax({
		type: "POST",
		url: "/popup/getTargetList",
		async : false,
		data : {
			host: host
		},
		dataType: "text",
	    success: function (resultMap) {
	    	var data = JSON.parse(resultMap);
	    	console.log('resultMap :: ' + resultMap)
	    	if(data.resultCode == '0'){
	    		console.log('data :: ' + data)
	    		var resultList = data.resultData
	    		if(resultList.length > 0){
	    			var html = setLocationList(resultList, '', '', '', "search");
	    			//console.llg
	    			$("#Tbl_search").html(html)
	    		} else {
	    			$("#div_all").show()
	    			$("#div_search").hide()
	    			alert('검색 결과가 없습니다.')
	    		}
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.")
	        console.log("ERROR : ", error)
	    }
	});
}

function fnSearchHost(e) {
	var searchHost = $("#txt_host").val();
	
	if (isNull(searchHost)) {
		$("#div_all").show();
		$("#div_search").hide();	
		return;
	}
	
	$("#div_all").hide();
	$("#div_search").show();
	getSearchData(searchHost);
	
}

/* $("input[name=checkTarget]").change(function(){
	var value = $(this).val();

	// 해제 할때 false
	if($(this).is(":checked")){
		$("input[name=checkTarget]:checked").each(function(index, val){
			$(val).prop("checked", false)
		});
		$("input[name=checkTarget][value="+value+"]:checkbox").prop("checked", true)
	} else {
		$("input[name=checkTarget][value="+value+"]:checkbox").prop("checked", false)
	}
}); */
</script>
	
</body>
</html>

