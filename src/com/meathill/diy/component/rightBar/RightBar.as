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
    public var saveButton:PrimaryButton;
    public var buyButton:SuccessButton;
    public var backButton:PrimaryButton;
    
    private var receipt:Receipt;
    
    public function RightBar() {
      layout();
    }
    
    private function layout():void {
      backButton = new PrimaryButton('重选款式', 'reply', 120);
      addChild(backButton);
      
      saveButton = new PrimaryButton('保存', 'save', 120);
      saveButton.y = 50;
      addChild(saveButton);
      
      buyButton = new SuccessButton('购买', 'shoppingCart', 120);
      buyButton.y = 100;
      addChild(buyButton);
      
      receipt = new Receipt(120);
      receipt.y = 145;
      addChild(receipt);
    }
    
  }

}