package com.meathill.diy.utils 
{
  import flash.display.DisplayObject;
  import flash.geom.ColorTransform;
	/**
   * ...
   * @author Meathill
   */
  public class ColorMaker {
    public static function color2rgb(color:uint, percent:uint = 1):Object {
      return {
        r: (color >> 16 & 0xFF) / percent,
        g: (color >> 8 & 0xFF) / percent,
        b: (color & 0xFF) / percent
      };
    }
    public static function rgb2color(rgb:Object):uint {
      return rgb.r << 16 | rgb.g << 8 | rgb.b;
    }
    public static function colorMC(color:uint, mc:DisplayObject):DisplayObject {
      var rgb:Object = color2rgb(color);
      mc.transform.colorTransform = new ColorTransform(0, 0, 0, 1, rgb.r, rgb.g, rgb.b);
      return mc;
    }
    
    public static function draken(color:uint, percent:uint):uint {
      var rgb:Object = color2rgb(color);
      for (var prop:String in rgb) {
        rgb[prop] = rgb[prop] * (100 - percent) / 100;
      }
      return rgb2color(rgb);
    }
    
    static public function lighten(color:uint, percent:Number):uint {
      var rgb:Object = color2rgb(color);
      for (var prop:String in rgb) {
        rgb[prop] = rgb[prop] * (100 + percent) / 100;
      }
      return rgb2color(rgb);
    }
    
  }

}