package com.meathill.diy.utils 
{
	/**
   * ...
   * @author Meathill
   */
  public class ColorMaker 
  {
    public static function color2rgb(color:uint):Object {
      return {
        r: color >> 16 & 0xFF,
        g: color >> 8 & 0xFF,
        b: color & 0xFF
      };
    }
    public static function rgb2color(rgb:Object):uint {
      return rgb.r << 16 | rgb.g << 8 | rgb.b;
    }
    
    public static function draken(color:uint, percent:uint):uint {
      var rgb:Object = color2rgb(color);
      for (var prop:String in rgb) {
        rgb[prop] = rgb[prop] * (100 - percent) / 100;
      }
      return rgb2color(rgb);
    }
    
  }

}