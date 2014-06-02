package com.meathill.diy.controller 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ConfigModel;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.view.Spinner;
  import com.meathill.diy.view.welcome.WelcomeView;
  import flash.events.IEventDispatcher;
  import robotlegs.bender.bundles.mvcs.Command;
  import robotlegs.bender.extensions.contextView.ContextView;
	
	/**
   * ...
   * @author Meathill
   */
  public class ShowWelcomeCommand extends Command 
  {
    [Inject]
    public var contextView:ContextView;
    
    [Inject]
    public var assets:AssetsManager;
    
    [Inject]
    public var welcome:WelcomeView;
    
    [Inject]
    public var spinner:Spinner;
    
    [Inject]
    public var config:ConfigModel;
    
    [Inject]
    public var eventDispatcher:IEventDispatcher;
    
    override public function execute():void {
      if (contextView.view.contains(spinner)) {
        contextView.view.removeChild(spinner);
      }
      contextView.view.addChild(welcome);
      welcome.show(config.welcome, assets.welcome);
      welcome.addEventListener(UserEvent.SELECT_CLOTH, dispatch);
    }
    
    private function dispatch(e:UserEvent):void {
      eventDispatcher.dispatchEvent(e);
    }
    
  }

}