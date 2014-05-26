package com.meathill.diy.model 
{
	/**
   * 保存设置信息
   * @author Meathill
   */
  public class ConfigModel {
    
    private var _baseURL:String;
    private var _shareText:String;
    private var _welcome:Array;
    private var _prices:Object;
    private var _assets:Object;
    
    public function get baseURL():String {
      return _baseURL;
    }
    public function get shareText():String {
      return _shareText;
    }
    public function get welcome():Array {
      return _welcome;
    }
    public function get assets():Object {
      return _assets;
    }
    public function get prices():Object {
      return _prices;
    }
    
    public function parse(init:Object):void {
      _baseURL = init.baseURL;
      _shareText = init.shareText;
      _welcome = init.welcome;
      _prices = init.prices;
      _assets = init.assets;
    }
    
  }

}