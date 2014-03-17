package com.meathill.diy.config {
  import com.meathill.diy.controller.BuyCommand;
  import com.meathill.diy.controller.GotoStepCommand;
  import com.meathill.diy.controller.PreloadAssetsCommand;
  import com.meathill.diy.controller.SaveCommand;
  import com.meathill.diy.controller.SelectColorCommand;
  import com.meathill.diy.controller.SelectTemplateCommand;
  import com.meathill.diy.controller.SetSquadNumberCommand;
  import com.meathill.diy.controller.ShowWelcomeCommand;
  import com.meathill.diy.controller.StartDiyCommand;
  import com.meathill.diy.event.DesignEvent;
  import com.meathill.diy.event.SystemEvent;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.popup.PopupManager;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.service.ServerManager;
  import flash.events.IEventDispatcher;
  import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
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
      injector.map(PopupManager).asSingleton();
      injector.map(AssetsManager).asSingleton();
      
      commandMap.map(SystemEvent.DATA_READY).toCommand(PreloadAssetsCommand);
      commandMap.map(SystemEvent.ASSETS_READY).toCommand(ShowWelcomeCommand);
      commandMap.map(UserEvent.START_DIY).toCommand(StartDiyCommand);
      commandMap.map(UserEvent.GO_TO_STEP).toCommand(GotoStepCommand);
      commandMap.map(UserEvent.SELECT_TPL).toCommand(SelectTemplateCommand);
      commandMap.map(UserEvent.SAVE).toCommand(SaveCommand);
      commandMap.map(UserEvent.BUY).toCommand(BuyCommand);
      commandMap.map(DesignEvent.SELECT_COLOR).toCommand(SelectColorCommand);
      commandMap.map(DesignEvent.SET_SQUAD_NUMBER).toCommand(SetSquadNumberCommand);
      
      loadConfig();
    }
    
    private function loadConfig():void {
      server.add(ServerManager.INIT, null, config_loadCompleteHandler);
    }
    
    private function config_loadCompleteHandler(data:String):void {
      cloth.parse(data);
      
      eventDispatcher.dispatchEvent(new SystemEvent(SystemEvent.DATA_READY));
    }
  }

}