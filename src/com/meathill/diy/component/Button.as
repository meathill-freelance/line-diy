package com.meathill.diy.component 
{
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.utils.ColorMaker;
  import com.meathill.diy.utils.Scaler;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.filters.BitmapFilterQuality;
  import flash.filters.DropShadowFilter;
  import flash.geom.ColorTransform;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
	
	/**
   * 常规按钮类
   * @author Meathill
   */
  public class Button extends Sprite {
    public static const ICON_TOP:uint = 0;
    public static const ICON_LEFT:uint = 1;
    public static const ICON_RIGHT:uint = 2;
    public static const ICON_BOTTOM:uint = 3;
    
    protected var iconAsset:String;
    protected var buttonWidth:uint = 0;
    protected var buttonHeight:uint = 0;
    protected var label:TextField;
    protected var labelText:String = '';
    protected var icon:DisplayObject;
    protected var iconPos:uint;
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
    
    public function Button(label:String = 'button', icon:String = '', iconPos:uint = 1) {
      this.iconPos = iconPos;
      iconAsset = icon;
      labelText = label;
      resetAttr();
      createIcon();
      createLabel();
      layout();
			drawBG();
      mouseChildren = false;
      buttonMode = useHandCursor = true;
      
      addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
      addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
      addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
      addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
    }
    
    protected function createIcon():void {
      if (!iconAsset) {
        return;
      }
      icon = AssetsManager.instance.clone(iconAsset);
      var rgb:Object = ColorMaker.color2rgb(uint(textFormat.color));
      icon.transform.colorTransform = new ColorTransform(0, 0, 0, 1, rgb.r, rgb.g, rgb.b);
      Scaler.resize(icon, 18, 18);
      addChild(icon);
    }
    protected function createLabel():void {
      if (!labelText) {
        return;
      }
      label = new TextField();
      label.defaultTextFormat = textFormat;
      label.mouseEnabled = false;
      label.autoSize = TextFieldAutoSize.LEFT;
      label.text = labelText;
      addChild(label);
    }
    protected function draw(bg:uint, border:uint, width:uint, height:uint, bgAlpha:Number = 1, hasBorder:Boolean = true):void {
      graphics.clear();
      graphics.beginFill(bg, bgAlpha);
      if (hasBorder) {
        graphics.lineStyle(0, border);
      }
      graphics.drawRoundRect(0.5, 0.5, width, height, 6);
      graphics.endFill();
    }
    protected function drawBG():void {
      draw(bgColor, borderColor, buttonWidth, buttonHeight, bgAlpha, hasBorder);
    }
    protected function layout():void {
      if (iconPos === ICON_LEFT) {
        if (icon) {
          icon.x += 10;
          icon.y += 8;
        }
        if (label) {
          label.x = 12 + (icon ? icon.width + 10 : 0);
          label.y = 8;
        }
      } else if (iconPos === ICON_RIGHT) {
        if (label) {
          label.x = 10;
          label.y = 8;
        }
        if (icon) {
          icon.x += 10 + (label ? label.width + 10 : 0);
          icon.y += 8;
        }
      }
      
      
      buttonWidth = 24 + (label ? label.width : 0) + (icon ? icon.width : 0) + (label && icon ? 10 : 0);
      buttonHeight = 11 + Math.max(label ? label.height : 0, icon ? icon.height : 0);
    }
    
    protected function resetAttr():void {
      
    }
    protected function mouseDownHandler(event:MouseEvent):void {
      this.filters = [activeFilter];
    }
    protected function mouseUpHandler(event:MouseEvent):void {
      this.filters = null;
    }
    protected function rollOutHandler(e:MouseEvent):void {
      draw(bgColor, borderColor, buttonWidth, buttonHeight, bgAlpha, hasBorder);
    }
    protected function rollOverHandler(event:MouseEvent):void {
      draw(hoverBgColor, hoverBorderColor, buttonWidth, buttonHeight, hoverBgAlpha, hasHoverBorder);
    }
  }

}