package com.meathill.diy.popup.view 
{
  import com.meathill.diy.component.GroupButton;
  import com.meathill.diy.component.options.ColorCardItem;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.popup.AbstractPopup;
  import com.meathill.diy.utils.ColorMaker;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.GradientType;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.geom.Matrix;
  import flash.net.FileReference;
  import flash.text.TextField;
  import flash.utils.ByteArray;
  import mx.graphics.codec.JPEGEncoder;
	
	/**
   * ...
   * @author Meathill
   */
  public class HaibaoPopup extends AbstractPopup {
    private static var type:Array = [
      {
        label: '桌面',
        w: 1366,
        h: 768
      }, 
      { 
        label: 'iPhone',
        w: 640,
        h: 1136
      },
      { 
        label: 'iPad',
        w:1024,
        h: 768
      },
      { 
        label: 'Android',
        w: 1280,
        h: 720
      }
    ];
    private var color:uint = 0;
    private var w:uint = 368;
    private var h:uint = 207;
    private var preview:Sprite;
    private var isSimpleColor:Boolean;
    private var currBitmap:Bitmap;
    
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
        item.x = 424 + 40 * (i % 7);
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
        mc.x = 404 + 95 * i;
        mc.y = 176 + headerHeight;
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
      text1.x = 404
      text1.y = 10 + headerHeight;
      text1.defaultTextFormat = Typography.getTextFormat(Typography.LEAD);
      text1.text = '纯色背景';
      text1.mouseEnabled = false;
      addChild(text1);
      
      var text2:TextField = new TextField();
      text2.x = 404;
      text2.y = 140 + headerHeight;
      text2.defaultTextFormat = Typography.getTextFormat(Typography.LEAD);
      text2.text = 'XLINE背景';
      text2.mouseEnabled = false;
      addChild(text2);
      
      // 暂时不做选择尺寸的功能
      return;
      
      // 创建4个按钮用来选择尺寸
      var offset:uint = 20;
      for (var i:uint = 0; i < 4; i++) {
        var btn:GroupButton = new GroupButton(type[i].label, '', 1, i === 0 ?
          GroupButton.FIRST : (i === 3 ? GroupButton.LAST : GroupButton.MIDDLE));
        btn.x = offset;
        btn.y = contentHeight + 15 + headerHeight;
        btn.value = sizes[i];
        btn.addEventListener(MouseEvent.CLICK, typeButton_clickHandler);
        addChild(btn);
        offset += btn.width;
        
        if (i === 0) {
          btn.active();
        }
      }
    }
    override protected function resetAttr():void {
      title = '制作海报';
      hasCancel = false;
      confirmLable = '保存海报';
      contentHeight = 247;
      popupWidth = 700;
    }
    
    private function createBitmapCanvas(target:Sprite, bitmap:Bitmap, width:uint, height:uint):void {
      var matrix:Matrix = new Matrix(width / bitmap.width * bitmap.scaleX, 0, 0, height / bitmap.height * bitmap.scaleY);
      target.graphics.clear();
      target.graphics.beginBitmapFill(bitmap.bitmapData, matrix, true, true);
      target.graphics.drawRect(0, 0, width, height);
      target.graphics.endFill();
    }
    private function createColorCanvas(target:Sprite, color:uint, width:uint, height:uint):void {
      var colors:Array = [ColorMaker.lighten(color, 10), ColorMaker.draken(color, 20)];
      var matrix:Matrix = new Matrix();
      matrix.createGradientBox(width, height);
      target.graphics.clear();
      target.graphics.beginGradientFill(GradientType.RADIAL, colors, [1, 1], [0, 255], matrix);
      target.graphics.drawRect(0, 0, width, height);
      target.graphics.endFill();
    }
    private function createColorPreview():void {
      isSimpleColor = true;
      color = color ? color : parseInt(_colors[_colors.length * Math.random() >> 0], 16);
      createColorCanvas(preview, color, w, h);
    }
    private function createHaibaoPreview(bitmap:Bitmap):void {
      isSimpleColor = false;
      currBitmap = bitmap;
      createBitmapCanvas(preview, bitmap, w, h);
    }
    private function createPreview():void {
      
    }
    
    override protected function confirmButton_clickHandler(e:MouseEvent):void {
      var mc:Sprite = new Sprite();
      var w:uint = 1366;
      var h:uint = 768;
      if (isSimpleColor) {
        createColorCanvas(mc, color, w, h);
      } else {
        createBitmapCanvas(mc, currBitmap, w, h);
      }
      var bmp:Bitmap = new Bitmap(_cloth.bitmapData.clone(), "auto", true);
      bmp.x = w - bmp.width >> 1;
      bmp.y = h - bmp.height >> 1;
      mc.addChild(bmp);
      var bmpd:BitmapData = new BitmapData(w, h, true, 0);
      bmpd.draw(mc);
      var encoder:JPEGEncoder = new JPEGEncoder(80);
      var data:ByteArray = encoder.encode(bmpd);
      var file:FileReference = new FileReference();
      file.save(data, '海报.jpg');
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
    private function typeButton_clickHandler(e:MouseEvent):void {
      var btn:GroupButton = GroupButton(e.target);
      var key:String = btn.group;
      var group:Vector.<GroupButton> = GroupButton.groups[key];
      var index:uint = group.indexOf(btn);
      var size:Object = type[index];
    }
    
    
  }

}