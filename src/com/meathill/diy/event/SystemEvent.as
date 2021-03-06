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
    static public const SAVE_COMPLETE:String = "save_complete";
    static public const SAVE_FAILED:String = "save_failed";
    static public const DOUBLE_COLOR:String = "double_color";
    static public const SINGLE_COLOR:String = "single_color";
    static public const BUY_FAILED:String = "buy_failed";
    static public const ADDED_TO_CART:String = "added_to_cart";
    static public const NOT_LOGIN:String = "not_login";
    
    public function SystemEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
    }
    
    override public function clone():Event {
      return new SystemEvent(type, bubbles, cancelable);
    }
  }

}