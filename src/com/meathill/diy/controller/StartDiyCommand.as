package com.meathill.diy.controller 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.view.DIYView;
  import com.meathill.diy.view.WelcomeView;
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
    
    override public function execute():void {
      contextView.view.removeChildAt(0);
      
      var diy:DIYView = new DIYView();
      injector.map(DIYView).toValue(diy);
      contextView.view.addChild(diy);
      
      var event:UserEvent = new UserEvent(UserEvent.GO_TO_STEP);
      eventDispatcher.dispatchEvent(event);
    }
  }

}