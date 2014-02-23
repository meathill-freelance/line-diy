package com.meathill.diy.mediator 
{
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.view.Preview;
  import flash.display.Sprite;
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
    
    override public function initialize():void {
      view.show(assets.templates[cloth.template]);
      
      addViewListener(MouseEvent.CLICK, view_clickHanaler);
      
      addContextListener(DesignEvent.SELECT_COLOR, color_changeHandler, DesignEvent);
      addContextListener(UserEvent.GO_TO_STEP, user_gotoStepHandler);
      addContextListener(UserEvent.SELECT_TPL, user_selectTemplateHandler);
    }
    
    
    private function user_gotoStepHandler(e:UserEvent):void {
      view.highlight(e.step);
    }
    private function user_selectTemplateHandler(e:UserEvent):void {
      view.show(assets.templates[e.template]);
    }
    private function view_clickHanaler(e:MouseEvent):void {
      var index:uint = Sprite(e.target).parent.getChildIndex(Sprite(e.target)),
          event:UserEvent = new UserEvent(UserEvent.GO_TO_STEP);
      event.step = index;
      dispatch(event);
    }
    private function color_changeHandler(e:DesignEvent):void {
      view.setColor(e.color, e.piece);
    }
    
  }

}