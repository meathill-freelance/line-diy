package com.meathill.diy.popup.view 
{
  import com.meathill.diy.component.options.ColorCardItem;
  import com.meathill.diy.config.Colors;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.popup.AbstractPopup;
  import com.meathill.diy.utils.ColorMaker;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.GradientType;
	import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.geom.Matrix;
  import flash.text.TextField;
	
	/**
   * ...
   * @author Meathill
   */
  public class HaibaoPopup extends AbstractPopup {
    private var color:uint = 0;
    private var w:uint = 240;
    private var h:uint = 180;
    private var preview:Sprite;
    
    private var _cloth:Bitmap;
    public function set cloth(value:BitmapData):void {
      if (_cloth) {
        _cloth.bitmapData.dispose();
      }
      _cloth = new Bitmap(value, "auto", true);
      _cloth.scaleX = _cloth.scaleY = 0.20;
      _cloth.x = w - _cloth.width >> 1;
      _cloth.y = h - _cloth.height >> 1;
      preview.addChild(_cloth);
      createColorPreview();
    }
    
    private var _colors:Array;
    public function set colors(value:Array):void {
      _colors = value;
      for (var i:uint = 0, len:uint = _colors.length; i < len; i++) {
        var item:ColorCardItem = new ColorCardItem(parseInt(_colors[i], 16));
        item.x = 320 + 40 * (i % 7);
        item.y = 65 + headerHeight + 41 * (i / 7 >> 0);
        item.addEventListener(MouseEvent.CLICK, colorCardItem_clickHandler);
        addChild(item);
      }
    }
    
    private var _haibao:Vector.<Bitmap>;
    public function set haibao(value:Vector.<Bitmap>):void {
      _haibao = value;
      for (var i:uint = 0, len:uint = _haibao.length; i < len; i++) {
        _haibao[i].width = 90;
        _haibao[i].scaleY = _haibao[i].scaleX;
        var mc:Sprite = new Sprite();
        mc.x = 300 + 95 * i;
        mc.y = 190 + headerHeight;
        mc.addChild(_haibao[i]);
        mc.addEventListener(MouseEvent.CLICK, haibao_clickHandler);
        addChild(mc);
      }
    }

    
    override protected function createContent():void {
      preview = new Sprite();
      preview.x = 20;
      preview.y = 20 + headerHeight;
      addChild(preview);
      
      var text1:TextField = new TextField();
      text1.x = 300
      text1.y = 10 + headerHeight;
      text1.defaultTextFormat = Typography.getTextFormat(Typography.LEAD);
      text1.text = '纯色背景';
      text1.mouseEnabled = false;
      addChild(text1);
      
      var text2:TextField = new TextField();
      text2.x = 300;
      text2.y = 150 + headerHeight;
      text2.defaultTextFormat = Typography.getTextFormat(Typography.LEAD);
      text2.text = 'XLINE背景';
      text2.mouseEnabled = false;
      addChild(text2);
    }
    override protected function resetAttr():void {
      title = '制作海报';
    }
    
    private function createColorPreview():void {
      preview.graphics.clear();
      color = color ? color : parseInt(_colors[_colors.length * Math.random() >> 0], 16);
      var colors:Array = [ColorMaker.lighten(color, 10), ColorMaker.draken(color, 20)];
      var matrix:Matrix = new Matrix();
      matrix.createGradientBox(w, h);
      preview.graphics.beginGradientFill(GradientType.RADIAL, colors, [1, 1], [0, 255], matrix);
      preview.graphics.drawRect(0, 0, w, h);
      preview.graphics.endFill();
    }
    private function createHaibaoPreview(bitmap:Bitmap):void {
      preview.graphics.clear();
      var matrix:Matrix = new Matrix(w / bitmap.width * bitmap.scaleX, 0, 0, h / bitmap.height * bitmap.scaleY);
      preview.graphics.beginBitmapFill(bitmap.bitmapData, matrix, true, true);
      preview.graphics.drawRect(0, 0, w, h);
      preview.graphics.endFill();
    }
    
    private function colorCardItem_clickHandler(e:MouseEvent):void {
      var colorCardItem:ColorCardItem = ColorCardItem(e.target);
      color = colorCardItem.color;
      createColorPreview();
    }    
    private function haibao_clickHandler(e:MouseEvent):void {
      var mc:Sprite = Sprite(e.target);
      createHaibaoPreview(Bitmap(mc.getChildAt(0)));
    }
    
  }

}