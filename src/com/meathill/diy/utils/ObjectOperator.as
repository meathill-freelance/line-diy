package com.meathill.diy.utils 
{
	/**
   * ...
   * @author Meathill
   */
  public class ObjectOperator 
  {
    public static function extend(...args):Object {
      var result:Object = { };
      for (var i:uint = 0, len:uint = args.length; i < len; i++) {
        var obj:Object = args[i];
        for (var prop:String in obj) {
          result[prop] = obj[prop];
        }
      }
      return result;
    }
    
  }

}