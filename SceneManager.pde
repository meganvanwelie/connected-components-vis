public class SceneManager {

	int SCENE_CREATE_IMAGE = 0;
	int SCENE_SEARCH = 1;
	int SCENE_FINISHED = 2;

	int scene;

	public SceneManager() {}

	public void init() {
		scene = 0;
	}

	public boolean nextScene() {
		if (scene < 3) {
			scene += 1;
		}
	}

}
