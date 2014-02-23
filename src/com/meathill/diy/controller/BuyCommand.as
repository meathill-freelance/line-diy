package com.meathill.diy.controller 
{
  import com.meathill.diy.popup.PopupManager;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
   * ...
   * @author Meathill
   */
  public class BuyCommand extends Command 
  {
    [Inject]
    public var popupManager:PopupManager;
    
    override public function execute():void {
      
    }
    
  }

}