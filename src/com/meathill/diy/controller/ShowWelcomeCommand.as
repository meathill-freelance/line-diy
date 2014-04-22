package com.meathill.diy.controller 
{
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.view.WelcomeView;
  import flash.display.DisplayObject;
  import flash.display.Shape;
  import flash.display.Sprite;
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
    
    override public function execute():void {
      contextView.view.removeChildAt(0);
      contextView.view.addChild(new WelcomeView(contextView.view.stage.stageWidth));
    }
    
  }

}