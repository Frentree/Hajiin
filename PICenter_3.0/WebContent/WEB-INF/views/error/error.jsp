<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta charset="utf-8">
	<title>에러 페이지</title>

	<link href="${pageContext.request.contextPath}/resources/assets/css/ui.fancytree.css" rel="stylesheet" type="text/css" /> 
	<link href="${pageContext.request.contextPath}/resources/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

	<!-- Publish JS -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>
	<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui.js" type="text/javascript"></script>

	<!--[if lte IE 8]>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/ie-8.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/ie-8.css" />
	<![endif]-->
	<!--[if lte IE 9]>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/ie-9.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/ie-9.css" />
	<![endif]-->

	<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/echart/echarts-all.js"></script>
	<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.ui-deps.js"></script>
	<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.js"></script>
	
	<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/jquery.jqGrid.min.js"></script>
	<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/wickedpicker.js"></script>
	
	<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/ui.jqgrid.css" />
	
	<!-- Application Common Functions  -->
	<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
	
	<!-- Publish CSS -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design.css" />
	
</head>

<body class="">
  <div class="" style="top: 25%; position: relative;">
    <div class="error_wrap">
      <div class="container" style="text-align: center; padding: 0px;">

          <div class="area_img"><img src="${pageContext.request.contextPath}/resources/assets/images/img_error.png" alt=""></div><BR/>
          <h1 style="padding: 20px;">요청하신 페이지를 찾을 수 없습니다.</h1>
          <p>서비스 이용에 불편을 드려 죄송합니다.<br />
            메인페이지로 이동 후 원하는 정보에 대한 페이지로 연결해주시기 바랍니다.
          </p>
          <div class="btn_area magin_t1" style="text-align: center;">
            <button onclick="main();">메인으로 가기 </button>
            <button onclick="javascript:history.back(-1)">이전 페이지로 가기</button>
          </div>

      </div>
    </div>
  </div>
</body>

<script type="text/javascript">
function main() {
	document.location.href = "<%=request.getContextPath()%>/";
}
</script>

</html>
