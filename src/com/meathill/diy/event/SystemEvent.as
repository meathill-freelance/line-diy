package com.meathill.diy.event 
{
	import flash.events.Event;
	
	/**
   * ...
   * @author Meathill
   */
  public class SystemEvent extends Event 
  {
    public static const DATA_READY:String = 'data_ready';
    public static const ASSETS_READY:String = 'assets_ready';
    static public const SAVE_COMPLETE:String = "saveComplete";
    static public const SAVE_FAILED:String = "saveFailed";
    
    public function SystemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
    {
      super(type, bubbles, cancelable);
			
    }
    
  }

}