package com.meathill.diy.component.rightBar 
{
  import com.meathill.diy.model.ClothModel;
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
    
    override public function initialize():void {
      var suit:Object = cloth.suit;
      var pieces:Array = [];
      for (var prop:String in suit) {
        pieces.push(suit[prop]);
      }
      view.draw(pieces);
    }
    
  }

}