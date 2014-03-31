//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
// 

//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.sarsIntegration
{
	import away3d.containers.View3D;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.sarsIntegration.api.AwayCollection;

	import robotlegs.bender.extensions.matching.instanceOfType;
	
	import robotlegs.bender.extensions.sarsIntegration.api.IAway3DViewMap;
	import robotlegs.bender.extensions.sarsIntegration.impl.Away3DViewMap;
	
	import robotlegs.bender.extensions.sarsIntegration.api.IStarlingViewMap;
	import robotlegs.bender.extensions.sarsIntegration.impl.StarlingViewMap;
	
	import robotlegs.bender.extensions.sarsIntegration.api.StarlingCollection;
	
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.impl.UID;

	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;

	/**
	 * <p>This Extension will map all Starling view instances and View3D instance in
	 * injector as well as create view maps for automatic mediation when instances are
	 * added on stage/scene.</p>
	 */
	public class SARSIntegrationExtension implements IExtension
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		/** Extension UID. **/
		private const _uid:String = UID.create(SARSIntegrationExtension);

		/** Context being initialized. **/
		private var _context:IContext;

		/** Logger used to log messaged when using this extension. **/
		private var _logger:ILogger;
	
		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/** @inheritDoc **/
		public function extend(context:IContext):void
		{
			_context = context;
			_logger = context.getLogger(this);
			
			//modified by Ondina - 01.10.2013
			/*_context.addConfigHandler(instanceOf(StarlingCollection), handleStarlingCollection);
			_context.addConfigHandler(instanceOf(View3D), handleView3D);*/
			
			_context.addConfigHandler(instanceOfType(StarlingCollection), handleStarlingCollection);
			_context.addConfigHandler(instanceOfType(AwayCollection), handleAwayCollection);
		}

		/**
		 * Returns the string representation of the specified object.
		 */
		public function toString():String
		{
			return _uid;
		}

		/*============================================================================*/
		/* Private Functions                                                          */
		/*============================================================================*/

		/**
		 * Map all Starling view instances to injector with their defined name and map
		 * and initialize Starling view map which will mediate display instances.
		 *
		 * @param collection Collection of Starling view instances used in context.
		 */
		private function handleStarlingCollection(starlingCollection:StarlingCollection):void
		{
			_logger.debug("Mapping provided Starling instances...");
			_context.injector.map(StarlingCollection).toValue(starlingCollection);
			
			var key:String;
			for (key in starlingCollection.items)
			{
				_context.injector.map(DisplayObjectContainer, key).toValue(Starling(starlingCollection.items[key]).stage);
			}
			
			_context.injector.map(IStarlingViewMap).toSingleton(StarlingViewMap);
			_context.injector.getInstance(IStarlingViewMap);
		}
		
		/**
		 * Map View3D instance to injector and map and initialize Away3D view map
		 * which will mediate display instances.
		 *
		 * @param view3D View3D instance which will be used in context.
		 */
		private function handleAwayCollection(awayCollection:AwayCollection):void
		{
			_logger.debug("Mapping provided View3D as Away3D contextView...");
			_context.injector.map(AwayCollection).toValue(awayCollection);
			
			var key:String;
			for (key in awayCollection.items)
			{
				var view3D:View3D = View3D(awayCollection.items[key]);
				_context.injector.map(View3D, key).toValue(view3D);
			}
			
			_context.injector.map(IAway3DViewMap).toSingleton(Away3DViewMap);
			_context.injector.getInstance(IAway3DViewMap);
		}
	}
}
