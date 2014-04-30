package com.meathill.diy.component.options 
{
  import com.meathill.diy.component.Button;
	import flash.display.Sprite;
	
	/**
   * ...
   * @author Meathill
   */
  public class LevelSelect extends Sprite 
  {
    
    public function LevelSelect() {
      layout();
    }
    
    private function layout():void {
      var level1:Button = new Button('1');
      addChild(level1);
      
      var level2:Button = new Button('2');
      level2.x = 200 - level2.width;
      addChild(level2);
    }
    
  }

}