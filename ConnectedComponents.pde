float radius = 50.0;
int X, Y;
int nX, nY;
int delay = 16;

ImageGrid grid;
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
  int border = 5;
  size( w+2*border, h+2*border );

  // setup and initialize scene manager
  sceneManager = new SceneManager();
  sceneManager.init();

  // create image grid
  grid = new ImageGrid(border, border, w, h-50, 10, 10);
  grid.setStrokeColor(color(255, 0, 255));

  // create control button panel
  controls = new ButtonPanel(border, h-50, w, 50);
  controls.addButton(10, h-50+5, 40, 25, buttonDemo, demo);
  controls.addButton(w-10-40, h-50+5, 40, 25, buttonStart, startAlgorithm);
}

void draw(){
  background(0, 0, 0);

  if (sceneManager.update()) {
	  /*
	  if (queue.length > 0) {
		currentPixel = queue.shift();
		addToQueue(currentPixel.neighbors());
	  } else {
		sweepPixel = sweepPixel.nextPixel(grid);
		if (!sweepPixel.isAssigned()) {
			updateConnectedComponentId(); // get next ID
			queue.push(sweepPixel);		  // add to queue
		}
	  }
	  */
  }

  grid.draw();
  controls.draw();
}

void mouseDragged() {
	console.log("Main mouse dragged");
	if (sceneManager.scene == sceneManager.SCENE_CREATE_IMAGE) {
		grid.onMouseDragged();
	}
}

void mousePressed() {
	console.log("Main mouse click");
	if (sceneManager.scene == sceneManager.SCENE_CREATE_IMAGE) {
		grid.onMousePressed();
	}
	controls.onMousePressed();
}

void mouseReleased() {
	controls.onMouseReleased();
}

