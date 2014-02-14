package com.meathill.diy.config 
{
  import com.meathill.diy.utils.ObjectOperator;
  import flash.text.TextFormat;
	/**
   * ...
   * @author Meathill
   */
  public class Typography 
  {
    public static const BODY:String = 'body';
    public static const LEAD:String = 'lead';
    private static var defaults:Object = {
      body: {
        font: '宋体',
        size: 14,
        color: 0x333333,
        leading: 4
      },
      lead: {
        font: '宋体',
        size: 21,
        color: 0x333333,
        leading: 6
      }
    };
    public static function getTextFormat(type:String, init:Object = null):TextFormat {
      var tf:TextFormat =  new TextFormat();
      init = ObjectOperator.extend(defaults[type], init);
      for (var prop:String in init) {
        tf[prop] = init[prop];
      }
      return tf;
    }
  }

}