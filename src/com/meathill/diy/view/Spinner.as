package com.meathill.diy.view 
{
	import flash.display.Sprite;
  import flash.events.Event;
	
	/**
   * 加载进度
   * @author Meathill
   */
  public class Spinner extends Sprite 
  {
    private var r:uint = 20;
    private var color:uint = 0x2ECC71;
    private var gap:uint = 20;
    private var count:uint = 0;
    
    public function Spinner() 
    {
      super();
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }
    
    private function draw():void {
      graphics.clear();
      for (var i:uint = 0; i < 3; i++) {
        graphics.beginFill(color, 1 - (count % 30 + i * 5) * 0.02);
        graphics.drawCircle((i - 1) * r << 2, 0, r);
        graphics.endFill();
      }
      count ++;
    }
    
    private function addedHandler(e:Event):void {
      x = stage.stageWidth >> 1;
      y = stage.stageHeight >> 1;
      count = 0;
      
      removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
      addEventListener(Event.ENTER_FRAME, enterFrameHandler);
      addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
    }
    private function enterFrameHandler(e:Event):void {
      draw();
    }
    private function removedHandler(e:Event):void {
      removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
      addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }
    
  }

}