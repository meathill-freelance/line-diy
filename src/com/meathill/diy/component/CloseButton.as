package com.meathill.diy.component 
{
  import flash.display.Shape;
	/**
   * ...
   * @author Meathill
   */
  public class CloseButton extends Button {
    
    public function CloseButton() {
      bgColor = 0;
      hoverBgAlpha = 0.6;
      hasBorder = hasHoverBorder = false;
      super('');
    }
    
    override protected function createIcon():void {
      icon = new Shape();
      icon.graphics.lineStyle(2, 0x666666);
      icon.graphics.moveTo(1, 1);
      icon.graphics.lineTo(9, 9);
      icon.graphics.moveTo(9, 1);
      icon.graphics.lineTo(1, 9);
      icon.x = 10;
      icon.y = 10;
      addChild(icon);
    }
    
  }

}