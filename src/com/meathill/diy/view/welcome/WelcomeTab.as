package com.meathill.diy.view.welcome 
{
  import com.greensock.TweenLite;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.filter.Filters;
  import com.meathill.diy.utils.Scaler;
  import flash.display.Bitmap;
  import flash.display.Shape;
	import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class WelcomeTab extends Sprite {
    public static const WIDTH:uint = 150;
    
    private var _selected:Boolean = false;
    public function get selected():Boolean {
      return _selected;
    }
    public function set selected(value:Boolean):void {
      _selected = value;
      name = value ? 'active' : '';
      draw();
    }
    
    private var _label:String;
    private var text:TextField;
    public function get label():String {
      return _label;
    }
    
    
    public function WelcomeTab(label:String) {
      _label = label;
      createLabel(label);
      
      useHandCursor = buttonMode = true;
			mouseChildren = false;
    }
    
    private function createLabel(label:String):void {
      text = new TextField();
      text.defaultTextFormat = Typography.getTextFormat(Typography.LEAD, {color: 0xFFFFFF, align: TextFormatAlign.CENTER});
      text.width = WIDTH;
      text.height = 30;
      text.y = 4;
      text.text = label;
      addChild(text);
    }
    private function draw():void {
      graphics.clear();
      var format:TextFormat = text.defaultTextFormat;
      format.color = _selected ? 0x333333 : 0xFFFFFF;
      text.setTextFormat(format);
      if (!_selected) {
        return;
      }
      graphics.beginFill(0xFFFFFF, 1);
      graphics.drawRoundRectComplex(0, 0, WIDTH, 40, 0, 0, 6, 6);
      graphics.endFill();
    }
  }
}