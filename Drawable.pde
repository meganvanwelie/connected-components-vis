class Drawable {

	int x;
	int y;

	color cbackgounrd;
	color cforeground;
	color ctext;
	color cstroke;
	color chighlight;

	boolean selected;

	public Drawable(int x, int y) {
		this.x = x;
		this.y = y;

		setBackgroundColor(color(255));
		setForegroundColor(color(255));
		setTextColor(color(0));
		setStrokeColor(color(0));
		setHighlightColor(color(255));

		selected = false;
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
