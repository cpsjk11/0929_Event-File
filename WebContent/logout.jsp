<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//HttpSession에서 mvo라는 이름으로 저장되는 정보를 삭제한다.
	session.removeAttribute("mvo");
	response.sendRedirect("left.jsp");
%>
