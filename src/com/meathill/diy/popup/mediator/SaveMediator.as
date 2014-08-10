package com.meathill.diy.popup.mediator 
{
  import com.meathill.diy.event.SystemEvent;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.popup.view.SavePopup;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class SaveMediator extends Mediator {
    [Inject]
    public var view:SavePopup;
    
    override public function initialize():void {
      addViewListener(UserEvent.CONFIRM, confirmHandler);
      addContextListener(SystemEvent.SAVE_COMPLETE, saveCompleteHandler);
      addContextListener(SystemEvent.SAVE_FAILED, saveFailedHandler);
    }
    
    private function confirmHandler(e:UserEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.SAVE);
      event.name = view.desginName;
      dispatch(event);
    }
    private function saveCompleteHandler(e:SystemEvent):void {
      view.showSuccess();
    }
    private function saveFailedHandler(e:SystemEvent):void {
      view.showError();
    }
  }

}