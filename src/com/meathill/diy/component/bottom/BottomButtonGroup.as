package com.meathill.diy.component.bottom 
{
  import com.meathill.diy.component.BottomButton;
  import flash.display.Sprite;
	/**
   * ...
   * @author Meathill
   */
  public class BottomButtonGroup extends Sprite {
    public var prevButton:BottomButton;
    public var nextButton:BottomButton;
    public var upButton:BottomButton;
    public var downButton:BottomButton;
    
    public function draw(hasTwo:Boolean = false):void {
      var offset:uint = 0;
      
      prevButton = new BottomButton('', 'arrowLeft', true);
      addChild(prevButton);
      offset = prevButton.width;
      
      if (hasTwo) {
        upButton = new BottomButton('', 'arrowUp', false, false);
        upButton.x = prevButton.width;
        addChild(upButton);
        
        downButton = new BottomButton('', 'arrowDown', false, false);
        downButton.x = upButton.x + upButton.width;
        addChild(downButton);
        
        offset = downButton.x + upButton.width;
      }
      
      nextButton = new BottomButton('', 'arrowRight', false, true);
      nextButton.x = offset;
      addChild(nextButton);
      
      x = stage.stageWidth - width >> 1;
      y -= height + 20;
    }
    
  }

}