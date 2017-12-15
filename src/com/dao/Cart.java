package com.dao;

import java.util.HashMap;

public class Cart {
    HashMap<String, Integer> cartItems;
    public Cart(){
     cartItems = new HashMap<>();
      
    }
    public HashMap<String, Integer> getCartItems(){
        return cartItems;
    }
    public void addToCart(String itemId, int amount){
        cartItems.put(itemId, amount);
    }
     
}