package com.meathill.diy.controller 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.service.ServerManager;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
   * ...
   * @author Meathill
   */
  public class LoadClothDataCommand extends Command {
    
    [Inject]
    public var server:ServerManager;
    
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var assets:AssetsManager;
    
    [Inject]
    public var eventDispatcher:IEventDispatcher;
    
    override public function execute():void {
      server.add(ServerManager.CLOTH, null, cloth_loadCompleteHandler);
    }
    
    private function cloth_loadCompleteHandler(data:String):void {
      var clothData:Object = JSON.parse(data);
      cloth.parse(clothData);
      trace('cloth data loaded');
      
      assets.addEventListener(Event.COMPLETE, assets_completeHandler);
      for (var i:uint = 0, len:uint = cloth.templates.length; i < len; i++) {
        assets.add(AssetsManager.TEMPLATE, cloth.templates[i]);
      }
      assets.load();
    }
    private function assets_completeHandler(e:Event):void {
      assets.removeEventListener(Event.COMPLETE, assets_completeHandler);
      
      eventDispatcher.dispatchEvent(new UserEvent(UserEvent.START_DIY));
    }
    
  }

}