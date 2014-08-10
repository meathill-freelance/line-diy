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
    public static const H2:String = 'h2';
    public static const H3:String = 'h3';
    public static const SMALL:String = 'small';
    private static var defaults:Object = {
      body: {
        font: '宋体',
        size: 14,
        color: 0x333333,
        leading: 4
      },
      lead: {
        font: '微软雅黑',
        size: 20,
        color: 0x333333,
        leading: 6
      },
      h1: {
        
      },
      h2: {
        font: '微软雅黑',
        size: 20,
        color: 0x333333,
        bold: true
      },
      h3: {
        font: '宋体',
        size: 14,
        color: 0x333333,
        leading: 4,
        bold: true
      },
      small: {
        font: '宋体',
        size: 12,
        color: 0x333333
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