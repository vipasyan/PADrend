/*
Any copyright is dedicated to the Public Domain.
http://creativecommons.org/publicdomain/zero/1.0/
Author: Sascha Brandt <sascha@brandt.graphics>
*/

/*
Modifications done by: Saman Saman, Vipasyan Telaprolu, Avishek Mishra.
*/


// Create a new Type which inherits from MinSG.ScriptedNodeRendererState
static Renderer = new Type( MinSG.ScriptedNodeRendererState );
// Set the name of the Renderer (for GUI)
Renderer._printableName @(override) ::= $ScriptedExampleRenderer;

// load the shader
var vsFile = __DIR__ + "/../../data/shader/SimpleShader.vs";
var fsFile = __DIR__ + "/../../data/shader/SimpleShader.fs";
static shader = Rendering.Shader.loadShader(vsFile, fsFile);

// When adding @(init) to a variable, the variable gets initialized by the return value of the function.
Renderer.drawBoundingBox @(init) := fn() { return new Std.DataWrapper(true); };
Renderer.rootNode @(private) := void;

//--------------------

// Constructor
Renderer._constructor ::= fn() {
	// nothing to do here
};

//--------------------

/**
 * Gets called before traversal.
 * The return value indicates if the traversal should continue or not.
 */
Renderer.doEnableState @(override) ::= fn(node, params) {
	// Set the root node
	//this.rootNode = node;
	//This will skip rendering if the node is more than 12 units away from camera
	
    var camPos = frameContext.getCamera().getWorldOrigin();
	var nodepos = node.getWorldPosition();
	//outln("hello -1");
	var diff = (camPos - nodepos).length();
	outln("Camera = " +diff);
	
	if(diff > 12 ) 
	{
	// You can also return MinSG.STATE_SKIP_RENDERING to break the traversal (doDisableState does also not get called)
	return MinSG.STATE_SKIP_RENDERING; }
	else
	{
	  return MinSG.STATE_OK;
	}
 
};



//----------------------------------------------------------------
// GUI
//----------------------------------------------------------------

// Register the renderer at the NodeEditor
registerExtension( 'NodeEditor_QueryAvailableStates' , Renderer->fn(states){
	if(Renderer!=this)
		return Extension.REMOVE_EXTENSION;
	states[ "[scripted] "+_printableName ] = this->fn(){return new this();};
});




// Register an exporter for this renderer so that we can save it in a .minsg file
Std.module.on( 'LibMinSGExt/ScriptedStateExportersRegistry',fn(registry){
	registry[Renderer._printableName] = fn(state,description){	
		description['drawBoundingBox'] = state.drawBoundingBox();
	};
});

// return the renderer so that we can use it as a module
return Renderer;