package com.meathill.diy.config {
  import com.meathill.diy.component.wizard.Wizard;
  import com.meathill.diy.component.wizard.WizardMediator;
  import com.meathill.diy.controller.ShowWelcomeCommand;
  import com.meathill.diy.controller.StartDiyCommand;
  import com.meathill.diy.event.SystemEvent;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.mediator.WelcomeMediator;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.service.ServerManager;
  import com.meathill.diy.view.Spinner;
  import com.meathill.diy.view.WelcomeView;
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
    public var mediatorMap:IMediatorMap;
    
    [Inject]
    public var commandMap:IEventCommandMap;
    
    [Inject]
    public var eventDispatcher:IEventDispatcher;
    
    [Inject]
    public var contextView:ContextView;
    
    private var server:ServerManager;
    private var cloth:ClothModel;
    
    public function configure():void {
      server = new ServerManager();
      cloth = new ClothModel();
      
      injector.map(ClothModel).toValue(cloth);
      injector.map(ServerManager).toValue(server);
      
      commandMap.map(SystemEvent.READY).toCommand(ShowWelcomeCommand);
      commandMap.map(UserEvent.START_DIY).toCommand(StartDiyCommand);
      
      mediatorMap.map(WelcomeView).toMediator(WelcomeMediator);
      mediatorMap.map(Wizard).toMediator(WizardMediator);
      
      contextView.view.addChild(new Spinner());
      
      loadConfig();
    }
    
    private function loadConfig():void {
      server.add('../mocks/init.json', null, config_loadCompleteHandler);
    }
    
    private function config_loadCompleteHandler(data:String):void {
      cloth.parse(data);
      eventDispatcher.dispatchEvent(new SystemEvent(SystemEvent.READY));
    }
  }

}