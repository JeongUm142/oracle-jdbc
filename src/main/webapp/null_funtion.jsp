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
	
	/*
		select 이름, nvl(일분기, 0) from 실적;
	*/
		PreparedStatement nvl1Stmt = null;
   		ResultSet nvl1Rs = null;
		String nvl1Sql = "SELECT 이름, nvl(일분기, 0) 결과 FROM 실적";
		
		nvl1Stmt = conn.prepareStatement(nvl1Sql);
			System.out.println(nvl1Stmt + "<--nvl1Stmt");
		nvl1Rs = nvl1Stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> nvl1List = new ArrayList<HashMap<String, Object>>();
		while(nvl1Rs.next()) {
			HashMap<String, Object> n1 = new HashMap<String, Object>();
			n1.put("이름", nvl1Rs.getString("이름"));
			n1.put("결과", nvl1Rs.getString("결과"));
			nvl1List.add(n1);
		}
			System.out.println(nvl1List + "<--nvl1List");
	/*
		select 이름, nvl2(일분기, 'success', 'fail') from 실적;
	*/
		PreparedStatement nvl2Stmt = null;
		ResultSet nvl2Rs = null;
		String nvl2Sql = "SELECT 이름, nvl2(일분기, 'success', 'fail') 결과 FROM 실적";
		
		nvl2Stmt = conn.prepareStatement(nvl2Sql);
			System.out.println(nvl2Stmt + "<--nvl2Stmt");
		nvl2Rs = nvl2Stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> nvl2List = new ArrayList<HashMap<String, Object>>();
		while(nvl2Rs.next()) {
			HashMap<String, Object> n2 = new HashMap<String, Object>();
			n2.put("이름", nvl2Rs.getString("이름"));
			n2.put("결과", nvl2Rs.getString("결과"));
			nvl2List.add(n2);
		}
			System.out.println(nvl2List + "<--nvl2List");
	
	/*
		select 이름, nullif(사분기, 100) from 실적;
	*/
		PreparedStatement nvl3Stmt = null;
		ResultSet nvl3Rs = null;
		String nvl3Sql = "SELECT 이름, nullif(사분기, 100) 결과 FROM 실적";
		
		nvl3Stmt = conn.prepareStatement(nvl3Sql);
			System.out.println(nvl3Stmt + "<--nvl3Stmt");
			nvl3Rs = nvl3Stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> nvl3List = new ArrayList<HashMap<String, Object>>();
		while(nvl3Rs.next()) {
			HashMap<String, Object> n3 = new HashMap<String, Object>();
			n3.put("이름", nvl3Rs.getString("이름"));
			n3.put("결과", nvl3Rs.getString("결과"));
			nvl3List.add(n3);
		}
			System.out.println(nvl3List + "<--nvl3List");
	/*
		select 이름, coalesce(일분기, 이분기, 삼분기, 사분기) from 실적;
	*/
		PreparedStatement nvl4Stmt = null;
		ResultSet nvl4Rs = null;
		String nvl4Sql = "SELECT 이름, coalesce(일분기, 이분기, 삼분기, 사분기) 결과 FROM 실적";
		
		nvl4Stmt = conn.prepareStatement(nvl4Sql);
			System.out.println(nvl4Stmt + "<--nvl4Stmt");
		nvl4Rs = nvl4Stmt.executeQuery();
		
		ArrayList<HashMap<String, Object>> nvl4List = new ArrayList<HashMap<String, Object>>();
		while(nvl4Rs.next()) {
			HashMap<String, Object> n4 = new HashMap<String, Object>();
			n4.put("이름", nvl4Rs.getString("이름"));
			n4.put("결과", nvl4Rs.getString("결과"));
			nvl4List.add(n4);
		}
			System.out.println(nvl4List + "<--nvl4List");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container row">
<div class="row">
	<div class="col-sm-3">
		<h1>Nvl 1</h1>
		<table class="table table-bordered">
			<tr>
				<td>이름</td>
				<td>결과</td>
			</tr>
			
			<%
				for(HashMap<String, Object> n1 : nvl1List) {
			%>
				<tr>
					<td><%=(String)n1.get("이름")%></td>
					<td><%=(String)n1.get("결과")%></td>
				</tr>
			<%				
				}
			%>
		</table>
	</div>
<br>
	<div class="col-sm-3">
	<h1>Nvl 2</h1>
	<table class="table table-bordered">
		<tr>
			<td>이름</td>
			<td>결과</td>
		</tr>
		
		<%
			for(HashMap<String, Object> n2 : nvl2List) {
		%>
			<tr>
				<td><%=(String)n2.get("이름")%></td>
				<td><%=(String)n2.get("결과")%></td>
			</tr>
		<%				
			}
		%>
	</table>
	</div>
<br>
	<div class="col-sm-3">
	<h1>Null If</h1>
	<table class="table table-bordered">
		<tr>
			<td>이름</td>
			<td>결과</td>
		</tr>
		
		<%
			for(HashMap<String, Object> n3 : nvl3List) {
		%>
			<tr>
				<td><%=(String)n3.get("이름")%></td>
				<td><%=(String)n3.get("결과")%></td>
			</tr>
		<%				
			}
		%>
	</table>
	</div>
<br>
	<div class="col-sm-3">
	<h1>Coalesce</h1>
	<table class="table table-bordered">
		<tr>
			<td>이름</td>
			<td>결과</td>
		</tr>
		
		<%
			for(HashMap<String, Object> n4 : nvl4List) {
		%>
			<tr>
				<td><%=(String)n4.get("이름")%></td>
				<td><%=(String)n4.get("결과")%></td>
			</tr>
		<%				
			}
		%>
	</table>
	</div>
</div>
</div>
</body>
</html>