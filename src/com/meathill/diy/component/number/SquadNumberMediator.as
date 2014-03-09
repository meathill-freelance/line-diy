package com.meathill.diy.component.number 
{
  import com.meathill.diy.event.DesignEvent;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class SquadNumberMediator extends Mediator 
  {
    [Inject]
    public var view:SquadNumber;
    
    override public function initialize():void {
      addViewListener(DesignEvent.SET_SQUAD_NUMBER, dispatch);
    }
  }

}