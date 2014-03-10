package com.meathill.diy.model.vo 
{
  import flash.display.Sprite;
	/**
   * ...
   * @author Meathill
   */
  public class SingleStepConfig 
  {
    private var _curr:uint;
    private var _type:String;
    private var _title:String;
    private var _colors:Array;
    private var _asset:String;
    private var _length:uint;
    
    public function SingleStepConfig(src:Object) {
      _type = src.type;
      _title = src.title;
      _colors = src.colors
      _asset = src.asset;
      _length = src.length;
      _curr = src.curr;
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
    public function get asset():String {
      return _asset;
    }
    public function get length():uint {
      return _length;
    }
    public function get curr():uint {
      return _curr;
    }
    
  }

}