package com.meathill.diy.component.bottom 
{
  import com.meathill.diy.component.CustomRadiusButton;
  import com.meathill.diy.event.UserEvent;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
	/**
   * ...
   * @author Meathill
   */
  public class BottomButtonGroup extends Sprite
  {
    private var prevButton:CustomRadiusButton;
    private var nextButton:CustomRadiusButton;
    
    public function BottomButtonGroup() {
      draw();
    }
    
    private function draw():void {
      prevButton = new CustomRadiusButton('<', 6, 0, 6, 0);
      prevButton.addEventListener(MouseEvent.CLICK, prevButton_clickHandler);
      addChild(prevButton);
      
      nextButton = new CustomRadiusButton('>', 0, 6, 0, 6);
      nextButton.x = prevButton.width;
      nextButton.addEventListener(MouseEvent.CLICK, nextButton_clickHandler);
      addChild(nextButton);
    }
    
    
    private function prevButton_clickHandler(e:MouseEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.PREV_TPL);
      dispatchEvent(event);
    }
    private function nextButton_clickHandler(e:MouseEvent):void {
      var event:UserEvent = new UserEvent(UserEvent.NEXT_TPL);
      dispatchEvent(event);
    }
    
  }

}