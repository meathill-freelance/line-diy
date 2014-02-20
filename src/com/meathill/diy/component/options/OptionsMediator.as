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
      addContextListener(UserEvent.GO_TO_STEP, user_gotoStepHandler);
    }
    
    private function user_gotoStepHandler(e:UserEvent):void {
      view.showStepButtons(e.step > 0, e.step < cloth.steps.length);
    }
    
  }

}