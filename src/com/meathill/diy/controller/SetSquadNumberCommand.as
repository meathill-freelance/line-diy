package com.meathill.diy.controller 
{
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.model.vo.SingleStepConfig;
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
    
    override public function execute():void {
      var step:SingleStepConfig = cloth.getConfig(cloth.step);
      step.number = event.number;
      step.style = event.style;
      cloth.isChanged = true;
    }
    
  }

}