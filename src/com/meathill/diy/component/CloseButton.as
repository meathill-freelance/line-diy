package com.meathill.diy.component 
{
  import flash.display.Shape;
	/**
   * ...
   * @author Meathill
   */
  public class CloseButton extends Button {
    
    override protected function createIcon():void {
      var icon:Shape = new Shape();
      icon.graphics.lineStyle(2, 0x666666);
      icon.graphics.moveTo(1, 1);
      icon.graphics.lineTo(9, 9);
      icon.graphics.moveTo(9, 1);
      icon.graphics.lineTo(1, 9);
      icon.x = 6;
      icon.y = 6;
      addChild(icon);
      this.icon = icon;
    }
    override protected function drawBG():void {
      buttonWidth = 21;
      buttonHeight = 21;
      draw(bgColor, borderColor, buttonWidth, buttonHeight, bgAlpha, hasBorder);
    }
    override protected function resetAttr():void {
      bgAlpha = 0;
      hoverBgAlpha = 1;
      hoverBgColor = 0xFFFFFF;
      hasBorder = hasHoverBorder = false;
      labelText = '';
    }
  }

}