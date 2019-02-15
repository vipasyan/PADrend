/*
Any copyright is dedicated to the Public Domain.
http://creativecommons.org/publicdomain/zero/1.0/
Author: Sascha Brandt <sascha@brandt.graphics>
*/

/*
Modifications done by: Saman Saman, Vipasyan Telaprolu, Avishek Mishra.
*/


// Create a Plugin object which tells PADrend what this plugin contains
var plugin = new Plugin({
		Plugin.NAME : 'ExampleProject', // Name of the plugin
		Plugin.DESCRIPTION : 'Simple example project with gui, scripted renderer, and dynamic c++ library loading', // A short description of the plugin
		Plugin.VERSION : 0.1, // (optional) Version of the plugin (e.g. 2.7)
		Plugin.AUTHORS : "Sascha Brandt", // (optional) Main author(s) of the plugin (e.g. "Hans Hase & Petra Hummel")
		Plugin.OWNER : "All", // (optional) who is responsible for this plugin and is allowed to make changes (can be "All")
		Plugin.CONTRIBUTORS : "", // (optional) If someone adds a minor part to the plugin, he/she can be added to this list.
		Plugin.LICENSE : "Public Domain", // (optional) e.g. "Mozilla Public License, v. 2.0", PublicDomain or PROPRIETARY
		Plugin.REQUIRES : ['PADrend/GUI', 'Tools', 'GUITools', 'NodeEditor'], // (optional) Array of other plugins that are needed for this plugin
		Plugin.EXTENSION_POINTS : [ ] // (optional) Array of extension points' names provided by this plugin
});

// Load the module 'LibUtilExt/LibraryLoader' which allows dynamic loading of c++ libraries
static LibraryLoader = Std.module("LibUtilExt/LibraryLoader");

// ---------------------------

// Plugin initialization; is called initially when the plugin is loaded.
plugin.init @(override) :=fn() {
	
	// Call the function 'initGUI' when the module 'PADrend/gui' is loaded.
	module.on('PADrend/gui', initGUI);
	
	// Create an instance of the LibraryLoader.
	var loader = new LibraryLoader; 
	
	// We need to add our build path to the LibraryLoader so it can find the library
	loader.addSearchPath(__DIR__ + "/../../build/");
	loader.addSearchPath(__DIR__ + "/../../lib/"); // You can copy the library here if you want
	
	// Searches for the file 'libExampleProject.so' (linux) or 'libExampleProject.dll' (windows) 
	// and calls the C entry point function 'loadLibary'.
	if(loader.loadLibary("libExampleProject")) {
		// call the function 'initCppGUI' when the module 'PADrend/gui' is loaded.
		module.on('PADrend/gui', initCppGUI);
	}
	
	// Call the function 'afterInit' after all plugins are initialized.
	// The 'LOW_PRIORITY' means, that the function gets called after all other 'PADrend_Init' were called.
	// Here we need to add 'this->...' to delegate the function to this plugin object.
	Util.registerExtension('PADrend_Init', this->afterInit, Extension.LOW_PRIORITY);
	
	// Adds the 'Scripts' folder to the Speed-Dial menu ('F3' key) - requires 'Tools' plugin.
	Util.registerExtension('Tools_SpeedDial_QueryFolders', fn(Array paths) {
		paths += __DIR__ + "/../../scripts/";
	});
	
	return true; // plugin successful initialized
};

// ---------------------------

// Custom init function that gets called after all other plugins are initialized.
// The ... indicates that we don't care about possible input parameters.
plugin.afterInit := fn(...) {
	// Show a short message on the screen - requires 'GUITools' plugin.
	PADrend.message("ExampleProject initialized!");
};

// ---------------------------

// GUI initialization
static initGUI = fn(gui) {
	outln("ExampleProject: Init GUI...");
		
	// Adds the menu entry 'ExampleProject' to the plugins menu.
	gui.register('PADrend_PluginsMenu.ExampleProject',[
		{
			GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Project",
			GUI.ON_CLICK : fn() {
				// Open a window
				gui.create({
					GUI.TYPE : GUI.TYPE_WINDOW,
					GUI.LABEL : "Project-Window",
					GUI.POSITION : [50,100],
					GUI.SIZE : [250,300],
					GUI.CONTENTS: [{
						GUI.TYPE: GUI.TYPE_PANEL,
						GUI.SIZE: [GUI.WIDTH_FILL_REL|GUI.HEIGHT_FILL_REL, 1, 1],
						GUI.CONTENTS: 'ExampleProject_WindowEntries',
					}]
				});
			}
		}
	]);

	// Register the content of the dialog window
	gui.register('ExampleProject_WindowEntries.content',[
		// See https://padrend.github.io/Tutorials/gui_factories for a description of all values
		{
			GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Load scene 1",
			GUI.TOOLTIP : "Loads the scene stored in 'ExampleProject/data/scene/'!",
			GUI.SIZE: [GUI.WIDTH_FILL_ABS, 10, 0],
			GUI.ON_CLICK : fn() {
				// loads a scene from file
				var scene = PADrend.loadScene(__DIR__ + "/../../data/scene/szene_1.minsg");
				// Activate the scene
				PADrend.selectScene(scene);
			}
		},
		GUI.NEXT_ROW,
			{
			GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Load scene 2",
			GUI.TOOLTIP : "Loads the scene stored in 'Project/data/scene/'!",
			GUI.SIZE: [GUI.WIDTH_FILL_ABS, 10, 0],
			GUI.ON_CLICK : fn() {
				// loads a scene from file
				var scene = PADrend.loadScene(__DIR__ + "/../../data/scene/szene_2.minsg");
				// Activate the scene
				PADrend.selectScene(scene);
			}
		   },
		GUI.NEXT_ROW,
		{
			GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Rebuild as octree",
			GUI.TOOLTIP : "Rebuilds the scene graph of the active scene as octree.",
			GUI.SIZE: [GUI.WIDTH_FILL_ABS, 10, 0],
			GUI.ON_CLICK : fn() {
				// Get the active scene
				var scene = PADrend.getCurrentScene();
				// Rebuild as octree
				MinSG.TreeBuilder.rebuildAsOcTree(scene, {
					MinSG.TreeBuilder.MAX_TREE_DEPTH: 10,
					MinSG.TreeBuilder.MAX_CHILD_COUNT: 8,
					MinSG.TreeBuilder.LOOSE_FACTOR: 2,
					MinSG.TreeBuilder.PREFERE_CUBES: true,
					MinSG.TreeBuilder.USE_GEOMETRY_BB: false,
					MinSG.TreeBuilder.EXACT_CUBES: true,
				});
			}
		},
		GUI.NEXT_ROW,
		{
			GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Add ColorCube Renderer",
			GUI.TOOLTIP : "Add the ColorCube renderer to the scene!",
			GUI.SIZE: [GUI.WIDTH_FILL_ABS, 10, 0],
			GUI.ON_CLICK : fn() {				
				// Check if the ColorCube renderer is available
				if(!MinSG.isSet($ColorCubeRenderer)) {
					outln("WARNING: ColorCubeRenderer is not available!");
					outln("You need to build PADrend with the flag MINSG_EXT_COLORCUBES.");
					return;
				}				
				// Get the active scene
				var scene = PADrend.getCurrentScene();
				// Remove all previous states
				scene.removeStates();				
				// We need a ProjSizeFilterState for the color cubes to work
				scene += (new MinSG.ProjSizeFilterState).setMaximumProjSize(100);				
				// add TreeBuilder.rebuildAsQuadTree to scene
				scene += new MinSG.TreeBuilder.rebuildAsQuadTree;//ColorCubeRenderer;
			}
		},
		GUI.NEXT_ROW,
		{
			GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Add ExampleRenderer (Scripted)",
			GUI.TOOLTIP : "Add the scripted ExampleRenderer to the scene!",
			GUI.SIZE: [GUI.WIDTH_FILL_ABS, 20, 5],
			GUI.ON_CLICK : fn() {
				// Get the active scene
				var scene = PADrend.getCurrentScene();
				// Remove all previous states
				scene.removeStates();
				// load the ScriptedExampleRenderer module
				var ScriptedExampleRenderer = Std.module('SamanVipasyanAvishek_Group/ScriptedExampleRenderer');
				// add ScriptedExampleRenderer to scene
				scene += new ScriptedExampleRenderer;
			}
		},
			GUI.NEXT_ROW,
		{
			GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Add Camera Effect (Scripted)",
			GUI.TOOLTIP : "Add the scripted ExampleRendererCamera to the scene!",
			GUI.SIZE: [GUI.WIDTH_FILL_ABS, 20, 5],
			GUI.ON_CLICK : fn() {
				// Get the active scene
				var scene = PADrend.getCurrentScene();
				// Remove all previous states
				scene.removeStates();
				// load the ScriptedExampleRenderer module
				var ScriptedExampleRendererCamera = Std.module('SamanVipasyanAvishek_Group/ScriptedExampleRendererCamera');
				// add ScriptedExampleRenderer to scene
				scene += new ScriptedExampleRendererCamera;
			}
		},
		GUI.NEXT_ROW,
		{
			GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Add Color Effect (Scripted)",
			GUI.TOOLTIP : "Add the scripted ExampleRendererColor to the scene!",
			GUI.SIZE: [GUI.WIDTH_FILL_ABS, 20, 5],
			GUI.ON_CLICK : fn() {
				// Get the active scene
				var scene = PADrend.getCurrentScene();
				// Remove all previous states
				scene.removeStates();
				// load the ScriptedExampleRenderer module
				var ScriptedExampleRendererColor = Std.module('SamanVipasyanAvishek_Group/ScriptedExampleRendererColor');
				// add ScriptedExampleRenderer to scene
				scene += new ScriptedExampleRendererColor;
			}
		},
		GUI.NEXT_ROW,
	]);

};

// ---------------------------

// GUI initialization for C++ part
static initCppGUI = fn(gui) {
	
	// Register additional content of the dialog window
	gui.register('ExampleProject_WindowEntries.cppContent',[
		// See https://padrend.github.io/Tutorials/gui_factories for a description of all values
		{
			GUI.TYPE : GUI.TYPE_BUTTON,
			GUI.LABEL : "Add ExampleRenderer (C++)",
			GUI.TOOLTIP : "Add the C++ ExampleRenderer to the scene!",
			GUI.SIZE: [GUI.WIDTH_FILL_ABS, 20, 5],
			GUI.ON_CLICK : fn() {
				// Get the active scene
				var scene = PADrend.getCurrentScene();
				// Remove all previous states
				scene.removeStates();
				// add ExampleRenderer to scene
				scene += new ExampleProject.ExampleRenderer;
			}
		},
		GUI.NEXT_ROW,
	]);
	
	// Register the renderer at the NodeEditor
	registerExtension( 'NodeEditor_QueryAvailableStates' , ExampleProject.ExampleRenderer->fn(states) {
		if(Renderer!=this)
			return Extension.REMOVE_EXTENSION;
		states["[Ext] ExampleRenderer"] = this->fn(){return new this();};
	});

	// Create a config gui for the renderer
	NodeEditor.registerConfigPanelProvider( ExampleProject.ExampleRenderer, fn(renderer, panel) {
		panel += {
			GUI.TYPE : GUI.TYPE_BOOL,
			GUI.LABEL : "Draw bounding boxes",
			GUI.DATA_WRAPPER : DataWrapper.createFromFunctions(renderer->renderer.getDrawBoundingBox, renderer->renderer.setDrawBoundingBox),
		};
		panel++; // next row
	});
};

return plugin;
// ------------------------------------------------------------------------------
