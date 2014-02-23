package com.meathill.diy.component.footer 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.popup.PopupManager;
  import com.meathill.diy.popup.view.HaibaoPopup;
  import com.meathill.diy.popup.view.SharePopup;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class FooterMediator extends Mediator 
  {
    [Inject]
    public var popupManager:PopupManager;
    
    override public function initialize():void {
      addViewListener(UserEvent.HAIBAO, user_haibaoHandler);
      addViewListener(UserEvent.CONTRIBUTE, user_contributeHandler);
    }
    
    private function user_contributeHandler(e:UserEvent):void {
      popupManager.popup(new SharePopup());
    }
    private function user_haibaoHandler(e:UserEvent):void {
      popupManager.popup(new HaibaoPopup());
    }
    
  }

}