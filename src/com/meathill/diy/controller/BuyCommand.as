package com.meathill.diy.controller 
{
  import com.meathill.diy.event.SystemEvent;
  import com.meathill.diy.event.UserEvent;
  import com.meathill.diy.model.ClothModel;
  import com.meathill.diy.popup.PopupManager;
  import com.meathill.diy.service.ServerManager;
  import flash.events.IEventDispatcher;
  import flash.events.IOErrorEvent;
  import flash.external.ExternalInterface;
  import flash.net.navigateToURL;
  import flash.net.URLRequest;
	import robotlegs.bender.bundles.mvcs.Command;
	
	/**
   * ...
   * @author Meathill
   */
  public class BuyCommand extends Command {
    [Inject]
    public var popupManager:PopupManager;
    
    [Inject]
    public var cloth:ClothModel;
    
    [Inject]
    public var eventDispatcher:IEventDispatcher;
    
    [Inject]
    public var server:ServerManager;
    
    override public function execute():void {
      if (cloth.id && !cloth.isChanged) {
        callAddToCart();
      } else {
        eventDispatcher.addEventListener(SystemEvent.SAVE_COMPLETE, saveCompleteHandler);
        callSaveCommand();
      }
    }
    
    
    private function callSaveCommand():void {
      var event:UserEvent = new UserEvent(UserEvent.SAVE);
      event.name = 'XLINE球队';
      eventDispatcher.dispatchEvent(event);
    }
    private function callAddToCart():void {
      var pid:Array = [];
      for (var i:uint = 0, len:uint = cloth.clothes.length; i < len; i++) {
        pid.push(cloth.clothes[i].tid);
      }
      server.add(ServerManager.API, {
        action: 'line_buy',
        id: cloth.id,
        pid: pid.join(',')
      }, successHandler, null, failedHandler);
    }
    
    
    private function saveCompleteHandler(e:SystemEvent):void {
      eventDispatcher.removeEventListener(SystemEvent.SAVE_COMPLETE, saveCompleteHandler);
      callAddToCart();
    }
    private function successHandler(response:Object):void {
      var event:SystemEvent = new SystemEvent(SystemEvent.ADDED_TO_CART);
      eventDispatcher.dispatchEvent(event);
      
      if (ExternalInterface.available) {
        ExternalInterface.call('gotoCart');
      } else {
        navigateToURL(new URLRequest('/cart'));
      }
    }
    private function failedHandler(e:IOErrorEvent):void {
      trace(e);
      var event:SystemEvent = new SystemEvent(SystemEvent.BUY_FAILED);
      eventDispatcher.dispatchEvent(event);
    }
  }

}