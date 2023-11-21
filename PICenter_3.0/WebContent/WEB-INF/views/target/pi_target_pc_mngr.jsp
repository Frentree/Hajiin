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
</style>
		<section>
			<!-- container -->
				<div class="container">
					<%-- <%@ include file="../../include/menu.jsp"%> --%>
					<h3>PC 관리</h3>
					<p class="container_comment" style="position: absolute; top: 32px; left: 137px; font-size: 13px; color: #9E9E9E;">에이전트 관리 화면입니다.</p>
					<!-- content -->
					<div class="content magin_t25">
						<table class="user_info" style="display: inline-table; width: 590px;">
							<tbody>
								<tr>
						            <th style="text-align: center; width: 50px; border-radius: 0.25rem;">버전</th>
									<td>
										<select id="ver_type" name="ver_type" style="width:186px; font-size: 12px; padding-left: 5px;">
		                                	<option value="X" selected>전체</option>
		                                	
										</select>
						            </td>
									<th style="text-align: center; width: 50px; border-radius: 0.25rem;">이름</th>
									<td>
										<p style="width: 230px; margin-bottom: 5px;"><input type="text" id="searchID" style="font-size: 13px; line-height: 2; padding-left: 5px; width: 200px;" placeholder="ID를 입력하세요."/></p>
										<input type="button" name="button" class="btn_look" id="btnSearch" style="margin-top: -27px; margin-right: 5px;">
						            </td>
						        </tr>
						    </tbody>
						</table>
						<div class="grid_top" style="height: 100%; width: 100%; padding-top:10px;">
							<div class="left_box2" style="height: 94%; max-height: 700px; overflow: hidden;">
			   					<table id="topNGrid"></table>
			   				 	<div id="topNGridPager"></div>
			   				</div>
						</div>
						
					</div>
				</div>
			<!-- container -->
		</section>
		<!-- section -->

<%@ include file="../../include/footer.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	fn_drawTopNGrid();
	
	var postData = {}
	
	$.ajax({
			type: "POST",
			url: "/target/selectVersionList",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	console.log(resultMap);
		    	
		    	var com = "";
		    	
		    	for(i=0;i<resultMap.length;i++){
		    		com += "<option value='"+resultMap[i].AGENT_VERSION+"' >"+resultMap[i].AGENT_VERSION+"</option>";
		    	}
		    	$("#ver_type").append(com);
		    },
		    error: function (request, status, error) {
				alert("ERROR : " + error);
		    }
		}); 
	
	
	$(document).click(function(e){
		
	});
});

function fn_drawTopNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	
	$("#topNGrid").jqGrid({
		url: "<%=request.getContextPath()%>/target/selectPcManagerList",
		datatype: "json",
		//data: temp,
	   	mtype : "POST",
		colNames:['에이전트 이름','연결 여부','버전', '연결된 IP','에이전트 설치 일','AGENT_CONNECTED_START_DT', 'AGENT_CONNECTED_END_DT', 'AGENT_ID'],
		colModel: [
			{ index: 'AGENT_NAME', 					name: 'AGENT_NAME', 				width: 80, align: "left"},
			{ index: 'AGENT_USE', 					name: 'AGENT_USE', 					width: 80, align: "center"},
			{ index: 'AGENT_VERSION', 				name: 'AGENT_VERSION', 				width: 80, align: "center"},
			{ index: 'AGENT_CONNECTED_IP', 			name: 'AGENT_CONNECTED_IP', 		width: 80, align: "center", formatter: nullCheck},
			{ index: 'AGENT_STARTED', 				name: 'AGENT_STARTED', 				width: 80, align: "center", formatter: nullCheck},
			{ index: 'AGENT_CONNECTED_START_DT', 	name: 'AGENT_CONNECTED_START_DT', 	width: 80, align: "center",  hidden:true},
			{ index: 'AGENT_CONNECTED_END_DT', 		name: 'AGENT_CONNECTED_END_DT', 	width: 80, align: "center",  hidden:true},
			{ index: 'AGENT_ID', 					name: 'AGENT_ID', 					width: 80, align: "center",  hidden:true},
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 583,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:20,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#topNGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  	},
	  	onCellSelect : function(rowid){
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data) {
	    },
	    gridComplete : function() {
	    }
	});
}

function nullCheck(cellvalue, options, rowObject) {
	
	if(cellvalue == "" || cellvalue == null){
		return '-';
	}else{
		return cellvalue;
	}
}


</script>
</body>
</html>