package example.view.starling 
{
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class StarlingUILayerMediator extends Mediator 
	{
		[Inject]
		public var view:StarlingUILayer;
		
		override public function initialize():void
		{
			trace("StarlingUILayerMediator initialize");
			view.init();
		}	
	}	
}