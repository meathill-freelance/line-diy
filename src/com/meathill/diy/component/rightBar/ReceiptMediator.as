package com.meathill.diy.component.rightBar 
{
  import com.meathill.diy.event.SystemEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.model.ConfigModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	/**
   * ...
   * @author Meathill
   */
  public class ReceiptMediator extends Mediator {
    
    [Inject]
    public var view:Receipt;
    
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var config:ConfigModel;
    
    private var plusItems:Array;
    
    override public function initialize():void {
      view.draw(cloth.clothes);
      
      addContextListener(SystemEvent.SINGLE_COLOR, singleColorHandler);
      addContextListener(SystemEvent.DOUBLE_COLOR, doubleColorHandler);
    }
    private function doubleColorHandler(e:SystemEvent):void {
      if (plusItems) {
        return;
      }
      plusItems = view.addItem('双色', config.prices.doubleColor);
    }
    private function singleColorHandler(e:SystemEvent):void {
      view.removeItem(plusItems);
      plusItems = null;
    }
    
  }

}