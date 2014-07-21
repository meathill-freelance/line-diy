package com.meathill.diy.view 
{
	import flash.display.Sprite;
  import flash.events.Event;
	
	/**
   * 加载进度
   * @author Meathill
   */
  public class Spinner extends Sprite {
    private var r:uint = 20;
    private var color:uint = 0x2ECC71;
    private var gap:uint = 20;
    private var count:uint = 0;
    
    [Embed(source="../../../../../assets/xlinecom.swf")]
    private var Logo:Class;
    private var logo:Sprite;
    
    public function Spinner() {
      super();
      logo = new Logo() as Sprite;
      logo.x = -logo.width >> 1;
      logo.y = -logo.height >> 1;
      addChild(logo);
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }
    
    private function draw():void {
      count++;
      count = count >> 4;
      
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