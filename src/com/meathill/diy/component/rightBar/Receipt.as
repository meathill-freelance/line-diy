package com.meathill.diy.component.rightBar 
{
  import com.meathill.diy.config.Typography;
	import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class Receipt extends Sprite {
    private var w:uint;
    
    public function Receipt(w:uint) {
      this.w = w;
      
    }
    
    
    public function draw(pieces:Array):void {
      drawBg(pieces.length);
      drawHeader();
      for (var i:uint = 0, len:uint = pieces.length; i < len; i++) {
        var text:TextField = new TextField();
        text.defaultTextFormat = Typography.getTextFormat(Typography.SMALL);
        text.mouseEnabled = false;
        text.text = pieces[i].name;
        addChild(text);
        
        var price:TextField = new TextField();
        price.defaultTextFormat = Typography.getTextFormat(Typography.SMALL, { align: TextFormatAlign.RIGHT } );
        price.mouseEnabled = false;
        price.text = pieces[i].price;
        addChild(price);
        
        price.x = text.x = 10;
        price.y = text.y = 45 + 30 * i;
        price.height = text.height = 20;
      }
      drawFooter();
    }
    
    private function drawBg(length:uint):void {
      var h:uint = length * 30 + 90;
      graphics.clear();
      
      graphics.beginFill(0xFFFFFF);
      graphics.drawRoundRect(0, 0, w, h, 4);
      graphics.moveTo(w >> 1, -5);
      graphics.lineTo(w + 12 >> 1, 0);
      graphics.lineTo(w - 12 >> 1, 0);
      graphics.lineTo(w >> 1, -5);
      graphics.endFill();
      
      graphics.lineStyle(1, 0x666666);
      graphics.moveTo(10, 30);
      graphics.lineTo(w - 10, 30);
      graphics.moveTo(10, h - 40);
      graphics.lineTo(w - 10, h - 40);
    }
    private function drawFooter():void {
      
    }
    private function drawHeader():void {
      var header:TextField = new TextField();
      header.defaultTextFormat = Typography.getTextFormat(Typography.H3, { align: TextFormatAlign.CENTER } );
      header.mouseEnabled = false;
      header.x = 0;
      header.y = 6;
      header.width = w;
      header.text = '费用小计';
      addChild(header);
    }
  }
}