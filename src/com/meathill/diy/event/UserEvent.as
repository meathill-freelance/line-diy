package com.meathill.diy.event 
{
	import flash.events.Event;
	
	/**
   * ...
   * @author Meathill
   */
  public class UserEvent extends Event {
    static public const SELECT_CLOTH:String = "select_cloth";
    public static const START_DIY:String = "start_diy";
    
    public static const GO_TO_STEP:String = "go_to_step";
    static public const NEXT_STEP:String = "next_step";
    static public const PREV_STEP:String = "prev_step";
    
    public static const SELECT_TPL:String = 'select_tpl';
    static public const NEXT_TPL:String = "nextTpl";
    static public const PREV_TPL:String = "prevTpl";
    
    static public const CONFIRM:String = "confirm";
    static public const BUY:String = "buy";
    static public const SAVE:String = "save";
    static public const HAIBAO:String = "haibao";
    static public const CONTRIBUTE:String = "contribute";
    
    private var _template:uint;
    private var _step:uint = 0;
    private var _name:String = '';
    
    public function UserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
    {
      super(type, bubbles, cancelable);
			
    }
    
    public function get step():uint {
      return _step;
    }
    public function set step(value:uint):void {
      _step = value;
    }
    
    public function get template():uint {
      return _template;
    }
    public function set template(value:uint):void {
      _template = value;
    }
    
    public function get name():String {
      return _name;
    }
    public function set name(value:String):void {
      _name = value;
    }
  }

}