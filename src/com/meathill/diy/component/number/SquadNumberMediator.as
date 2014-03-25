package com.meathill.diy.component.number 
{
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.service.AssetsManager;
  import flash.display.Sprite;
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
    public var cloth:ClothModel
    
    [Inject]
    public var assets:AssetsManager;
    
    override public function initialize():void {
      view.asset = Sprite(assets.getAsset(view.config.asset));
      
      addViewListener(DesignEvent.SET_SQUAD_NUMBER, squadNumber_changeHandler);
    }
    
    private function squadNumber_changeHandler(e:DesignEvent):void {
      dispatch(e.clone());
    }
  }

}