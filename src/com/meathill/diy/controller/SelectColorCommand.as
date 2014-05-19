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
      trace('set color: ', event.piece, event.color.toString(16));
      cloth.steps[cloth.step].color = event.color;
    }
  }

}