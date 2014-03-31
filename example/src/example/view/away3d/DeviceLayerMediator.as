package example.view.away3d
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.geom.Vector3D;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.framework.api.IContext;
	
	public class DeviceLayerMediator extends Mediator
	{
		[Inject]
		public var view:DeviceLayer;
		
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var dispatcher:IEventDispatcher;
		
		override public function initialize():void
		{
			trace("INITIALIZE Device3dMediator");
			
			view.init();
			view.stage.addEventListener(Event.ENTER_FRAME, OnUpdate);
		}
		
		private function OnUpdate(e:Event):void 
		{
			view.cube.rotationY += 1;
		}
	}
}
