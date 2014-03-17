package com.meathill.diy.model.vo 
{
  import flash.display.Sprite;
	/**
   * ...
   * @author Meathill
   */
  public class SingleStepConfig 
  {
    private var _color:uint;
    private var _number:uint;
    private var _type:String;
    private var _title:String;
    private var _colors:Array;
    private var _asset:String;
    private var _length:uint;
    private var _style:uint;
    
    public function SingleStepConfig(src:Object) {
      trace(JSON.stringify(src));
      _type = src.type;
      _title = src.title;
      _colors = src.colors
      _asset = src.asset;
      _length = src.length;
      _number = src.number;
      _style = src.style;
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
    
    public function get color():uint {
      return _color;
    }
    public function set color(value:uint):void {
      _color = value;
    }
    public function get number():uint {
      return _number;
    }
    public function set number(value:uint):void {
      _number = value;
    }
    public function get style():uint {
      return _style;
    }
    public function set style(value:uint):void {
      _style = value;
    }
    
  }

}