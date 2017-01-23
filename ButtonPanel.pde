class ButtonPanel extends SquareDrawable {

	HashMap<String, Button> buttons;

	int width;
	int height;

	public ButtonPanel(int x, int y, int w, int h) {
		super(x, y, w, h);
		this.width = w;
		this.height = h;

		this.buttons = new HashMap<String, Button>();
	}

	public void addButton(int w, int h, int x, int y,
							String label, var functionality) {
		Button button = new Button(w, h, x, y);
		button.setLabel(label);
		button.setFunctionality(functionality);
		buttons.put(label, button);
	}

	public void draw() {
		super.draw();
		for (Button button : buttons.values()) {
			button.draw();
		}
	}

	public void onMouseClick() {
		for (Button button : buttons.values()) {
			if (button.contains(mouseX, mouseY)) {
				button.click();
				break;
			}
		}
	}
}

class Button extends Drawable {

	var functionality;
	String label;

	int width;
	int height;

	public Button(int x, int y, int w, int h) {
		super(x, y);
		this.width = w;
		this.height = h;

		functionality = null;
		label = "Click Me";

		chighlight = color(255, 0, 0);

		selected = false;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public void setFunctionality(var functionality) {
		this.functionality = functionality;
	}

	public void draw() {
		// draw button
		fill(backgroundColor());
		stroke(strokeColor());
		rect(this.x, this.y, width, height);
		// draw button text
		fill(textColor());
		textAlign(CENTER);
		text(this.label, this.x + width/2, this.y + height/2);
	}

	public void click() {
		if (functionality != null) {
			functionality();
		}
		console.log(this.label + ": button clicked");
	}

	public boolean contains(int x, int y) {
		return (x >= this.x && x <= this.x + width) &&
			   (y >= this.y && y <= this.y + height);
	}

}
