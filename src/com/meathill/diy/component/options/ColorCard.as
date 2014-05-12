package com.meathill.diy.component.options 
{
  import com.meathill.diy.model.vo.SingleStepConfig;
	import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
	
	/**
   * ...
   * @author Meathill
   */
  public class ColorCard extends Sprite {
    private var colors:Array;
    private var curr:uint;
    
    public function ColorCard(config:SingleStepConfig) {
      curr = config.color;
      colors = config.colors;
			draw();
      
      addEventListener(MouseEvent.CLICK, clickHandler);
    }
    
    public function set color(value:uint):void {
      var item:ColorCardItem = ColorCardItem(getChildByName('active'));
      if (item) {
        item.deactive();
      }
      for (var i:uint = 0, len:uint = colors.length; i < len; i++) {
        var mc:ColorCardItem = ColorCardItem(getChildAt(i));
        if (mc.color === value) {
          mc.active();
        }
      }
      curr = value;
    }
    public function get color():uint {
      return curr;
    }
    
    
    private function draw():void {
      for (var i:uint = 0, len:uint = colors.length; i < len; i++) {
        var mc:ColorCardItem = new ColorCardItem(parseInt(colors[i], 16));
        mc.x = i % 5 * 41 + 19;
        mc.y = (i / 5 >> 0) * 41 + 12;
        addChild(mc);
        if (mc.color === curr) {
          mc.active();
        }
      }
      
    }
    private function clickHandler(e:MouseEvent):void {
      var item:ColorCardItem = ColorCardItem(getChildByName('active'));
      if (item) {
        item.deactive();
      }
      item = ColorCardItem(e.target);
      item.active();
      curr = item.color;
      
      dispatchEvent(new Event(Event.CHANGE));
    }
    
  }

}