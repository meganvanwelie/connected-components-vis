class ImageGrid extends SquareDrawable {

	float xdiv;
	float ydiv;
	int hsteps;
	int vsteps;

	Pixel[][] image;
	ArrayList<GridLine> gridLines;

	Pixel activePixel;

	public ImageGrid(float x, float y, float w, float h, int hsteps, int vsteps) {
		super(x, y, w, h);
		this.hsteps = hsteps;
		this.vsteps = vsteps;

		// calculate size of grid lines
		this.xdiv = w / hsteps;
		this.ydiv = h / vsteps;

		// initialize grid lines for efficient drawing
		this.gridLines = new ArrayList<GridLine>();
		int i;
		PVector start, end;
		for (i = x; i <= x + width; i += xdiv) {
			start = new PVector(i, y);
			end = new PVector(i, y + height);
			this.gridLines.add(new GridLine(start, end));
		}
		for (i = y; i <= y + height; i += ydiv) {
			start = new PVector(x, i);
			end = new PVector(x + width, i);
			this.gridLines.add(new GridLine(start, end));
		}

		// initialize pixel grid
		this.image = new Pixel[vsteps][hsteps]; // rows x cols
		Pixel p;
		int row, col;
		for (row = 0; row < vsteps; ++row) {
			for (col = 0; col < hsteps; ++col) {
				p = new Pixel(row, col, x+col*xdiv, y+row*ydiv, xdiv, ydiv);
				p.setId(backgroundId); // all pixels set to background ID
				this.image[row][col] = p;
			}
		}

		this.activePixel = null;
	}

	private void update() {
		switch(sceneManager.scene) {
			case sceneManager.SCENE_CREATE_IMAGE:
				setActivePixelState();
				break;
		}
	}

	public void draw() {
		super.draw();
		update();

		// draw pixels
		int row, col;
		for (row = 0; row < vsteps; ++row) {
			for (col = 0; col < hsteps; ++col) {
				this.image[row][col].draw();
			}
		}
		// draw grid lines
		stroke(style.strokeColor());
		for (GridLine gl : gridLines) {
			line(gl.start.x, gl.start.y, gl.end.x, gl.end.y);
		}
	}

	public void onMousePressed() {
		locateActivePixel();
	}

	public void onMouseDragged() {
		// Efficiently checks for mouse drag by only considering
		// neighbors of pixel in which original click took place
		if (activePixel != null) {
			if (!activePixel.contains(mouseX, mouseY)) {
				ArrayList<Pixel> neighbors =
								activePixel.neighbors(image, vsteps, hsteps);
				clearActivePixel();
				for (Pixel p : neighbors) {
					if (p.contains(mouseX, mouseY)) {
						setActivePixel(p);
						break;
					}
				}
			}
		} else {
			locateActivePixel();
		}
	}

	public void onMouseReleased() {
		clearActivePixel();
	}

	public boolean contains(int x, int y) {
		return (x >= this.x && x <= this.x + width) &&
			   (y >= this.y && y <= this.y + height);
	}

	public boolean inRange(PVector p) {
		return (p.x >= 0 && p.x < hsteps && p.y >= 0 && p.y < vsteps);
	}

	/* Locates and sets the currently selected pixel.*/
	private void locateActivePixel() {
		clearActivePixel();
		if (contains(mouseX, mouseY)) {
			int col, row;
			outerloop:
			for (row = 0; row < vsteps; ++row) {
				for (col = 0; col < hsteps; ++col) {
					if (image[row][col].contains(mouseX, mouseY)) {
						setActivePixel(image[row][col]);
						break outerloop;
					}
				}
			}
		}
	}

	private void setActivePixel(Pixel p) {
		this.activePixel = p;
	}

	private void clearActivePixel() {
		this.activePixel = null;
	}

	private void setActivePixelState() {
		// set pixel to selected
		if (activePixel != null) {
			if (mouseButton == LEFT) {
				//activePixel.select(true);
				activePixel.setId(foregroundId);
			} else {
				//activePixel.select(false);
				activePixel.setId(backgroundId);
			}
		}
	}

}

class Pixel extends SquareDrawable {

	int row;
	int col;

	String label;
	int groupId;

	public Pixel(int row, int col, float x, float y, float w, float h) {
		super(x, y, w, h);
		this.row = row;
		this.col = col;

		this.label = null;

		this.id = -1;
		this.groupId = -1;		// unassigned

		style.setNoStroke();
	}

	public void setId(int id) {
		this.id = id;
		this.label = String.valueOf(id);
		if (id == 0) {
			style.setBackgroundColor(color(255)); //pixelColorMap.get(this.label));
		} else {
			style.setBackgroundColor(color(255, 0, 255));
		}
	}

	public void setGroupId(int id) {
		this.groupId = id;
	}

	public void isAssigned() {
		return (this.groupId != -1);
	}

	public ArrayList<Pixel> neighbors(Pixel[][] image, int rows, int cols) {
		ArrayList<Pixel> neighbors = new ArrayList<Pixel>();
		if (row-1 >= 0)   { neighbors.add(image[row-1][col]); }
		if (row+1 < rows) { neighbors.add(image[row+1][col]); }
		if (col-1 >= 0)   { neighbors.add(image[row][col-1]); }
		if (col+1 < cols) { neighbors.add(image[row][col+1]); }
		return neighbors;
	}

	public void draw() {
		super.draw();
		if (this.label != null) {
			fill(style.textColor());
			textAlign(CENTER);
			text(this.id, x + width/2, y + height/2);
		}
		/*
		if (visited) {
			fill(color(100, 100, 100, 100));
			rect(this.x, this.y, width, height);
		}
		*/
	}

	public boolean contains(int x, int y) {
		return (x >= this.x && x <= this.x + width) &&
			   (y >= this.y && y <= this.y + height);
	}

}

class GridLine<PVector, PVector> {
	public final PVector start;
	public final PVector end;

	public GridLine(PVector start, PVector end) {
		this.start = start;
		this.end = end;
	}
}
