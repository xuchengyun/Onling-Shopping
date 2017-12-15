<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<style type="text/css">
.right {text-align: right;
}
</style>
<link href="italics.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%@ page language="java" %>
    <%@ page import="java.sql.*" %>
         <%@ page import="java.sql.DriverManager.*" %>
<table width="993" height="102" border="0">
  <tr>
    <td width="251" height="96"><img src="head.png" width="251" height="88" alt="Logo" /></td>
    <td width="726" class="right">24X7 Customer Support - <a href="contact.jsp">Contact us</a> | <a href="main.jsp">Home</a> |
      <% if(session.getAttribute("uname")==null) {
			%>
      <a href="login.jsp">Login</a>
      <%} else {
				%>
      <a href="logout.jsp">Logout</a>
      <%}%></td>
  </tr>
</table>
<hr />
<p> Edit & <strong><span class="italics">Confirm</span></strong> your details below:</p>
<% 
       PreparedStatement ps;
        Connection conn;
        ResultSet rs= null;
       Class.forName("oracle.jdbc.driver.OracleDriver");
        conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","sizgooml");
      
         Statement st=conn.createStatement();
		 String sql = "SELECT * from register1 where mid=?"; 
		 ps = conn.prepareStatement (sql);
		 ps.setString(1,request.getParameter("mid"));
	 rs = ps.executeQuery (); 
	 while(rs.next())
	 {
%><form action="updatemem.jsp"><table width="473" height="138" border="1">
  <tr>
    <td width="92" height="33" align="right">Phone No.</td>
    <td width="365"><input type="text" name="phone" value=<%=rs.getString(6)%> /></td>
  </tr>
  <tr>
    <td align="right">Address:</td>
    <td><input type="text" size="120" name="address" value=<%=rs.getString(5)%> /></td>
  </tr>
</table>
<p> <input type="submit" value="Confirm" />
<input type="hidden" name="mid1" value=<%=rs.getString(2)%> />
<%}%>
</p>
</form>
</body>
</html>