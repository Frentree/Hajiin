<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>타겟 조회</title>
<!-- <title> NH농협중앙회 서버 내 개인정보 검색 시스템</title> -->

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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jstree.min.js"></script>

<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />

<!-- Application Common Functions  -->
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<!-- Publish CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset-PIC.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design-PIC.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.min.css" />

</head>
<%@ include file="../../include/session.jsp"%>
<body>
	<div id="stepContents1" class="step_content" style="border-top: 1px solid #aca49c; background: #f9f9f9; width: 100%; height: 100%;">
		<div class="step_content_cell fl_l padd_r" style="width: 95%; height: 100%; overflow-y: auto; margin-left: 25px;">
		
			<div class="select_location sch_left" style="height: 60px; min-height: 60px;background: #fff; border-bottom: 0px; border-radius: 0;">
				<div style="position: absolute; right: 10px; top: 10px; padding-top: 0px; font-size: 18px; font-weight: bold;">
				HOST : <input type="text" id="searchHost" value="" class="edt_sch" style="width: 263px;" onKeypress="javascript:if(event.keyCode==13) fnSearchHost()">
				<button id="btnSearch" class="btn_sch" style="margin-top: 5px;">검색</button>
				</div>
			</div>
			<div id="jstree" class="select_location" style="overflow-y: auto; width:100%; height: 460px;background: #ffffff; border-radius: 0;">
				
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function() {
	$('#jstree').jstree({
		// List of active plugins
		"core" : {
		    "animation" : 0,
		    "check_callback" : true,
			"themes" : { "stripes" : false },
			"data" : ${exceptionHostList}
		},
		"types" : {
			    "#" : {
			      "max_children" : 1,
			      "max_depth" : 4,
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
		'plugins' : [""],
	})
    .bind('select_node.jstree', function(evt, data, x) {
    	var id = data.node.id;
    	var type = data.node.data.type;
    	var ap = data.node.data.ap;
    	var name =  data.node.text;
    	//$('#jstree').jstree(true).refresh();
    	
    	console.log("dafd");
    	console.log(data.node);
    	
    	console.log(data);
    	$(opener.document).find("#createServerHost").val(name);
		$(opener.document).find("#createServerHost").text(name);
		$(opener.document).find("#hostSelect").val(id);
		$(opener.document).find("#ap_no").val(ap_no);
		
		$("#createServerService").val(name);
		$("#createServerService").text(name);
		
		opener.findByPop();
		
		window.close();
    	
    });
});

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

function setTargetId(event){
	
	var id = $(event.target).attr('id')
	var name = $(event.target).text()
	var ap_no = $(event.target).data('apno')
	
	$(opener.document).find("#createServerGroup").val(name);
	$(opener.document).find("#createServerGroup").text(name);
	$(opener.document).find("#hostSelect").val(id);
	$(opener.document).find("#ap_no").val(ap_no);
	opener.findByPop();
	
	window.close();

}
</script>
</html>
