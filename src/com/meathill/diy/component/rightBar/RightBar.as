package com.meathill.diy.component.rightBar 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.component.PrimaryButton;
  import com.meathill.diy.component.SuccessButton;
  import com.meathill.diy.event.UserEvent;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
	
	/**
   * ...
   * @author Meathill
   */
  public class RightBar extends Sprite {
    private var saveButton:Button;
    private var buyButton:Button;
    private var receipt:Receipt;
    
    public function RightBar() {
      layout();
    }
    
    private function layout():void {
      saveButton = new PrimaryButton('保存', 'save', 120);
      saveButton.addEventListener(MouseEvent.CLICK, saveButton_clickHandler);
      addChild(saveButton);
      
      buyButton = new SuccessButton('购买', 'shoppingCart', 120);
      buyButton.y = 50;
      buyButton.addEventListener(MouseEvent.CLICK, buyButton_clickHandler);
      addChild(buyButton);
      
      receipt = new Receipt(120);
      receipt.y = 95;
      addChild(receipt);
    }
    
    private function buyButton_clickHandler(e:MouseEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.BUY);
      dispatchEvent(event);
    }
    private function saveButton_clickHandler(e:MouseEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.SAVE);
      dispatchEvent(event);
    }
    
  }

}