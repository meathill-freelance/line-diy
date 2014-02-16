package com.meathill.diy.component.colorCard 
{
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.ClothModel;
  import flash.events.MouseEvent;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class ColorCardMediator extends Mediator 
  {
    [Inject]
    public var cloth:ClothModel;
    
    override public function initialize():void {
      addViewListener(MouseEvent.CLICK, view_clickHandler);
    }
    
    private function view_clickHandler(e:MouseEvent):void {
      var item:Item = Item(e.target);
      var event:DesignEvent = new DesignEvent(DesignEvent.SELECT_COLOR);
      event.color = item.color;
      event.piece = cloth.step;
      dispatch(event);
    }
    
  }

}