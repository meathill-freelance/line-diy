package com.meathill.diy.mediator 
{
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ConfigModel;
  import com.meathill.diy.service.AssetsManager;
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
    
    [Inject]
    public var assets:AssetsManager;
    
    override public function initialize(): void {
      view.show(assets.welcome);
      addViewListener(UserEvent.START_DIY, dispatch);
    }
  }

}