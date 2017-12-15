<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<style type="text/css">
.right {	text-align: right;
}
</style>
<link href="italics.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%@ page language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.DriverManager.*" %>
<%@ page import="java.util.*" %> 
<%@ page import="java.io.*" %>
<%@ page import="com.dao.Cart" %>
<%@ page import="java.text.*" %>
         <%   
        PreparedStatement ps;
        Connection conn;
        ResultSet rs= null, rs1= null, rs2= null;
         Class.forName("oracle.jdbc.driver.OracleDriver");
         conn=DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl","hang","Zy891110");        
         Statement st=conn.createStatement();
         String uname1=(String)session.getAttribute("uname"); 
         int uname = Integer.parseInt(uname1);
         Cart myCart = new Cart();
         myCart = (Cart) session.getAttribute("Cart");
         HashMap<String, Integer> items = myCart.getCartItems();
         
         for(String key: items.keySet()) {
       	  int output = items.get(key);
       	  String[] sArray = key.split("#");
       	  long product_id = Long.parseLong(sArray[0]);
          float price = Float.parseFloat(sArray[3]);
       	  String sql = "select * from corder where customer_id = ? and C_EAN =? and paid = 0";
       	  ps = conn.prepareStatement (sql);
       	  ps.setInt(1, uname);
       	  ps.setLong(2, product_id);
       	  rs1 =ps.executeQuery();
       	  if(!rs1.next()) {
       		 
       	String sql1 = "insert into corder(customer_id,c_EAN,amount,order_date,paid,shipped,order_price,total_price) values(?,?,?,?,?,?,?,?)";
        ps= conn.prepareStatement(sql1);
        int s = uname;
        long s1 = product_id;
        int s2 = output;
        String s3 = "04/17/2017";
        java.sql.Date date=new java.sql.Date(2017,4,17);
       
        
        int s4 = 0;
        int s5 = 0;
        float s6 = price;
        float s7 = price * output;
        ps.setInt(1,s);
        ps.setLong(2,s1);
        ps.setInt(3,s2);
        ps.setDate(4,date);
        ps.setInt(5,s4);
        ps.setInt(6,s5);
        ps.setFloat(7, s6);
        ps.setFloat(8, s7);
        int insertResult = ps.executeUpdate();
       	 } 
     }
         items.clear();
         session.setAttribute("Cart", myCart);
		 String sql = "SELECT * from customer where customer_id=?"; 
		 ps = conn.prepareStatement (sql); 
%> 
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
<%

  
 if(session.getAttribute("uname")!=null) {
	 session.setAttribute("product",request.getParameter("name"));
	 ps.setInt(1,uname);
	 rs = ps.executeQuery (); %>
	  <span class="italics"><strong></strong></span> you have successfully checked out <span class="italics"></span>
	 <p>Thanks for shopping with us. Your item will be delivered within 2-3 days</p>
     <%
	 while(rs.next())
	 { %>
</p>
<table width="981" height="108" border="0" cellspacing="0">
  <tr>
    <td width="134" height="29">&nbsp;</td>
    <td width="303" align="center"></td>
  </tr>
  <tr>
    <td height="29" align="right"><strong>email:</strong></td>
    <td><%=rs.getString("email")%></td>
  </tr>
</table>
<%}%>
<p>
<p>
  <%}
else {
	 session.setAttribute("product",request.getParameter("name"));%>
	Enter the following details:
</p>
<p>
<form action="orderconf.jsp">
<table width="450" height="142" border="0">
  <tr>
    <td width="92" height="33" align="right">Name:</td>
    <td width="342"><input type="text" name="name" size="30"/></td>
  </tr>
  <tr>
    <td height="32" align="right">Phone No.</td>
    <td><input type="text" name="phone" size="20"/></td>
  </tr>
  <tr>
    <td height="60" align="right">Address:</td>
    <td><input type="text" name="address" size="120"/></td>
  </tr>
</table>

</form>
</p>
<%}%>
</body>
</html>