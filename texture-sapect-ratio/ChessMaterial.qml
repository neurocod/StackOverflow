import Qt3D.Core 2.0
import Qt3D.Render 2.0

Material {
	id: root

	property color firstColor: Qt.rgba(1, 1, 0.0, 1)
	property color secondColor: Qt.rgba(0.0, 0.0, 1, 1)
	property vector3d boxSize: Qt.vector3d(1, 1, 1)

	parameters: [
		Parameter {
			name: "firstColor"
			value: Qt.vector3d(root.firstColor.r, root.firstColor.g, root.firstColor.b)
		},
		Parameter {
			name: "secondColor"
			value: Qt.vector3d(root.secondColor.r, root.secondColor.g, root.secondColor.b)
		},
		Parameter {
			name: "boxSize"
			value: root.boxSize
		}
	]

	effect: Effect {
		property string vertex: "qrc:/shaders/gl3/chessColor.vert"
		property string fragment: "qrc:/shaders/gl3/chessColor.frag"

		FilterKey {
			id: forward
			name: "renderingStyle"
			value: "forward"
		}

		ShaderProgram {
			id: gl3Shader
			vertexShaderCode: loadSource(parent.vertex)
			fragmentShaderCode: loadSource(parent.fragment)
		}

		techniques: [
			// OpenGL 3.1
			Technique {
				filterKeys: [forward]
				graphicsApiFilter {
					api: GraphicsApiFilter.OpenGL
					profile: GraphicsApiFilter.CoreProfile
					majorVersion: 3
					minorVersion: 1
				}
				renderPasses: RenderPass {
					shaderProgram: gl3Shader
				}
			}
		]
	}
}


