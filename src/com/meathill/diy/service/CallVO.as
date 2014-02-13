package com.meathill.diy.service 
{
  import flash.net.URLRequest;
	/**
   * ...
   * @author Meathill
   */
  public class CallVO 
  {
    private var _req:URLRequest;
    private var _success:Function;
    private var _progress:Function;
    private var _error:Function;
    
    public function CallVO(req:URLRequest, success:Function, progress:Function, error:Function) 
    {
      _req = req;
      _success = success;
      _progress = progress;
      _error = error;
    }
    
    public function get req():URLRequest {
      return _req;
    }
    public function get success():Function {
      return _success;
    }
    public function get progress():Function {
      return _progress;
    }
    public function get error():Function {
      return _error;
    }
    
  }

}