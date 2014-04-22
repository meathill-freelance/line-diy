package com.meathill.diy.utils 
{
  import flash.display.DisplayObject;
  import flash.text.TextField;
	/**
   * ...
   * @author Meathill
   */
  public class Scaler 
  {
    public static function resize(mc:DisplayObject, w:uint, h:uint, isContain:Boolean = true):void {
      var width:uint = mc.width;
      var height:uint = mc.height;
      if (width > w || height > h) {
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
    /**
     * 将一批mc在一定区域内剧中
     * @param width
     * @param height
     * @param ...args
     */
    static public function recenter(width:uint, height:uint, ...args):void {
      var x:int = 0;
      var y:int = 0;
      var r:int = 0;
      var b:int = 0;
      for (var i:uint = 0, len:uint = args.length; i < len; i++) {
        if (!args[i]) {
          continue;
        }
        x = args[i].x < x ? args[i].x : x;
        y = args[i].y < y ? args[i].y : y;
        r = args[i].x + args[i].width > r ? args[i].x + args[i].width : r;
        b = args[i].y + args[i].height > b ? args[i].y + args[i].height : b;
      }
      var offsetX:int = width - r - x >> 1;
      var offsetY:int = height - b - y >> 1;
      for (i = 0; i < len; i++) {
        if (!args[i]) {
          continue;
        }
        args[i].x += offsetX;
        args[i].y += offsetY;
      }
    }
  }

}