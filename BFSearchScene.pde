class BFSearchScene extends Scene {

	var queue;

	Pvector sweepSearchPixel;
	Pvector bfsSearchPixel;

	int currentComponentId;
	HashMap<int, ArrayList<PVector>> connectedComponents;

	ArrayList<PVector> neighborPixels;

	// Timeline of updates
	//   1. step one pixel over.
	//     NEGATIVE: at end of image, stop.
	//     POSTIIVE: highlight selected pixel, check if it has been assigned. continue.
	int SWEEP_SEARCH_STEP = 1;
	//   2. check if new sweep step pixel has been assigned
	//     NEGATIVE. No, go to 1.
	//     POSITIVE. Yes, set as active pixel. continue.
	int IS_PIXEL_A_NEW_COMPONENT = 2;
	//   3. find neighbors of selected pixel and add to queue. continue.
	int ADD_NEIGHBORS_TO_QUEUE = 3;
	//   4. take value from queue. continue.
	//     NEGATIVE: queue was empty, go to 1.
	//     POSITIVE: queue was not empty, set new value as active pixel. continue.
	int TAKE_PIXEL_FROM_QUEUE = 4;
	//   5. check if queue pixel is marked and has same ID. continue.
	//     NEGATIVE: if it is marked or has different ID, skip. go to 4.
	//     POSITIVE: not marked and has same ID, add to component. go to 3.
	int IS_PIXEL_UNASSIGNED_AND_IN_CURRENT_COMPONENT = 5;

	public BFSearchScene() {
		super();
		this.mode = SWEEP_SEARCH_STEP;

		this.queue = [];
		this.sweepSearchPixel = new PVector(-1, 0); // -1 so first step is (0,0)
		this.bfsSearchPixel = null;

		this.currentComponentId = 0;
		this.connectedComponents = new HashMap<int, ArrayList<PVector>>();

		this.neighborPixels = new ArrayList<PVector>();
	}

	// executes current mode, updates mode to execute on next call
	public boolean update() {
		console.log("Current mode: " + mode);
		switch(mode) {
			case SWEEP_SEARCH_STEP:
				sweepSearchPixel = nextPixel(sweepSearchPixel);
				if (sweepSearchPixel == null) {
					// no remaining un-visited pixels, end algorithm.
					setMainText("END OF ALGORITHM");
					return false;
				} else {
					// new pixel found, highlight it
					setMainText("We stepped to the next pixel, and found one.");
					//grid.image[sweepSearchPixel.y][sweepSearchPixel.x].select(true);
					// continue on to check if it has been visited
					mode = IS_PIXEL_A_NEW_COMPONENT;
				}
				break;
			case IS_PIXEL_A_NEW_COMPONENT:
				if (isPixelAssigned(sweepSearchPixel)) {
					// pixel already assigned, gray out highlight and continue on to look for next pixel
					setMainText("Pixel was already assigned, so we do not attempt to reassign.");
					mode = SWEEP_SEARCH_STEP;
				} else {
					// pixel not yet assigned, show as active pixel and continue on BFS search
					currentComponentId = createNewComponent();
					addPixelToComponent(currentComponentId, sweepSearchPixel);
					setMainText("Pixel is not yet assigned. We add it to our component.");
					mode = ADD_NEIGHBORS_TO_QUEUE;
				}
				break;
			case ADD_NEIGHBORS_TO_QUEUE:
				// highlight neighbors and add to queue
				ArrayList<PVector> neighbors;
				if (bfsSearchPixel != null) {
					neighbors = searchNeighbors(bfsSearchPixel);
				} else {
					neighbors = searchNeighbors(sweepSearchPixel);
				}
				for (PVector n : neighbors) {
					if (grid.inRange(n)) {
						setNeighborPixel(n);
						queue.push(n);
					}
				}
				setMainText("We now look to the neighbors of the pixel to see if they are in the component. Add to queue");
				mode = TAKE_PIXEL_FROM_QUEUE;
				break;
			case TAKE_PIXEL_FROM_QUEUE:
				clearNeighborPixels();
				if (queue.length == 0) {
					bfsSearchPixel = null;
					setMainText("Queue was empty. There are no more candidates for current component. We continue our sweep.");
					mode = SWEEP_SEARCH_STEP;
				} else {
					// highlight popped value as currently considered
					bfsSearchPixel = queue.shift();
					setMainText("We consider first value on queue");
					mode = IS_PIXEL_UNASSIGNED_AND_IN_CURRENT_COMPONENT;
				}
				break;
			case IS_PIXEL_UNASSIGNED_AND_IN_CURRENT_COMPONENT:
				setActivePixel(bfsSearchPixel);
				if (isPixelAssigned(bfsSearchPixel) ||
						pixelId(bfsSearchPixel) != pixelId(sweepSearchPixel)) {
					setMainText("This pixel has already been assigned or is not in our current component. TODO: indicate which one.");
					mode = TAKE_PIXEL_FROM_QUEUE;
				} else {
					addPixelToComponent(currentComponentId, bfsSearchPixel);
					setMainText("This pixel was in our current component! Add to component, and continue on to add this pixels neighbors to queue.");
					mode = ADD_NEIGHBORS_TO_QUEUE;
				}
				break;
		}

		return true;
	}

	private void clearNeighborPixels() {
		for (PVector p : neighborPixels) {
			//TODO: clear pixel style
			//grid.image[p.y][p.x].clearState();
		}
		neighborPixels.clear();
	}

	private void setNeighborPixel(PVector p) {
		neighborPixels.add(p);
		//TODO: set new style to pixel
		//grid.image[p.y][p.x].setSpecialState("neighbor", neighborState);
	}

	private void clearActivePixel() {
		activePixel = null;
		//TODO: clear pixel style
		//grid.image[p.y][p.x].clearState();
	}

	private void setActivePixel(PVector p) {
		activePixel = p;
		//TODO: set new style to pixel
		//grid.image[p.y][p.x].setSpecialState("active", activeState);
	}

	private boolean isPixelAssigned(PVector p) {
		return grid.image[p.y][p.x].isAssigned();
	}

	private int pixelGroupId(PVector p) {
		return grid.image[p.y][p.x].groupId;
	}

	private int pixelId(PVector p) {
		return grid.image[p.y][p.x].id;
	}

	private ArrayList<PVector> searchNeighbors(PVector p) {
		ArrayList<PVector> neighbors = new ArrayList<PVector>();
		neighbors.add(new PVector(p.x+1, p.y));
		neighbors.add(new PVector(p.x-1, p.y));
		neighbors.add(new PVector(p.x, p.y+1));
		neighbors.add(new PVector(p.x, p.y-1));
		return neighbors;
	}

	private PVector nextPixel(PVector p) {
		PVector next = new PVector(p.x + 1, p.y);
		if (!grid.inRange(next)) {
			next.x = 0;
			next.y = p.y + 1;
			if (!grid.inRange(next)) {
				next = null;
			}
		}
		return next;
	}

	private int createNewComponent() {
		currentComponentId += 1;
		connectedComponents.put(currentComponentId, new ArrayList<PVector>());
		return currentComponentId;
	}

	private void addPixelToComponent(int componentId, PVector p) {
		if (connectedComponents.containsKey(componentId)) {
			// set group ID of corresponding pixel in image grid
			grid.image[p.y][p.x].setGroupId(componentId);

			// add pixel representation to connected components
			ArrayList<PVector> pixelsInComponent = connectedComponents.get(componentId);
			pixelsInComponent.add(p);
			connectedComponents.put(componentId, pixelsInComponent);
		} else {
			console.log("ERROR: component not yet created.");
		}
	}
}

