package com.meathill.diy.popup.mediator 
{
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.model.ConfigModel;
  import com.meathill.diy.popup.view.HaibaoPopup;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.view.DIYView;
  import com.meathill.diy.view.Preview;
  import flash.events.Event;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class HaibaoMediator extends Mediator {
    
    [Inject]
    public var view:HaibaoPopup;
    
    [Inject]
    public var diy:DIYView;
    
    [Inject]
    public var config:ConfigModel;
    
    [Inject]
    public var assets:AssetsManager;
    
    override public function initialize():void {
      if (assets.haibao.length === 0) {
        loadHaibaoAssets();
      } else {
        view.haibao = assets.haibao;
      }
      view.colors = config.colors;
      view.cloth = diy.getBitmapData();
    }
    
    private function loadHaibaoAssets():void {
      assets.addEventListener(Event.COMPLETE, haibao_loadHandler);
      for (var i:uint = 0, len:uint = config.haibao.length; i < len; i++) {
        assets.add(AssetsManager.HAIBAO, config.haibao[i]);
      }
      assets.load();
    }
    
    private function haibao_loadHandler(e:Event):void {
      view.haibao = assets.haibao;
    }
    
  }

}