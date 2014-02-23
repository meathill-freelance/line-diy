package com.meathill.diy.component.rightBar 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.popup.PopupManager;
  import com.meathill.diy.popup.view.BuyPopup;
  import com.meathill.diy.popup.view.SavePopup;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class RightBarMediator extends Mediator 
  {
    [Inject]
    public var popupManager:PopupManager;
    
    override public function initialize():void {
      addViewListener(UserEvent.BUY, user_buyHandler);
      addViewListener(UserEvent.SAVE, user_saveHandler);
    }
    
    private function user_buyHandler(e:UserEvent):void {
      popupManager.popup(new BuyPopup());
    }
    private function user_saveHandler(e:UserEvent):void {
      popupManager.popup(new SavePopup());
    }
    
  }

}