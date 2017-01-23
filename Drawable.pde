class Drawable {

	int x;
	int y;

	color cfill;
	color cstroke;
	color chighlight;

	boolean selected;

	public Drawable(int x, int y) {
		this.x = x;
		this.y = y;

		cfill = color(255, 255, 255);
		cstroke = color(0, 0, 0);
		chighlight = color(255);

		selected = false;
	}

}
