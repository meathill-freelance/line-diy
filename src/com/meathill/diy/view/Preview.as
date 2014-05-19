package com.meathill.diy.view 
{
  import com.greensock.TweenMax;
  import com.meathill.diy.config.Typography;
  import com.meathill.diy.filter.Filters;
  import com.meathill.diy.utils.Scaler;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.display.Sprite;
  import flash.geom.Matrix;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.TextFormatAlign;
	
	/**
   * ...
   * @author Meathill
   */
  public class Preview extends Sprite {
    private var loader:Loader;
    private var cloth:Sprite;
    
    public function Preview() {
      buttonMode = useHandCursor = true;
    }
    
    public function show(mc:Sprite):void {
      if (numChildren > 0) {
        removeChildAt(0);
      }
      cloth = mc;
      Scaler.resize(cloth, 300, 500);
      cloth.x = - cloth.width >> 1;
      cloth.y = - cloth.height >> 1;
      addChild(cloth);
    }
    public function setColor(color:uint, step:uint):void {
      cloth.getChildAt(step).filters = [Filters.getColorFilter(color)];
    }
    public function setNumber(number:uint, style:uint, step:uint, length:uint, asset:Sprite):void {
      var piece:Sprite = Sprite(cloth.getChildAt(step));
      var numberAsset:Sprite = Sprite(asset.getChildAt(style));
      while (piece.numChildren > 1) {
        piece.removeChildAt(1);
      }
      var width:uint = piece.width;
      var height:uint = piece.height;
      piece.getChildAt(0).visible = false;
      var str:String = number.toString();
      for (var i:uint = 0, len:uint = str.length; i < len; i++) {
        var index:uint = parseInt(str.charAt(i));
        index = index === 0 ? 10 : index;
        var mc:DisplayObject = numberAsset.getChildAt(index - 1);
        var size:Object = Scaler.getSize(mc, width / len, height);
        var bmpd:BitmapData = new BitmapData(size.width, size.height, true, 0);
        bmpd.draw(mc, new Matrix(size.width / mc.width, 0, 0, size.height/ mc.height), null, null, null, true);
        var bmp:Bitmap = new Bitmap(bmpd, "auto", true);
        bmp.x += i * width / len; 
        piece.addChild(bmp);
      }
    }
    
    public function setTeamName(teamname:String, font:String, color:uint, step:uint):void {
      var piece:Sprite = Sprite(cloth.getChildAt(step));
      var tf:TextField;
      if (piece.getChildAt(0) is TextField) {
        tf = TextField(piece.getChildAt(0));
        var textFormat:TextFormat = tf.defaultTextFormat;
        textFormat.font = font;
        textFormat.color = color;
        tf.defaultTextFormat = textFormat;
      } else {
        tf = new TextField();
        tf.defaultTextFormat = Typography.getTextFormat(Typography.LEAD, { font: font, color: color, align: TextFormatAlign.CENTER, size: piece.height - 4, leading: 0} );
        tf.width = piece.width;
        tf.height = piece.height;
        tf.mouseEnabled = false;
        piece.removeChildAt(0);
        piece.addChild(tf);
      }
      tf.text = teamname;
    }
    public function highlight(step:uint):void {
      var tween:TweenMax = TweenMax.to(cloth.getChildAt(step), 0.3, {
        glowFilter: {
          color: 0xFFFFFF,
          alpha: 0.8,
          blurX: 16,
          blurY: 16,
          strength: 2,
          quality: 2
        },
        onComplete: function ():void {
          tween.reverse();
        }
      });
    }
    
    
  }

}