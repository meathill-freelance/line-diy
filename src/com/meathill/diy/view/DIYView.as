package com.meathill.diy.view 
{
  import com.meathill.diy.component.bottom.BottomButtonGroup;
  import com.meathill.diy.component.footer.Footer;
  import com.meathill.diy.component.options.Options;
  import com.meathill.diy.component.rightBar.RightBar;
  import com.meathill.diy.component.wizard.Wizard;
  import com.meathill.diy.service.AssetsManager;
  import com.meathill.diy.utils.Scaler;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.filters.BlurFilter;
	
	/**
   * ...
   * @author Meathill
   */
  public class DIYView extends Sprite {
    public static const THUMBNAIL_WIDTH:uint = 600;
    public static const THUMBNAIL_HEIGHT:uint = 450;
    
    [Inject]
    public var assets:AssetsManager;
      
    private var wizard:Wizard;
    private var preview:Preview;
    private var options:Options;
    private var bottom:BottomButtonGroup;
    private var rightBar:RightBar;
    private var footer:Footer;
    
    public function get image():Sprite {
      var vector:Vector.<BitmapData> = preview.bitmaps;
      var mc:Sprite = new Sprite();
      if (vector.length === 1) {
        mc.addChild(new Bitmap(vector[0], "auto", true));
      } else {
        for (var i:uint = 0, len:uint = vector.length; i < len; i++) {
          var bmp:Bitmap = new Bitmap(vector[i], "auto", true);
          if (i === 0) {
            bmp.x = 200;
          } else if (i === 1) {
            bmp.y = 100;
          }
          mc.addChildAt(bmp, 0);
        }
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
    public function getBitmapData(hasBackground:Boolean = false):BitmapData {
      var mc:Sprite = image;
      var bmpd:BitmapData;
      if (hasBackground) {
        Scaler.resize(mc, THUMBNAIL_WIDTH * 0.8, THUMBNAIL_HEIGHT * 0.8);
        mc.x += THUMBNAIL_WIDTH * .1;
        mc.y += THUMBNAIL_HEIGHT * .05;
        var bg:Bitmap = assets.clone('thumbnail');
        var shadow:Shape = new Shape();
        shadow.graphics.beginFill(0x000000, 0.05);
        shadow.graphics.drawEllipse(0, 0, mc.width - 20, 30);
        shadow.graphics.endFill();
        shadow.filters = [new BlurFilter(16, 16)];
        shadow.x = mc.x + 10;
        shadow.y = mc.y + mc.height + 10;
        var container:Sprite = new Sprite();
        container.addChild(bg);
        container.addChild(mc);
        container.addChild(shadow);
        bmpd = new BitmapData(THUMBNAIL_WIDTH, THUMBNAIL_HEIGHT, true, 0);
        bmpd.draw(container);
      } else {
        bmpd = new BitmapData(mc.width, mc.height, true, 0);
        bmpd.draw(mc);
      }
      return bmpd;
    }
    public function getThumbnail():BitmapData {
      var mc:Sprite = image;
      var bmpd:BitmapData;
      Scaler.resize(mc, 600, 500);
      mc.x += 150;
      mc.y += 50;
      var container:Sprite = new Sprite();
      container.graphics.beginFill(0x7f7f7f);
      container.graphics.drawRect(0, 0, 900, 600);
      container.addChild(mc);
      bmpd = new BitmapData(900, 600, true, 0);
      bmpd.draw(container);
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