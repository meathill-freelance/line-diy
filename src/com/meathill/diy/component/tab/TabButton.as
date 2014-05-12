package com.meathill.diy.component.tab 
{
  import com.meathill.diy.component.Button;
  import com.meathill.diy.filter.Filters;
	/**
   * ...
   * @author Meathill
   */
  public class TabButton extends Button 
  {
    
    public function TabButton(label:String='button', icon:String='', iconPos:uint=1) {
      super(label, icon, iconPos);
			
    }
    
    public function active():void {
      name = 'active';
      filters = [Filters.SUNKEN];
    }
    public function deactive():void {
      name = '';
      filters = null;
    }
    
    override protected function resetAttr():void {
      buttonWidth = 95;
      buttonHeight = 30;
    }
  }
}