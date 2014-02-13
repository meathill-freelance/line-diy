package com.meathill.diy.model 
{
	/**
   * ...
   * @author Meathill
   */
  public class ClothModel 
  {
    private var store:Object;
    
    public function ClothModel() 
    {
      
    }
    
    public function get(key:String):* {
      return store[key];
    }
    
    public function parse(data:String):void {
      store = JSON.parse(data);
    }
  }

}