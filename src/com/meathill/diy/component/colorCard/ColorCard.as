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
    private var color:uint;
    
    public function ColorCard(config:SingleStepConfig) {
      color = config.color;
      colors = config.colors;
			draw();
    }
    
    
    private function draw():void {
      for (var i:uint = 0, len:uint = colors.length; i < len; i++) {
        var mc:Item = new Item(parseInt(colors[i], 16));
        mc.x = i % 5 * 41 + 19;
        mc.y = (i / 5 >> 0) * 41 + 12;
        addChild(mc);
        if (mc.color === color) {
          mc.active();
        }
      }
      
    }
    
  }

}