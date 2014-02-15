package com.meathill.diy.model.vo 
{
	/**
   * ...
   * @author Meathill
   */
  public class SingleStepConfig 
  {
    private var _type:String;
    private var _title:String;
    private var _colors:Array;
    
    public function SingleStepConfig(src:Object) {
      _type = src.type;
      _title = src.title;
      _colors = src.colors
    }
    
    public function get type():String {
      return _type;
    }
    public function get title():String {
      return _title;
    }
    public function get colors():Array {
      return _colors;
    }
    
  }

}