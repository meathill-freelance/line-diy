package com.meathill.diy.config {
  import com.meathill.diy.controller.StartDiyCommand;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.mediator.WelcomeMediator;
  import com.meathill.diy.view.WelcomeView;
	import flash.automation.Configuration;
  import robotlegs.bender.extensions.contextView.ContextView;
  import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
  import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
  import robotlegs.bender.framework.api.IInjector;
	
	/**
   * ...
   * @author Meathill
   */
  public class AppConfig extends Configuration {
    
    [Inject]
    public var injector:IInjector;
    
    [Inject]
    public var mediatorMap:IMediatorMap;
    
    [Inject]
    public var commandMap:IEventCommandMap;
    
    [Inject]
    public var contextView:ContextView;
    
    public function AppConfig() {
      super();
			
    }
    
    public function configure():void {
      commandMap.map(UserEvent.START_DIY).toCommand(StartDiyCommand);
      
      mediatorMap.map(WelcomeView).toMediator(WelcomeMediator);
      
      contextView.view.addChild(new WelcomeView);
    }
  }

}