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
      dispatchStep(view.items[0], 0);
      
      addViewListener(MouseEvent.CLICK, view_clickHandler);
    }
    
    private function view_clickHandler(e:MouseEvent):void {
      var item:Item = Item(e.target),
          index:uint = view.getChildIndex(item);
      dispatchStep(item, index - 1);
    }
    private function dispatchStep(item:Item, step:uint):void {
      var event:UserEvent = new UserEvent(UserEvent.GO_TO_STEP);
      for (var i:uint = 0, len:uint = view.items.length; i < len; i++) {
        view.items[i].deactive();
      }
      item.active();
      event.step = step;
      dispatch(event);
    }
  }

}