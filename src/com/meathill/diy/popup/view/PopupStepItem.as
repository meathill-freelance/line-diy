package com.meathill.diy.popup.view 
{
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.utils.ColorMaker;
  import flash.display.Shape;
	import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.ColorTransform;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class PopupStepItem extends Sprite {
    public static const WIDTH:uint = 80;
    public static const COLOR:uint = 0x888888;
    
    private var index:uint;
    private var label:String;
    private var text:TextField;
    private var bg:Shape;
    
    public function set working(value:Boolean):void {
      drawDashedCircle();
      addEventListener(Event.ENTER_FRAME, enterFrameHandler);
    }
    
    public function set ready(value:Boolean):void {
      if (!value) {
        return;
      }
      var style:TextFormat = new TextFormat(null, null, Colors.EMERALD);
      text.setTextFormat(style);
      removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
      drawCircle(Colors.EMERALD);
    }
    
    public function PopupStepItem(index:uint, label:String) {
			this.label = label;
      this.index = index;
      mouseChildren = mouseEnabled = false;
      
      draw();
    }
    
    private function draw():void {
      text = new TextField();
      text.width = WIDTH;
      text.defaultTextFormat = Typography.getTextFormat(Typography.H2, { color: COLOR, align: TextFormatAlign.CENTER, size: 60 } );
      text.text = (index + 1).toString();
      addChild(text);
      
      var p:TextField = new TextField();
      p.x = -10;
      p.defaultTextFormat = Typography.getTextFormat(Typography.LEAD, {align: TextFormatAlign.CENTER, color: COLOR});
      p.y = WIDTH + 10;
      p.text = label;
      addChild(p);
      
      bg = new Shape();
      bg.x = bg.y = WIDTH >> 1;
      drawCircle();
      addChild(bg);
    }
    private function drawCircle(color:uint = COLOR):void {
      bg.rotation = 0;
      bg.graphics.clear();
      bg.graphics.lineStyle(10, color);
      bg.graphics.drawCircle(0, 0, WIDTH >> 1);
    }
    private function drawDashedCircle():void {
      // 每段15度，空5度
      var r:uint = 15;
      var gap:uint = 15;
      var total:uint = 360 / (r + gap);
      var out:Number = WIDTH / 2 / Math.cos(Math.PI * r / 2 / 180);
      bg.graphics.clear();
      bg.graphics.lineStyle(6, COLOR);
      bg.graphics.moveTo(0, WIDTH >> 1);
      for (var i:uint = 0; i < total; i++) {
        var angle:Number = Math.PI * (r / 2 + i * (r + gap)) / 180;
        var toAngle:Number = Math.PI * (r + i * (r + gap)) / 180;
        var gapAngle:Number = Math.PI * (r + gap) * (i + 1) / 180;
        trace(angle / Math.PI * 180, toAngle / Math.PI * 180, gapAngle / Math.PI * 180);
        bg.graphics.curveTo(out * Math.sin(angle), out * Math.cos(angle), WIDTH / 2 * Math.sin(toAngle), WIDTH / 2 * Math.cos(toAngle));
        bg.graphics.moveTo(WIDTH / 2 * Math.sin(gapAngle), WIDTH / 2 * Math.cos(gapAngle)); 
      }
    }
    
    private function enterFrameHandler(e:Event):void {
      bg.rotation += 5;
    }
  }

}