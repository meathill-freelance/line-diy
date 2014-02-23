package com.meathill.diy.component 
{
	/**
   * ...
   * @author Meathill
   */
  public class CustomRadiusButton extends Button 
  {
    private var lt:uint;
    private var rt:uint;
    private var lb:uint;
    private var rb:uint;
    
    public function CustomRadiusButton(label:String='button', lt:uint = 6, rt:uint = 6, lb:uint = 6, rb:uint = 6) {
			this.rb = rb;
      this.lb = lb;
      this.rt = rt;
      this.lt = lt;
      super(label);
    }
    
    override protected function draw(bg:uint, border:uint, width:uint, height:uint):void {
      graphics.beginFill(bg);
      graphics.lineStyle(0, border);
      graphics.drawRoundRectComplex(0.5, 0.5, width, height, lt, rt, lb, rb);
      graphics.endFill();
    }
  }

}