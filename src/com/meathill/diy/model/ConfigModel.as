package com.meathill.diy.model 
{
import flash.text.Font;

/**
   * 保存设置信息
   * @author Meathill
   */
  public class ConfigModel {
    private var _baseURL:String;
    public function get baseURL():String {
      return _baseURL;
    }
    
    private var _shareText:String;
    public function get shareText():String {
      return _shareText;
    }
    
    private var _tips:Array;
    public function get tips():Array {
      return _tips;
    }
    
    private var _assets:Object;
    public function get assets():Object {
      return _assets;
    }
    
    private var _prices:Object;
    public function get prices():Object {
      return _prices;
    }
    
    private var _more:String;
    public function get more():String 
    {
      return _more;
    }
    
    private var _colors:Array;
    public function get colors():Array {
      return _colors;
    }
    
    private var _haibao:Object;
    public function get haibao():Object {
      return _haibao;
    }

  private var _fonts:Array;
  public function get fonts():Array {
    return _fonts;
  }
    
    public function parse(init:Object):void {
      _baseURL = init.baseURL;
      _shareText = init.shareText;
      _tips = init.tips;
      _prices = init.prices;
      _assets = init.assets;
      _haibao = init.haibao;
      _more = init.moreText;
      _colors = init.colors;

      var hanzi:Array = ['黑体', '华文行楷', '华文琥珀', '方正姚体', '幼圆', '微软雅黑'];
      var local:Array = Font.enumerateFonts(true);
      _fonts = [];
      for (var i:uint = 0, len:uint = local.length; i < len; i++) {
        if (hanzi.indexOf(local[i].fontName) !== -1) {
          _fonts.push(local[i].fontName);
        }
      }
      trace('Fonts: ', _fonts);
    }

}

}