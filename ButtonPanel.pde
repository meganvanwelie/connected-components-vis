class ButtonPanel extends SquareDrawable {

	HashMap<String, Button> buttons;

	public ButtonPanel(float x, float y, float w, float h) {
		super(x, y, w, h);
		this.buttons = new HashMap<String, Button>();
	}

	public void addButton(float w, float h, float x, float y,
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

	public void onMousePressed() {
		for (Button button : buttons.values()) {
			if (button.contains(mouseX, mouseY)) {
				activeButton = button;
				activeButton.click();
				break;
			}
		}
	}

	public void onMouseReleased() {
		if (activeButton != null) {
			activeButton.release();
			activeButton = null;
		}
	}
}

class Button extends SquareDrawable {

	String label;
	var functionality;

	public Button(float x, float y, float w, float h) {
		super(x, y, w, h);
		this.label = "";
		this.functionality = null;

		setHighlightColor(color(255, 0, 0));
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public void setFunctionality(var functionality) {
		this.functionality = functionality;
	}

	public void draw() {
		super.draw();
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
