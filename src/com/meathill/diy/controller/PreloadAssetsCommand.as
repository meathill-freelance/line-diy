package com.meathill.diy.controller 
{
  import com.meathill.diy.event.SystemEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.service.AssetsManager;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
   * ...
   * @author Meathill
   */
  public class PreloadAssetsCommand extends Command 
  {
    [Inject]
    public var assets:AssetsManager;
    
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var eventDispatcher:IEventDispatcher;
    
    override public function execute():void {
      assets.addEventListener(Event.COMPLETE, completeHandler);
      
      for (var i:uint = 0, len:uint = cloth.templates.length; i < len; i++) {
        assets.add(AssetsManager.TEMPLATE, cloth.templates[i]);
      }
      assets.load();
    }
    
    private function completeHandler(e:Event):void {
      assets.removeEventListener(Event.COMPLETE, completeHandler);
      
      eventDispatcher.dispatchEvent(new SystemEvent(SystemEvent.ASSETS_READY));
    }
    
  }

}