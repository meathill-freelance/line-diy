package com.meathill.diy.controller 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.service.ServerManager;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
	import robotlegs.bender.bundles.mvcs.Command;
  import robotlegs.bender.extensions.contextView.ContextView;
	
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
    
    [Inject]
    public var view:ContextView;
    
    override public function execute():void {
      var clothes:Array;
      if ('cloth' in view.view.loaderInfo.parameters) {
        clothes = view.view.loaderInfo.parameters.cloth.split(',');
      } else {
        clothes = ['football-t3', 'football-pants3'];
      }
      for (var i:uint = 0, len:uint = clothes.length; i < len; i++) {
        server.add(ServerManager.CLOTH + clothes[i] + '.json', null, cloth_loadCompleteHandler);
      }
      server.addEventListener(ServerManager.COMPLETE_ALL, completeAllHandler);
    }
    
    private function cloth_loadCompleteHandler(response:Object):void {
      cloth.parse(response);
      cloth.sights = response.templates.length;
    }
    private function assets_completeHandler(e:Event):void {
      assets.removeEventListener(Event.COMPLETE, assets_completeHandler);
      
      eventDispatcher.dispatchEvent(new UserEvent(UserEvent.START_DIY));
    }
    private function completeAllHandler(e:Event):void {
      server.removeEventListener(ServerManager.COMPLETE_ALL, completeAllHandler);
      assets.addEventListener(Event.COMPLETE, assets_completeHandler);
      for (var i:uint = 0, len:uint = cloth.templates.length; i < len; i++) {
        assets.add(AssetsManager.TEMPLATE, cloth.templates[i]);
      }
      assets.load();
    }
    
  }

}