package com.meathill.diy.view.welcome 
{
  import com.greensock.TweenLite;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.filter.Filters;
  import com.meathill.diy.utils.Scaler;
  import flash.display.Bitmap;
  import flash.display.Shape;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class WelcomeItem extends Sprite {
    public static const WIDTH:uint = 150;
    public static const HEIGHT:uint = 200;
    public static const GAP:uint = 20;
    
    private var _price:uint;
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
      name = value ? 'active' : '';
      filters = getFilters();
    }
    
    private var _label:String;
    public function get label():String {
      return _label;
    }
    
    private var _id:String;
    public function get id():String {
      return _id;
    }
    public function set id(value:String):void {
      _id = value;
    }
    
    public function WelcomeItem(thumbnail:Bitmap, config:Object) {
      Scaler.resize(thumbnail, WIDTH, HEIGHT);
      thumbnail.smoothing = true;
      addChild(thumbnail);
      
      _price = config.price;
      createLabel(_price);
      
      useHandCursor = buttonMode = true;
			mouseChildren = false;
      
      addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
      addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
    }
    
    public function fadeInUp(index:uint):void {
      TweenLite.to(this, 0.6, { alpha: 100, y: 100, delay: index * 0.4 } );
    }
    
    private function createLabel(_price:uint):void {
      var bg:Shape = new Shape();
      bg.y = HEIGHT - 30;
      bg.graphics.beginFill(0xFFFFFF, 0.8);
      bg.graphics.drawRoundRect(5, 0, WIDTH - 10, 25, 6);
      bg.graphics.endFill();
      addChild(bg);
      
      var text:TextField = new TextField();
      text.defaultTextFormat = Typography.getTextFormat(Typography.BODY, {font: 'Arial', align: TextFormatAlign.CENTER});
      text.width = WIDTH;
      text.height = 20;
      text.y = 2 + bg.y;
      text.text = '￥' + _price.toString();
      addChild(text);
    }
    private function draw(clear:Boolean = false):void {
      graphics.clear();
      if (clear) {
        return;
      }
      graphics.beginFill(0x111111, 0.2);
      graphics.drawRoundRect(0, 0, WIDTH, HEIGHT, 12);
      graphics.endFill();
    }
    private function getFilters():Array {
      var all:Array = _enable ? [] : [Filters.BLACK_WHITE, Filters.BLUR];
      if (_selected) {
        all.push(Filters.GLOW_RED);
      }
      return all;
    }
    
    private function rollOutHandler(e:MouseEvent):void {
      draw(true);
    }
    private function rollOverHandler(e:MouseEvent):void {
      draw();
    }
  }
}