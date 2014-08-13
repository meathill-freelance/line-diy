package com.meathill.diy.component.options 
{
  import com.meathill.diy.utils.ColorMaker;
  import com.meathill.diy.utils.Scaler;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.geom.Matrix;
	/**
   * ...
   * @author Meathill
   */
  public class SquadNumberUtils {
    static public var numColor:uint = 1;
    
    public static function useDesign(asset:Sprite, number:String, color:uint, color2:uint, length:uint, hasOutput:Boolean = false):Vector.<Bitmap> {
      var vector:Vector.<Bitmap> = hasOutput ? new Vector.<Bitmap>() : null;
      for (var i:uint = 0, len:uint = number.length; i < len; i++) {
        var index:uint = parseInt(number.charAt(i));
        index = index === 0 ? 10 : index;
        var mc:Sprite = Sprite(asset.getChildAt(index - 1));
        SquadNumberUtils.colorNumber(mc, color, color2);
        if (!hasOutput) {
          continue;
        }
        
        numColor = mc.numChildren;
        var size:Object = Scaler.getSize(mc, 50, 80);
        var bmpd:BitmapData = new BitmapData(size.width, size.height, true, 0);
        bmpd.draw(mc, new Matrix(size.width / mc.width, 0, 0, size.height/ mc.height), null, null, null, true);
        var bmp:Bitmap = new Bitmap(bmpd, "auto", true);
        bmp.x = (50 - size.width >> 1) + i * 60;
        vector.push(bmp);
      }
      return vector;
    }
    public static function colorNumber(mc:Sprite, color:uint, color2:uint):void {
      if (mc.numChildren === 1) {
        ColorMaker.colorMC(color, mc.getChildAt(0));
        return;
      }
      for (var i:uint = 0, len:uint = mc.numChildren; i < len; i++) {
        ColorMaker.colorMC(i & 1 ? color2 : color, mc.getChildAt(i));
      }
    }
    
  }

}