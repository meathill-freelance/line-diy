package com.meathill.diy.popup.mediator 
{
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.model.ConfigModel;
  import com.meathill.diy.popup.view.HaibaoPopup;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.view.DIYView;
  import com.meathill.diy.view.Preview;
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
      view.colors = config.colors;
      view.haibao = assets.haibao;
      view.cloth = diy.getBitmapData();
    }
    
  }

}