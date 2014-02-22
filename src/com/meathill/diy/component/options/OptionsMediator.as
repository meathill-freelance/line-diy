package com.meathill.diy.component.options 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class OptionsMediator extends Mediator 
  {
    [Inject]
    public var view:Options;
    
    [Inject]
    public var cloth:ClothModel;
    
    override public function initialize():void {
      addViewListener(UserEvent.PREV, view_gotoPrevHandler);
      addViewListener(UserEvent.NEXT, view_gotoNextHandler);
      addContextListener(UserEvent.GO_TO_STEP, user_gotoStepHandler);
    }
    
    private function view_gotoPrevHandler(e:UserEvent):void {
      if (cloth.step > 0) {
        var event:UserEvent = new UserEvent(UserEvent.GO_TO_STEP);
        event.step = cloth.step - 1;
        dispatch(event);
      }
    }
    private function view_gotoNextHandler(e:UserEvent):void {
      if (cloth.step < cloth.steps.length -1) {
        var event:UserEvent = new UserEvent(UserEvent.GO_TO_STEP);
        event.step = cloth.step + 1;
        dispatch(event);
      }
    }
    
    private function user_gotoStepHandler(e:UserEvent):void {
      view.clear();
      view.show(cloth.steps[e.step]);
      view.showStepButtons(e.step > 0, e.step < cloth.steps.length - 1);
    }
    
  }

}