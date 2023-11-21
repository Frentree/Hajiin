<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>개인정보 검출관리 센터</title>

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
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/select2.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/jquery-ui-PIC.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/ui.jqgrid-PIC.css" />
<%@ include file="../../include/session.jsp"%>
<style>
	.ui-widget.ui-widget-content{
		border: none;
		border-bottom: 1px solid #c8ced3;
		border-radius: unset !important;
	}
	body{
		width: auto;
	}
	.ui-jqgrid tr.ui-row-ltr td{
		cursor: pointer;
	}
	@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
		html{
			overflow: auto !important;
		}
		body{
			width: auto !important;
		}
	}
</style>
</head>
<body>
	<div id="userHelpPopup" class="popup_layer" style="background: #f9f9f9;">
		<div class="help_popup_box" style="padding: 10px; background: #f9f9f9;">
			<div class="popup_content" style="dispaly: block;">
				<div class="content-box" id="userHelpImg" style="width: 98vw; height: 95vh; background: #fff; border: 1px solid #c8ced3; text-align: center;">
					<img id="helpImg" src="" style="width: 100%; height: 100%;">
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
var id = "${id}";

if(id == "target_mngr"){
	$("#helpImg").attr("src", "${pageContext.request.contextPath}/resources/assets/images/target_mngr_help_icon.png");
}else if(id == "target_mngr_pc"){
	$("#helpImg").attr("src", "${pageContext.request.contextPath}/resources/assets/images/target_mngr_pc_help_icon.png");
}
else if(id == "search_regist"){
	$("#helpImg").attr("src", "${pageContext.request.contextPath}/resources/assets/images/search_regist_help_icon.png");
}else if(id == "detection_list"){
	$("#helpImg").attr("src", "${pageContext.request.contextPath}/resources/assets/images/detection_help_icon.png");
}else if(id == "detection_list_pc"){
	$("#helpImg").attr("src", "${pageContext.request.contextPath}/resources/assets/images/detection_pc_help_icon.png");
}else if(id == "search_list"){
	$("#helpImg").attr("src", "${pageContext.request.contextPath}/resources/assets/images/search_list_help_icon.png");
}else if(id == "search_approval"){
	$("#helpImg").attr("src", "${pageContext.request.contextPath}/resources/assets/images/approval_help_icon.png");
}

</script>
</html>
