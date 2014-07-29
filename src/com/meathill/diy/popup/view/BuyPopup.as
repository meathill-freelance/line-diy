package com.meathill.diy.popup.view 
{
  import com.meathill.diy.popup.AbstractPopup;
	import flash.display.Sprite;
	
	/**
   * ...
   * @author Meathill
   */
  public class BuyPopup extends AbstractPopup {
    private static var steps:Array = ['保存设计', '生成订单', '跳转页面'];
    
    public function BuyPopup() {
      super();
			
    }
    override protected function createContent():void {
      
    }
    override protected function resetAttr():void {
      title = '添加到购物车';
    } 
  }

}