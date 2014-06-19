package com.meathill.diy.component.bottom 
{
  import com.meathill.diy.component.BottomButton;
  import flash.display.Sprite;
	/**
   * ...
   * @author Meathill
   */
  public class BottomButtonGroup extends Sprite
  {
    public var prevButton:BottomButton;
    public var nextButton:BottomButton;
    public var upButton:BottomButton;
    public var downButton:BottomButton;
    
    public function BottomButtonGroup() {
      draw();
    }
    
    private function draw():void {
      prevButton = new BottomButton('', 'arrowLeft', true);
      addChild(prevButton);
      
      upButton = new BottomButton('', 'arrowUp', false, false);
      upButton.x = prevButton.width;
      addChild(upButton);
      
      downButton = new BottomButton('', 'arrowDown', false, false);
      downButton.x = upButton.x + upButton.width;
      addChild(downButton);
      
      nextButton = new BottomButton('', 'arrowRight', false, true);
      nextButton.x = downButton.x + downButton.width;
      addChild(nextButton);
    }
    
  }

}