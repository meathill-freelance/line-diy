package com.meathill.diy.controller 
{
	import robotlegs.bender.bundles.mvcs.Command;
  import robotlegs.bender.extensions.contextView.ContextView;
	
	/**
   * ...
   * @author Meathill
   */
  public class StartDiyCommand extends Command 
  {
    [Inject]
    public var contextView:ContextView;
    
    public function StartDiyCommand() 
    {
      super();
			
    }
    
  }

}