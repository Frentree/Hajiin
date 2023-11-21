<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>


		<!-- section -->
		<section>
			<!-- container -->
			<div class="container">
			<h3>스캔 신규 등록</h3>
			<%-- <%@ include file="../../include/menu.jsp"%> --%>

				<!-- content -->
				<div class="content magin_t25">
					<div class="location_area">
						<p class="location">스캔관리 > 스캔 스케줄 등록</p>
					</div>
					<h3 style="position: relative; padding: 0;"> 대상 리스트</h3>
					<div class="left_box" style="height:36vw; width:50%; float: left;">
						<div class="left_list">
						   <div id="div_all" class="select_location" style="overflow-y: auto; overflow-x: auto; height: 100%;background: #ffffff; white-space:nowrap;">
								<table class="tbl_input" id="location_table">
									<tbody>
											<!-- <script type="text/javascript">
											console.log($('tr[data-level=1]').length)
											$('tr[data-level=1]').each(function(i, val){
												var id = $(val).children('th').children('p').attr('id')
												$('tr[data-mother='+id+']').each(function(bel_i, bel_val){
													var targetcnt = $(bel_val).data('targetcnt')
													
													if(targetcnt > 0){
														var mother = $(bel_val).data('mother')
														$('p#'+id).parent('th').parent('tr').show()
														return false;
													}
												})
											});
										</script> -->
										<tr data-uptidx="0" data-level="1" data-mother="pc" data-targetcnt="0" data-id="pc">
											<th style="padding-top: 10px;"><p id="server" class="sta_tit" style="cursor:pointer; margin-left:10px;">서버</p></th>
										</tr>
										<c:set var="motherIdx" value =""></c:set>
										
										<c:forEach items="${groupList}" var="item" varStatus="status">
											<%-- <c:if test="${item.LEVEL == 1}">
												<c:set var="motherIdx" value ="${item.IDX}"></c:set>
												<tr data-uptidx="${item.UP_IDX}" data-level="${item.LEVEL}" data-mother="${motherIdx}">
											</c:if>
											<c:if test="${item.LEVEL != 1}">
											</c:if> --%>
											<tr style="display:none;" data-uptidx="${item.UP_IDX}" data-level="${item.LEVEL}" data-mother="${motherIdx}" data-targetcnt="${item.CNT}" data-id="pc">
												<th><p id="${item.IDX}" class="sta_tit" style="cursor:pointer; margin-left:${item.LEVEL*10}px; width:auto; float:left; " >${item.NAME}</p></th>
											</tr>
										</c:forEach>
										
										<c:if test="${noGroupSize > 0}">
											<tr style="display:none;" data-uptidx="server" data-level="2" data-mother="" data-targetcnt="">
												<th style="padding-top: 10px;"><p id="noGroup" class="sta_tit" style="cursor:pointer; margin-left:20px; " >그룹없음</p></th>
											</tr>
										</c:if>
										
										
										<tr data-uptidx="0" data-level="1" data-mother="pc" data-targetcnt="0">
											<th style="padding-top: 10px;"><p id="pc" class="sta_tit" style="cursor:pointer; margin-left:10px;">PC</p></th>
										</tr>
										<c:set var="motherIdx" value =""></c:set>
										<c:forEach items="${userGroupList}" var="item" varStatus="status">
											<tr style="display:none;" data-uptidx="${item.UP_IDX}" data-level="${item.LEVEL}" data-mother="${motherIdx}" data-targetcnt="${item.CNT}">
												<th><p id="${item.IDX}" class="sta_tit" style="cursor:pointer; margin-left:${item.LEVEL*10}px; width:auto; float:left; " >${item.NAME}</p></th>
											</tr>
										</c:forEach>
										<script type="text/javascript">
											console.log($('tr[data-level=1]').length)
											$('tr[data-level=1]').each(function(i, val){
												var id = $(val).children('th').children('p').attr('id')
												$('tr[data-mother='+id+']').each(function(bel_i, bel_val){
													var targetcnt = $(bel_val).data('targetcnt')
													
													if(targetcnt > 0){
														var mother = $(bel_val).data('mother')
														$('p#'+id).parent('th').parent('tr').show()
														return false;
													}
												})
											});
										</script>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="grid_top" style="height: 100%; width: 50%; top:-40px; float: right; padding-left:20px;">
						<h3 style="padding: 0;">정책 리스트</h3>
						<div class="left_box2" style="height: 238px; overflow: hidden;">
		   					<table id="topNGrid"></table>
		   				 	<div id="topNGridPager"></div>
		   				</div>
					</div>
					<div class="grid_top" style="width: 50%; height: 250px; top: -40px; float: right; padding-left:20px;"> 
						<h3 style="padding: 0;">정책 상세 정보</h3>
						<table class="user_info" style="width: 100%; height: 90%;">
							<caption>정책 상세 정보</caption>
							<colgroup>
								<col width="25%">
								<col width="*">
							</colgroup>
							<tbody>
								<tr>
									<th class="borderB">정책 상세 정보</th>
									<td>-</td>
								</tr>
								<tr>
									<th class="borderB">정책명</th>
									<td>-</td>
								</tr>
								<tr>
									<th class="borderB">개인정보 유형 명</th>
									<td>-</td>
								</tr>
								<tr>
									<th class="borderB">정채 시작 시간</th>
									<td>-</td>
								</tr>
								<tr>
									<th class="borderB">개인정보 유형</th>
									<td>-</td>
								</tr>
								<tr>
									<th class="borderB">활성화</th>
									<td>-</td>
								</tr>
								<tr>
									<th class="borderB">적용 범위</th>
									<td>-</td>
								</tr>
								<tr>
									<th class="borderB">주기</th>
									<td>-</td>
								</tr>
								<tr>
									<th class="borderB">일시정지 시간</th>
									<td>-</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: right; padding: 8px 8px;">
										<button class="btn_down" type="button" id="btnSave" name="btnSave">신규</button> 
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="grid_top" style="width: 50%; top: 130px; float: right; padding-left:20px;">
						<button class="btn_down" type="button" id="btnSave" name="btnSave" style="width: 100%;">실행</button>
					</div>
				</div>
					
			</div>

			<!-- container -->
		</section>
		<!-- section -->
		
<%@ include file="../../include/footer.jsp"%>

<script type="text/javascript">


$(document).ready(function () {
	fn_drawTopNGrid();
});

function fn_drawTopNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	$("#topNGrid").jqGrid({
		url: "<%=request.getContextPath()%>/target/selectAdminServerFileTopN",
		datatype: "local",
	   	mtype : "POST",
		colNames:['경로','소유자','검출 수'],
		colModel: [
			{ index: 'PATH', 	name: 'PATH', 	editable: true, width: 200 },
			//{ index: 'OWNER', 	name: 'OWNER', 	width: 100, align: "center" },
			{ index: 'OWNER', 	name: 'OWNER', 	width: 200, align: "center", hidden:true },
			{ index: 'CNT', 	name: 'CNT', 	width: 200, align: "right" },
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 155,
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
	    			/* alert('검색 결과가 없습니다.') */
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

function setServerCnt(){
	$.ajax({
		type: "POST",
		url: "/popup/getTargetList",
		async : false,
		dataType: "text",
	    success: function (resultMap) {
	    	var data = JSON.parse(resultMap);
	    	if(data.resultCode == '0'){
	    		var resultList = data.resultData
	    		if(resultList.length > 0){
	    			var discon_cnt = 0
	    			$('#hostCnt').text(resultList.length+' 대')
	    			
	    		} else {
	    			$("#div_all").show()
	    			$("#div_search").hide()
	    			/* alert('검색 결과가 없습니다.') */
	    		}
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.")
	        console.log("ERROR : ", error)
	    }
	});
}

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
			    	console.log(resultMap)
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
	} else {											// 안 보여지고 있을 때
		if($('tr[data-id="pc"]')){
			$.ajax({
				type: "POST",
				url: "/popup/getUserTargetList",
				async : false,
				data : {
					groupID: id,
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
		} else {
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
		}
		$('tr[data-uptidx="'+id+'"][data-flag!="path"]').show();
	}
});

function setLocationList(locList, level, id, mother, code){
	var html = "";
	var target_id = "";
	var target_name = "";
	locList.forEach(function(item, index) {
		if(code == "all"){
			html += "	<tr data-uptidx=\""+id+"\" data-flag=\"target\" data-mother=\""+mother+"\"\">"
			html += 	"<td style=\"padding-bottom: 0px; cursor: pointer;\">"
			html += 		"<p style=\"padding-bottom: 0px; margin-left:"+(((level-1)*10))+"px;\""
			html +=			 "data-targetid=\""+item.TARGET_ID+"\" data-name=\""+item.AGENT_NAME+"\" data-connected=\""+item.AGENT_CONNECTED+"\" data-version=\""+item.AGENT_VERSION+"\" data-platform=\""+item.AGENT_PLATFORM+"\""
			html +=			 "data-apc=\""+item.AGENT_PLATFORM_COMPATIBILITY+"\" data-verified=\""+item.AGENT_VERIFIED+"\" data-user=\""+item.AGENT_USER+"\" data-cpu=\""+item.AGENT_CPU+"\" data-cores=\""+item.AGENT_CORES+"\""
			html +=			 "data-boot=\""+item.BOOT+"\" data-ram=\""+item.AGENT_RAM+"\" data-ip=\""+item.AGENT_CONNECTED_IP+"\" data-searchdt=\""+item.SEARCH_DATETIME+"\" data-apno=\""+item.AP_NO+"\""
			html +=			">"
			if(item.AGENT_CONNECTED == '1'){
				html +=		"<img src=\"/resources/assets/images/icon_con.png\" value=\"1\" />"
			} else {
				html +=		"<img src=\"/resources/assets/images/icon_dicon.png\" value=\"0\" />"
			}
			if(item.AGENT_CONNECTED_IP != null){
				html +=		item.AGENT_NAME +" ("+item.AGENT_CONNECTED_IP+")" 
			}else{
				html +=		item.AGENT_NAME 
			} 
			html += 		"</p>"
			html +=		"</td>"
			html += "	</tr>"
		} else if (code == "search"){
			html += "	<tr data-flag=\"target\"\">"
			html += 	"<td style=\"padding-bottom: 0px;\">"
			html += 		"<p style=\"padding-bottom: 0px; margin-left:"+(((level-1)*10))+"px;\""
			html +=			 "data-targetid=\""+item.TARGET_ID+"\" data-name=\""+item.AGENT_NAME+"\" data-connected=\""+item.AGENT_CONNECTED+"\" data-version=\""+item.AGENT_VERSION+"\" data-platform=\""+item.AGENT_PLATFORM+"\""
			html +=			 "data-apc=\""+item.AGENT_PLATFORM_COMPATIBILITY+"\" data-verified=\""+item.AGENT_VERIFIED+"\" data-user=\""+item.AGENT_USER+"\" data-cpu=\""+item.AGENT_CPU+"\" data-cores=\""+item.AGENT_CORES+"\""
			html +=			 "data-boot=\""+item.BOOT+"\" data-ram=\""+item.AGENT_RAM+"\" data-ip=\""+item.AGENT_CONNECTED_IP+"\" data-searchdt=\""+item.SEARCH_DATETIME+"\" data-apno=\""+item.AP_NO+"\""
			html +=			">"
			if(item.AGENT_CONNECTED == '1'){
				html +=		"<img src=\"/resources/assets/images/icon_con.png\" value=\"1\" />"
			} else {
				html +=		"<img src=\"/resources/assets/images/icon_dicon.png\" value=\"0\" />"
			}
			if(item.AGENT_CONNECTED_IP != null){
				html +=		item.AGENT_NAME +" ("+item.AGENT_CONNECTED_IP+")" 
			}else{
				html +=		item.AGENT_NAME 
			} 
			html += 		"</p>"
			html +=		"</td>"
			html += "	</tr>"
		}
	})
	return html;
}


</script>
	<!-- wrap -->
</body>
</html>
