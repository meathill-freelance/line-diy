/**
 * Created by 路佳 on 2014/10/26.
 */
package com.meathill.diy.config {
import com.meathill.diy.controller.LoadClothDataCommand;
import com.meathill.diy.controller.PreloadAssetsCommand;
import com.meathill.diy.controller.ViewAllCommand;
import com.meathill.diy.event.SystemEvent;
import com.meathill.diy.event.UserEvent;
import com.meathill.diy.model.ClothModel;
import com.meathill.diy.model.ConfigModel;
import com.meathill.diy.service.AssetsManager;
import com.meathill.diy.service.ServerManager;

import flash.events.IEventDispatcher;

import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

public class ViewerConfig implements IConfig {
  [Inject]
  public var injector:IInjector;

  [Inject]
  public var commandMap:IEventCommandMap;

  [Inject]
  public var eventDispatcher:IEventDispatcher;

  private var cloth:ClothModel;
  private var server:ServerManager;
  private var config:ConfigModel;

  public function configure():void {
    server = new ServerManager();
    cloth = new ClothModel();
    config = new ConfigModel();

    injector.map(ClothModel).toValue(cloth);
    injector.map(ServerManager).toValue(server);
    injector.map(ConfigModel).toValue(config);
    injector.map(AssetsManager).asSingleton();

    commandMap.map(SystemEvent.DATA_READY).toCommand(PreloadAssetsCommand);
    commandMap.map(SystemEvent.ASSETS_READY).toCommand(LoadClothDataCommand);
    commandMap.map(UserEvent.START_DIY).toCommand(ViewAllCommand);

    loadConfig();
  }

  private function loadConfig():void {
    server.add(ServerManager.INIT, null, config_loadCompleteHandler);
  }

  private function config_loadCompleteHandler(response:Object):void {
    config.parse(response)

    eventDispatcher.dispatchEvent(new SystemEvent(SystemEvent.DATA_READY));
  }
}
}
