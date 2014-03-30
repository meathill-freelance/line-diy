package com.meathill.diy.component 
{
  import flash.events.MouseEvent;
	/**
   * ...
   * @author Meathill
   */
  public class BottomButton extends PrimaryButton {
    private var isFirst:Boolean;
    private var isLast:Boolean;
    
    
    public function BottomButton(label:String='', icon:String='', isFirst:Boolean = false, isLast:Boolean = false) {
			this.isLast = isLast;
      this.isFirst = isFirst;
      super(label, icon);
      
    }
    
    override protected function createIcon():void {
      super.createIcon();
      icon.x += 3;
      icon.y += 3;
    }
    override protected function draw(bg:uint, border:uint, width:uint, height:uint, bgAlpha:Number = 1, hasBorder:Boolean = true):void {
      var lt:uint = isFirst ? 6 : 0;
      var lb:uint = isFirst ? 6 : 0;
      var rt:uint = isLast ? 6 : 0;
      var rb:uint = isLast ? 6 : 0;
      graphics.clear();
      graphics.beginFill(bg);
      graphics.drawRoundRectComplex(0, 0, 40, 40, lt, rt, lb, rb);
      graphics.endFill();
    }
  }

}