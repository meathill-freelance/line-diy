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
    
    private var _store:Object;
    
    public function DIYModel() {
      _store = { };
    }
    
    public function get store():Object {
      return _store;
    }
    
    public function getValue(key:String):* {
      return _store[key];
    }
    public function setValue(vo:Object, options:Object):void {
      ObjectOperator.extend(_store, vo);
      if (!options.silent) {
        eventDispatcher.dispatchEvent(new Event(Event.CHANGE));
      }
    }
    
  }

}