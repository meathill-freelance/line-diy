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
    private var total:TextField;
    
    public function Receipt(w:uint) {
      this.w = w;
      
    }
    
    
    public function draw(pieces:Array):void {
      drawBg(pieces.length);
      drawHeader();
      var total:uint = 0;
      for (var i:uint = 0, len:uint = pieces.length; i < len; i++) {
        var text:TextField = createLabel(45 + 30 * i);
        text.text = pieces[i].name;
        
        var price:TextField = createLabel(45 + 30 * i, TextFormatAlign.RIGHT);
        price.text = pieces[i].price;
        
        total += pieces[i].price;
      }
      drawFooter(pieces.length * 30 + 60, total);
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
    private function drawFooter(y:uint, money:uint):void {
      var summary:TextField = createLabel(y);
      summary.text = '总计';
      
      total = createLabel(y, TextFormatAlign.RIGHT);
      total.text = money.toString();
    }
    private function drawHeader():void {
      var header:TextField = new TextField();
      header.defaultTextFormat = Typography.getTextFormat(Typography.H3, { align: TextFormatAlign.CENTER } );
      header.mouseEnabled = false;
      header.x = 0;
      header.y = 6;
      header.width = w;
      header.text = '本次定制';
      addChild(header);
    }
    
    private function createLabel(y:uint = 10, align:String = TextFormatAlign.LEFT):TextField {
      var label:TextField = new TextField();
      label.mouseEnabled = false;
      label.x = 10;
      label.y = y;
      label.width = w - 20;
      label.height = 20;
      label.defaultTextFormat = Typography.getTextFormat(Typography.SMALL, { align: align });
      addChild(label);
      return label;
    }
  }
}