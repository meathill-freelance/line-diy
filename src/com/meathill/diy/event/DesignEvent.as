package com.meathill.diy.event 
{
  import flash.display.Sprite;
  import flash.events.Event;
  
  /**
   * ...
   * @author Meathill
   */
  public class DesignEvent extends Event {
    public static const SELECT_COLOR:String = "select_color";
    static public const SET_SQUAD_NUMBER:String = "set_squad_number";
    static public const SET_TEAM_NAME:String = "set_team_name";
    
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
    
    private var _piece:uint;
    public function get piece():uint {
      return _piece;
    }
    public function set piece(value:uint):void {
      _piece = value;
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
    
    private var _font:String;
    public function get font():String {
      return _font;
    }
    public function set font(value:String):void {
      _font = value;
    }
    
    private var _teamname:String;
    public function get teamname():String {
      return _teamname;
    }
    public function set teamname(value:String):void {
      _teamname = value;
    }
    
    private var _isSync:Boolean;
    public function get isSync():Boolean {
      return _isSync;
    }
    public function set isSync(value:Boolean):void {
      _isSync = value;
    }
    
    public function DesignEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
      super(type, bubbles, cancelable);
      
    }
    
    public override function clone():Event {
      var event:DesignEvent = new DesignEvent(type, bubbles, cancelable);
      event.color = _color;
      event.color2 = _color2;
      event.piece = _piece;
      event.number = _number;
      event.style = _style;
      event.teamname = _teamname;
      event.font = _font;
      return event;
    } 
    
    public override function toString():String { 
      return formatToString("DesignEvent", "type", "bubbles", "cancelable", "eventPhase"); 
    }
    
  }
  
}