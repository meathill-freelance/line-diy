package com.meathill.diy.controller 
{
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.DIYModel;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
   * ...
   * @author Meathill
   */
  public class SelectColorCommand extends Command 
  {
    [Inject]
    public var diy:DIYModel;
    
    [Inject]
    public var event:DesignEvent;
    
    override public function execute():void {
      diy.setValue('piece' + event.piece, event.color);
    }
  }

}