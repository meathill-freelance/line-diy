package com.meathill.diy
{
  import com.meathill.diy.config.AppConfig;
  import com.meathill.diy.config.GUIConfig;
	import flash.display.Sprite;
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
			// entry point
      Security.allowDomain('*');
      _context = new Context();
      _context.install(MVCSBundle);
      _context.configure(AppConfig, GUIConfig);
      _context.configure(new ContextView(this));
		}

	}

}