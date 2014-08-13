package com.meathill.diy.controller 
{
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.model.vo.SingleStepConfig;
  import flash.events.IEventDispatcher;
  import robotlegs.bender.bundles.mvcs.Command;
	
	/**
   * ...
   * @author Meathill
   */
  public class SetSquadNumberCommand extends Command 
  {
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var event:DesignEvent;
    
    [Inject]
    public var eventDispatcher:IEventDispatcher;
    
    override public function execute():void {
      var config:SingleStepConfig = cloth.getConfig(cloth.step);
      config.number = event.number;
      config.style = event.style;
      cloth.isChanged = true;
      
      if (event.isSync) {
        return;
      }
      
      // 找到其它的number，并触发其事件
      var step:uint = cloth.step;
      cloth.steps.forEach(function (config:SingleStepConfig, i:uint, steps:Vector.<SingleStepConfig>):void {
        if (config.type === 'number' && i !== step) {
          var anotherEvent:DesignEvent = new DesignEvent(DesignEvent.SET_SQUAD_NUMBER);
          anotherEvent.number = event.number;
          anotherEvent.style = config.style;
          anotherEvent.isSync = true;
          cloth.step = i;
          eventDispatcher.dispatchEvent(anotherEvent);
        };
      });
      cloth.step = step;
    }
    
  }

}