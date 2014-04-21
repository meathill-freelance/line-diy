package com.meathill.diy.popup.view 
{
  import com.meathill.diy.popup.AbstractPopup;
	import flash.display.Sprite;
	
	/**
   * ...
   * @author Meathill
   */
  public class HaibaoPopup extends AbstractPopup
  {
    
    override protected function createContent():void {
      super.createContent();
    }
    override protected function resetAttr():void {
      title = '制作海报';
    }
  }

}