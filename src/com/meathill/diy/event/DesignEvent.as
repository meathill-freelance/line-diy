package com.meathill.diy.event 
{
  import flash.display.Sprite;
  import flash.events.Event;
  
  /**
   * ...
   * @author Meathill
   */
  public class DesignEvent extends Event 
  {
    public static const SELECT_COLOR:String = "select_color";
    static public const SET_SQUAD_NUMBER:String = "set_squad_number";
    static public const SET_TEAM_NAME:String = "set_team_name";
    
    private var _piece:uint;
    private var _color:uint;
    private var _color2:uint;
    private var _number:uint;
    private var _style:uint;
    private var _font:String;
    private var _teamname:String;
    
    public function DesignEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
      super(type, bubbles, cancelable);
      
    } 
    
    public function get color():uint {
      return _color;
    }
    public function set color(value:uint):void {
      _color = value;
    }
    public function get color2():uint {
      return _color2;
    }
    public function set color2(value:uint):void {
      _color2 = value;
    }
    public function get piece():uint {
      return _piece;
    }
    public function set piece(value:uint):void {
      _piece = value;
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
    public function get font():String {
      return _font;
    }
    public function set font(value:String):void {
      _font = value;
    }
    public function get teamname():String {
      return _teamname;
    }
    public function set teamname(value:String):void {
      _teamname = value;
    }
    
    
    public override function clone():Event {
      var event:DesignEvent = new DesignEvent(type, bubbles, cancelable);
      event.color = _color;
      event.piece = _piece;
      event.number = _number;
      event.style = _style;
      return event;
    } 
    
    public override function toString():String { 
      return formatToString("DesignEvent", "type", "bubbles", "cancelable", "eventPhase"); 
    }
    
  }
  
}