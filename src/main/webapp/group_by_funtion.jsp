<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
	select department_id, job_id count(*) from employees
	group by department_id, job_id; 
	*/
	PreparedStatement rollStmt = null;
   	ResultSet rollRs = null;
	String rollSql = "SELECT department_id 何辑ID, job_id 流公ID, count(*) 何辑牢盔 FROM employees GROUP BY department_id, job_id";
	
	rollStmt = conn.prepareStatement(rollSql);
		System.out.println(rollStmt + "<--rollStmt");
	rollRs = rollStmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> rollList = new ArrayList<HashMap<String, Object>>();
	while(rollRs.next()) {
		HashMap<String, Object> r = new HashMap<String, Object>();
		r.put("何辑ID", rollRs.getInt("何辑ID"));
		r.put("流公ID", rollRs.getString("流公ID"));
		r.put("何辑牢盔", rollRs.getInt("何辑牢盔"));
		rollList.add(r);
	}
		System.out.println(rollList + "<--rollList");
	
	/*
	-- rollup()窃荐
	select department_id, job_id, count(*) from employees
	group by rollup(department_id, job_id);
	*/
	PreparedStatement roll2Stmt = null;
   	ResultSet roll2Rs = null;
	String roll2Sql = "SELECT department_id 何辑ID, job_id 流公ID, count(*) 何辑牢盔 FROM employees GROUP BY ROLLUP(department_id, job_id)";

	roll2Stmt = conn.prepareStatement(rollSql);
		System.out.println(roll2Stmt + "<--roll2Stmt");
	roll2Rs = rollStmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> rollList2 = new ArrayList<HashMap<String, Object>>();
	while(roll2Rs.next()) {
		HashMap<String, Object> r2 = new HashMap<String, Object>();
		r2.put("何辑ID", roll2Rs.getInt("何辑ID"));
		r2.put("流公ID", roll2Rs.getString("流公ID"));
		r2.put("何辑牢盔", roll2Rs.getInt("何辑牢盔"));
		rollList2.add(r2);
	}
		System.out.println(rollList2 + "<--rollList2");
	
	/*
	-- cube()窃荐
	select department_id, job_id, count(*) from employees
	group by cube(department_id, job_id);
	*/
	PreparedStatement cubeStmt = null;
   	ResultSet cubeRs = null;
	String cubeSql = "SELECT department_id 何辑ID, job_id 流公ID, count(*) 何辑牢盔 FROM employees GROUP BY ROLLUP(department_id, job_id)";

	cubeStmt = conn.prepareStatement(cubeSql);
		System.out.println(cubeStmt + "<--cubeStmt");
	cubeRs = rollStmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> cubeList = new ArrayList<HashMap<String, Object>>();
	while(cubeRs.next()) {
		HashMap<String, Object> c = new HashMap<String, Object>();
		c.put("何辑ID", cubeRs.getInt("何辑ID"));
		c.put("流公ID", cubeRs.getString("流公ID"));
		c.put("何辑牢盔", cubeRs.getInt("何辑牢盔"));
		cubeList.add(c);
	}
		System.out.println(cubeList + "<--cubeList");
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
<div class="container">
<div class="row">
	<div class="col-sm-4">
		<h1>GROUP BY</h1>
		<table class="table table-bordered">
			<tr>
				<td>何辑ID</td>
				<td>流公ID</td>
				<td>何辑牢盔</td>
			</tr>
			
			<%
				for(HashMap<String, Object> r : rollList) {
			%>
				<tr>
					<td><%=(Integer)(r.get("何辑ID"))%></td>
					<td><%=(String)(r.get("流公ID"))%></td>
					<td><%=(Integer)(r.get("何辑牢盔"))%></td>
				</tr>
			<%				
				}
			%>
		</table>
	</div>
<br>
	<div class="col-sm-4">
	<h1>GROUP BY ROLLUP</h1>
	<table class="table table-bordered">
		<tr>
			<td>何辑ID</td>
			<td>流公ID</td>
			<td>何辑牢盔</td>
		</tr>
		
		<%
			for(HashMap<String, Object> r2 : rollList2) {
		%>
			<tr>
				<td><%=(Integer)(r2.get("何辑ID"))%></td>
				<td><%=(String)(r2.get("流公ID"))%></td>
				<td><%=(Integer)(r2.get("何辑牢盔"))%></td>
			</tr>
		<%				
			}
		%>
	</table>
	</div>
<br>
	<div class="col-sm-4">
	<h1>CUBE</h1>
	<table class="table table-bordered">
		<tr>
			<td>何辑ID</td>
			<td>流公ID</td>
			<td>何辑牢盔</td>
		</tr>
		
		<%
			for(HashMap<String, Object> c : cubeList) {
		%>
			<tr>
				<td><%=(Integer)(c.get("何辑ID"))%></td>
				<td><%=(String)(c.get("流公ID"))%></td>
				<td><%=(Integer)(c.get("何辑牢盔"))%></td>
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