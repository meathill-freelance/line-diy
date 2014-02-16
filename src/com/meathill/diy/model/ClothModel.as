package com.meathill.diy.model 
{
  import com.meathill.diy.model.vo.SingleStepConfig;
	/**
   * ...
   * @author Meathill
   */
  public class ClothModel 
  {
    private var _step:uint;
    private var store:Object;
    private var _steps:Vector.<SingleStepConfig>
    private var _templates:Array;
    
    public function ClothModel() 
    {
      
    }
    public function get step():uint {
      return _step;
    }
    public function set step(value:uint):void {
      _step = value;
    }
    
    public function get(key:String):* {
      return store[key];
    }
    
    public function parse(data:String):void {
      store = JSON.parse(data);
      _steps = new Vector.<SingleStepConfig>;
      for (var i:uint = 0, len:uint = store.steps.length; i < len; i++) {
        _steps.push(new SingleStepConfig(store.steps[i]));
      }
      _templates = store.templates;
    }
    
    public function get steps():Vector.<SingleStepConfig> {
      return _steps;
    }
    public function get templates():Array {
      return _templates;
    }
    
  }

}