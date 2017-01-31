class ButtonPanel extends SquareDrawable {

	HashMap<String, Button> buttons;
	Button activeButton;
	String mainText;

	public ButtonPanel(float x, float y, float w, float h) {
		super(x, y, w, h);
		this.buttons = new HashMap<String, Button>();
		this.activeButton = null;
		this.mainText = "Left click to select, right click to deselect.";
	}

	public void addButton(float w, float h, float x, float y,
							String label, var functionality,
							boolean hideOnRelease) {
		Button button = new Button(w, h, x, y);
		button.setLabel(label);
		button.setFunctionality(functionality);
		button.style.setHighlightColor(color(0, 191, 165));
		button.setHideOnRelease(hideOnRelease);
		buttons.put(label, button);
	}

	public void setMainText(String text) {
		mainText = text;
	}

	public void hideButton(String id) {
		buttons.get(id).hide();
	}

	public void showButton(String id) {
		buttons.get(id).show();
	}

	public void draw() {
		super.draw();
		for (Button button : buttons.values()) {
			if (button.isVisible()) {
				button.draw();
			}
		}
		if (mainText != null) {
			fill(style.textColor());
			textAlign(CENTER);
			text(mainText, this.x + width/2, this.y + height/2);
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

	boolean hideOnRelease;

	public Button(float x, float y, float w, float h) {
		super(x, y, w, h);
		this.label = null;
		this.functionality = null;
		this.hideOnRelease = false;

		style.setHighlightColor(color(255, 0, 0));
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public void setFunctionality(var functionality) {
		this.functionality = functionality;
	}

	public void setHideOnRelease(boolean hide) {
		this.hideOnRelease = hide;
	}

	public void draw() {
		super.draw();
		// draw button text
		fill(style.textColor());
		textAlign(CENTER);
		if (label != null) {
			text(this.label, this.x + width/2, this.y + height/2);
		}
	}

	public void click() {
		if (functionality != null) {
			functionality();
		}
		select(true);
		console.log(this.label + ": button clicked");
	}

	public void release() {
		select(false);
		if (hideOnRelease) {
			hide();
		}
	}

	public boolean contains(int x, int y) {
		return (x >= this.x && x <= this.x + width) &&
			   (y >= this.y && y <= this.y + height);
	}

}
