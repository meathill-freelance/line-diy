package com.meathill.diy.controller 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
   * ...
   * @author Meathill
   */
  public class SelectTemplateCommand extends Command 
  {
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var event:UserEvent;
    
    override public function execute():void {
      cloth.template = event.template;
    }
    
  }

}