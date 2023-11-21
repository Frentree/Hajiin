<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>하위 경로 정보</title>
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
<style>
	body{
		width: auto;
	}
	.ui-widget-content ul{
		padding: 0;
	}
	.ui-widget-content li{
		padding: 0;
	}
	@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
		body{
			width: auto !important;
		}
	}
</style>
<body>
	<div class="wrap" style="min-height: 364px !important;">
		<!-- 팝업창 시작 개인정보검출 상세정보 -->
		<%
		String browser = "";
		String userAgent = request.getHeader("User-Agent");
		
		%>
		
		<!-- 팝업창 시작 하위 로케이션 상세정보 -->
		<%-- <%
		if (userAgent.indexOf("Trident") > 0 || userAgent.indexOf("MSIE") > 0) {
		%>
			<div id="pathWindow" style="position:absolute; touch-action: none; width: 100%; height: 100%; z-index: 999; min-width: 30%; min-height: 200px; background: #f9f9f9;" class="ui-widget-content">
			<table class="mxWindow" style="position: absolute; left: 15px; width: 97%; height: 95%;">
			<tbody>
				<tr>
					<td class="mxWindowTitle" style="touch-action: none; background: #fff; padding: 0;">
						<table style="width: 100%; height: 36px;">
							<colgroup>
								<col width="*">
								<col width="30px">
							</colgroup>
							<tr>
								<td style="color: #000; text-align: left; background: #f9f9f9;">
									<h2 style="width: 1110px;">하위 경로 정보</h2>
								</td>
								<td style="display: inline-block; padding-top: 6px; cursor: default;">
									<img src="${pageContext.request.contextPath}/resources/assets/images/close.gif" title="Close" id="pathWindowClose">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="mxWindowPane">
						<div class="mxWindowPane" style="width: 100%;height: 100%;">
							<table style="width: 100%;height: 100%;">
							<tbody>
								<tr>
									<td style="width: 100%; height: 100%; border:none; border: 1px solid #c8ced3; background: #fff;">
										<div id="pathContent" style="overflow-y:auto;height: 100%; padding: 5px 5px;">&nbsp;</div>
									</td>
								</tr>
							</tbody>
							</table>
						</div>
					</td>
				</tr>
			</tbody>
			</table>
			</div>
		<%
		} else {
		%> --%>
			<div id="pathWindow" style="position:absolute; touch-action: none; width: 100%; height: 100%; z-index: 999; min-width: 30%; min-height: 200px; background: #f9f9f9;" class="ui-widget-content">
			<table class="mxWindow" style="position: absolute; left: 15px; width: 97%; height: 95%;">
			<tbody>
				<tr>
					<td class="mxWindowTitle" style="touch-action: none; background: #fff; padding: 0;">
						<table style="width: 100%; height: 36px;">
							<colgroup>
								<col width="*">
								<col width="30px">
							</colgroup>
							<tr>
								<td style="color: #000; text-align: left; background: #f9f9f9;">
									<h2 style="width: 1110px;">하위 경로 정보</h2>
								</td>
								<%-- <td style="display: inline-block; padding-top: 6px; cursor: default;">
									<img src="${pageContext.request.contextPath}/resources/assets/images/close.gif" title="Close" id="pathWindowClose">
								</td> --%>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="mxWindowPane">
						<div class="mxWindowPane" style="width: 100%;height: 100%;">
						 <table style="width: 100%;height: 100%;">
							<tbody>
								<tr>
									<td style="width: 100%; height: 100%; border:none; border: 1px solid #c8ced3; background: #fff;">
										<div id="subpathTree" style="overflow-y:auto;height: 100%;">&nbsp;</div>
									</td>
								</tr>
							</tbody>
							</table>
							
						</div>
					</td>
				</tr>
			</tbody>
			</table>
			</div>
		<%-- <%
		}
		%> --%>
		<!-- 팝업창 종료 -->
	</div>
</body>
<script type="text/javascript">
$(function() {
	$('#subpathTree').jstree({
		// List of active plugins
		"core" : {
		    "animation" : 0,
		    "check_callback" : true,
			"themes" : { "stripes" : false },
			"data" : ${subPath}
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
		'plugins' : ["search"],
	})
	.bind("loaded.jstree", function(evt, data, x, e) { 
		if(data == null || data == ""){
			alert("하위 경로를 불러올 수 없습니다.");
			self.close();
		}
		
		$("#subpathTree").jstree("open_all");
	}.bind(this))
    .bind('select_node.jstree', function(evt, data, x) {
    	
    	var parent = data.node.parent;
    	var id = data.node.id;
    	var type = data.node.data.type;
    	var tid = data.node.data.tid;
    	
    	console.log(data);
    	
    	if(type != 0){
        	var pathid = data.node.id;
        	var ap_no = data.node.original.ap_no;
        	
        	var pop_url = "${getContextPath}/popup/detectionDetail?id="+pathid+"&ap_no="+ap_no+"&tid="+tid;
        	var winWidth = 1142;
        	var winHeight = 365;
        	var popupOption= "left=20, top=10, width="+winWidth+", height="+winHeight + ", scrollbars=no, resizable=no, location=no"; 	
        	//var pop = window.open(pop_url,"detail",popupOption);
        	var pop = window.open(pop_url,pathid,popupOption);
        	/* popList.push(pop);
        	sessionUpdate ();*/
        	
        	//pop.check();
        	
        	var newForm = document.createElement('form');
        	newForm.method='POST';
        	newForm.action=pop_url;
        	newForm.name='newForm';
        	//newForm.target='detail';
        	newForm.target=pathid;
        	
        	var input_id = document.createElement('input');
        	input_id.setAttribute('type','hidden');
        	input_id.setAttribute('name','id');
        	input_id.setAttribute('value',pathid);
        	
        	var input_tid = document.createElement('input');
        	input_tid.setAttribute('type','hidden');
        	input_tid.setAttribute('name','id');
        	input_tid.setAttribute('value',tid);
        	
        	var input_ap = document.createElement('input');
        	input_ap.setAttribute('type','hidden');
        	input_ap.setAttribute('name','ap_no');
        	input_ap.setAttribute('value',ap_no);
        	
        	newForm.appendChild(input_id);
        	newForm.appendChild(input_tid);
        	newForm.appendChild(input_ap);
        	document.body.appendChild(newForm);
        	newForm.submit();
        	
        	document.body.removeChild(newForm);
        	
    	$("#pathWindow").show();
        }
    });
});

$(document).ready(function(){
	/* if('${id}' != null && '${ap_no}' != null){
		setContent('${id}', '${ap_no}');
	} */
});

function setContent(id, ap_no){
    var oPostDt = {hash_id: id, ap_no: ap_no};
    /* $.ajax({
        type: "POST",
        url: "/manage/subpathSelect",
        async : true,
        data : oPostDt,
        success: function (resultMap) {
        	var subPathList = "<ul id='subList'>";
        	var dev = 0;
        	subPathList += "<li class='subPathList'><a href='javascript:void(0)'><img style='margin-right: 3px; margin-bottom: 3px;' src='${pageContext.request.contextPath}/resources/assets/images/arrow_deactive.png'>"; 
			subPathList += resultMap[0].PATH + "</a><ul id='pathList'></ul></li></ul>";
			$("#pathContent").html(subPathList);
			
			var pathList = $("#pathList");
			
        	for(var i = 1; i < resultMap.length; i++) {
        		var codeNm = resultMap[i].PATH;
        		var codeId = resultMap[i].ID;
        	  	var parentId = resultMap[i].PID;
        		var codeLvl = resultMap[i].LEVEL;
        		var oid = resultMap[i].OID;
        		
        		var li = '<li id="'+ codeId +'" lvl="' + codeLvl + '"><a href="javascript:void(0)">';
        		if(resultMap[i].OID == null){
        			li += "<img style='margin-right: 3px; margin-bottom: 3px;' src='${pageContext.request.contextPath}/resources/assets/images/arrow_deactive.png'>" + codeNm ;
        		} else {
        			li += "<input type='hidden' value='" + codeId + "'> <U style='color:blue;'>" + codeNm + "</U>";
        		}
        		li +=  "</a></li>";
        		
        		if(codeLvl == '2') {
        			pathList.append(li);
        			if(resultMap[i].OID == null){
        				var ul = "<ul></ul>"
        				$("#"+ codeId).append(ul);
        			}
        			//lvl1.append(li);
        		} else {
        			var parentLi = $("li[id='"+ parentId +"']");
        			var bUl = parentLi.find("ul");
        		    // 하위 그룹이 없으면 li로 추가
        			// 하위 그룹이 있으면 ul로 추가
        			if(bUl.length == 0) {
        			  li = "<ul>" + li + "</ul>";
        			  parentLi.append(li);
        			} else {
        			  bUl.append(li);
        			}
        		}
        	
        	}
        	
        	$(".subPathList").find('a').click(function() {
            if ($(this).next('ul').is(':visible')) {
                $(this).children("img").attr("src", '${pageContext.request.contextPath}/resources/assets/images/arrow_active.png');
                $(this).next('ul').hide();
            } else {
                $(this).children("img").attr("src", '${pageContext.request.contextPath}/resources/assets/images/arrow_deactive.png');
                $(this).next('ul').show();
            }
            
            if($(this).find('input').val() != null){
            	var pathid = $(this).find('input').val();
            	
            	var pop_url = "${getContextPath}/popup/detectionDetail";
            	var winWidth = 1142;
            	var winHeight = 365;
            	var popupOption= "left=20, top=10, width="+winWidth+", height="+winHeight + ", scrollbars=no, resizable=no, location=no"; 	
            	//var pop = window.open(pop_url,"detail",popupOption);
            	var pop = window.open(pop_url,pathid,popupOption);
            	
            	
            	//pop.check();
            	
            	var newForm = document.createElement('form');
            	newForm.method='POST';
            	newForm.action=pop_url;
            	newForm.name='newForm';
            	//newForm.target='detail';
            	newForm.target=pathid;
            	
            	var input_id = document.createElement('input');
            	input_id.setAttribute('type','hidden');
            	input_id.setAttribute('name','id');
            	input_id.setAttribute('value',pathid);
            	
            	var input_ap = document.createElement('input');
            	input_ap.setAttribute('type','hidden');
            	input_ap.setAttribute('name','ap_no');
            	input_ap.setAttribute('value',ap_no);
            	
            	newForm.appendChild(input_id);
            	newForm.appendChild(input_ap);
            	document.body.appendChild(newForm);
            	newForm.submit();
            	
            	document.body.removeChild(newForm);
            	
            	//var oPostDt = {id : pathid};
            }
        });  
        	
        	 $("#pathWindow").show();
        },
        error: function (request, status, error) {
            alert("하위 경로를 불러올 수 없습니다.");
        }
    }); */
}
</script>
</html>
