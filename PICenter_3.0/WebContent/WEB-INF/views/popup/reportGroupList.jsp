<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>범위 조회</title>

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
	<div id="stepContents1" class="step_content" style="border-top: 1px solid #aca49c;  background: #f9f9f9;  width: 100%; height: 100%; background: #f9f9f9;">
		<div class="step_content_cell fl_l padd_r" style="width: 95%; overflow-y: auto; margin-left: 25px;">
		
			<div class="select_location sch_left" style="height: 50px; min-height: 50px;background: #fff; border-bottom: 0px; border-radius: 0;">
				<div style="position: absolute; right: 10px; top: 10px; padding-top: 0px; font-size: 14px; font-weight: bold;">
				그룹명 : <input type="text" id="searchHost" value="" class="edt_sch" style="width: 180px; margin-bottom: 2px;">
				<button id="btnSearch" class="btn_sch" style="margin-top: 2px;">검색</button>
				</div>
			</div>
			<div id="div_all" class="select_location" style="overflow-y: auto; width: 100%; height: 460px;background: #ffffff; border-radius: 0;">
				<div id="groupJstree">
				</div>
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
var typeChk = "${type}";
$(function(){
	$('#groupJstree').jstree({
		// List of active plugins
	   "core" : {
		    "animation" : 0,
		    "check_callback" : true,
			"themes" : { "stripes" : false },
			"data" : ${userReportGroupList}
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
		'search': {
	        'case_insensitive': false,
	        'show_only_matches' : true,
	        "show_only_matches_children" : true
	    },
		'plugins' : ["search"],
	}).bind('select_node.jstree', function(evt, data, x) {
    	
    }).bind("dblclick.jstree", function (event) {
    	var node = $(event.target).closest("li");
    	var data = node.data("jstree"); 
    	
    	var js_node = $('#groupJstree').jstree(true).get_node(node[0].id);
    	
    	// Do some action
    	var type = js_node.data.type;
    	var name = js_node.text;
    	var id = node[0].id;
    	var ap = js_node.data.ap;
    	var insa_code = js_node.data.insa_code;
    
    	if(type == 0){
    		if(ap == 0) {
    	    	$(opener.document).find("#SCH_GROUP").val(name);
    			$(opener.document).find("#AP_NO").val(ap);
    			window.close();
        	}else {
        		$(opener.document).find("#SCH_GROUP").val(name);
        		$(opener.document).find("#GROUP_ID").val(insa_code);
    			$(opener.document).find("#AP_NO").val(ap);
    			window.close();
        	}
    	} else if(type == 1 || type == 2 || type == 3) {
    		name = js_node.data.name;
    		window.close();
    	}
    });
	
	var to = true;
	$('#btnSearch').on('click', function(){
		
	    var v = $('#searchHost').val();
		console.log(v);
		
		if(to) { clearTimeout(to); }
	    to = setTimeout(function () {
	      $('#groupJstree').jstree(true).search(v);
	    }, 250);
	});
	
	$('#searchHost').keyup(function (e) {
    	var v = $('#searchHost').val();
    	if (e.keyCode == 13) {
        	
        	if(to) { clearTimeout(to); }
            to = setTimeout(function () {
              $('#groupJstree').jstree(true).search(v);
            }, 250);
        }
    });
});

</script>
</html>
