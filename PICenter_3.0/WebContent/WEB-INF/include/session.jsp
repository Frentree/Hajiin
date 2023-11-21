<%@ page language="java" contentType="text/html; charset=UTF-8"%>  <!-- 한글깨짐 방지 -->

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>타겟 조회</title>

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

<div id="sessionUpdatePop" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 466px; padding: 10px; background: #f9f9f9; top: 69%;">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">자동로그아웃 안내</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 69px; background: #fff; border: 1px solid #c8ced3; font-size: 13px;">
				약 10분 동안 서비스 이용이 없어 잠시후 자동 로그아웃 됩니다. <br>
				서비스를 계속 이용 하시려면 메인 페이지에서 <span style="color: #FF7A00; font-weight: bold;">연장</span>을 진행해 주시길 바랍니다.
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<!-- <button type="button" id="btnUserDateDelete">계정삭제</button> -->
				<button type="button" id="btnSessionPop">확인</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
var link = opener.performance.navigation.type;

$(document).ready(function () {
	console.log(link);
});

function showSessionPop(){
	console.log(link);
	$("#sessionUpdatePop").show();
}
function hideSessionPop(){
	$("#sessionUpdatePop").hide();
}
$("#btnSessionPop").click(function(){
	$("#sessionUpdatePop").hide();
});



</script>