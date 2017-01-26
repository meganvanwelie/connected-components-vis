class DrawableQueue extends SquareDrawable {

	var queue;			// javascript queue, easiest way in Processing.js
	QueueItem head;

	int itemWidth;
	int itemHeight;
	int itemBorder;

	int maxItems;

	public DrawableQueue(int x, int y, int w, int h) {
		super(x, y, w, h);

		this.queue = [];

		this.itemBorder = 4;
		int queueWidth = this.width - itemBorder;
		int queueHeight = this.height - itemBorder*4;

		float itemAspectRatio = 0.3;

		// calculate queue item height
		this.maxItems = (int)(queueHeight / (queueWidth * itemAspectRatio));
		this.itemHeight = queueHeight / (maxItems + 1);
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
		int yPos = y + itemBorder;

		// draw empty head background
		fill(color(200, 200, 200));
		noStroke();
		rect(xPos, yPos, itemWidth, itemHeight);

		// set item queue colors
		fill(color(255));
		stroke(color(0));

		// draw head if item has been dequeued
		if (head != null) {
			rect(xPos, yPos, itemWidth, itemHeight);
		}
		yPos += itemBorder + itemHeight; // always start below head position

		// draw remainder of queue
		PVector item;
		int num = Math.min(this.maxItems, size());
		for (int i = 0; i < num; ++i) {
			item = this.queue[i];

			// draw background
			fill(color(255));
			stroke(color(0));
			rect(xPos, yPos, itemWidth, itemHeight);

			// draw label
			label = "( " + item.x + ", " + item.y + " )";
			fill(color(0));
			textAlign(CENTER);
			text(label, xPos + itemWidth/2, yPos + itemHeight/2);

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
