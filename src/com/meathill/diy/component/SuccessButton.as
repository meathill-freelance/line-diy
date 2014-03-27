package com.meathill.diy.component 
{
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.utils.ColorMaker;
	/**
   * ...
   * @author Meathill
   */
  public class SuccessButton extends Button {
    
    public function SuccessButton(label:String = 'Success', icon:String = '') {
      super(label, icon);
    }
    
    override protected function resetAttr():void {
      bgColor = Colors.EMERALD;
      borderColor = ColorMaker.draken(bgColor, 5);
      hoverBgColor = ColorMaker.lighten(bgColor, 10);
      hoverBorderColor = ColorMaker.draken(bgColor, 10);
      textFormat.color = 0xFFFFFF;
    }
    
  }

}