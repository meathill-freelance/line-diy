package com.meathill.diy.view 
{
  import com.greensock.TweenLite;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.filter.Filters;
  import com.meathill.diy.utils.Scaler;
  import flash.display.Bitmap;
  import flash.display.Shape;
	import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class WelcomeItemView extends Sprite {
    public static const WIDTH:uint = 240;
    public static const HEIGHT:uint = 400;
    public static const GAP:uint = 350;
    
    private var _enable:Boolean = true;
    public function get enable():Boolean {
      return _enable;
    }
    public function set enable(value:Boolean):void {
      useHandCursor = buttonMode = _enable = value;
      filters = getFilters();
    }
    
    private var _selected:Boolean = false;
    public function get selected():Boolean {
      return _selected;
    }
    public function set selected(value:Boolean):void {
      _selected = value;
      filters = getFilters();
    }
    
    
    public function WelcomeItemView(bmp:Bitmap, name:String) {
      Scaler.resize(bmp, WIDTH, HEIGHT);
      bmp.smoothing = true;
      addChild(bmp);
      
      createLabel(name);
      
      useHandCursor = buttonMode = true;
			mouseChildren = false;
      alpha = 0;
    }
    
    public function fadeInUp(index:uint):void {
      TweenLite.to(this, 0.6, { alpha: 100, y: 100, delay: index * 0.4 } );
    }
    
    private function createLabel(name:String):void {
      var bg:Shape = new Shape();
      bg.y = 340;
      bg.graphics.beginFill(0xFFFFFF, 0.8);
      bg.graphics.drawRoundRect(0, 0, WIDTH, 60, 6);
      bg.graphics.endFill();
      addChild(bg);
      
      var text:TextField = new TextField();
      text.defaultTextFormat = Typography.getTextFormat(Typography.LEAD, {color: 0x333333, align: TextFormatAlign.CENTER});
      text.width = WIDTH;
      text.height = 40;
      text.y = 15 + bg.y;
      text.text = name;
      addChild(text);
    }
    private function getFilters():Array {
      var all:Array = _enable ? [] : [Filters.BLACK_WHITE, Filters.BLUR];
      if (_selected) {
        all.push(Filters.GLOW_RED);
      }
      return all;
    }
  }
}