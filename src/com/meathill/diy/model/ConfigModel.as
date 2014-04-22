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
    
    public function get baseURL():String {
      return _baseURL;
    }
    public function get shareText():String {
      return _shareText;
    }
    public function get welcome():Array {
      return _welcome;
    }
    
    public function parse(all:Object):void {
      _baseURL = all.baseURL;
      _shareText = all.shareText;
      _welcome = all.welcome;
    }
    
  }

}