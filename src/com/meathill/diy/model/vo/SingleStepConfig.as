package com.meathill.diy.model.vo 
{
  import flash.display.Sprite;
	/**
   * ...
   * @author Meathill
   */
  public class SingleStepConfig {
    private var _type:String;
    public function get type():String {
      return _type;
    }
    private var _asset:String;
    public function get asset():String {
      return _asset;
    }
    private var _length:uint;
    public function get length():uint {
      return _length;
    }
    
    private var _color:uint;
    public function get color():uint {
      return _color;
    }
    public function set color(value:uint):void {
      _color = value;
    }
    
    private var _color2:uint;
    public function get color2():uint {
      return _color2;
    }
    public function set color2(value:uint):void {
      _color2 = value;
    }
    
    private var _number:uint;
    public function get number():uint {
      return _number;
    }
    public function set number(value:uint):void {
      _number = value;
    }
    
    private var _style:uint;
    public function get style():uint {
      return _style;
    }
    public function set style(value:uint):void {
      _style = value;
    }
    
    private var _teamname:String;
    public function get teamname():String {
      return _teamname;
    }
    public function set teamname(value:String):void {
      _teamname = value;
    }
    
    private var _font:String;
    public function get font():String {
      return _font;
    }
    public function set font(value:String):void {
      _font = value;
    }
    
    private var _sight:uint;
    public function get sight():uint {
      return _sight;
    }
    
    private var _title:String;
    public function get title():String {
      return _title;
    }
    
    private var _colors:Array;
    public function get colors():Array {
      return _colors;
    }
    
    public function SingleStepConfig(src:Object) {
      trace(JSON.stringify(src));
      _type = src.type;
      _title = src.title;
      _color = parseInt(src.color, 16);
      _color2 = parseInt(src.color2, 16);
      _colors = src.colors;
      _asset = src.asset;
      _length = src.length;
      _number = src.number;
      _style = src.style;
      _teamname = src.teamname;
      _font = src.font;
      _sight = src.sight;
    }
  }
}