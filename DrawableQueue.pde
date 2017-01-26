class DrawableQueue extends SquareDrawable {

	var queue;			// javascript queue, easiest way in Processing.js
	QueueItem head;

	int itemWidth;
	int itemHeight;
	int itemBorder;

	public DrawableQueue(int x, int y, int w, int h) {
		super(x, y, w, h);

		this.queue = [];

		this.itemBorder = 4;
		this.itemHeight = 25;
		this.itemWidth = w - itemBorder*2;
	}

	public void clear() {
		this.queue.length = 0; // clear javascript array
	}

	public int size() {
		return this.queue.length;
	}

	public void enqueue(PVector p) {
		//QueueItem item = new QueueItem(0, null, p.x + " " + p.y);
		this.queue.push(p);
	}

	public PVector dequeue() {
		PVector next = this.queue.shift();
		head = next;
		return next;
	}

	public void clearHead() {
		head = null;
	}

	public void draw() {
		super.draw();

		int xPos = x + itemBorder;
		int yPos = y + itemBorder + itemHeight; // start below head position

		// TODO: handle too many items to draw
		int num = size();
		int endY = num*itemHeight + yPos;
		if (endY > (y + height)) {
			num = (int)((height - yPos) / itemHeight);
		}

		PVector item;
		for (int i = 0; i < num; ++i) {
			item = this.queue[i];

			fill(color(255));
			stroke(color(0));
			rect(xPos, yPos, itemWidth, itemHeight);

			yPos += itemHeight;
		}
	}

}

class QueueItem {

	int id;
	Drawable icon;
	String text;

	public QueueItem(int id, Drawable icon, String text) {
		this.id = id;
		this.icon = icon.copy(); // copy of drawable for safe movement
		this.text = text;
	}

}
