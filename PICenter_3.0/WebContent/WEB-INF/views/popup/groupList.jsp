<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>그룹 조회</title>

<link href="${pageContext.request.contextPath}/resources/assets/css/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<!-- Publish JS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui-PIC.js" type="text/javascript"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.ui-deps.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.js"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/jquery.jqGrid.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/i18n/grid.locale-kr.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/wickedpicker.js"></script>

<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />

<!-- Application Common Functions  -->
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<!-- Publish CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset-PIC.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design-PIC.css" />
<%@ include file="../../include/session.jsp"%>
</head>
<style>
	body{
		width: auto;
	}
	@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
		body{
			width: auto !important;
		}
	}
</style>
<body>
	<div id="stepContents1" class="step_content" style="border-top: 1px solid #aca49c;  background: #f9f9f9;  width: 100%;">
		<div class="step_content_cell fl_l padd_r" style="width: 95%; height: 520px; max-height: 70%; overflow-y: auto; margin-left: 25px;">
		
			<div class="select_location sch_left" style="height: 60px; min-height: 60px;background: #fff; border-bottom: 0px; border-radius: 0;">
				<div style="position: absolute; right: 10px; top: 10px; padding-top: 0px; font-size: 18px; font-weight: bold;">
				Group : <input type="text" id="searchHost" value="" class="edt_sch" style="width: 263px;" onKeypress="javascript:if(event.keyCode==13) fnSearchHost()">
				<button id="btnSearch" class="btn_sch" style="margin-top: 5px;">검색</button>
				</div>
			</div>
			<div id="div_all" class="select_location" style="overflow-y: auto; width: 100%; height: 460px;background: #ffffff; border-radius: 0;">
				<table class="tbl_input" id="location_table">
					<tbody>
						<%-- <c:set var="motherIdx" value =""></c:set>
						<c:forEach items="${groupList}" var="item" varStatus="status">
							<c:if test="${item.LEVEL == 1}">
								<c:set var="motherIdx" value ="${item.IDX}"></c:set>
							</c:if>
							<tr style="display:none" data-uptidx="${item.UP_IDX}" data-level="${item.LEVEL}" data-mother="${motherIdx}" data-targetcnt="${item.CNT }">
								<th style="padding-top: 10px;"><p id="${item.IDX}" class="sta_tit" style="cursor:pointer; margin-left:${item.LEVEL*10}px; " ondblclick="setGroup(event)">${item.NAME}</p></th>
							</tr>
						</c:forEach> --%>
						
					<!-- 	<tr data-uptidx="0" data-level="1" data-mother="pc" data-targetcnt="0" data-id="pc">
							<th style="padding-top: 10px;"><p id="pc" class="sta_tit" style="cursor:pointer; margin-left:10px;">PC</p></th>
						</tr> -->
										
						<tr class="sktoa" data-uptidx="0" data-level="1" data-mother="sktoa" data-targetcnt="0" data-id="sktoa">
							<th style="padding-top: 10px;"><p id="sktoa" class="sta_tit" style="cursor:pointer; margin-left:20px;">SKT(OA망)</p></th>
						</tr>
						<tr class="sktut" data-uptidx="0" data-level="1" data-mother="sktut" data-targetcnt="0" data-id="sktut">
							<th style="padding-top: 10px;"><p id="sktut" class="sta_tit" style="cursor:pointer; margin-left:20px; width:auto; float:left;">SKT(유통망)</p></th>
						</tr>
						<c:set var="motherIdx" value =""></c:set>
						<c:forEach items="${groupList}" var="item" varStatus="status">
							<script type="text/javascript">
								var html = "<tr class='${item.IDX}' style='display:none;' data-uptidx='${item.UP_IDX}' data-level='${item.LEVEL}' data-mother='${motherIdx}' data-targetcnt='${item.CNT}' data-id='${item.IDX}' data-type='pc'>"
									+ "<th><p id='${item.IDX}' class='sta_tit' style='cursor:pointer; margin-left:${item.LEVEL*10 + 10}px; width:auto; float:left;' ondblclick='setGroup(event)'>${item.NAME}</p></th></tr>";
										
									$("."+"${item.UP_IDX}").after(html);
							</script>
											
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
						<!-- <script type="text/javascript">
							//console.log($('tr[data-level=1]').length)
							$('tr[data-level=1]').each(function(i, val){
								console.log(val)
								var id = $(val).children('th').children('p').attr('id')
								//console.log('id :: ' + id)
								//console.log($('tr[data-mother='+id+']').length)
								$('tr[data-mother='+id+']').each(function(bel_i, bel_val){
									var targetcnt = $(bel_val).data('targetcnt')
									//console.log('targetcnt :: ' + targetcnt)
									
									/* if(targetcnt > 0){
										var mother = $(bel_val).data('mother')
										//console.log('mother :: ' + mother)
										return false;
									} */
									$('p#'+id).parent('th').parent('tr').show()
								})
							});
						</script> -->
						<%-- 
						<c:if test="${noGroupSize > 0}">
							<tr>
								<th style="padding-top: 10px;"><p id="noGroup" class="sta_tit" style="cursor:pointer; margin-left:10px; " ondblclick="setGroup(event)" >그룹없음</p></th>
							</tr>
						</c:if> --%>
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
</body>
<script type="text/javascript">
var aut = "${aut}"

$("#btnSearch").click( function(e) {
	fnSearchHost(e);
});	

function fnSearchHost(e) {
	var searchHost = $("#searchHost").val();
	
	if (isNull(searchHost)) {
		$("#div_all").show();
		$("#div_search").hide();	
		return;
	}
	
	$("#div_all").hide();
	$("#div_search").show();
	getSearchData(searchHost);
	
}

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
			/* $.ajax({
				type: "POST",
				url: "/popup/getTargetList",
				async : false,
				data : {
					noGroup: id,
					aut: aut
				},
				dataType: "text",
			    success: function (resultMap) {
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
			return; */
		}
	}
	
	if($('tr[data-uptidx="'+id+'"]').is(':visible')){	// 보여지고 있을 때
		var up_id = [id]
		var up_idx = up_id.length
		var flag = true
		while(flag){
		/* 	var below_id = []
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
			 */
			var below_id = []
			console.log("IDX >> " + up_id);
			up_id.forEach(function(idx){
				$('tr[data-uptidx="'+idx+'"]').each(function(bi, value){
					var bel_id = $(value).children('th').children('p').attr('id')
					
					if($('tr[data-id="'+bel_id+'"]').is(':visible')){
						below_id.push(bel_id);
					} 					
					$('tr[data-uptidx="'+idx+'"][data-flag="target"]').remove();
					$('tr[data-uptidx="'+idx+'"][data-flag="path"]').remove(); 
					$(value).hide();
					
				});
			})
			if(below_id.length < 1){
				flag = false;
			} else {
				up_id = below_id;
			}
			
		}
	} else {											// 안 보여지고 있을 때
		/* $.ajax({
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
		}); */
		$('tr[data-uptidx="'+id+'"][data-flag!="path"]').show();
	}
	
});

$(document).on('click', function(event){
	var target = event.target;
	var tr = target.parentElement.parentElement;
	var data_flag = tr.getAttribute('data-flag')
	if(data_flag == 'target'){
		var id = target.getAttribute('id')
		if($('tr[name='+id+']').is(':visible')){	// 보여지고 있을 때
			$('tr[name='+id+']').hide()
		} else {
			$('tr[name='+id+']').show()
		}
	}
});

function setLocationList(locList, level, id, mother, code){
	var html = "";
	var target_id = "";
	var target_name = "";
	locList.forEach(function(item, index) {
		if(code == "all"){
			html += "	<tr data-uptidx=\""+id+"\" data-flag=\"target\" data-mother=\""+mother+"\" ondblclick=\"setTargetId(event)\">"
			html += "		<th style=\"padding-top: 10px;\"><p id=\""+item.TARGET_ID+"\" class=\"sta_tit4\" style=\"cursor:pointer;\ margin-left:"+((level*10)+10)+"px;\"  data-apno=\"" + item.AP_NO + "\" >"+item.AGENT_NAME+"</p></th>"
			html += "	</tr>"
		} else if (code == "search"){
			html += "	<tr data-flag=\"target\" ondblclick=\"setTargetId(event)\">"
			html += "		<th style=\"padding-top: 10px;\"><p id=\""+item.TARGET_ID+"\" class=\"sta_tit4\" style=\"cursor:pointer;\" data-apno=\"" + item.AP_NO + "\" >"+item.AGENT_NAME+"</p></th>"
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
			host: host,
			aut: aut
		},
		dataType: "text",
	    success: function (resultMap) {
	    	var data = JSON.parse(resultMap);
	    	if(data.resultCode == '0'){
	    		var resultList = data.resultData
	    		if(resultList.length > 0){
	    			var html = setLocationList(resultList, '', '', '', "search");
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

function setTargetId(event){
	
	var id = $(event.target).attr('id')
	var name = $(event.target).text()
	var ap_no = $(event.target).data('apno')
	
	$(opener.document).find("#searchHost").val(name);
	$(opener.document).find("#searchHost").text(name);
	$(opener.document).find("#hostSelect").val(id);
	$(opener.document).find("#ap_no").val(ap_no);
	opener.findByPop();
	
	window.close();

}

function setGroup(event){
	var id = $(event.target).attr('id')
	var name = $(event.target).text()
	
	$(opener.document).find("#SCH_GROUP").val(name);
	$(opener.document).find("#GROUP_ID").val(id);
	
	window.close();

	/* alert('click')
	console.log('id :: ' + id)
	console.log('name :: ' + name)
	
	console.log('') */
}
</script>
</html>
