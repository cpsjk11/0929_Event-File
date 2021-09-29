<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 여기는 폴더를 생성해줘야 하는 페이지 이다!!
	
	// 먼저 요청시 한글처리
	request.setCharacterEncoding("utf-8");

	// 인자로 넘어온 파라미터를 받자(cPath,f_name)
	String name = request.getParameter("f_name"); // 폴더명
	String path = request.getParameter("cPath"); // 현재위치값
	
	// 이제 넘어온 값을 현재경로와 만들 폴더의 이름이자 이 두개를 이용해 절대경로로 만들어주자
	String c_path = application.getRealPath("/members/"+path+"/"+name);
	
	// 만들어진 경로로 파일 객체를 생성해주자
	File f = new File(c_path);
	
	// 이제 경로에 폴더가 있는지 없느지를 비교해 없을 경우에만 폴더를 생성해주자!
	if(!f.exists())
		f.mkdir();
	
	// 원래 있던 위치로 myDisk.jsp로 돌아간다.
	response.sendRedirect("myDisk.jsp?cPath="+path); // myDisk에서 cPath를 통해 페이지를 설정 해 놨기 때문에 선택한 폴더를 이름을 가진 path라는 값을 페이지로 보내줘 선택한 폴더의 위치로 보이게끔 해주었다.
%>
	<script>
	//parent.right.location.href="myDisk.jsp?cPath=<%=path%>";
	
	</script>
<%%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>