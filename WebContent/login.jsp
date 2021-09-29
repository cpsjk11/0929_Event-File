<%@page import="sun.security.provider.certpath.OCSPResponse.ResponseStatus"%>
<%@page import="org.apache.tomcat.dbcp.pool2.impl.PooledSoftReference"%>
<%@page import="mybatis.vo.MemVO"%>
<%@page import="mybatis.dao.MemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 로그인 페이지 작업이다!!
	// 요청시 한글처리부터 하자
	request.setCharacterEncoding("utf-8");

	// 파라미터를 통해 인자값을 받자!
	String id = request.getParameter("u_id");
	String pw = request.getParameter("u_pw");
	
	// 인자값을 받은것을 매퍼를 통해 DB와 연결하자!
	MemVO mvo = MemDAO.login(id, pw);
	
	// 값을 받았다면 받았는지 안 받았는지를 확인후 메인페이지로 이동하자!
	if(mvo != null){
		// 로그인이 된 경우
		session.setAttribute("mvo", mvo); // 세션에 mvo라는 이름으로 로그인 한 정보(mvo) 저장!
		//response.sendRedirect("left.jsp"); 페이지 강제이동이다!!
%>	
	<script>
	parent.location.href = "index.jsp";
	</script>
<% 
	}else{// 로그인 실패경우
%>
	<h2>로그인 실패 했습니다 아이디와 비밀번호를 확인해주세요</h2>
	<button type="button" onclick="javascript:parent.location.href = 'index.jsp'">메인페이지 이동</button>
<%} %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>