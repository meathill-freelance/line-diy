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
  public class SetTeamNameCommand extends Command {
    
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var event:DesignEvent;
    
    override public function execute():void {
      var step:SingleStepConfig = cloth.steps[cloth.step];
      step.font = event.font;
      step.color = event.color;
      step.teamname = event.teamname;
    }
    
  }

}