package com.meathill.diy.event 
{
  import flash.events.Event;
  
  /**
   * ...
   * @author Meathill
   */
  public class DesignEvent extends Event 
  {
    public static const SELECT_COLOR:String = "select_color";
    private var _piece:uint;
    private var _color:uint;
    
    public function DesignEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
      super(type, bubbles, cancelable);
      
    } 
    
    public function get color():uint {
      return _color;
    }
    public function set color(value:uint):void {
      _color = value;
    }
    public function get piece():uint {
      return _piece;
    }
    public function set piece(value:uint):void {
      _piece = value;
    }
    
    public override function clone():Event {
      var event:DesignEvent = new DesignEvent(type, bubbles, cancelable);
      event.color = _color;
      event.piece = _piece;
      return event;
    } 
    
    public override function toString():String { 
      return formatToString("DesignEvent", "type", "bubbles", "cancelable", "eventPhase"); 
    }
    
  }
  
}