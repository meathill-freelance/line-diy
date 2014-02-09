package com.meathill.diy.component 
{
	import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFormat;
	
	/**
   * 常规按钮类
   * @author Meathill
   */
  public class Button extends Sprite 
  {
    protected var label:String = '';
    protected var bgColor:uint = 0xFFFFFF;
    protected var borderColor:uint = 0xCCCCCC;
    protected var fontColor:uint = 0x333333;
    protected var textFormat:TextFormat = new TextFormat('宋体', 14, 0x333333);
    
    public function Button(label:String = 'button') 
    {
      super();
      this.label = label;
      createLabel();
			draw();
      
      addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
      addEventListener(MouseEvent.CLICK, clickHandler);
    }
    
    private function createLabel():void {
      var label:TextField = new TextField();
      label.setTextFormat(textFormat);
      label.width = 80;
      label.y = 6;
      addChild(label);
    }
    private function draw():void {
      graphics.beginFill(bgColor);
      graphics.lineStyle(1, borderColor);
      graphics.drawRoundRect(0, 0, 80, 34, 4, 4);
      graphics.endFill();
    }
    
    protected function mouseOverHandler(event:MouseEvent):void {
      
    }
    protected function clickHandler(event:MouseEvent):void {
      
    }
  }

}