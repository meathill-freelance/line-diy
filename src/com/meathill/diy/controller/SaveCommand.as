package com.meathill.diy.controller 
{
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.model.DIYModel;
  import com.meathill.diy.popup.PopupManager;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
   * ...
   * @author Meathill
   */
  public class SaveCommand extends Command 
  {
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var diy:DIYModel;
    
    [Inject]
    public var popupManager:PopupManager;
    
    override public function execute():void {
      
    }
    
  }

}