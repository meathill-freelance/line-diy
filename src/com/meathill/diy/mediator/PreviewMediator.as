package com.meathill.diy.mediator 
{
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.view.Preview;
  import flash.events.MouseEvent;
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
    
    [Inject]
    public var assets:AssetsManager;
    
    private var curr:uint = 0;
    
    override public function initialize():void {
      view.show(assets.templates[curr]);
      
      addViewListener(MouseEvent.CLICK, view_clickHanaler);
      addContextListener(DesignEvent.SELECT_COLOR, color_changeHandler, DesignEvent);
    }
    
    private function view_clickHanaler(e:MouseEvent):void {
      
    }
    
    private function color_changeHandler(e:DesignEvent):void {
      view.setColor(e.color, e.piece);
    }
    
  }

}