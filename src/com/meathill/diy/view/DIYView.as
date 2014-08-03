package com.meathill.diy.view 
{
  import com.meathill.diy.component.bottom.BottomButtonGroup;
  import com.meathill.diy.component.footer.Footer;
  import com.meathill.diy.component.options.Options;
  import com.meathill.diy.component.rightBar.RightBar;
  import com.meathill.diy.component.wizard.Wizard;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.Event;
	
	/**
   * ...
   * @author Meathill
   */
  public class DIYView extends Sprite 
  {
    private var wizard:Wizard;
    private var preview:Preview;
    private var options:Options;
    private var bottom:BottomButtonGroup;
    private var rightBar:RightBar;
    private var footer:Footer;
    
    public function get image():Sprite {
      var vector:Vector.<BitmapData> = preview.bitmaps;
      var mc:Sprite = new Sprite();
      for (var i:uint = 0, len:uint = vector.length; i < len; i++) {
        var bmp:Bitmap = new Bitmap(vector[i], "auto", true);
        if (i === 0) {
          bmp.x = 200;
        } else if (i === 1) {
          bmp.y = 100;
        }
        mc.addChildAt(bmp, 0);
      }
      return mc;
    }
    
    public function DIYView() {
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
    }
    
    public function addBg(bmp:Bitmap):void {
      bmp.x = stage.stageWidth - bmp.width >> 1;
      bmp.y = wizard.height;
      addChildAt(bmp, 0);
    }
    public function getBitmapData(bg:uint = 0):BitmapData {
      var mc:Sprite = image;
      var bmpd:BitmapData
      if (bg) {
        mc.graphics.beginFill(bg);
        mc.graphics.drawRect(0, 0, mc.width + 200, mc.height + 100);
        bmpd = new BitmapData(mc.width, mc.height, true, 0);
      } else {
        bmpd = new BitmapData(mc.width + 200, mc.height + 100, true, 0);
      }
      bmpd.draw(mc);
      return bmpd;
    }
    
    private function layout():void {
      preview = new Preview();
      preview.x = stage.stageWidth >> 1;
      preview.y = stage.stageHeight - 120 >> 1;
      addChild(preview);
      
      wizard = new Wizard();
      addChild(wizard);
      
      options = new Options();
      options.x = stage.stageWidth - 1200 >> 1;
      options.y = 70;
      addChild(options);
      
      bottom = new BottomButtonGroup();
      bottom.y = stage.stageHeight - Footer.HEIGHT;
      addChild(bottom);
      
      rightBar = new RightBar();
      rightBar.x = stage.stageWidth - (stage.stageWidth - 1200 >> 1) - 120;
      rightBar.y = 80;
      addChild(rightBar);
      
      footer = new Footer(stage.stageWidth > 1200 ? 1200 : stage.stageWidth);
      footer.x = stage.stageWidth - footer.width >> 1;
      footer.y = stage.stageHeight - Footer.HEIGHT + 2;
      addChild(footer);
    }
    
    
    private function addedHandler(e:Event):void {
      removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
      layout();
    }
  }

}