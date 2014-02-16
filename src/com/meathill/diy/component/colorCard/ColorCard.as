package com.meathill.diy.component.colorCard 
{
  import com.meathill.diy.model.vo.SingleStepConfig;
	import flash.display.Sprite;
	
	/**
   * ...
   * @author Meathill
   */
  public class ColorCard extends Sprite 
  {
    private var colors:Array;
    
    public function ColorCard(config:SingleStepConfig) {
      colors = config.colors;
			draw();
    }
    
    
    private function draw():void {
      for (var i:uint = 0, len:uint = colors.length; i < len; i++) {
        var mc:Item = new Item(colors[i]);
        mc.x = i % 6 * 34 + 15;
        mc.y = (i / 6 >> 0) * 35 + 10;
        addChild(mc);
      }
      
    }
    
  }

}