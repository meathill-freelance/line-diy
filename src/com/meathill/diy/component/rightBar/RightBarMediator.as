package com.meathill.diy.component.rightBar 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.popup.PopupManager;
  import com.meathill.diy.popup.view.BuyPopup;
  import com.meathill.diy.popup.view.SavePopup;
  import flash.events.MouseEvent;
  import flash.external.ExternalInterface;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class RightBarMediator extends Mediator {
    [Inject]
    public var popupManager:PopupManager;
    
    [Inject]
    public var view:RightBar;
    
    override public function initialize():void {
      addViewListener(MouseEvent.CLICK, view_clickHandler);
    }
    
    private function view_clickHandler(e:MouseEvent):void {
      switch (e.target) {
        case view.backButton:
          ExternalInterface.call('backToForm');
          break;
          
        case view.saveButton:
          popupManager.popup(new SavePopup());
          break;
          
        case view.buyButton:
          popupManager.popup(new BuyPopup());
          break;
      }
    }
    
  }

}