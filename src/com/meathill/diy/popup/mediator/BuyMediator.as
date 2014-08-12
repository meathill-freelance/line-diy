package com.meathill.diy.popup.mediator 
{
  import com.meathill.diy.event.SystemEvent;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.popup.view.BuyPopup;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class BuyMediator extends Mediator {
    
    [Inject]
    public var view:BuyPopup;
    
    [Inject]
    public var cloth:ClothModel;
    
    override public function initialize():void {
      if (cloth.id && !cloth.isChanged) {
        view.light(0);
      }
      
      addViewListener(UserEvent.CONFIRM, view_confirmHandler);
      addContextListener(SystemEvent.SAVE_COMPLETE, saveCompleteHandler);
      addContextListener(SystemEvent.ADDED_TO_CART, addedToCartHandler);
    }
    
    
    
    private function view_confirmHandler(e:UserEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.BUY);
      dispatch(event);
    }
    private function addedToCartHandler(e:SystemEvent):void {
      view.light(2);
    }
    private function saveCompleteHandler(e:SystemEvent):void {
      view.light(1);
    }
    
  }

}