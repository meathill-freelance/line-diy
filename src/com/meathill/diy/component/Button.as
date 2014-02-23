package com.meathill.diy.component 
{
  import com.meathill.diy.config.Typography;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.filters.BitmapFilterQuality;
  import flash.filters.DropShadowFilter;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
	
	/**
   * 常规按钮类
   * @author Meathill
   */
  public class Button extends Sprite 
  {
    protected var label:TextField;
    protected var labelText:String = '';
    protected var bgColor:uint = 0xFFFFFF;
    protected var borderColor:uint = 0xCCCCCC;
    protected var hoverBgColor:uint = 0xEBEBEB;
    protected var hoverBorderColor:uint = 0xADADAD;
    protected var activeFilter:DropShadowFilter = new DropShadowFilter(4, 90, 0, 0.125, 4, 4, 2, BitmapFilterQuality.MEDIUM, true);
    protected var textFormat:TextFormat = Typography.getTextFormat(Typography.BODY);
    
    public function Button(label:String = 'button') {
      labelText = label;
      resetAttr();
      createLabel();
			drawBG();
      mouseChildren = false;
      buttonMode = useHandCursor = true;
      
      addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
      addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
      addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
      addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
    }
    
    private function createLabel():void {
      label = new TextField();
      label.defaultTextFormat = textFormat;
      label.x = 12;
      label.y = 10;
      label.mouseEnabled = false;
      label.autoSize = TextFieldAutoSize.LEFT;
      label.text = labelText;
      addChild(label);
    }
    protected function draw(bg:uint, border:uint, width:uint, height:uint):void {
      graphics.beginFill(bg);
      graphics.lineStyle(0, border);
      graphics.drawRoundRect(0.5, 0.5, width, height, 6);
      graphics.endFill();
    }
    private function drawBG():void {
      draw(bgColor, borderColor, label.width + 24, label.height + 16);
    }
    
    protected function resetAttr():void {
      
    }
    protected function mouseDownHandler(event:MouseEvent):void {
      this.filters = [activeFilter];
    }
    protected function mouseUpHandler(event:MouseEvent):void {
      this.filters = null;
    }
    private function rollOutHandler(e:MouseEvent):void {
      drawBG();
    }
    protected function rollOverHandler(event:MouseEvent):void {
      draw(hoverBgColor, hoverBorderColor, label.width + 24, label.height + 16);
    }
  }

}