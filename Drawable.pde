class Drawable {

	int x;
	int y;

	private color cbackgounrd;
	private color cforeground;
	private color ctext;
	private color cstroke;
	private color chighlight;

	private boolean selected;

	public Drawable(int x, int y) {
		this.x = x;
		this.y = y;

		setBackgroundColor(color(255));
		setForegroundColor(color(255));
		setTextColor(color(0));
		setStrokeColor(color(0));
		setHighlightColor(color(255, 0, 0));

		select(false);
	}

	public void select() {
		this.selected = !this.selected;
	}

	public void select(boolean s) {
		this.selected = s;
	}

	public void setBackgroundColor(color c) {
		this.cbackground = c;
	}

	public void setForegroundColor(color c) {
		this.cforeground = c;
	}

	public void setTextColor(color c) {
		this.ctext = c;
	}

	public void setStrokeColor(color c) {
		this.cstroke = c;
	}

	public void setHighlightColor(color c) {
		this.chighlight = c;
	}

	public boolean isSelected() {
		return this.selected;
	}

	public color backgroundColor() {
		return this.cbackground;
	}

	public color foregroundColor() {
		return this.cforeground;
	}

	public color textColor() {
		return this.ctext;
	}

	public color strokeColor() {
		return this.cstroke;
	}

	public color highlightColor() {
		return this.chighlight;
	}

	public void onMouseClick() {
		console.log("ERROR: Not implemented, subclass responsibility!");
	}

}

class SquareDrawable extends Drawable {

	int width;
	int height;

	public SquareDrawable(int x, int y, int w, int h) {
		super(x, y);
		this.width = w;
		this.height = h;
	}

	public void draw() {
		if (isSelected()) {
			fill(highlightColor());
			stroke(strokeColor());
		} else {
			fill(backgroundColor());
			stroke(strokeColor());
		}
		rect(this.x, this.y, width, height);
	}

}
