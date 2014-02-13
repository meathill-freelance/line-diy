package com.meathill.diy.controller 
{
  import com.meathill.diy.view.WelcomeView;
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
    
    override public function execute():void {
      contextView.view.removeChildAt(0);
      contextView.view.addChild(new WelcomeView);
    }
    
  }

}