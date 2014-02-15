package com.meathill.diy.event 
{
	import flash.events.Event;
	
	/**
   * ...
   * @author Meathill
   */
  public class UserEvent extends Event 
  {
    public static const START_DIY:String = "start_diy";
    public static const GO_TO_STEP:String = "go_to_step";
    
    private var _step:uint = 0;
    
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
  }

}