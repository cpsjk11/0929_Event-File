<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
	
	div#wrap{
		width: 400px;
		margin: 30px auto;
	}
	
	table th, table td{
		padding: 3px;
	}
	table tbody td>input{
		width: 120px;
		border: 1px solid #27a;
		border-radius: 3px;
		padding: 4px;
	}
	.txt_r{ text-align: right; }
	.phone{ width: 50px; }
	
	.success{ color: #00f; font-weight: bold; font-size: 11px;}
	.fail{ color: #f00; font-weight: bold; font-size: 11px; }
	
	div#box{
		display: inline-block;
		width: 65px;
		height: 20px;
		padding: 0;
		margin: 0;
		margin-left: 3px;
	}
</style>
</head>
<body>
	<div id="wrap">
		<form action="registry.jsp" method="post">
			<table>
				<colgroup>
					<col width="100px"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
						<th><label for="s_id">ID:</label></th>
						<td>
							<input type="text" id="s_id" name="id"/>
							<div id="box"></div>
						</td>
					</tr>
					<tr>
						<th><label for="s_pw">PW:</label></th>
						<td>
							<input type="password" id="s_pw" name="pw"/>
						</td>
					</tr>
					<tr>
						<th><label for="s_name">NAME:</label></th>
						<td>
							<input type="text" id="s_name" name="name"/>
						</td>
					</tr>
					<%-- 
					<tr>
						<th><label for="s_addr">ADDR:</label></th>
						<td>
							<input type="text" id="s_addr" name="addr"/>
						</td>
					</tr>
					<tr>
						<th><label for="s_phone">PHONE:</label></th>
						<td>
							<input type="text" id="s_phone" name="phone" class="phone"/>
							- <input type="text" name="phone" class="phone"/>
							- <input type="text" name="phone" class="phone"/>
						</td>
					</tr>
					--%>
					<tr>
						<th>
							<label for="s_email">EMAIL:</label>
						</th>
						<td>
							<input type="text" id="s_email" name="email"/>
						</td>
					</tr>					
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2" >
							<p class="btn">
								<a href="javascript:reg()">
									회원가입
								</a>
							</p>
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script>
		$(function(){
			
			// 사용자가 id를 입력하기 위해 
			// 키보드를 누를 때 마다 이벤트 적용시킨다.
			$("#s_id").bind("keyup",function(){
				// 사용자가 입력한 아이디가 s_id에 입력되므로 그곳에 있는 값(value)를 가져온다.
				var str = $(this).val();
				//console.log(id);
				//str의 값에서 공백이 있는지? 없는지? 판단하고 있다면
				// 정규표현식 등을 이용하여 제거하는 작업이 필요하다. 일단 생략(참고, HTML_Study)
				
				if(str.trim().length > 3){
					// 아이디를 4자 이상 입력했을 경우
					// 서버로 보낸다.
					$.ajax({
						url:"checkId.jsp",
						type: "post",
						data: "u_id="+encodeURIComponent(str),
					}).done(function(res){
						// 요청에 도착하는 함수
						$("#box").html(res);
					}).fail(function(err){
						// 서버 요청 실패시
						console.log(err);
					});
				}else{
					// 사용자가 입력한 id값의 길이가 4자 미민이면 아이디가
					// box인 요소의 내용을 없앤다.
					$("#box").html("");
				}
			});
			
		});
		
		function reg(){
			// 아이디가 chk인 요소의 class값을 얻어낸자
			var chk = $("#chk").hasClass("success");  // 해당 아이디를 가진 태그가 클래스가 success가 있다면 true 없다면 false를 반환해준다.
			//var chk = document.getElementById("chk").className;
			
			if(!chk){ // if(chk != "success")
				alert("아이디 체크를 먼저 하세요");
				return;
			}
			
			// 나머지 유효성 검사
			var id = $("#s_id").val();
			var pw = $("#s_pw").val();
			var name = $("#s_name").val();
			
			if(id.trim().length < 1){
				alert("아이디를 입력해주세요");
				$("#s_id").val("");
				$("#s_id").focus();
				return;
			}
			if(pw.trim().length < 1){
				alert("비밀번호를 입력해주세요");
				$("#s_pw").val("");
				$("#s_pw").focus();
				return;
			}
			if(name.trim().length < 1){
				alert("이름를 입력해주세요");
				$("#s_name").val("");
				$("#s_name").focus();
				return;
			}
			
			// 위의 3개 비교문을 모두 통과했다면 서버로 보낸다.
			document.forms[0].submit();
		}
	</script>
</body>
</html>