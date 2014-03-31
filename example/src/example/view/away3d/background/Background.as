package example.view.away3d.background 
{
	import away3d.textures.BitmapTexture;
	import blaze.away3d.BlazeContainer3D;
	import blaze.away3d.Image;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public class Background extends BlazeContainer3D 
	{
		private var loader:Loader;
		private var image:Image;
		
		public function Background() 
		{
			super();
			
			var url:String = "./assets/background-test.jpg";
			var request:URLRequest = new URLRequest(url);
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnLoadComplete);
			loader.load(request);
		}
		
		private function OnLoadComplete(e:Event):void 
		{
			var bmd:BitmapData = Bitmap(loader.content).bitmapData;
			var texture:BitmapTexture = new BitmapTexture(bmd);
			
			image = new Image(texture);
			image.scaleToScreen = true;
			image.width = 100;
			image.height = 100;
			image.z = 10000;
			addChild(image);
			
			Blaze.viewPort.update.add(OnViewPortUpdate);
			Blaze.viewPort.update.dispatch();
		}
		
		private function OnViewPortUpdate():void 
		{
			image.width = Blaze.viewPort.rect.width;
			image.height = Blaze.viewPort.rect.height;
		}
	}
}