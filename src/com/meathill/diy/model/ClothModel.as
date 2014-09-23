package com.meathill.diy.model 
{
  import com.meathill.diy.model.vo.SingleStepConfig;
	/**
   * ...
   * @author Meathill
   */
  public class ClothModel {
    public var id:uint = 0;
    public var isChanged:Boolean = false;
    
    private var cloth1:Object;
    private var cloth2:Object;
    
    private var _step:uint;
    public function get step():uint {
      return _step;
    }
    public function set step(value:uint):void {
      _step = value;
    }
    
    private var _template:uint;
    public function get template():uint {
      return _template;
    }
    public function set template(value:uint):void {
      _template = value;
    }
    
    private var _sights:uint;
    public function get sights():uint {
      return _sights;
    }
    public function set sights(value:uint):void {
      _sights = value;
    }
    
    private var _numParts:uint;
    public function get numParts():uint {
      return _numParts;
    }
    
    private var _numSteps:uint = 0;
    public function get numSteps():uint {
      return _numSteps;
    }
    
    private var _clothes:Vector.<Object> = new Vector.<Object>();
    public function get clothes():Vector.<Object> {
      return _clothes;
    }
    
    public function get steps():Vector.<SingleStepConfig> {
      return cloth2 ? cloth1.steps.concat(cloth2.steps) : cloth1.steps;
    }
    public function get templates():Array {
      return cloth2 ? cloth1.templates.concat(cloth2.templates) : cloth1.templates;
    }
    public function get seperator():uint { 
      return cloth1.steps.length - 1;
    }
    
    public function parse(store:Object):void {
      var _steps:Vector.<SingleStepConfig> = new Vector.<SingleStepConfig>();
      for (var i:uint = 0, len:uint = store.steps.length; i < len; i++) {
        _steps.push(new SingleStepConfig(store.steps[i]));
      }
      store.steps = _steps;
      _numSteps += _steps.length;
      _numParts++;
      
      if (_numParts === 1) {
        cloth1 = store;
      } else {
        cloth2 = store;
      }
      
      _clothes.push(store);
    }
    
    public function getConfig(step:uint):SingleStepConfig {
      if (step > cloth1.steps.length - 1) {
        return cloth2.steps[step - cloth1.steps.length];
      }
      return cloth1.steps[step];
    }
    
    public function toJSON():String {
      return JSON.stringify([cloth1, cloth2]);
    }
    
    
  }

}