package com.meathill.diy.mediator 
{
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.view.Preview;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class PreviewMediator extends Mediator 
  {
    [Inject]
    public var view:Preview;
    
    [Inject]
    public var cloth:ClothModel;
    
    private var curr:uint = 0;
    
    override public function initialize():void {
      view.show(cloth.templates[curr]);
      
      addContextListener(DesignEvent.SELECT_COLOR, color_changeHandler, DesignEvent);
    }
    
    private function color_changeHandler(e:DesignEvent):void {
      view.setColor(e.color, e.piece);
    }
    
  }

}