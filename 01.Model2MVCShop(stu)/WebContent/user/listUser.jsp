<%@ page contentType="text/html; charset=euc-kr" %>

<%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.service.user.vo.*" %>
<%@ page import="com.model2.mvc.common.*" %>

<%

	HashMap<String,Object> map=(HashMap<String,Object>)request.getAttribute("map"); 
	// request객체에서 map이라는 이름의 attribute를 가져와서 map 이라는 이름을 가지는 HashMap instance 생성
	SearchVO searchVO=(SearchVO)request.getAttribute("searchVO");
	// request객체에서 searchVO라는 이름의 attribute를 가져와서 SearchVO 형의 searchVO instance를 생성
	
	int total=0; // DAO상 total은 조회하여 얻은 table row의 수
	ArrayList<UserVO> list=null;	// UserVO형의 객체를 input 할 수 있는 ArrayList 생성하고 초기값 null 로 설정
	System.out.println("listUser.jsp 내의 map 확인출력 : "+map);
	if(map != null){	// 만약에 map 이 null 이면(map에 들어가있는 값이 없다면),
		total=((Integer)map.get("count")).intValue(); // total 은 map에서 "count" 라는 key의 value를 받아서 그것을 intValue를 리턴한 후 Integer로 형변환
		list=(ArrayList<UserVO>)map.get("list"); // list는 map에서 "list" 라는 key의 value를 받아서 그것을 'ArrayList객체로 들어가는 UserVO' 로 형변환
	}
	
	System.out.println("listUser.jsp 내의 ArratList에서의 'list'로 mapping된 값 출력 : "+list);
	
	int currentPage=searchVO.getPage(); // 아마도 currentPage는 현재페이지를 의미하고 이것은 searchVO객체의 page를 받아온다
	
	int totalPage=0; // totalPage를 0으로 초기화
	if(total > 0) { // total이 0보다 크면
		totalPage= total / searchVO.getPageUnit() ; 
		// totalPage는 total을 searchVO객체에서 pageUnit()을 받아온 값으로 나눈다. ==> ?? 어디서 받아오는가? 현재예상은 web.xml에 param-name & param-value=3
		if(total%searchVO.getPageUnit() >0) // 만약에 searchVO객체에서 pageUnit()으로 받아온 값으로 total을 나누었을때 나머지가 존재한다면,
			totalPage += 1; //totalPage는 나눈 몫에다가 1을 추가해준다. 
	}
	
	/*
	예를들어 list(list 객체는 ArrayList<UserVO>) 에 존재하는 전체 게시물(건) 수(total)가 100개라 하자. total = 100
	list 는 map 에서 "list"라는 key값을 ampping 된 value를 ArrayList에 input하는 UserVO
	totalPage = total / searchVO.getPageUnit() 아래 분모는 currentPage => totalPage = 100 / currentPage => 
	만약 currentPage 가 9라 하자. 그러면 위의 total%searchVO.getPageUnit()는 0이 아니다 나머지 연산자
	그럴때 totalPage에 1더해준다. 100 = 9*11 + 1 => 페이지당 9개 출력하면, 11페이지가 (몫)나오고 + 1페이지 가 나온다.
	*/
	
%>

<html>
<head>
<title>회원 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
function fncGetUserList(){
	document.detailForm.submit();
}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/listUser.do" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">회원 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
	<%
		if(searchVO.getSearchCondition() != null) {
	%>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
		<%
				if(searchVO.getSearchCondition().equals("0")){
		%>
				<option value="0" selected>회원ID</option>
				<option value="1">회원명</option>
		<%
				}else {
		%>
				<option value="0">회원ID</option>
				<option value="1" selected>회원명</option>
		<%
				}
		%>
			</select>
			<input 	type="text" name="searchKeyword"  value="<%=searchVO.getSearchKeyword() %>" 
							class="ct_input_g" style="width:200px; height:19px" >
		</td>
	<%
		}else{
	%>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0">회원ID</option>
				<option value="1">회원명</option>
			</select>
			<input type="text" name="searchKeyword"  class="ct_input_g" style="width:200px; height:19px" >
		</td>
	<%
		}
	%>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetUserList();">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >전체  <%= total%> 건수, 현재 <%=currentPage %> 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">이메일</td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<% 	
		int no=list.size();
		for(int i=0; i<list.size(); i++) {
			UserVO vo = (UserVO)list.get(i);
	%>
	<tr class="ct_list_pop">
		<td align="center"><%=no--%></td>
		<td></td>
		<td align="left">
			<a href="/getUser.do?userId=<%=vo.getUserId() %>"><%= vo.getUserId() %></a>
		</td>
		<td></td>
		<td align="left"><%= vo.getUserName() %></td>
		<td></td>
		<td align="left"><%= vo.getEmail() %>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<%
			int linkPage = 5; //페이지 수를 5개씩만 출력할 예정이다.			
			for(int i=0; i<=totalPage; i++){  //현재 totalPage = 7 : 회원 21 / 3 = 7 
			%>
				<%
				if(i > totalPage){%>
					<a href="/listUser.do?page=<%=i%>&searchKeyword=<%=searchVO.getSearchKeyword()%>&searchCondition=<%=searchVO.getSearchCondition()%>">이전</a>
				<%
				}
				while(i <= linkPage){ %>
					<a href="/listUser.do?page=<%=i%>&searchKeyword=<%=searchVO.getSearchKeyword()%>&searchCondition=<%=searchVO.getSearchCondition()%>">[<%=i %>]</a>
					<%i++;
				 }%>
				<%
				if(i < totalPage){
					while(i <= totalPage){	%>
						<a href="/listUser.do?page=<%=i%>&searchKeyword=<%=searchVO.getSearchKeyword()%>&searchCondition=<%=searchVO.getSearchCondition()%>">[<%=i %>]</a>
						<%
						i++;
					}%>
					<a href="/listUser.do?page=<%=i%>&searchKeyword=<%=searchVO.getSearchKeyword()%>&searchCondition=<%=searchVO.getSearchCondition()%>">다음</a>
				<%
				}
			}
			%>
				
			
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->
</form>
</div>

</body>
</html>