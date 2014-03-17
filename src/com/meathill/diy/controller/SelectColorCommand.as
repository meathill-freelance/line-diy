package com.meathill.diy.controller 
{
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.ClothModel;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
   * ...
   * @author Meathill
   */
  public class SelectColorCommand extends Command 
  {
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var event:DesignEvent;
    
    override public function execute():void {
      cloth.steps[event.piece].color = event.color;
    }
  }

}