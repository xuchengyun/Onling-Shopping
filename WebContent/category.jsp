<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
  
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Commodity List</title>
<!------------------------------------------- CSS ------------------------------------------------->
<style type="text/css">
.right {text-align: right;
}
</style>
<link href="center.css" rel="stylesheet" type="text/css" />
</head>

<body>
  <%@ page language="java" %>
  <%@ page import="java.sql.*" %>
  <%@ page import="java.sql.DriverManager.*" %>
  <%@ page import="java.util.HashMap" %>
  <%!
  public int nullIntconv(String str)
  {   
  	int conv=0;
    if(str==null)
    {
        str="0";
    }
    else if((str.trim()).equals("null"))
    {
        str="0";
    }
    else if(str.equals(""))
    {
        str="0";
    }
    try{
        conv=Integer.parseInt(str);
    }
    catch(Exception e)
    {
    }
    return conv;
  }
%>

   <%!
   public class Cart {
	    HashMap<String, Integer> cartItems;
	    public Cart(){
	     cartItems = new HashMap<>();
	      
	    }
	    public HashMap getCartItems(){
	        return cartItems;
	    }
	    public void addToCart(String itemId, int price){
	        cartItems.put(itemId, price);
	    }
	     
   }
   %>

	<%/* int firstRow = 1;
		int rowCount = 11; */
		/*   if(nullIntconv(request.getParameter("firstRow")) != 1){
  	  		 firstRow=nullIntconv(request.getParameter("firstRow"));
 	  		 rowCount=nullIntconv(request.getParameter("rowCount"));
  			} else {
	   		 firstRow = 1;
	         rowCount = 11;
  			}
    */
    int firstRow ;
    int rowCount ;
    firstRow = 1;
    rowCount = 11;
   %>
  <!---------------------------------------- Background Format ---------------------------------------------->
  <table width="993" height="102" border="0">
  <tr>
    <td width="251" height="96"><img src="head.png" width="251" height="88" alt="Logo" /></td>
    <td width="726" class="right">24X7 Customer Support - <a href=" ">Contact us</a > | <a href="main.jsp">Home</a > |
      <% if(session.getAttribute("uname")==null) {
   %>
      <a href="login.jsp">Login</a >
      <%} else {
    %>
      <a href="logout.jsp">Logout</a >
      <%}%></td>
  </tr>
  </table><hr/>
<%
  int pageSize = 10;
  String cat=null;
  String category=request.getParameter("category");
  String type=request.getParameter("type");//brand
  %>
  
  
  <a href="main.jsp">Home</a> >><a><%=category%></a>
  
<!----------------------------------------- Form(verb) Products List ---------------------------------------------->  
<%  
  PreparedStatement ps;
  Connection con;
  ResultSet rs=null,rs1=null,rs2=null;
  Class.forName("oracle.jdbc.driver.OracleDriver");
  try{
   		con=DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl","hang","Zy891110");
        Statement st=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
      
  		if(type=="brand");//if it is one of category from previous jsp "main.jsp"
		{
/*    String SQL = "select * from category where category=?  and rownum between %d and %d";
 */   		ps=con.prepareStatement("select * from (select EAN,CATEGORY,rownum rm from category where rownum<=? and category=?) where  rm >= ?");
    		if(nullIntconv(request.getParameter("firstRow")) != 1 && nullIntconv(request.getParameter("firstRow")) != 0){
	  			firstRow=nullIntconv(request.getParameter("firstRow"));
	  			rowCount=nullIntconv(request.getParameter("rowCount"));
			} else {
	   			firstRow = 1;
	   			rowCount = 10;
			}
   				ps.setInt(1,rowCount);
   				ps.setString(2,category);
   				ps.setInt(3,firstRow);
  		}
  				rs=ps.executeQuery();
  %>
		
	
  <p><table width="992" height="179" border="1">
  <%while(rs.next())
   	 {%>
   	 
     	<tr>
    		<td width="185" height="173" class="center1">
    		<%  cat=rs.getString(1);
 				ps=con.prepareStatement("select * from commodity where EAN=?");
   				ps.setString(1,cat);
   				rs1=ps.executeQuery();
   		
   				while(rs1.next())
   				{%>
     			<table width="120" height="133" border="0" align="center">
              	<tr>
                	<td><form action="product.jsp"> 
      					<input type="hidden" name="product_id" value=<%=rs1.getString("EAN")%>>
      					<input type="hidden" name="category" value=<%=rs.getString("category")%>> 
      					<input name="buy" type="image" value="Image" src=<%=rs1.getString(7)%> width="73" height="105">
    				</form></td>
         		</tr>
         			<form method="post" action="HelloServlet">
         				<input type="hidden" name="product_id" value=<%=rs1.getString("EAN")%>>
         				<input type="hidden" name="cname" value=<%=rs1.getString("title")%>>
         				<input type="hidden" name="image" value=<%=rs1.getString("image")%>>
         				<input type="hidden" name="price" value=<%=rs1.getString("Selling_price")%>>
      					<input type="hidden" name="category" value=<%=rs.getString("category")%>>
						<tr><td></td></td><input type="submit" value="Add to Cart"></td></tr>
					</form>
              <%}%>
	</table>
            
            
				
            
         
            
            
            
   			<%  ps=con.prepareStatement("select * from commodity where EAN=?");
   				ps.setString(1,cat);//cat: commodity id
   				rs2=ps.executeQuery();
   				
   				while(rs2.next())
   				{%>
            </td>
                <td width="591">
                <p>ID：<%=rs2.getString(1)%> </p>
                <p>Name: <%=rs2.getString(4)%> </p >
                <p>Price: <%=rs2.getString(2)%> </p >
                <p>Amount: <%=rs2.getString(5)%> </p ></td>
          </tr>
     			<%}
  		}
  
  	// try{}结束
  	}catch (Exception ex) { 
			ex.printStackTrace(); 
  			} 
  	finally{ // 释放数据集对象 
  				if (rs!=null&&rs1!=null&&rs2!=null){ 
  					try { 
  						rs.close(); 
  						rs = null;
  						rs1.close(); 
  						rs1 = null;
  						rs2.close(); 	
  						rs2 = null;
  						} catch (Exception ex) { 
  						ex.printStackTrace(); 		
  				    	} 
  				 } // 释放语句对象 
  		   }%>
</table></p>


<a href="category.jsp?firstRow=<%=firstRow + 10%>&rowCount=<%=rowCount + 10%>&category=<%=category%>&type=<%=type%>">Next</a>  
<a href="category.jsp?firstRow=<%=firstRow - 10%>&rowCount=<%=rowCount - 10%>&category=<%=category%>&type=<%=type%>">Previous</a>

</body>
</html>