package com.meathill.diy.component.bottom 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
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
      addViewListener(UserEvent.PREV_TPL, user_prevTemplateHandler);
      addViewListener(UserEvent.NEXT_TPL, user_nextTemplateHandler);
    }
    
    
    private function user_prevTemplateHandler(e:UserEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.SELECT_TPL);
      event.template = cloth.template - 1 >= 0 ? cloth.template - 1 : cloth.sights - 1;
      dispatch(event);
    }
    private function user_nextTemplateHandler(e:UserEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.SELECT_TPL);
      event.template = cloth.template + 1 < cloth.sights ? cloth.template + 1 : 0;
      dispatch(event);
    }
    
    
  }

}