<%@page import="mybatis.vo.MemVO"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	// 선언부 멤버변수 또는 멤버메서드들을 정의할 때 사용한다.
	
	// 개인이 사용한 용량을 측정하는 메서드(File은 파일만 용량을 얻을 수 있으며, 폴더는 용량을 구하지 못하고
	//								안에 있는 파일들의 용량을 모두 더해야 한다. 그래서 재귀호출 기법을 활용해야 한다.)
	public int useSize(File f){// 중요하다 복습!
		// 인자로 전달된 File객체가 폴더여야 한다.
		// 이 폴더의 하위요소들의 File용량을 모두 더해야 한다. 우선
		// 하위 요소들을 모두 얻어내자!
		File[] list = f.listFiles();
		
		int size = 0;
		
		// 파일일 경우엔 용량을 size에 누적 시키고, 폴더(디렉토리)일 경우 현재 함수를 다시 호출한다.(재귀호출함수)
		for(File sf : list){
			if(sf.isFile())
				size += sf.length(); // 용량을 누적!
			else
				size += useSize(sf); // 재귀호출!
		}
		return size;
	}
%>
<%
	int totalSize = 1024*1024*10; // 10MBtye 용량 계산법이다!!
	int useSize = 0;
	
	// 현재 페이지는 무조건 로그인이 되어 있어야 사용 가능한 페이지다.
	// 이쯤에서 로그인 여부를 확인해야 한다.
	Object obj = session.getAttribute("mvo");
	
	if(obj != null){
		// 현재 영역은 로그인이 된 상태이니까 캐스팅을 시켜준다.
		MemVO mvo = (MemVO)obj;
		
		// 현재 사용자가 보고자 하는 현재 위치값(cPath)을 파라미터로 받는다.
		String dir = request.getParameter("cPath"); // myDisk버튼을 클릭하고
							// 들어온 경우에는 dir에 null을 받는다.
							
		// 사용자가 폴더를 선택했을 경우라면 f_name이라는 파라미터 또한 넘어온다.
		String fname = request.getParameter("f_name");
							
		if(dir == null){
			
			// 현재 위치 값을 받지 못한 경우는 무조건 해당 id로 지정한다.
			dir = mvo.getM_id();
			
		}else{
			//현재 영역은 MyDisk화면에서 원하는 폴더를 선택 할 경우 수행하는 곳!
			if(fname != null && fname.trim().length() > 0){
				dir = dir+"/"+fname; // admin/abc 형태로 들어간다.
			}
							
			
		}
		session.setAttribute("dir", dir);
		//위는 엄청 중요한 정보다.
		// 사용자가 언젠가 파일올리기할 때 현재위치 값을 upload.jsp문서에 전달해야 한다.
		// 그러나 파라미터 값으로 전달하기에는 너무 시간적으로 맞지 않다.
		// 파라미터가 전달되기 전에 전달이 가능해야 한다. 그래서 파라미터와 상관없는
		// HttpSession에 저장한다.
%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table{
		width: 600px;
		border: 1px solid #27a;
		border-collapse: collapse;
	}
	table th, table td{
		border: 1px solid #27a;
		padding: 4px;
	}
	table th{ background-color: #bcbcbc; }
	.title { background-color: #bcbcbc; width: 25%; }
	
	.btn{
		display: inline-block;
		width: 70px;
		height: 20px;
		text-align: center;
		padding:0px;	
		margin-right: 20px;	
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
	
	#f_win{
		width: 220px;
		height: 80px;
		padding: 20px;
		border: 1px solid #27a;
		border-radius: 8px;
		background-color: #efefef;
		text-align: center;
		position: absolute;
		top: 150px;
		left: 250px;
		display: none;
	}
	#f_win2{
		width: 300px;
		height: 80px;
		padding: 20px;
		border: 1px solid #27a;
		border-radius: 8px;
		background-color: #efefef;
		text-align: center;
		position: absolute;
		top: 150px;
		left: 250px;
		display: none;
	}
	.m_id{
		color: #00f;
		font-weight: bold;
	}
</style>
</head>
<body>
	<h1>My Disk service</h1>
	<hr/><%=mvo.getM_name()%>
	(<span class="m_id"><%=mvo.getM_id()%></span>)님의 디스크
	&nbsp;[<a href="javascript:home()">Home</a>]
	<hr/>
	
	<table summary="사용량을 표시하는 테이블">
		<tbody>
			<tr>
				<th class="title">전체용량</th>
				<td><%=totalSize/1024 %>KB</td>
			</tr>
			<tr>
				<th class="title">사용량</th>
				<td><%=useSize/1024 %>KB</td>
			</tr>
			<tr>
				<th class="title">남은용량</th>
				<td><%=(totalSize-useSize)/1024 %>KB</td>
			</tr>
		</tbody>
	</table>
	<hr/>
		<div id="btn_area">
			<p class="btn">
				<a href="javascript:selectFile()">
					파일올리기
				</a>
			</p>
			<p class="btn">
				<a href="javascript:makeFolder()">
				
					폴더생성
				</a>
			</p>
			<p class="btn">
				<a href="javascript:exe()">
					파일생성
				</a>
			</p>
		</div>		
	<hr/>
	
	<label for="dir">현재위치: <%=dir %></label>
	<span id="dir"></span>
	
	<table summary="폴더의 내용을 표현하는 테이블">
		<colgroup>
			<col width="50px"/>
			<col width="*"/>
			<col width="80px"/>
		</colgroup>
		<thead>
			<tr>
				<th>구분</th>
				<th>폴더 및 파일명</th>
				<th>삭제여부</th>
			</tr>
		</thead>
		<tbody>
		<% 
			//member폴더에서 로그인한 자신의 폴더를 홈디렉토리로 지정하여 그 안에
			// 있는 모든 파일 또는 디렉토리들을 표현하자!
			//(이렇게 한 이유는 폴더를 생성할때 각 사용자의 아이디의 이름 그대로 폴더를 생성하도록 했기 때문에 dir이라는 변수의 값이 id와 같다면
			//		현재 그 폴더는 사용할수 있는 최상위 폴더의 위치하고 있기 때문에 "상위로.." 라는 기능을 if문을 통해 적용시킬지 말지를 결정 하였다.)
			if(!dir.equals(mvo.getM_id())){// 현재위치값과 아이디가 다를 때만
		%>
			<tr>
				<td>↑</td>
				<td colspan="2">
					<a href="javascript:goUp('')">
						상위로...
					</a>
				</td>
				
			</tr>
<%		
		}//if문의 끝
		// 현재 위치 값(dir)을 가지고 절대경로로 만든다.
		String realPath = application.getRealPath("/members/"+dir); // 파일들을 검색할때는 무조건 절대경로를 사용해야 한다.
		
		// 절대경로를 만든 이유는 FIle객체를 생성하여 하위에 있는 파일 또는 디렉토리들을 얻기 위함이다.
		File s_file = new File(realPath); // 파일 객체를 생성하면서 절대경로로 얻은 값을 s_file에 넣어준다.
		File[] sub_list = s_file.listFiles(); // 파일의 모든정보가 필요 하므로 여기선 list()가 아닌 listFiles()를 사용한 것 이당
		for(File f : sub_list){
%>
			<tr>
				<td>
					<%if(f.isFile()){ %>
						<img src="../images/file.png"/>
					<%}else{ //폴더인 경우 %>
						<img src="../images/folder.png"/>
					<%} %>
				</td>
				<td>
				<%if(f.isDirectory()){ %>
					<a href="javascript: gogo('<%=f.getName()%>')"> <!-- ''치지않으면 변수로 인식하기 때문에 안에 있는 내용을 보내준다 그러기 때문에 문자열로 지정해서 이름을 보내준다. -->
						<%=f.getName() %>
					</a>
				<%} else { // 파일인 경우 %>
					<a href="javascript:down('')">
						<%=f.getName() %>
					</a>
				<%} %>
				</td>
				<td></td>
			</tr>
<%
	}//반복문의끝
%>
		</tbody>
	</table>
	
	<form name="ff" method="post" >
		<input type="hidden" name="f_name"/><%-- 선택된 폴더 명 --%>
		<input type="hidden" name="cPath" value="<%=dir%>"/><%-- dir이 현재 위치 값이다. --%>
	</form>
	
	
	<div id="f_win">
		<form action="makeFolder.jsp" method="post" name="frm">
			<input type="hidden" name="cPath" value="<%=dir%>"/>
			<label for="f_name">폴더명:</label>
			<input type="text" id="f_name" name="f_name"/><br/>
			<p class="btn">
				<a href="javascript:newFolder()">
					만들기
				</a>
			</p>
			<p class="btn">
				<a href="javascript:closeWin()">
					닫 기
				</a>
			</p>
		</form>
	</div>
	

	<div id="f_win2">
	<!-- 파일첨부가 되는 폼은 반드시 enctype에 multipart/form-data로 지정되어야한다 -->
		<form action="upload.jsp" method="post" name="frm2"
		enctype="multipart/form-data">
			
			<label for="selectFile">첨부파일:</label>
			<input type="file" id="selectFile" 
				name="upload"/><!--type-file이 파일선택기이다!!  --><br/>
				
			<p class="btn">
				<a href="javascript:upload()">
					보내기
				</a>
			</p>
			<p class="btn">
				<a href="javascript:closeWin2()">
					닫 기
				</a>
			</p>
		</form>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script>
		function gogo(fname){
			//alert(fname);
			// 현재문서 (document)에 이름은 ff인 form객체를 검색한다.
			// 검색된 form 개체 안에 이름이 f_name인 요소의 값으로 인자로 받은 폴더명을 넣어준다.
			document.ff.f_name.value = fname;
			
			// 현재문서에 이름이 ff인 form의 서버 경로를 myDisk.jsp로 설정한다.
			document.ff.action = "myDisk.jsp";
			document.ff.submit(); // 현재페이지 다시 로드한다.
			
			// 다음은 Get방식으로 호출하는 형태이다.
			//location.href = "myDisk.jsp?cPath=<%=dir%>&f_name="+fname;
		}
		function makeFolder(){
			// 현재 문서에서 아이디가 f_win인 요소를 보여준다.
			document.getElementById("f_win").style.display = "block";
		}
		function closeWin(){
			
			document.getElementById("f_win").style.display = "none";
		}
		function newFolder(){
			// 만들기 버튼을 눌렀을때!!!
			
			//유효성 검사부터 시작
			var id = $("#f_name").val();
			
			if(id.trim().length <= 0){
				alert("폴더명을 입력해주세요.");
				$("#f_name").val("");
				$("#f_name").focus();
				return;
			}
			// 유효성 검사를 완료 했으면 makeFolder.jsp로 보내자.
			document.frm.submit(); // 보내기
		}
		function selectFile(){
			$("#f_win2").css("display","block");
			//$("#selectFile").val("test.txt");  이와 같이 file선택이에 특정 파일을 지정하는 것은 보안성 절대 안되는 것 이다.
		}
		function closeWin2(){
			$("#f_win2").css("display","none");
		}
		function upload() {
			// 파일선택기에서 선택된 파일의 값을 가져온다.
			var select_file = document.frm2.upload.value;
			
			//alert(select_file);
			if(select_file.trim().length < 1){
				alert("파일을 선택해주세요");
				return;
			}
			document.frm2.submit(); // 서버로 보낸다. (upload.jsp)
		}
	</script>
</body>
</html>
<%
	}else{
		// 로그인을 하지 않은 경우
%>
	<script>
		parent.location.href = "../index.jsp"; // 현재페이지는 폴더안에 있기때문에 상대경로로 위치를 지정해줘야지 화면을 넘어갈 수 있다.
	</script>
<%
	}// if문의 끝
%>

