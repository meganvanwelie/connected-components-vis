class Drawable {

	float x;
	float y;

	public DrawableStyle style;
	public DrawableState specialStyle;

	private boolean selected;
	private boolean visible;

	public Drawable(float x, float y) {
		this.x = x;
		this.y = y;

		this.style = new DrawableStyle();
		this.specialStyle = null;

		select(false);
		show();
	}

	public void select() {
		this.selected = !this.selected;
	}

	public void select(boolean s) {
		this.selected = s;
	}

	public boolean isSelected() {
		return this.selected;
	}

	public void show() {
		visible = true;
	}

	public void hide() {
		visible = false;
	}

	public boolean isVisible() {
		return this.visible;
	}

	public void onMouseClick() {
		console.log("ERROR: Not implemented, subclass responsibility!");
	}

	public void onMousePressed() {
		console.log("ERROR: Not implemented, subclass responsibility!");
	}

	public void setStyle(DrawableStyle s) {
		this.style = s;
	}

	public void setSpecialStyle(DrawableStyle s) {
		this.specialStyle = s;
	}

	public void clearSpecialStyle() {
		this.specialStyle = null;
	}

	public void currentStyle() {
		if (specialStyle != null) {
			return specialStyle;
		} else {
			return style;
		}
	}

}

class DrawableStyle {

	private color cbackground;
	private color cforeground;
	private color ctext;
	private color cstroke;
	private color chighlight;

	public DrawableStyle() {
		setBackgroundColor(color(255));
		setForegroundColor(color(255));
		setTextColor(color(0));
		setStrokeColor(color(0));
		setHighlightColor(color(255, 0, 0));
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
		// always draw regular style
		if (isSelected()) {
			fill(style.highlightColor());
		} else {
			fill(style.backgroundColor());
		}
		if (style.strokeColor() != null) {
			stroke(style.strokeColor());
		} else {
			noStroke();
		}
		rect(x, y, width, height);
	}

}

