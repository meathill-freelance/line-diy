package com.meathill.diy.component.wizard 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class WizardMediator extends Mediator 
  {
    [Inject]
    public var view:Wizard;
    
    [Inject]
    public var cloth:ClothModel;
    
    override public function initialize():void {
      view.draw(cloth.steps);
      
      addViewListener(UserEvent.GO_TO_STEP, reDispatch);
    }
    
    private function reDispatch(e:UserEvent):void {
      var event:UserEvent = new UserEvent(e.type);
      event.step = e.step;
      dispatch(event);
    }
    
  }

}