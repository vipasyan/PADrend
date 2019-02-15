Simple Renderer for PADrend
===========================
This is the  mini project for course Algorithms for Highly Complex Virtual Scenes.
The mini project is done in group of 3 members:
 1.Saman Saman,
 2.Vipasyan Telaprolu and 
 3.Avishek Mishra.

The mini project for course Algorithms for Highly Complex Virtual Scenes done in PADrend contains 3 basic effects.
The 2 Rendering effects are:
1) Hiding of scene on moving camera position.
2) Changing object color with bounding boxes.
3) Changing object color(different colors) and removing  bounding boxes.

There is also one more modification in MeshBuilderExample.
1) Adding the noise effect.
2) Changing the ground color.
3) Removing the shadow.

It is developed in Escripts. 

Getting Started
----------------
To include the this project into PADrend, copy the entire 'SamanVipasyanAvishek_Group' folder /download all files(in GitHub) into your local PADrend folder (e.g., '~/PADrend/SamanVipasyanAvishek_Group/' or 'C:\PADrend\SamanVipasyanAvishek_Group\').

Now, you need to add the SamanVipasyanAvishek_Group to your plugin search path, so that PADrend can find it.
For this, open the file 'config.json' in a text editor (you need to run PADrend once to create it) and search for the following section:
```json
"Paths":{
	"data":"data/",
	"plugins":[
		"extPlugins/",
		"plugins/"
	],
	"scene":"data/scene/",
	"user":"./"
},
```

Here you need to add the 'plugins' folder of your 'SamanVipasyanAvishek_Group' to 'Paths.plugins' (don't forget the trailing '/'):
```json
"Paths":{
	"data":"data/",
	"plugins":[
		"extPlugins/",
		"plugins/",
		"SamanVipasyanAvi_Group/plugins/"
	],
	"scene":"data/scene/",
	"user":"./"
},
```

Now, you need to activate your plugin in PADrend.
For this, you need to start PADrend.
After you started PADrend, Open the 'Config' menu ![gear](./data/icons/gear.png) and click on 'Plugins'.
There you should see a list of all plugins with a small 'x' if they are active.
Search for the entry named 'SamanVipasyanAvishek_Group' and click on it to activate it.
To use your plugin you need to restart PADrend.
After you restarted PADrend, you should now find a new menu entry 'SamanVipasyanAvishek_Group' under the 'Plugins' menu ![puzzle](./data/icons/puzzle.png).
When you click on it, a window should open in PADrend with a set of buttons which do various things when you click on them.

Folder Structure
----------------
The folder structure of this this project is as follows:
```
SamanVipasyanAvi_Group
.
|-- CMakeLists.txt                            # Configuration file for CMake to build C++ library
|-- README.md                                 # This README file
|-- cmake                                     # Contains custom CMake modules
|   `-- FindEScript.cmake                     # CMake module for finding the EScript library
|   `-- FindPADrend.cmake                     # CMake module for finding the PADrend main libraries
|-- data                                      # Contains various resource files for the project
|   |-- icons                                 # Icons used in this README
|   |   |-- gear.png
|   |   `-- puzzle.png
|   |-- mesh                                  # 3D meshes used by the scene 'scene_1.minsg'
|   |   |-- Schwein.low.t.mmf
|   |   |-- tCube.mmf
|   |   |-- tWall_2.mmf
|   |   |-- tree_lite1.mmf
|   |   |-- tree_lite2.mmf
|   |   `-- tree_red.mmf
|   |-- scene
|   |   `-- szene_1.minsg                     # A simple MinSG scene
|   |   `-- szene_2.minsg                     # A simple MinSG scene
|   |-- shader                                # Shader files for the renderers
|   |   |-- ShadowShader.shader               # Shader configuration file for shadow rendering
|   |   |-- SimpleShader.vs                   # Vertex shader
|   |   `-- SimpleShader.fs                   # Fragment shader
|   `-- texture                               # Textures used by the scene 'scene_1.minsg'
|       |-- Schwein.low.t.png
|       `-- stone3.bmp
|-- plugins                                   # Folder for PADrend to search for custom plugins
|   `-- SamanVipasyanAvishek_Group            # Main folder of the plugin 'SamanVipasyanAvishek_Group'
|       |-- Plugin.escript                    # Plugin specification/entry point for the plugin 'SamanVipasyanAvishek_Group'
|       |-- ScriptedRenderer.escript          # Project renderer written in EScript
|       |-- ScriptedRendererCamera.escript    # Camera renderer written in EScript
|       |-- ScriptedRendererColor.escript     # Color renderer written in EScript
```

