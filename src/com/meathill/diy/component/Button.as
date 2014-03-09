package com.meathill.diy.component 
{
  import com.meathill.diy.config.Typography;
  import flash.display.DisplayObject;
  import flash.display.Shape;
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
    protected var icon:Shape;
    protected var labelText:String = '';
    protected var bgColor:uint = 0xFFFFFF;
    protected var borderColor:uint = 0xCCCCCC;
    protected var bgAlpha:Number = 1;
    protected var hoverBgAlpha:Number = 1;
    protected var hoverBgColor:uint = 0xEBEBEB;
    protected var hoverBorderColor:uint = 0xADADAD;
    protected var hasBorder:Boolean = true;
    protected var hasHoverBorder:Boolean = true;
    protected var activeFilter:DropShadowFilter = new DropShadowFilter(4, 90, 0, 0.125, 4, 4, 2, BitmapFilterQuality.MEDIUM, true);
    protected var textFormat:TextFormat = Typography.getTextFormat(Typography.BODY);
    
    public function Button(label:String = 'button') {
      labelText = label;
      resetAttr();
      createIcon();
      createLabel();
			drawBG();
      mouseChildren = false;
      buttonMode = useHandCursor = true;
      
      addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
      addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
      addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
      addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
    }
    
    protected function createIcon():void {
      
    }
    protected function createLabel():void {
      if (!labelText) {
        return;
      }
      label = new TextField();
      label.defaultTextFormat = textFormat;
      label.x = 12 + (icon ? icon.width + 10 : 0);
      label.y = 5;
      label.mouseEnabled = false;
      label.autoSize = TextFieldAutoSize.LEFT;
      label.text = labelText;
      addChild(label);
    }
    protected function draw(bg:uint, border:uint, width:uint, height:uint, bgAlpha:Number = 1, hasBorder:Boolean = true):void {
      graphics.beginFill(bg, bgAlpha);
      graphics.lineStyle(0, border);
      graphics.drawRoundRect(0.5, 0.5, width, height, 6);
      graphics.endFill();
    }
    private function drawBG():void {
      draw(bgColor, borderColor, label.width + 24, label.height + 6, bgAlpha, hasBorder);
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
      draw(hoverBgColor, hoverBorderColor, label.width + 24, label.height + 6, hoverBgAlpha, hasHoverBorder);
    }
  }

}