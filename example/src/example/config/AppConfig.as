package example.config
{
	import example.view.away3d.DeviceLayer;
	import example.view.away3d.DeviceLayerMediator;
	import example.view.starling.StarlingUILayer;
	import example.view.starling.StarlingUILayerMediator;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;

	public class AppConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var context:IContext;

		[Inject]
		public var commandMap:IEventCommandMap;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var dispatcher:IEventDispatcher;

		[Inject]
		public var contextView:ContextView;

		public function configure():void
		{
			context.afterInitializing(init);
		}

		private function init():void
		{
			// Away3D Layers
			mediatorMap.map(DeviceLayer).toMediator(DeviceLayerMediator);
			
			// Starling Layers
			mediatorMap.map(StarlingUILayer).toMediator(StarlingUILayerMediator);
			
			var stage:Stage = contextView.view.stage;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			Blaze.contextView = contextView.view;
			
			dispatcher.dispatchEvent(new Event(Event.INIT));
		}
	}
}
