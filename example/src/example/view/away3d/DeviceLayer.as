package example.view.away3d 
{
	import away3d.entities.Mesh;
	import away3d.lights.DirectionalLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.CubeGeometry;
	import blaze.away3d.Image;
	import blaze.away3d.layers.AwayLayer;
	import blaze.utils.layout.Alignment;
	import blaze.utils.layout.Dimensions;
	import example.view.away3d.background.Background;
	import flash.geom.Vector3D;
	
	/**
	 * @author Michal Moczynski
	 */
	
	public class DeviceLayer extends AwayLayer
	{
		public var cube:Mesh;
		private var bg:Background;
		
		//lights
		private var light0:DirectionalLight;
		private var light1:DirectionalLight;
		private var light2:DirectionalLight;		
		private var lightPicker:StaticLightPicker;
		
		public function DeviceLayer(instanceIndex:int) 
		{
			super(instanceIndex);
			
			lens.far = 1000000;
			lens.fieldOfView = 50;
			
			addLights();
			addContent();
			addShadow();
		}
		
		public function init():void
		{
			viewPort.alignment = Alignment.LEFT;
			viewPort.offsetFraction.x = renderModel.instanceIndex * (1 / renderModel.proxySlotsUsed);
			viewPort.optimalScreenFraction.x = 1 / renderModel.proxySlotsUsed;
			viewPort.optimalScreenFraction.y = 1;
			viewPort.zoomType = Dimensions.LETTERBOX;
			
			this.renderModel.start();
		}
		
		private function addLights():void 
		{
			light0 = new DirectionalLight();
			light0.direction = new Vector3D(0, -50, -100);
			light0.color = 0xFFFFFF;
			light0.ambient = 0.3;
			light0.diffuse = 0.1;
			light0.specular = 0.6;
			this.scene.addChild(light0);
			
			light1 = new DirectionalLight();
			light1.direction = new Vector3D(100, -20, 100);
			light1.color = 0xFFFFFF;
			light1.ambient = 0.1;
			light1.diffuse = 0.1;
			this.scene.addChild(light1);
			
			light2 = new DirectionalLight();
			light2.direction = new Vector3D(-100, -20, -100);
			light2.color = 0xFFFFFF;
			light2.ambient = 0.3;
			light2.diffuse = 1;
			this.scene.addChild(light2);
			
			lightPicker = new StaticLightPicker([light0, light1, light2]);
		}
		
		private function addContent():void 
		{
			bg = new Background();
			scene.addChild(bg);
			
			var geo:CubeGeometry = new CubeGeometry(300, 300, 300, 1, 1, 1);
			var material:ColorMaterial = new ColorMaterial(0x883333);
			material.lightPicker = lightPicker;
			cube = new Mesh(geo, material);
			scene.addChild(cube);
		}
		
		private function addShadow():void 
		{
			var shadow:Image = Image.fromURL('assets/shadow.png');
			shadow.rotationX = 90;
			shadow.bothSides = false;
			shadow.alphaBlending = true;
			shadow.width = 400;
			shadow.height = 750;
			shadow.y = -300;
			cube.addChild(shadow);
		}
	}

}