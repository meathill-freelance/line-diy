package com.meathill.diy.component.number 
{
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.model.DIYModel;
  import com.meathill.diy.service.AssetsManager;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class SquadNumberMediator extends Mediator 
  {
    [Inject]
    public var view:SquadNumber;
    
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var diy:DIYModel;
    
    [Inject]
    public var assets:AssetsManager;
    
    override public function initialize():void {
      view.asset = assets.getAsset(view.config.asset);
      
      addViewListener(DesignEvent.SET_SQUAD_NUMBER, squadNumber_changeHandler);
      
      // 显示默认号码
      if (view.config.curr !== diy.squadNumber) {
        var event:DesignEvent = new DesignEvent(DesignEvent.SET_SQUAD_NUMBER);
        event.number = cloth.steps[cloth.step].curr;
        dispatch(event);
      }
    }
    
    private function squadNumber_changeHandler(e:DesignEvent):void {
      diy.squadNumber = e.number;
      dispatch(e.clone());
    }
  }

}