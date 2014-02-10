package com.meathill.diy.mediator 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.view.WelcomeView;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class WelcomeMediator extends Mediator 
  {
    [Inject]
    public var view:WelcomeView;
    
    override public function initialize(): void {
      addViewListener(UserEvent.START_DIY, dispatch);
    }
  }

}