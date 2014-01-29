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
    
    public function UserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
    {
      super(type, bubbles, cancelable);
			
    }
    
  }

}