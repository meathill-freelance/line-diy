package com.meathill.diy.model 
{
  import com.meathill.diy.utils.ObjectOperator;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
	/**
   * ...
   * @author Meathill
   */
  public class DIYModel 
  {
    [Inject]
    public var eventDispatcher:IEventDispatcher;
    
    private var _squadNumber:uint;
    
    public function DIYModel() {
      
    }
    
    public function get squadNumber():uint {
      return _squadNumber;
    }
    public function set squadNumber(value:uint):void {
      _squadNumber = value;
    }
    
    public function getValue(key:String):* {
      return this[key];
    }
    public function setValue(key:String, value:*, options:Object = null):void {
      this[key] = value;
      if (options && !options.silent) {
        eventDispatcher.dispatchEvent(new Event(Event.CHANGE));
      }
    }
    
  }

}