package com.meathill.diy.model.vo 
{
	/**
   * ...
   * @author Meathill
   */
  public class SingleStepConfig 
  {
    private var _type:String;
    
    public function SingleStepConfig(src:Object) {
      _type = src.type;
    }
    
    public function get type():String 
    {
      return _type;
    }
    
  }

}