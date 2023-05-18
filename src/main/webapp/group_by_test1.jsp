<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
/*	
select 
	department_id 부서ID, 
	count(*) 부서인원,
	sum(salary) 급여합계,
	round(avg(salary)) 급여평균,
	max(salary) 최대급여,
	min(salary) 최소급여 --5
	from employees --1
	where department_id is not null --2 
	-- where절은 group by절보다 실행순서가 우선된다
	-- -> group by 집계함수 결과에 대한 조건을 필터링할 수 없다
	-- -> group by 집계함수 결과를 필터링하는 조건절이 필요 --> having
	group by department_id --3
	having count(*) > 1 --4
	order by count(*) desc; --6
*/
String driver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String dbuser = "hr";
String dbpw = "1234";
Class.forName(driver);
Connection conn = DriverManager.getConnection(dburl,dbuser, dbpw);
System.out.println(conn);

String sql = "SELECT department_id 부서ID, count(*) 부서인원, sum(salary) 급여합계, round(avg(salary)) 급여평균, max(salary) 최대급여, min(salary) 최소급여 FROM employees WHERE department_id is not null GROUP BY department_id having count(*) > 1 ORDER BY count(*) desc";
PreparedStatement stmt = conn.prepareStatement(sql);
System.out.println(stmt);
ResultSet rs = stmt.executeQuery();

ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
while(rs.next()) {
	HashMap<String, Object> m = new HashMap<String, Object>();
	m.put("부서ID", rs.getInt("부서ID"));
	m.put("부서인원", rs.getInt("부서인원"));
	m.put("급여합계", rs.getInt("급여합계"));
	m.put("급여평균", rs.getInt("급여평균"));
	m.put("최대급여", rs.getInt("최대급여"));
	m.put("최소급여", rs.getInt("최소급여"));
	list.add(m);
}
System.out.println(list);

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
	<h1>Employees table GROUP BY test</h1>
	<table>
		<tr>
			<td>부서ID</td>
			<td>부서인원</td>
			<td>급여합계</td>
			<td>급여평균</td>
			<td>최대급여</td>
			<td>최소급여</td>
		</tr>
		
		<%
			for(HashMap<String, Object> m : list) {
		%>
			<tr>
				<td><%=(Integer)(m.get("부서ID"))%></td>
				<td><%=(Integer)(m.get("부서인원"))%></td>
				<td><%=(Integer)(m.get("급여합계"))%></td>
				<td><%=(Integer)(m.get("급여평균"))%></td>
				<td><%=(Integer)(m.get("최대급여"))%></td>
				<td><%=(Integer)(m.get("최소급여"))%></td>
			</tr>
		<%				
			}
		%>
	</table>
</body>
</html>