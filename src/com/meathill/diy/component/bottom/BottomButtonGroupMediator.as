package com.meathill.diy.component.bottom 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import flash.events.MouseEvent;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class BottomButtonGroupMediator extends Mediator 
  {
    [Inject]
    public var view:BottomButtonGroup;
    
    [Inject]
    public var cloth:ClothModel;
    
    override public function initialize():void {
      view.draw(cloth.numParts > 1);
      addViewListener(MouseEvent.CLICK, view_clickHandler);
    }
    
    private function view_clickHandler(e:MouseEvent):void {
      var event:UserEvent;
      switch (e.target) {
        case view.prevButton:
          event = new UserEvent(UserEvent.SELECT_TPL);
          event.template = cloth.template - 1 >= 0 ? cloth.template - 1 : cloth.sights - 1;
          break;
          
        case view.nextButton:
          event = new UserEvent(UserEvent.SELECT_TPL);
          event.template = cloth.template + 1 < cloth.sights ? cloth.template + 1 : 0;
          break;
          
        case view.upButton:
          event = new UserEvent(UserEvent.SHOW_TOP);
          break;
          
        case view.downButton:
          event = new UserEvent(UserEvent.SHOW_PANTS);
          break;
      }
      dispatch(event);
    }
  }

}