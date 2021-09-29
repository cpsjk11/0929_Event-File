<%@page import="mybatis.dao.MemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 요청시 한글처리
	request.setCharacterEncoding("utf-8");
	
	//파라미터 받기
	String id = request.getParameter("u_id");
	
	if(MemDAO.checkId(id)){
%>
		<pre class="success" id="chk">사용가능</pre>
	
<%
	}else{
%>
		<pre class="fail" id="chk">사용불가</pre>
<%} %>
