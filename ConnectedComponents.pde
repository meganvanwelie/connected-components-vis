/* @pjs font="https://fonts.googleapis.com/css?family=Roboto"; */
/* @pjs font="https://fonts.googleapis.com/css?family=Sansita"; */

ImageGrid grid;
SceneManager sceneManager;
BFSearchScene algorithm;
DrawableQueue queue;

// Setup buttons
// First-class Javascript functions, triggered by button presses
var startAlgorithm = function() {
	console.log("Start function!");
	imageCreated = true;
};

String buttonStart = "Start";
boolean imageCreated;

void setup(){
  int w = 600;
  int h = 550;
  int border = 5;
  size(w+2*border, h+2*border);

  // setup and initialize scene manager
  sceneManager = new SceneManager();
  sceneManager.init();

  algorithm = new BFSearchScene();

  // create image grid
  int gridSize = w*(3/4);
  grid = new ImageGrid(border, border, gridSize, gridSize, 10, 10);

  // create queue
  int queueWidth = w - gridSize - border;
  int queueHeight = gridSize;
  console.log("window size " + queueHeight);
  queue = new DrawableQueue(2*border+gridSize, border, queueWidth, queueHeight);

  // create control button panel
  int buttonPanelHeight = h - gridSize - border;
  controls = new ButtonPanel(border, 2*border+gridSize, w, buttonPanelHeight);
  int buttonSize = buttonPanelHeight - 4*border;
  controls.addButton(3*border, h-buttonSize-border, buttonSize, buttonSize,
						buttonStart, startAlgorithm, true);

  imageCreated = false;

  textFont(createFont("Sansita", 14));
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
		  controls.setMainText(algorithm.mainText());
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

