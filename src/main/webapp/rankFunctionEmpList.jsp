<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbuser = "hr";
	String dbpw = "1234";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dburl,dbuser, dbpw);
		System.out.println(conn + "<--conn");
		
	//페이징
	int totalRow = 0; // 전체행
	
	//전체행을 구하는 쿼리
	PreparedStatement totalRowStmt = null;
	ResultSet totalRowRs = null;
	String totalRowSql = "SELECT count(*) FROM employees";
	totalRowStmt = conn.prepareStatement(totalRowSql);
		System.out.println(totalRowStmt + "<--pageStmt");
	totalRowRs = totalRowStmt.executeQuery();
	if(totalRowRs.next()){
		totalRow = totalRowRs.getInt("count(*)");
	}
	
	int currentPage = 1;// 현재
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10; // 페이지당 행 
	int beginRow = (currentPage-1) * rowPerPage + 1;  //페이지에서 시작행1, 11, 21...
	int endRow = beginRow + (rowPerPage - 1); //페이지에서 끝행 10, 20, 30...
	if(endRow > totalRow) { // endRow의 값이 totalRow보다 클 경우 - 즉, 마지막페이지에서 마지막행의 수
		endRow = totalRow;
	}	
	
	/* 급여순위 -> rownum -> 최종
		SELECT 번호, 아이디, 이름, 급여, 급여순위 
		FROM(SELECT rownum 번호, 아이디, 이름, 급여, 급여순위 
		FROM(SELECT employee_id 아이디, last_name 이름, salary 급여, RANK() OVER (ORDER BY salary DESC) 급여순위 FROM employees)) 
		WHERE 번호 BETWEEN ? AND ?"
	*/
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "SELECT 번호, 아이디, 이름, 급여, 급여순위 FROM(SELECT rownum 번호, 아이디, 이름, 급여, 급여순위 FROM(SELECT employee_id 아이디, last_name 이름, salary 급여, RANK() OVER (ORDER BY salary DESC) 급여순위 FROM employees)) WHERE 번호 BETWEEN ? AND ?";
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, beginRow);
	stmt.setInt(2, endRow);
		System.out.println(stmt + "<--stmt");
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> e = new HashMap<String, Object>();
		e.put("번호", rs.getInt("번호"));
		e.put("아이디", rs.getString("아이디"));
		e.put("이름", rs.getString("이름"));
		e.put("급여", rs.getInt("급여"));
		e.put("급여순위", rs.getInt("급여순위"));
		list.add(e);
	}
		System.out.println(list.size() + "<--list.size()");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- test -->
	<h1>RankFunctionEmpList</h1>
	<table border="1">
		<tr>
			<td>아이디</td>
			<td>이름</td>
			<td>급여</td>
			<td>급여순위</td>
		</tr>
		<%
			for(HashMap<String, Object> e : list) {
		%>
		<tr>
			
			<td><%=(String)e.get("아이디")%></td>
			<td><%=(String)e.get("이름")%></td>
			<td><%=(Integer)e.get("급여")%></td>
			<td><%=(Integer)e.get("급여순위")%></td>
		</tr>
		<%
			}
		%>
	</table>
	
	<!-- 페이징 -->
	<%
	int lastPage = totalRow / rowPerPage; //마지막페이지 - 전체행 / 페이지당행
	if(totalRow % rowPerPage != 0) {//마지막페이지 +1 -> 전체행 / 페이지당행에 나머지가 있을 경우 (ex.행이 101개인경우 1페이지 추가)
		lastPage = lastPage + 1;
	}

	int pagePerPageNum = 10;//페이지 당 보여지는 페이지 숫자(이전 1, 2, 3 ... )
	
	int minPageNum = (((currentPage -1) / pagePerPageNum) * pagePerPageNum) + 1; // 페이지숫자 중 제일 작은 숫자(1, 11, 21...)
	int maxPageNum = minPageNum + (pagePerPageNum - 1); // 페이지숫자 중 제일 큰 숫자(10, 20, 30...)
	if(maxPageNum > lastPage) {
		maxPageNum = lastPage;
	}
	
	if(minPageNum > 1) {//이전페이지는 두번째페이지부터 생성
	%>
		<a href="<%=request.getContextPath()%>/rankFunctionEmpList.jsp?currentPage=<%=minPageNum - pagePerPageNum%>">이전</a>
	<%
		}
		
	for(int i = minPageNum; i<=maxPageNum; i=i+1) {
		if(i == currentPage) { // 선택됐을 경우
	%>	
		<%=i%>
		
	<%
			}else { // 선택되지 않았을경우에는 A 태그
	%>	
		<span><a href="<%=request.getContextPath()%>/rankFunctionEmpList.jsp?currentPage=<%=i%>"><%=i%></a>&nbsp;</span>
	<%
					
			}
		}
		
	if(maxPageNum != lastPage) { // 페이지 숫자에 마지막 숫자와 마지막 페이지가 다를 경우
	%>
		<a href="<%=request.getContextPath()%>/rankFunctionEmpList.jsp?currentPage=<%=minPageNum + pagePerPageNum%>">다음</a>
	<%
		}
	%>
	
</body>
</html>