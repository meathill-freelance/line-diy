package com.meathill.diy
{
  import com.meathill.diy.config.AppConfig;
	import flash.display.Sprite;
	import flash.events.Event;
  import robotlegs.bender.bundles.mvcs.MVCSBundle;
  import robotlegs.bender.extensions.contextView.ContextView;
  import robotlegs.bender.framework.impl.Context;
  

	/**
	 * ...
	 * @author Meathill
	 */
	[Frame(factoryClass="com.meathill.diy.Preloader")]
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
			// entry point
      _context = new Context()
          .install(MVCSBundle)
          .configure(AppConfig)
          .configure(new ContextView(this));
		}

	}

}