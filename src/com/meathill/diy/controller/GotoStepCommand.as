package com.meathill.diy.controller 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.view.DIYView;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
   * ...
   * @author Meathill
   */
  public class GotoStepCommand extends Command 
  {
    [Inject]
    public var event:UserEvent;
    
    [Inject]
    public var cloth:ClothModel;
    
    override public function execute():void {
      cloth.step = event.step;
    }
    
  }

}