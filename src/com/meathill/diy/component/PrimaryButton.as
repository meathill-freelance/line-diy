package com.meathill.diy.component 
{
	/**
   * ...
   * @author Meathill
   */
  public class PrimaryButton extends Button
  {
    
    public function PrimaryButton(label:String = 'Primary Button') 
    {
      super(label);
    }
    
    override protected function resetAttr():void {
      bgColor = 0x428bca;
      borderColor = 0x357ebd;
      hoverBgColor = 0x3276b1;
      hoverBorderColor = 0x285e8e;
      textFormat.color = 0xFFFFFF;
    }
  }

}