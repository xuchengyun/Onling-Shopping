<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<style type="text/css">
.right {
	text-align: right;
}
#form1 {
	text-align: center;
}
.normal {
	text-align: left;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}
.unormal {
	font-family: Arial, Helvetica, sans-serif;
}
.center1 {	text-align: center;
}
</style>
</head>
<body>
<%@ page language="java" %>
  <%@ page import="java.sql.*" %>
  <%@ page import="java.sql.DriverManager.*" %>
<table width="993" height="330" border="0">
  <tr>
    <td width="205" height="89"><img src="head.png" width="251" height="88" alt="Logo" />
    <hr /></td>
    <td width="772"><table width="723" height="88" border="0">
      <tr>
        <td width="713" class="right">24X7 Customer Support - Contact us  | Home | 
        <% 
        String uname=(String)session.getAttribute("uname");
        if(uname==null) {
			%>
            <a href="login.jsp">Login</a> | <a href="register.jsp">Signup</a>
            <%} else {
				%>
                <a href="logout.jsp">Logout</a>
                <a>| Hello <%=session.getAttribute("name")%>!</a>
                <%}%>
                <%  
  int n=0;int n1=0;int n2=0;int n3=0;int n4=0;
  PreparedStatement ps;
  Connection con;
  ResultSet rs=null,rs4=null,rs1=null,rs2=null,rs3=null,rs5=null;
  Class.forName("oracle.jdbc.driver.OracleDriver");
try{
   con=DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl","hang","Zy891110");   
   Statement st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);

   ps=con.prepareStatement("select sum(total_price) sum from corder where customer_id = ?");
   ps.setString(1,uname);//uname=customer_id
   rs5=ps.executeQuery();
   System.out.println("user spent $");
   if(uname!=null&&rs5.next()&&rs5.getInt("sum")>0){
%>	   <a>you have spent $<%=rs5.getString("sum")%>!</a>
<%   }
   else if(uname!=null){ 
   %>
   <a>you have spent $0</a>
 <% }%>                 
                </td>
      </tr>
      <tr>
        <td><form id="form1" name="form1" method="post" action="search.jsp">
          <input name="search" type="text" id="search" size="60" />
          <label>
            <input type="submit" name="submit" id="button" value="Search" />
          </label>
        </form></td>
      </tr>
    </table>
    <hr /></td>
  </tr>
  
  
  <tr>
        <td valign="top" height="182"><table width="222" height="171" border="0">
          <tr>
            <td class="normal">CATEGORY</td>
          </tr>
          <tr>
            <td><form action="category.jsp">
            <input type="hidden" name="type" value="brand" /><input type="hidden" name="category" value="Books" /><input type="submit" value="Books" /></form></td>
          </tr>
          <tr>
            <td><form action="category.jsp">
            <input type="hidden" name="type" value="brand" /><input type="hidden" name="category" value="Automotive" /><input type="submit" value="Automotive" /></form></td>
          </tr>
          <tr>
            <td><form action="category.jsp">
            <input type="hidden" name="type" value="brand" /><input type="hidden" name="category" value="Phones" /><input type="submit" value="Phones" /></form></td>
          </tr>
          <tr>
            <td height="22"><form action="category.jsp">
            <input type="hidden" name="type" value="brand" /><input type="hidden" name="category" value="Movies" /><input type="submit" value="Movies" /></form></td>
          </tr>
          <tr>
            <td><form action="category.jsp">
            <input type="hidden" name="type" value="brand" /><input type="hidden" name="category" value="Electronics" /><input type="submit" value="Electronics" /></form></td>
          </tr>
          <tr>
            <td><form action="category.jsp">
            <input type="hidden" name="type" value="brand" /><input type="hidden" name="category" value="House" /><input type="submit" value="House" /></form></td>
          </tr>
        </table></td>

    
    
     
    
    
    <td><table width="725" height="684" border="0">
    
    
    
    
    
      <tr class="normal">
        <td height="30">NEW ARRIVALS</td>
      </tr>
      
      
      <tr>
        <td height="261"><table width="714" height="258" border="0">
          <tr>
            
            
 <%    
 ps=con.prepareStatement("select * from (select COMMODITY.EAN EAN,title,SELLING_PRICE,PURCHASING_PRICE,AMOUNT,IMAGE,CATEGORY from COMMODITY,CATEGORY where COMMODITY.EAN=CATEGORY.EAN order by COMMODITY.purchasing_date desc) where rownum<=3");
 rs=ps.executeQuery();
 System.out.println("new arrivals");
 while(rs.next()){
 %>           
            <td width="228"><table width="120" height="173" border="0" align="center">
              <tr>
                <td><form action="product.jsp"> 
                <input type="hidden" name="product_id" value=<%=rs.getString("EAN")%>>
      			<input type="hidden" name="category" value=<%=rs.getString("category")%>> 
      			<input name="buy" type="image" value="Image" src=<%=rs.getString("image")%> width="114" height="165">
</form></td>
              </tr>
            </table>
              <p class="center1"><%=rs.getString("title")%></p>
              <p class="center1">PRICE: $<%=rs.getString("selling_price")%></p>
            </td>
            
            
            
 <%} %>
            
          </tr>
        </table></td>
      </tr>
      
  
  
   
      <tr class="normal">
        <td height="30">SALE & CLEARANCE</td>
      </tr>
      
      
      <tr>
        <td height="261"><table width="714" height="258" border="0">
          <tr>
            
            
 <%    
 ps=con.prepareStatement("select * from (select COMMODITY.EAN EAN,selling_price, purchasing_price, title,selling_price/purchasing_price rate, category.category category, image from COMMODITY, category where category.EAN = COMMODITY.EAN order by rate ASC)where rownum<4");
 rs4=ps.executeQuery();
 System.out.println("SALE & CLEARANCE");
 while(rs4.next()){
 %>           
            <td width="228"><table width="120" height="173" border="0" align="center">
              <tr>
                <td><form action="product.jsp"> 
                <input type="hidden" name="product_id" value=<%=rs4.getString("EAN")%>>
      			<input type="hidden" name="category" value=<%=rs4.getString("category")%>> 
      			<input name="buy" type="image" value="Image" src=<%=rs4.getString("image")%> width="114" height="165">
</form></td>
              </tr>
            </table>
              <p class="center1"><%=rs4.getString("title")%></p>
              <%double num=1.25*rs4.getDouble("purchasing_price");
              String s1=new String();
              s1=String.format("%.2f",num); 
              System.out.println("sales ");%>
              <p class="center1">OLD PRICE: $ <%=s1%> </p>
              <p class="center1">NEW PRICE: $ <%=rs4.getString("selling_price")%></p>
            </td>
            
            
            
 <%} %>
            
          </tr>
        </table></td>
      </tr>
      
        
      
      <tr class="normal">
        <td height="31">CLASSICAL COMMODITY</td>
      </tr>
      
        
      <tr>
        <td height="261"><table width="714" height="258" border="0">
          <tr>
            
            
 <%    
 ps=con.prepareStatement("select * from (select COMMODITY.EAN EAN,TITLE,PURCHASING_PRICE,SELLING_PRICE,AMOUNT,IMAGE,CATEGORY from COMMODITY,CATEGORY where COMMODITY.EAN=CATEGORY.EAN order by COMMODITY.purchasing_date asc) where rownum<=3");
 rs1=ps.executeQuery();
 System.out.println("CLASSICAL COMMODITY");
 while(rs1.next()){
 %>           
            <td width="228"><table width="120" height="173" border="0" align="center">
              <tr>
                <td><form action="product.jsp">
                <input type="hidden" name="product_id" value=<%=rs1.getString("EAN")%>>
      <input type="hidden" name="category" value=<%=rs1.getString("category")%>> 
      <input name="buy" type="image" value="Image" src=<%=rs1.getString("image")%> width="114" height="165"> 

</form></td>
              </tr>
            </table>
              <p class="center1"><%=rs1.getString("title")%></p>
              <p class="center1">PRICE: $<%=rs1.getString("selling_price")%></p>
            </td>           
 <%} %>
          </tr>
        </table></td>
      </tr>  
      <tr class="normal">
        <td height="27">BESTSELLING COMMODITY</td>
      </tr>
          
      <tr>
        <td height="261"><table width="714" height="258" border="0">
          <tr>
            
            
 <%    
 ps=con.prepareStatement("select EAN, selling_price, title, description, image, order_sum, category from(select CORDER.c_EAN EAN, COMMODITY.selling_price selling_price, COMMODITY.title title, COMMODITY.description description, COMMODITY.IMAGE image, sum(CORDER.amount)as order_sum, Category.category category from CORDER, COMMODITY, category where CORDER.c_EAN = COMMODITY.EAN and CATEGORY.EAN = COMMODITY.EAN group by (CORDER.c_EAN, COMMODITY.selling_price, COMMODITY.title, COMMODITY.description, COMMODITY.IMAGE, category.CATEGORY)order by order_sum DESC)where rownum < 4");
 rs2=ps.executeQuery();
 System.out.println("a");
 while(rs2.next()){
 %>           
            <td width="228"><table width="120" height="173" border="0" align="center">
              <tr>
                <td><form action="product.jsp">
                <input type="hidden" name="product_id" value=<%=rs2.getString("EAN")%>>
      <input type="hidden" name="category" value=<%=rs2.getString("category")%>> 
      <input name="buy" type="image" value="Image" src=<%=rs2.getString("image")%> width="114" height="165">
</form></td>
              </tr>
            </table>
              <p class="center1"><%=rs2.getString("title")%></p>
              <p class="center1">PRICE: $<%=rs2.getString("selling_price")%></p>
              <p class="center1">SELLING AMOUNT:<%=rs2.getString("order_sum")%></p>
            </td>
            
            
            
 <%} %>
          </tr>
        </table></td>
      </tr>
  
      <tr class="normal">
        <td height="27">LOW PRICE COMMODITY</td>
      </tr>
          
      <tr>
        <td height="261"><table width="714" height="258" border="0">
          <tr>
            
            
 <%    
 ps=con.prepareStatement("select * from (select COMMODITY.EAN EAN,title,PURCHASING_PRICE,SELLING_PRICE,AMOUNT,IMAGE,CATEGORY from COMMODITY,CATEGORY where COMMODITY.EAN=CATEGORY.EAN order by selling_price asc) where rownum<=3");
 rs3=ps.executeQuery();
 System.out.println("a");
 while(rs3.next()){
 %>           
            <td width="228"><table width="120" height="173" border="0" align="center">
              <tr>
                <td><form action="product.jsp"><input type="hidden" name="product_id" value=<%=rs3.getString("EAN")%>>
      <input type="hidden" name="category" value=<%=rs3.getString("category")%>> 
      <input name="buy" type="image" value="Image" src=<%=rs3.getString("image")%> width="114" height="165">
</form></td>
              </tr>
            </table>
              <p class="center1"><%=rs3.getString("title")%></p>
              <p class="center1">PRICE: $<%=rs3.getString("selling_price")%></p>
            </td>
            
            
            
 <%} %>
            
            
            
            
          </tr>
        </table></td>
      </tr>
      
      
      
      
    </table>
  </td>
<%
ps=con.prepareStatement("select count(*) total from  Commodity");
rs1=ps.executeQuery();
if(rs1.next()) n1=rs1.getInt("total");
System.out.println(n1);

ps=con.prepareStatement("select count(*) total from  Customer");
rs2=ps.executeQuery();
if(rs2.next()) n2=rs2.getInt("total");
System.out.println(n2);

ps=con.prepareStatement("select count(*) total from  CORDER");
rs3=ps.executeQuery();
if(rs3.next()) n3=rs3.getInt("total");
System.out.println(n3);

ps=con.prepareStatement("select count(*) total from  CATEGORY");
rs4=ps.executeQuery();
if(rs4.next()) n4=rs4.getInt("total");
System.out.println(n4);
n=n1+n2+n3+n4;
%>  
    
 <%}catch (Exception ex) { 
		ex.printStackTrace(); 
  } finally { 
  	if (rs!=null&&rs1!=null&&rs2!=null) { 
  		try { 
  			rs.close(); 
  			rs = null;
  			rs1.close(); 
  			rs1 = null;
  			rs2.close(); 
  			rs2 = null;
  			rs3.close(); 
  			rs3 = null;
  			rs4.close(); 
  			rs4 = null;
  		} catch (Exception ex) { 
  			ex.printStackTrace(); 		
  		} 
  	}
  	
  }

%>   
    
  </tr>
</table>

<p>"total tuples:"<%=n%></p>

</body>
</html>
