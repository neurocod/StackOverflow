import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.10
import QtQuick 2.0 as Quick

Entity {
	id: root
	components: [
		RenderSettings {
			activeFrameGraph: ForwardRenderer {
				clearColor: "white"
				camera: mainCamera
			}
		},
		InputSettings { }
	]

	Camera {
		id: mainCamera
		position: Qt.vector3d(0.0, 0.0, 7.0)
		upVector: Qt.vector3d(0.0, 1.0, 0.0)
		viewCenter: Qt.vector3d(0.0, 0.0, 0.0)
	}

	FirstPersonCameraController {
		camera: mainCamera
	}

	Entity {
		components: [
			PointLight {},
			Transform { translation: mainCamera.position }
		]
	}

	CubeEntity { //growig size, scale texture equally using textureScale
		id: parent1
		position: Qt.vector3d(-1, -1, 0)
		material: DiffuseSpecularMaterial {
			diffuse: TextureLoader { source: "qrc:/chess.png" }
			textureScale: 2 * parent1.mesh.xExtent
		}
		Quick.NumberAnimation on mesh.xExtent {
			from: 0.5; to: 2
			loops: Quick.Animation.Infinite
			duration: 5000
		}
	}

	CubeEntity { //default beaviour
		position: Qt.vector3d(-1, 1, 0)
		material: DiffuseSpecularMaterial {
			diffuse: TextureLoader { source: "qrc:/chess.png" }
		}
		Quick.NumberAnimation on mesh.xExtent {
			from: 0.5; to: 2
			loops: Quick.Animation.Infinite
			duration: 5000
		}
	}

	function updateSizes(mesh, material) {
		//console.log("MyComponent changed!");
		material.textureTransform = tools.scalingMatrix(2*mesh.xExtent, 2*mesh.yExtent, 2*mesh.zExtent);
	}

	CubeEntity { //growing size and material scales not equally
		id: parent2
		position: Qt.vector3d(1, 1, 0)
		mesh.yExtent: 1
		//matrix3x3 is not provided by Qt so need to expose it from C++ code, i used 'tools' class
		material: TextureMaterial {
			texture: TextureLoader { source: "qrc:/chess.png" }
		}
		mesh.onXExtentChanged: updateSizes(mesh, material)
		mesh.onYExtentChanged: updateSizes(mesh, material)
		mesh.onZExtentChanged: updateSizes(mesh, material)
		Quick.NumberAnimation on mesh.xExtent {
			from: 0.5; to: 2
			loops: Quick.Animation.Infinite
			duration: 5000
		}
	}
	//Binding { target: material; property: "textureTransform"; value: tools.scalingMatrix(parent2.mesh.xExtent, parent2.mesh.yExtent, parent2.mesh.zExtent) }

	CubeEntity { // same look but using shader
		id: parent3
		position: Qt.vector3d(1, -1, 0)
		mesh.yExtent: 1
		Quick.NumberAnimation on mesh.xExtent {
			from: 0.5; to: 2
			loops: Quick.Animation.Infinite
			duration: 5000
		}
		material: ChessMaterial {
			boxSize: Qt.vector3d(parent3.mesh.xExtent, parent3.mesh.yExtent, parent3.mesh.zExtent)
		}
	}
}
