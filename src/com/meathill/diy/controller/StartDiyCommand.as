package com.meathill.diy.controller 
{
  import com.meathill.diy.view.DIYView;
  import com.meathill.diy.view.WelcomeView;
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
    
    public function StartDiyCommand() 
    {
      super();
			
    }
    
    override public function execute():void {
      contextView.view.removeChildAt(0);
      
      var diy:DIYView = new DIYView();
      injector.map(DIYView).toValue(diy);
      contextView.view.addChild(diy);
    }
  }

}