package com.meathill.diy.controller 
{
  import com.meathill.diy.event.SystemEvent;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.service.ServerManager;
  import com.meathill.diy.view.DIYView;
  import flash.display.BitmapData;
  import flash.events.IEventDispatcher;
  import flash.external.ExternalInterface;
  import flash.utils.ByteArray;
  import mx.graphics.codec.JPEGEncoder;
  import robotlegs.bender.bundles.mvcs.Command;
	
	/**
   * ...
   * @author Meathill
   */
  public class SaveCommand extends Command 
  {
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var view:DIYView;
    
    [Inject]
    public var server:ServerManager;
    
    [Inject]
    public var event:UserEvent;
    
    [Inject]
    public var eventDispatcher:IEventDispatcher;
    
    override public function execute():void {
      server.isLogin(saveThumbnail, showLoginModal);
    }
    
    private function saveThumbnail():void {
      var bmpd:BitmapData = view.bmpd,
          coder:JPEGEncoder = new JPEGEncoder(80),
          bytes:ByteArray = coder.encode(bmpd);
      server.upload(ServerManager.API, {
        action: 'line_create_pic',
        type: 'thumbnail'
      }, bytes, saveDesgin, null, errorHandler);
    }
    private function saveDesgin(response:Object):void {
      server.add(ServerManager.API, {
        action: 'line_save',
        desgin: cloth.toJSON(),
        url: response.url,
        name: event.name
      }, successHandler, null, errorHandler);
    }
    private function showLoginModal():void {
      trace('not login');
      if (ExternalInterface.available) {
        ExternalInterface.call('showLoginModal');
      }
    }
    
    private function successHandler():void {
      var event:SystemEvent = new SystemEvent(SystemEvent.SAVE_COMPLETE);
      eventDispatcher.dispatchEvent(event);
    }
    private function errorHandler():void {
      var event:SystemEvent = new SystemEvent(SystemEvent.SAVE_FAILED);
      eventDispatcher.dispatchEvent(event);
    }
  }

}