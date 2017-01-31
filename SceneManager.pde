public class SceneManager {

	int SCENE_CREATE_IMAGE = 0;
	int SCENE_SEARCH = 1;
	int SCENE_FINISHED = 2;

	int scene;
	int sceneTimer;
	int STEP_SIZE = 1;
	int SCENE_DURATION = 20;

	public SceneManager() {
		init();
	}

	public void init() {
		scene = SCENE_CREATE_IMAGE;
		sceneTimer = 0;
	}

	public boolean update() {
		if (sceneTimer < SCENE_DURATION) {
			sceneTimer += STEP_SIZE;
			return false;
		} else {
			sceneTimer = 0;
			return true;
		}
	}

	public boolean nextScene() {
		switch(scene) {
			case SCENE_CREATE_IMAGE:
				scene = SCENE_SEARCH;
				break;
			case SCENE_SEARCH:
				scene = SCENE_FINISHED;
				break;
		}
		sceneTimer = SCENE_DURATION;
	}

}
