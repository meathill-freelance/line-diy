package com.meathill.diy.component.colorCard 
{
  import com.greensock.TweenLite;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.filters.BevelFilter;
	
	/**
   * ...
   * @author Meathill
   */
  public class Item extends Sprite 
  {
    public static var bevel:BevelFilter = new BevelFilter(2, 45, 0xFFFFFF, 0.25, 0, 0.25, 2, 2);
    private var _color:uint;
    private var tween:TweenLite;
    
    public function Item(color:String) {
      _color = parseInt(color, 16);
			
      buttonMode = useHandCursor = true;
      filters = [bevel];
      draw();
    
      addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
      addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
    }
    
    public function get color():uint {
      return _color;
    }
    
    private function draw():void {
      graphics.beginFill(_color);
      graphics.drawRoundRect(-15, -15, 30, 30, 3, 3);
      graphics.endFill();
    }
    
    
    private function rollOverHandler(e:MouseEvent):void {
      if (tween) {
        tween.kill();
      }
      scaleX = scaleY = 1.2;
    }
    private function rollOutHandler(e:MouseEvent):void {
      tween = TweenLite.to(this, .3, {
        scaleX: 1,
        scaleY: 1
      });
    }
  }

}