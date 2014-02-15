package com.meathill.diy.component 
{
  import com.meathill.diy.model.vo.SingleStepConfig;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
	
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
        var mc:Sprite = new Sprite();
        mc.buttonMode = mc.useHandCursor = true;
        mc.graphics.beginFill(parseInt(colors[i], 16));
        mc.graphics.drawRoundRect(0, 0, 30, 30, 3, 3);
        mc.graphics.endFill();
        mc.x = i % 6 * 33 + 10;
        mc.y = (i / 5 >> 0) * 33;
        mc.rotation = 20;
      
        mc.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
        mc.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
        addChild(mc);
      }
      
    }
    
    private function rollOverHandler(e:MouseEvent):void {
      Sprite(e.target).rotation = 0;
    }
    private function rollOutHandler(e:MouseEvent):void {
      Sprite(e.target).rotation = 20;
    }
    
  }

}