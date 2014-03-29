package com.meathill.diy.view 
{
  import com.greensock.TweenMax;
  import com.meathill.diy.utils.Scaler;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.display.Sprite;
  import flash.filters.ColorMatrixFilter;
	
	/**
   * ...
   * @author Meathill
   */
  public class Preview extends Sprite 
  {
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
    public function setColor(color:Object, step:uint):void {
      var piece:DisplayObject = cloth.getChildAt(step),
          matrix:Array = [color.r, 0, 0, 0, 1];
      matrix = matrix.concat([0, color.g, 0, 0, 1]);
      matrix = matrix.concat([0, 0, color.b, 0, 1]);
      matrix = matrix.concat([0, 0, 0, 1, 0]);
      var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
      piece.filters = [filter];
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
        var bmpd:BitmapData = new BitmapData(mc.width, mc.height, true, 0);
        bmpd.draw(mc);
        var bmp:Bitmap = new Bitmap(bmpd, "auto", true);
        Scaler.resize(bmp, width / len, height);
        bmp.x += i * width / len; 
        piece.addChild(bmp);
      }
      
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