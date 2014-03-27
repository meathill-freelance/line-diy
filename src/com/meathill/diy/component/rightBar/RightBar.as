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
  public class RightBar extends Sprite 
  {
    private var saveButton:Button;
    private var buyButton:Button;
    
    public function RightBar() {
      draw();
			
    }
    
    private function draw():void {
      saveButton = new PrimaryButton('保存', 'save');
      saveButton.addEventListener(MouseEvent.CLICK, saveButton_clickHandler);
      addChild(saveButton);
      
      buyButton = new SuccessButton('购买', 'shoppingCart');
      buyButton.y = 50;
      buyButton.addEventListener(MouseEvent.CLICK, buyButton_clickHandler);
      addChild(buyButton);
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