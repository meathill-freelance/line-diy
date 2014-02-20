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
    
    private var store:Object;
    
    public function DIYModel() {
      store = { };
    }
    
    public function get(key:String):* {
      return store[key];
    }
    public function set(vo:Object, options:Object):void {
      ObjectOperator.extend(store, vo);
      if (!options.silent) {
        eventDispatcher.dispatchEvent(new Event(Event.CHANGE));
      }
    }
    public function toJSON():void {
      return JSON.stringify(store);
    }
  }

}