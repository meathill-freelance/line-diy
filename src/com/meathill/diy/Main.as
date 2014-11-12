package com.meathill.diy
{
  import com.meathill.diy.config.AppConfig;
  import com.meathill.diy.config.GUIConfig;
	import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
	import flash.events.Event;
  import flash.system.Security;
  import robotlegs.bender.bundles.mvcs.MVCSBundle;
  import robotlegs.bender.extensions.contextView.ContextView;
  import robotlegs.bender.framework.impl.Context;
  

	/**
	 * ...
	 * @author Meathill
	 */
  [SWF(width=1200, height=900)]
	public class Main extends Sprite 
	{
    private var _context:Context;

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
      stage.scaleMode = StageScaleMode.NO_SCALE;
      stage.align = StageAlign.TOP_LEFT;
      
			// entry point
      Security.allowDomain('*');
      _context = new Context();
      _context.install(MVCSBundle);
      _context.configure(AppConfig, GUIConfig);
      _context.configure(new ContextView(this));
		}

	}

}