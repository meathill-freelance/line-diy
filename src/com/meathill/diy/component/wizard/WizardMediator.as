package com.meathill.diy.component.wizard 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
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
      view.highhight(0);
      dispatchStep(0);
      
      addViewListener(MouseEvent.CLICK, view_clickHandler);
      
      addContextListener(UserEvent.GO_TO_STEP, user_gotoStepHandler);
    }
    
    private function dispatchStep(step:uint):void {
      var event:UserEvent = new UserEvent(UserEvent.GO_TO_STEP);
      event.step = step;
      dispatch(event);
    }
    
    private function view_clickHandler(e:MouseEvent):void {
      if (e.target === view) {
        return;
      }
      var item:Item = Item(e.target),
          index:uint = view.getChildIndex(item);
      dispatchStep(index);
    }
    private function user_gotoStepHandler(e:UserEvent):void {
      view.highhight(e.step);
    }
  }

}