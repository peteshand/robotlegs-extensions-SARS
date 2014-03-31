package 
{
	import blaze.utils.layout.Dimensions;
	import example.config.AppConfig;
	import example.view.away3d.DeviceLayer;
	import example.view.starling.StarlingUILayer;
	import flash.display.Sprite;
	import flash.events.Event;
	import robotlegs.bender.bundles.SARSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.sarsIntegration.api.AwayCollection;
	import robotlegs.bender.extensions.sarsIntegration.api.StarlingCollection;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public class Main extends Sprite 
	{
		private var _context:IContext;
		
		public function Main():void 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			Blaze.stage = stage;
			Blaze.renderer.context3dReadySignal.addOnce(OnContextReady);
			
		}
		
		private function OnContextReady():void 
		{
			Blaze.viewPort.optimalScreenDimensions(1920, 1080);
			Blaze.viewPort.zoomType = Dimensions.LETTERBOX;
			
			Blaze.addView3D(DeviceLayer, 'device', 0);
			Blaze.addStarling(StarlingUILayer, 'ui-flat', 1);
			
			_context = new Context()
				.install(SARSBundle)
				.configure(AppConfig)
				.configure(new ContextView(this))
				.configure(new StarlingCollection(Blaze.starlingCollectionData))
				.configure(new AwayCollection(Blaze.awayCollectionData));
		}
		
	}
	
}