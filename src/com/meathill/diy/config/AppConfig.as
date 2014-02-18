package com.meathill.diy.config {
  import com.meathill.diy.controller.GotoStepCommand;
  import com.meathill.diy.controller.PreloadAssetsCommand;
  import com.meathill.diy.controller.ShowWelcomeCommand;
  import com.meathill.diy.controller.StartDiyCommand;
  import com.meathill.diy.event.SystemEvent;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.model.DIYModel;
  import com.meathill.diy.popup.PopupManager;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.service.ServerManager;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
  import robotlegs.bender.extensions.contextView.ContextView;
  import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
  import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
  import robotlegs.bender.framework.api.IConfig;
  import robotlegs.bender.framework.api.IInjector;
	
	/**
   * ...
   * @author Meathill
   */
  public class AppConfig implements IConfig {
    
    [Inject]
    public var injector:IInjector;
    
    [Inject]
    public var commandMap:IEventCommandMap;
    
    [Inject]
    public var eventDispatcher:IEventDispatcher;
    
    private var server:ServerManager;
    private var cloth:ClothModel;
    
    public function configure():void {
      server = new ServerManager();
      cloth = new ClothModel();
      
      injector.map(ClothModel).toValue(cloth);
      injector.map(ServerManager).toValue(server);
      injector.map(DIYModel).asSingleton();
      injector.map(PopupManager).asSingleton();
      injector.map(AssetsManager).asSingleton();
      
      commandMap.map(SystemEvent.DATA_READY).toCommand(PreloadAssetsCommand);
      commandMap.map(SystemEvent.ASSETS_READY).toCommand(ShowWelcomeCommand);
      commandMap.map(UserEvent.START_DIY).toCommand(StartDiyCommand);
      commandMap.map(UserEvent.GO_TO_STEP).toCommand(GotoStepCommand);
      
      loadConfig();
    }
    
    private function loadConfig():void {
      server.add('../mocks/init.json', null, config_loadCompleteHandler);
    }
    
    private function config_loadCompleteHandler(data:String):void {
      cloth.parse(data);
      
      eventDispatcher.dispatchEvent(new SystemEvent(SystemEvent.DATA_READY));
    }
  }

}