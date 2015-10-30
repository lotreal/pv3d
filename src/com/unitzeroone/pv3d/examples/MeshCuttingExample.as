package com.unitzeroone.pv3d.examples
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import org.papervision3d.objects.DisplayObject3D;	
	import org.papervision3d.core.geom.TriangleMesh3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.core.math.Plane3D;
	import org.papervision3d.core.utils.MeshUtil;
	import org.papervision3d.materials.BitmapColorMaterial;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.objects.primitives.Sphere;
	import org.papervision3d.view.BasicView;
        import org.papervision3d.materials.utils.MaterialsList;
        import org.papervision3d.materials.ColorMaterial;
        import org.papervision3d.materials.WireframeMaterial;
        import caurina.transitions.Tweener;

	public class MeshCuttingExample extends BasicView
	{
		protected var planeMaterial:BitmapColorMaterial;
		protected var sphereMaterial:BitmapMaterial;
		
		protected var sourceSphere:Sphere;
		protected var hemiSphereA:TriangleMesh3D;
		protected var hemiSphereB:TriangleMesh3D;
                protected var gismo:Cube;
		
		public function MeshCuttingExample()
		{
			super(0, 0, true, false, 'Target');
			opaqueBackground = 0;
			setupScene();
		}
		
		protected function setupScene():void
		{
			//Setup a bitmapdata material for the spheres to use.
			var bmp:BitmapData = new BitmapData(512,255,false,0);
			bmp.perlinNoise(64,64,4,123456,true,false);
			
			//Create a new sphere, which we will use as a source geometry, cutting it.
			sphereMaterial = new BitmapMaterial(bmp);
			sphereMaterial.doubleSided = true;
			sourceSphere = new Sphere(sphereMaterial, 400, 15,15);
			
			//Setup a plane3d along which we will cut the sphere.
			var normal:Number3D = new Number3D(.5,.5,0); //Some angle
			var point:Number3D = new Number3D(0,80,0); //at position...
			var cutPlane:Plane3D = Plane3D.fromNormalAndPoint(normal, point);
			
			//Cut the sphere along the plane3D, returns an array of maximum 2 meshes.
			var meshes:Array = MeshUtil.cutTriangleMesh(sourceSphere, cutPlane);

                        var mal:MaterialsList;
                        //mal = new MaterialsList({all:new ColorMaterial(0x0000ff)});
                        mal = new MaterialsList({all:new WireframeMaterial(0x0000ff)});
			gismo = new Cube( mal, 200, 100, 500, 1, 1, 1 );
			//gismo = new Cube( new MaterialsList({all:sphereMaterial}), 400, 1000, 200 );
			scene.addChild(gismo);
                        
                        var c1:Cube = new Cube( mal, 200, 300, 500, 3, 3, 3 );
                        c1.x = -200;
                        c1.y = -200;
			scene.addChild(c1);

			//Add result meshA
			hemiSphereA = meshes[0];
			hemiSphereA.x = 400;
			//scene.addChild(hemiSphereA);
			
			//Add result meshB
			hemiSphereB = meshes[1];
			hemiSphereB.x = -400;
			//scene.addChild(hemiSphereB);
			
			//Start rendering

                        camera.x = 400;
                        camera.y = 200;
                        //camera.target = DisplayObject3D.ZERO;
                        //camera.target = gismo;
                        gismo.y = -400;
			startRendering();

                        Tweener.addTween(gismo, {scaleY:0, time:10, onComplete:t2});
		}

                private function t2():void {
                    Tweener.addTween(gismo, {scaleY:1, time:10});
                }
		
		override protected function onRenderTick(event:Event=null):void
		{
			//Rotate the spheres.
			//hemiSphereA.yaw(1);
			//gismo.yaw(1);
			//hemiSphereB.yaw(-1);
			super.onRenderTick(event);
		}
		
	}
}