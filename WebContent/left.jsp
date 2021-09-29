<%@page import="mybatis.vo.MemVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.btn{
		width: 70px;
		height: 20px;
		text-align: center;
		padding:0px;		
	}
	.btn a{
		display: block;
		width: 100%;
		padding: 4px;
		height: 20px;
		line-height: 20px;
		background: #27a;
		color: #fff;
		border-radius: 3px;
		text-decoration: none;
		font-size: 12px;
		font-weight: bold;
	}
	.btn a:hover{
		background: #fff;
		color: #27a;
		border: 1px solid #27a;
	}
	
	#s_id, #s_pw{
		width: 80px;
		border: 1px solid #27a;
		border-radius: 3px;
		padding: 4px;
	}
	div#log_fail, div#log_suc{
		width: 170px;
		border: 1px solid #27a;
		border-radius: 3px;
	}
	.hide{ display: none; }
	.show{ display: block; }
	.txt_r{ padding-left: 10px;}
</style>
</head>
<body>
<%
	//로그인 시 세션에 저장한 "mvo"라는 값을 얻어낸다.
	// 이것이 null이면 로그인을 하지 않은 경우!
	Object obj = session.getAttribute("mvo");

	if(obj == null){
%>
	<div id="log_fail" class="">
		
		<form action="" method="post">
			<table>
				<colgroup>
					<col width="50px"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
						<td><label for="s_id">ID:</label></td>
						<td>
							<input type="text" id="s_id" name="u_id"/>
						</td>
					</tr>
					<tr>
						<td><label for="s_pw">PW:</label></td>
						<td>
							<input type="password" id="s_pw" name="u_pw"/>
						</td>
					</tr>
					<tr>
						<td>
							<p class="btn">
								<a href="javascript:exe()">
									로그인
								</a>
							</p>							
						</td>
						<td class="txt_r">
							<p class="btn">
								<a href="javascript:reg()">
									회원가입
								</a>
							</p>							
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	
<%
	}else{
		// 로그인이 된 경우에는 캐스팅을 해주자! - 사용자의 이름을 얻기 위해서는 obj를 MemVO로 형변환 해야 한다!
		MemVO mvo = (MemVO)obj;
%>
	<div id="log_suc" class="">
		
		<p>(<%=mvo.getM_name()%>)님 환영</p>
		<p class="btn">
			<a href="logout.jsp">로그아웃</a>
		</p>
		<p class="btn">
			<a href="javascript:memo()">메모장</a>
		</p>
		<p class="btn">
			<a href="javascript:myDisk()">MyDisk</a>
		</p>
	</div>
	

	<form>
		<input type="hidden" name="res" id="res" value=""/>
	</form>
<%}//if문의끝! %>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script>
		function reg(){
			// 회원가입 창 열기
			// parent라는 명칭으로 화면을 분활시킨 부모 창으로 이동하여 
			// 그곳에 등록된 right라는 창의 경로를 변경한다.
			parent.right.location.href="reg.jsp";
			
		}
		function exe(){
			// 유효성 검사
			var id = $("#s_id").val();
			var pw = $("#s_pw").val();
			
			if(id.trim().length <= 0){
				alert("아이디를 입력해주세요");
				$("#s_id").val("");
				$("#s_id").focus();
				return;
				}
			if(pw.trim().length <= 0){
				alert("비밀번호를 입력해주세요");
				$("#s_pw").val("");
				$("#s_pw").focus();
				return;
				}
			
			// 현재문서에서 첫번째 폼의 action을 변경한다.
			document.forms[0].action = "login.jsp";
			document.forms[0].submit();
		}
		function myDisk(){
			parent.right.location.href="disk/myDisk.jsp"; // 해당 위치가 다르니까 해당위치에 폴더를 지정하고 안에 있는 jsp파일을 선택한 방법이다.
		}
	</script>
</body>
</html>