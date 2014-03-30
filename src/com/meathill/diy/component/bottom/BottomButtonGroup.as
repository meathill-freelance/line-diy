package com.meathill.diy.component.bottom 
{
  import com.meathill.diy.component.BottomButton;
  import com.meathill.diy.event.UserEvent;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
	/**
   * ...
   * @author Meathill
   */
  public class BottomButtonGroup extends Sprite
  {
    private var prevButton:BottomButton;
    private var nextButton:BottomButton;
    
    public function BottomButtonGroup() {
      draw();
    }
    
    private function draw():void {
      prevButton = new BottomButton('', 'arrowLeft', true);
      prevButton.addEventListener(MouseEvent.CLICK, prevButton_clickHandler);
      addChild(prevButton);
      
      nextButton = new BottomButton('', 'arrowRight', false, true);
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