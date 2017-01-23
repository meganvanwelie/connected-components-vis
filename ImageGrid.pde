class ImageGrid extends Drawable {

	int width;
	int height;

	float xdiv;
	float ydiv;

	ArrayList<GridLine> gridLines;
	Pixel[][] image;

	public ImageGrid(int x, int y, int w, int h, int hsteps, int vsteps) {
		super(x, y);
		this.width = w;
		this.height = h;

		this.xdiv = w / hsteps;
		this.ydiv = h / vsteps;

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

		this.image = new Pixel[vsteps][hsteps]; // rows x cols
	}

	public void draw() {
		fill(backgroundColor());
		rect(this.x, this.y, width, height);

		fill(foregroundColor());
		for (GridLine gl : gridLines) {
			line(gl.start.x, gl.start.y, gl.end.x, gl.end.y);
		}
	}

}

class Pixel {

	public Pixel() {

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
