package com.meathill.diy.utils 
{
  import flash.display.DisplayObject;
	/**
   * ...
   * @author Meathill
   */
  public class Scaler 
  {
    public static function resize(mc:DisplayObject, w:uint, h:uint, isContain:Boolean = true):void {
      var width:uint = mc.width;
      var height:uint = mc.height;
      if (width > w || h > h) {
        if (w / h > width / height) {
          mc.height = h;
          mc.width = width / height * h;
        } else {
          mc.width = w;
          mc.height = height / width * w;
        }
      }
      mc.x = w - mc.width >> 1;
      mc.y = h - mc.height >> 1;
    }
  }

}