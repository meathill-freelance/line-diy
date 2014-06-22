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
    
    private var _welcome:Array;
    public function get welcome():Array {
      return _welcome;
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
    
    public function parse(init:Object):void {
      _baseURL = init.baseURL;
      _shareText = init.shareText;
      _welcome = init.welcome;
      _prices = init.prices;
      _assets = init.assets;
      _more = init.moreText;
    }
    
  }

}