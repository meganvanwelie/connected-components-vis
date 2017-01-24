class Scene {

	int mode;

	private String mainText;

	public Scene() {
		this.mainText = "";
	}

	public void setMainText(String text) {
		mainText = text;
	}

	public void mainText() {
		return mainText;
	}

	public void update() {
		console.log("ERROR: update method is sub-classes responsibility");
	}

}
