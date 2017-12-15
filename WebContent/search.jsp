<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<style type="text/css">
@import url("italics.css");

.right {text-align: right;
}
<%-- <%HttpSession session = request.getSession();%> --%>
</style>
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
<%String search = request.getParameter ("search");%>
<p class="italics">Search Results:<%=search%></p>
<%search="%"+search+"%";%>

<% 
       PreparedStatement ps;
        Connection con;
        ResultSet rs= null,rs1=null,rs2=null;
       Class.forName("oracle.jdbc.driver.OracleDriver");
        con=DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl","hang","Zy891110");
      
         Statement st=con.createStatement();
%> 
<% 
boolean flag = false; 

%>
<% 
String pid=null; 
int amount=0;
try {
	ps = con.prepareStatement ("select count(*) nb from commodity where title like ?");
	ps.setString(1, search);
	rs2 = ps.executeQuery();
	
	while (rs2.next()) {
		amount = rs2.getInt("nb");
	}
	
} catch (Exception e) { 
	out.println (e); 
	}
%>
<p class="italics">total amount:<%=amount%></p>
<% 
try {  
ps = con.prepareStatement ("SELECT * from commodity where title like ?"); 
ps.setString (1,search); 
rs = ps.executeQuery (); 
if (rs.next ()) {
    flag = true;
%>	<p>
	<p><table width="992" height="179" border="0">
  <%do
		 {%>
         <tr>
    <td width="185" height="173" class="center1">
    <% pid=rs.getString(1);
	ps=con.prepareStatement("select * from commodity where EAN=?");
		 ps.setString(1,pid);
		 rs1=ps.executeQuery();
		 while(rs1.next())
		 {
			 %>
    <table width="120" height="133" border="0" align="center">
              <tr>
                <td><form action="product.jsp"> 
<input type="hidden" name="product_id" value=<%=rs1.getString("EAN")%>> 
<input name="buy" type="image" value="Image" src=<%=rs1.getString(7)%> width="73" height="105"> 
</form></td>
              </tr>
            
      </table>
                </td>
           <td width="791">
		   <p>title:<%=rs1.getString(4)%></p>
		   <p>amount:<%=rs1.getString(5)%></p>
		   <p>price:<%=rs1.getString(2)%></p></td></tr><%}}while(rs.next());%> 
</table> 

<%} else { 
%>
<jsp:forward page="searchfail.jsp"/> 
 <%
}
} catch (Exception e) { 
out.println (e); 
} %>
</p>
</body>
</html>