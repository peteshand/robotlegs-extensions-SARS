package example
{
	import example.config.AppConfig;
	import example.view.away3d.DeviceLayer;
	import example.view.away3d.OverlayLayer;
	import example.view.starling.StarlingUILayer;
	import flash.display.Sprite;
	import flash.events.Event;
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.bundles.SARSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.sarsIntegration.api.AwayCollection;
	import robotlegs.bender.extensions.sarsIntegration.api.StarlingCollection;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;


	public class ProductDemoApp extends Sprite
	{
		private var _context:IContext;

		public function ProductDemoApp()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			Blaze.stage = stage;
			Blaze.renderer.context3dReadySignal.addOnce(OnContextReady);
			Blaze.viewPort.optimalScreenDimensions(1920, 1080);
		}
		
		private function OnContextReady():void 
		{
			var divs:int = 1;
			for (var i:int = 0; i < divs; i++) 
			{
				Blaze.addView3D(DeviceLayer, 'device'+i, 0, i);
				Blaze.addStarling(StarlingUILayer, 'ui-flat'+i, 1, i);
				Blaze.addView3D(OverlayLayer, 'overlay' + i, 2, i);
			}
			
			_context = new Context()
				.install(SARSBundle)
				.configure(AppConfig)
				.configure(new ContextView(this))
				.configure(new StarlingCollection(Blaze.starlingCollectionData))
				.configure(new AwayCollection(Blaze.awayCollectionData));
		}
	}
}
