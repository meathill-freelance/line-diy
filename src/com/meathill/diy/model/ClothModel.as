package com.meathill.diy.model 
{
  import com.meathill.diy.model.vo.SingleStepConfig;
	/**
   * ...
   * @author Meathill
   */
  public class ClothModel {
    
    private var _step:uint;
    public function get step():uint {
      return _step;
    }
    public function set step(value:uint):void {
      _step = value;
    }
    
    private var _steps:Vector.<SingleStepConfig>
    public function get steps():Vector.<SingleStepConfig> {
      return _steps;
    }
    
    private var _templates:Vector.<String>;
    public function get templates():Vector.<String> {
      return _templates;
    }
    
    private var _template:uint;
    public function get template():uint {
      return _template;
    }
    public function set template(value:uint):void {
      _template = value;
    }
    
    private var _clothes:Vector.<Object>;
    public function get clothes():Vector.<Object> {
      return _clothes;
    }
    
    private var _sights:uint;
    public function get sights():uint {
      return _sights;
    }
    public function set sights(value:uint):void {
      _sights = value;
    }
    
    private var _seperator:uint;
    public function get seperator():uint {
      return _seperator;
    }
    public function set seperator(value:uint):void {
      _seperator = value;
    }
    
    private var _numParts:uint;
    public function get numParts():uint {
      return _numParts;
    }
    public function set numParts(value:uint):void {
      _numParts = value;
    }
    
    
    public function ClothModel() {
      _steps = new Vector.<SingleStepConfig>();
      _templates = new Vector.<String>();
      _clothes = new Vector.<Object>();
    }
    
    public function parse(store:Object):void {
      for (var i:uint = 0, len:uint = store.steps.length; i < len; i++) {
        _steps.push(new SingleStepConfig(store.steps[i]));
      }
      for (i = 0, len = store.templates.length; i < len; i++) {
        _templates.push(store.templates[i]);
      }
      _clothes.push(store);
    }
    
    
  }

}