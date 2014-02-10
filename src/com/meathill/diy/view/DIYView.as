package com.meathill.diy.view 
{
  import com.meathill.diy.component.Wizard;
	import flash.display.Sprite;
	
	/**
   * ...
   * @author Meathill
   */
  public class DIYView extends Sprite 
  {
    private var wizard:Wizard;
    private var preview:Preview;
    
    public function DIYView() 
    {
      super();
			layout();
    }
    
    private function layout():void 
    {
      wizard = new Wizard();
      addChild(wizard);
      
      preview = new Preview();
      preview.x = 200;
      preview.y = 200;
      addChild(preview);
    }
    
  }

}