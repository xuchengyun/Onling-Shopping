<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Commodity Details</title>
<style type="text/css">
.name {
	font-weight: bold;
	font-size: 36px;
}
.gnrl {
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
}
.center1 {
	text-align: center;
}
.center1 table {
	font-family: Arial, Helvetica, sans-serif;
	font-size: x-large;
	font-weight: bold;
}
normal {
	font-weight: normal;
}
normal {
	font-weight: normal;
}
normal {
	font-weight: normal;
}
normal {
	font-family: Arial, Helvetica, sans-serif;
}
.right {
	text-align: right;
}
.norm {
	font-family: Arial, Helvetica, sans-serif;
}
</style>
</head>

<body>
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
<p>
  <%@ page language="java" %>
        <%@ page import="java.sql.*" %>
         <%@ page import="java.sql.DriverManager.*" %>
  <%
		String pid=request.getParameter("product_id");
  		String cat=request.getParameter("category");
		String hname="Grand";
		 PreparedStatement ps;
        Connection con;
        ResultSet rs= null;
       Class.forName("oracle.jdbc.driver.OracleDriver");
        con=DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl","hang","Zy891110");
      
         Statement st=con.createStatement();
		ps=con.prepareStatement("select * from commodity where EAN=?");
		 ps.setString(1,pid);
		 rs=ps.executeQuery();
		 
		 %>		
				<a href="main.jsp">Home</a><%--  >> <a href="category.jsp?category=<%=cat%>&type=<%="brand"%>"><%=cat%></a> --%>
         <%
		 
		 
		 ps=con.prepareStatement("select * from commodity where EAN=?");
		 ps.setString(1,pid);
		 rs=ps.executeQuery();
		 while(rs.next())
		 {
		 %>
</p>
<table width="997" height="399" border="0">
  <tr>
    <td width="358" class="center1"><img src=<%=rs.getString("image")%> width="200" height="300" alt=hname/></td>
    <%}
    ps=con.prepareStatement("select * from commodity where EAN=?");
		 ps.setString(1,pid);
		 rs=ps.executeQuery();
		 while(rs.next())
		 {
		 %>
    <td width="623" class="center1"><table width="466" height="200" border="0">
      <tr>
        <td width="179" class="center1">Name :</td>
        <td width="277" class="normal"><%=rs.getString(4)%></td>
      </tr>
      
      <tr>
        <td class="center1">Price : $</td>
        <td><%=rs.getString(2)%></td>
      </tr>
      <tr>
        <td class="center1">Amount :</td>
        <td><%=rs.getInt(5)%></td>
      </tr>
      
      
    </table>
    <p>         	<form method="post" action="HelloServlet">
         				<input type="hidden" name="product_id" value=<%=pid%>>
         				<input type="hidden" name="cname" value=<%=rs.getString("title")%>>
         				<input type="hidden" name="image" value=<%=rs.getString("image")%>>
         				<input type="hidden" name="price" value=<%=rs.getString("Selling_price")%>>
      					<input type="image" src="tel-domain-buy-logo.jpg" name="buy" value="grand"> 
						<tr><td></td></td><input type="submit" value="Add to Cart"></td></tr>
					</form>
					<%}%>
</p></td>
  </tr>
</table>
</body>
</html>