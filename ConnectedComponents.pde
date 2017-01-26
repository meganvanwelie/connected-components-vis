ImageGrid grid;
SceneManager sceneManager;
BFSearchScene algorithm;
DrawableQueue queue;

int backgroundId = 0;
int foregroundId = 1;

// Setup buttons
// First-class Javascript functions, triggered by button presses
var demo = function() {
	console.log("Demo function!");
	imageCreated = true;
};

var startAlgorithm = function() {
	console.log("Start function!");
	imageCreated = true;
};

String buttonDemo = "Demo";
String buttonStart = "Start";
boolean imageCreated;

void setup(){
  int w = 600;
  int h = 600;
  int border = 5;
  size(w+2*border, h+2*border);

  // setup and initialize scene manager
  sceneManager = new SceneManager();
  sceneManager.init();

  algorithm = new BFSearchScene();

  // create image grid
  int gridSize = w*(3/4);
  grid = new ImageGrid(border, border, gridSize, gridSize, 10, 10);
  grid.style.setStrokeColor(color(255, 0, 255));

  // create queue
  int queueWidth = w - gridSize - border;
  int queueHeight = gridSize;
  queue = new DrawableQueue(2*border+gridSize, border, queueWidth, queueHeight);

  // create control button panel
  controls = new ButtonPanel(border, h-50, w, 50);
  controls.addButton(10, h-50+5, 40, 25, buttonDemo, demo);
  controls.addButton(w-10-40, h-50+5, 40, 25, buttonStart, startAlgorithm);

  imageCreated = false;
}

void reset() {
	//TODO:
	//sceneManager.reset();
	//grid.reset();
	//algorithm.reset();
	//imageCreated = false;
}

void draw(){
  background(0, 0, 0);

  switch (sceneManager.scene) {
	  case sceneManager.SCENE_CREATE_IMAGE:
		  // no work to do, wait for user input
		  if (imageCreated) {
			sceneManager.nextScene();
		  }
		  break;
	  case sceneManager.SCENE_SEARCH:
		  if (sceneManager.update() && !algorithm.update()) {
			sceneManager.nextScene();
		  }
		  break;
	  case sceneManager.SCENE_FINSIHED:
		  // show closing scene
		  break;
  }

  grid.draw();
  controls.draw();
  queue.draw();
}

void mouseDragged() {
	if (sceneManager.scene == sceneManager.SCENE_CREATE_IMAGE) {
		grid.onMouseDragged();
	}
}

void mousePressed() {
	if (sceneManager.scene == sceneManager.SCENE_CREATE_IMAGE) {
		grid.onMousePressed();
	}
	controls.onMousePressed();
}

void mouseReleased() {
	if (sceneManager.scene == sceneManager.SCENE_CREATE_IMAGE) {
		grid.onMouseReleased();
	}
	controls.onMouseReleased();
}

