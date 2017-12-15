package com.runoob.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.dao.*;


/**
 * Servlet implementation class HelloServlet
 */
@WebServlet("/HelloServlet")
public class HelloServlet extends HttpServlet {
//    class Cart {
//	    HashMap<String, Integer> cartItems;
//	    public Cart(){
//	     cartItems = new HashMap<>();
//	      
//	    }
//	    public HashMap<String, Integer> getCartItems(){
//	        return cartItems;
//	    }
//	    public void addToCart(String itemId, int amount){
//	        cartItems.put(itemId, amount);
//	    }
//	     
//	}
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 使用 GBK 设置中文正常显示
		response.setCharacterEncoding("GBK");
		response.getWriter().write("菜鸟教程：http://www.runoob.com");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		
		HttpSession session = request.getSession();
		String param = request.getParameter("category");
		
		response.setContentType("text/html;charset=UTF-8");
		
		  // Set the response MIME type of the response message
		       response.setContentType("text/html");
		       // Allocate a output writer to write the response message into the network socket
		       Cart myCart = new Cart();
		       myCart = (Cart) session.getAttribute("Cart");
		       PrintWriter out = response.getWriter();
		       
		       if (myCart==null) {
		    	   myCart = new Cart();
		    	  session.setAttribute("Cart", myCart);
		    	  
		       }
		       String product_id = request.getParameter("product_id");
//		       out.println(product_id);
		       String cname = request.getParameter("cname");
		       String image = request.getParameter("image");
		       String price = request.getParameter("price");
		       String Big = product_id + "#" + cname + "#" + image + "#" + price;
		       
//		      out.println(Big);
		    
//		       request.getSession().getAttribute("myCart");
		       // Test if MAP has such an ID
		        if(!myCart.getCartItems().containsKey(Big)){
		    	   myCart.addToCart(Big, 1);
		        } else {
		           int count = (int) myCart.getCartItems().get(Big);
		           count = count + 1;
		           myCart.addToCart(Big, count);
		        }
		       // Session write back
		        session.setAttribute("Cart", myCart);
		        
		       // Write the response message, in an HTML page
		       try {
		    	  HashMap<String, Integer> items = myCart.getCartItems();
		    	  
		          out.println("<html>");
		          out.println("<head><title>Cart</title></head>");
		          out.println("<body>");
		          out.println("<table width='993' height='330' border='0'>");
		          out.println("<tr><td width='313' height='196'><img src='head.png' width='251' height='88 alt='Logo' />");
		          out.println("<hr/></td>");
		          out.println("<td width='826' class='right'>24X7 Customer Support - Contact us  |<a href='main.jsp'>Home</a> </td>");   
		          out.println("<h1></h1>");  // says Hello
		          // Echo client's request information
		          out.println("");
		          // Generate a random number upon each request
		          for(String key: items.keySet()) {
		        	  Integer output = items.get(key);
		        	  String[] sArray = key.split("#");

		        	  out.println("<table width='220' height='133' border='0' align='center'><tr><td width='599' height='105'><p align='Justify'>Cart Items:</p> <img src="+ sArray[2]+" ></td><td>name: "+sArray[1]+"  amount: "+ output+"</td></tr></table>");
		        	  
		          }
		          out.println("</body></html>");
		          out.println("<form action='buy.jsp'>Check Out<input type='hidden' name='product_id' value="+product_id+"><input type='submit' value='Check out'></form>");
		          
       } finally {
          out.close();  // Always close the output writer
       }
  
	}

}