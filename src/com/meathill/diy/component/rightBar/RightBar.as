package com.meathill.diy.component.rightBar 
{
  import com.meathill.diy.component.Button;
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
      saveButton = new Button('保存');
      saveButton.addEventListener(MouseEvent.CLICK, saveButton_clickHandler);
      addChild(saveButton);
      
      buyButton = new Button('购买');
      buyButton.y = 60;
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