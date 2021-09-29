<%@page import="java.io.File"%>

<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%--
	첨부된 파일을 받기 위해서는 servlets.com에 있는 cos라이브러리가 필요하다.
	사이트 왼쪽 메뉴에 [COS File Library]라는 메뉴 선택한 후 화면 아래 쪽에 있는
	cos-20.08.zip을 다운 받아서 압축을 해제한 후 lib폴더 안에 있는 cos.jar파일을
	원하는 프로젝트의 WedContent/WEB-INF/ilb에 복사해 넣는다.
 --%>
 <%
 	String dir = (String)session.getAttribute("dir");
 
 	String realPath = application.getRealPath("/members/"+dir);
 
 	// 전달되는 폼의 enctype=multipart/form-data로 되어 있다면 request로 파라미터들을 아래와 같이 받을 수 없다.
 	
 	//String dir = request.getParameter("cPath");
 	//String upload = request.getParameter("upload");
 	
 	MultipartRequest mr = new MultipartRequest(request,realPath,1024*1024*5, new DefaultFileRenamePolicy());
 	//                                          요청객체  저장할경로  용량제한       이름이 같다면 자동으로 파일명을 변경해주는 함수
 	// 여기까지만 해도 전달된 파일이 realPath경로에 저장된다.
 	
 	// 파일명이 변경될 수도 있으므로 확인하기 위해서 먼저 첨부파일을
 	// File객체로 얻어낸다.
 	File f = mr.getFile("upload");
 	
 	// 변경 전의 파일명
 	String o_name = mr.getOriginalFileName("upload");
 	
 	// 현재 파일명
 	String f_name = f.getName();
 	
 	//response.sendRedirect("myDisk.jsp?cPath="+dir);
 %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- 만약 get방식으로 보내는것이 아닌 post방식으로 보내고 싶으면 폼을 하나 만들어서 보내주면 된다. -->
<body onload="movePage()">
	<form action="myDisk.jsp" method="post">
		<input type="hidden" name="cPath" value="<%=dir%>"/>
	</form>
	<script>
		function movePage(){
			document.forms[0].submit();
		}
	</script>
</body>
</html>