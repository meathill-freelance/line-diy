package com.meathill.diy.model 
{
  import com.meathill.diy.model.vo.SingleStepConfig;
	/**
   * ...
   * @author Meathill
   */
  public class ClothModel 
  {
    private var store:Object;
    private var _step:uint;
    private var _steps:Vector.<SingleStepConfig>
    private var _template:uint;
    private var _templates:Vector.<String>;
    private var _assets:Object;
    
    public function get step():uint {
      return _step;
    }
    public function set step(value:uint):void {
      _step = value;
    }
    public function get steps():Vector.<SingleStepConfig> {
      return _steps;
    }
    public function get templates():Vector.<String> {
      return _templates;
    }
    public function get assets():Object {
      return _assets;
    }
    
    public function get template():uint {
      return _template;
    }
    public function set template(value:uint):void {
      _template = value;
    }
    
    
    public function parse(data:String):void {
      store = JSON.parse(data);
      _steps = new Vector.<SingleStepConfig>;
      for (var i:uint = 0, len:uint = store.steps.length; i < len; i++) {
        _steps.push(new SingleStepConfig(store.steps[i]));
      }
      _templates = new Vector.<String>();
      for (i = 0, len = store.templates.length; i < len; i++) {
        _templates.push(store.templates[i]);
      }
      
      _assets = store.assets;
      
    }
    
    
  }

}