package com.meathill.diy.popup.mediator 
{
  import com.meathill.diy.popup.view.HaibaoPopup;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class HaibaoMediator extends Mediator {
    
    [Inject]
    public var view:HaibaoPopup;
    
    override public function initialize():void {
      view.preview();
    }
    
  }

}