package example.view.starling 
{
	import blaze.starling.layers.StarlingLayer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import starling.display.Image;
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public class StarlingUILayer extends StarlingLayer 
	{
		public function StarlingUILayer() 
		{
			super();
		}
		
		public function init():void
		{
			var title:Image = Image.fromBitmap(new Bitmap(new BitmapData(32,32,false,0xFF0000)));
			title.x = 50;
			title.y = 50;
			addChild(title);
		}
	}

}