float radius = 50.0;
int X, Y;
int nX, nY;
int delay = 16;

ImageGrid image;
SceneManager sceneManager;

// Setup buttons
// First-class Javascript functions, triggered by button presses
var demo = function() {
	console.log("Demo function!");
};

var startAlgorithm = function() {
	console.log("Start function!");
};

String buttonDemo = "Demo";
String buttonStart = "Start";

void setup(){
  int w = 600;
  int h = 600;
  size( w, h );

  // setup and initialize scene manager
  sceneManager = new SceneManager();
  sceneManager.init();

  // create image grid
  image = new ImageGrid(200, 150, 0, 0);

  // create control button panel
  controls = new ButtonPanel(0, h-50, w, 50);
  controls.addButton(10, h-50+5, 40, 25, buttonDemo, demo);
  controls.addButton(w-10-40, h-50+5, 40, 25, buttonStart, startAlgorithm);
}

void draw(){
  background(0, 0, 0);

  fill( 255, 121, 184 );
  ellipse( 40, 50, 50, 50);

  controls.draw();
}

void mouseClicked() {
	if (sceneManager.scene == sceneManager.SCENE_INIT) {
		imageGrid.onMouseClick();
	}
	controls.onMouseClick();
}

void mouseMoved(){
	if (sceneManager.scene == sceneManager.SCENE_INIT) {
		imageGrid.onMouseMoved();
	}
}


