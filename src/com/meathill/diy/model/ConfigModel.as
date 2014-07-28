package com.meathill.diy.model 
{
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
    
    public function parse(init:Object):void {
      _baseURL = init.baseURL;
      _shareText = init.shareText;
      _tips = init.tips;
      _prices = init.prices;
      _assets = init.assets;
      _more = init.moreText;
      _colors = init.colors;
    }
    
  }

}