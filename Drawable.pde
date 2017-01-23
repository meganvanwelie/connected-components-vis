class Drawable {

	float x;
	float y;

	private color cbackgounrd;
	private color cforeground;
	private color ctext;
	private color cstroke;
	private color chighlight;

	private boolean selected;

	public Drawable(float x, float y) {
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

	public void setNoStroke() {
		this.cstroke = null;
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

	public void onMousePressed() {
		console.log("ERROR: Not implemented, subclass responsibility!");
	}

}

class SquareDrawable extends Drawable {

	float width;
	float height;

	public SquareDrawable(float x, float y, float w, float h) {
		super(x, y);
		this.width = w;
		this.height = h;
	}

	public void draw() {
		if (isSelected()) {
			fill(highlightColor());
		} else {
			fill(backgroundColor());
		}
		if (strokeColor() != null) {
			stroke(strokeColor());
		} else {
			noStroke();
		}
		rect(this.x, this.y, width, height);
	}

}
