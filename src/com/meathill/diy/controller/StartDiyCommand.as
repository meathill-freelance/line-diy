package com.meathill.diy.controller 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.view.DIYView;
  import flash.display.Bitmap;
  import flash.events.IEventDispatcher;
  import robotlegs.bender.bundles.mvcs.Command;
  import robotlegs.bender.extensions.contextView.ContextView;
  import robotlegs.bender.framework.api.IInjector;
	
	/**
   * ...
   * @author Meathill
   */
  public class StartDiyCommand extends Command 
  {
    [Inject]
    public var contextView:ContextView;
    
    [Inject]
    public var injector:IInjector;
    
    [Inject]
    public var eventDispatcher:IEventDispatcher;
    
    [Inject]
    public var diy:DIYView;
    
    [Inject]
    public var assets:AssetsManager;
    
    override public function execute():void {
      contextView.view.removeChildAt(0);
      
      contextView.view.addChild(diy);
      diy.addBg(Bitmap(assets.getAsset('bg')));
      
      var event:UserEvent = new UserEvent(UserEvent.GO_TO_STEP);
      eventDispatcher.dispatchEvent(event);
    }
  }

}