<%@page import="java.io.File"%>
<%@page import="mybatis.dao.MemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 여기는 회원가입을 위한 페이지 이다!
	// 먼저 요청시 한글처리
	request.setCharacterEncoding("utf-8");

	// 파라미터를 받아보자!
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	// 인자값을 다 받았다면 이제 MemDAO를 호출하자! - 받은 값들을 DB에 저장해야 한다!
	int cnt = MemDAO.registry(id, pw, name, email); 
	
	// 저장이 되었다면 cnt의 값은 0보다 클것이다.
	if(cnt > 0){
		
		//member라는 폴더에 아이디와 같은 폴더 생성해야 한다.
		//현재 서버 프로그램(application)
		// members라는 폴더의 정확한 절대경로를 얻자!
		String path = application.getRealPath("/members/"+id); // 어플리케이션을 통해서 경로 값을 받으면 현재 페이지의 WedContent까지 경로가 설정이 된다.
		
		//System.out.println(path);
		// 위의 절대경로를 가지고 File객체를 생성한 후 디렉토리를 생성하자!
		File f = new File(path);
		
		// 존재하지 않을 경우에만 디렉토리를 생성한다.
		if(!f.exists()) // 경로에 폴더가 있는지 없는지를 확인 하는 함수이다! 반환을 true false로 해준다.
			f.mkdirs(); // 실제 디렉토리를 만든다.
%>
	<!-- <p>회원가입 성공!!</p><br/>
	<a href="index.jsp">메인페이지 이동</a> -->
	<script>
		parent.location.href = "index.jsp";// 현재 페이지는 오른쪽 영역이다 그러니 상위 페이지를 지정해서 경로를 바꿔줘야지 화면이 제대로 변경이 가능하다.
	</script>
<%
	}else{
%>
	<!-- <p>회원가입 실패 다시 확인해 주세요</p><br/>
	<a href="index.jsp">메인페이지 이동</a> -->
		<script>
		parent.location.href = "index.jsp";
	</script>
<%
	}
%>
