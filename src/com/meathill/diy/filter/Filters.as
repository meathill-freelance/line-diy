package com.meathill.diy.filter 
{
  import com.meathill.diy.config.Colors;
  import flash.filters.DropShadowFilter;
  import flash.filters.GlowFilter;
	/**
   * ...
   * @author Meathill
   */
  public class Filters 
  {
    public static const INPUT:DropShadowFilter = new DropShadowFilter(2, 45, 0, 0.15, 2, 2, 1, 1, true);
    public static const INPUT_FOCUS_IN:DropShadowFilter = new DropShadowFilter(2, 45, 0, 0.25, 4, 4, 1, 1, true);
    public static const INPUT_GLOW:GlowFilter = new GlowFilter(Colors.PETER_RIVER, 0.6, 8, 8);
    
  }

}