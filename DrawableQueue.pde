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

		PVector item;
		int xPos = x + itemBorder;
		int yPos = y + itemBorder;

		// draw empty head background
		fill(color(200, 200, 200));
		noStroke();
		rect(xPos, yPos, itemWidth, itemHeight);

		// draw head if item has been dequeued
		if (head != null) {
			item = head;
			label = "( " + item.x + ", " + item.y + " )";
			drawQueueItem(xPos, yPos, label);
		}
		yPos += itemBorder + itemHeight; // always start below head position

		// calculate number of queue items too show
		int num = size();
		boolean drawTooLarge = false;
		if (num > this.maxItems) {
			num = this.maxItems - 2;
			drawTooLarge = true;
		}

		// draw remainder of queue
		for (int i = 0; i < num; ++i) {
			item = this.queue[i];
			label = "( " + item.x + ", " + item.y + " )";
			drawQueueItem(xPos, yPos, label);
			yPos += itemHeight;
		}

		if (drawTooLarge) {
			// draw ellipse indicating that the queue is too large
			fill(color(200, 200, 200));
			noStroke();
			float ellipseX = xPos + itemWidth/2;
			float ellipseHeight = itemHeight / 7;
			ellipse(ellipseX, yPos + 1*ellipseHeight + ellipseHeight/2,
					ellipseHeight, ellipseHeight);
			ellipse(ellipseX, yPos + 3*ellipseHeight + ellipseHeight/2,
					ellipseHeight, ellipseHeight);
			ellipse(ellipseX, yPos + 5*ellipseHeight + ellipseHeight/2,
					ellipseHeight, ellipseHeight);

			// draw final item in queue
			yPos += itemHeight;
			item = this.queue[size() - 1];
			label = "( " + item.x + ", " + item.y + " )";
			drawQueueItem(xPos, yPos, label);
		}

	}

	private void drawQueueItem(int x, int y, String label) {
		// draw background
		fill(color(255));
		stroke(color(0));
		rect(x, y, itemWidth, itemHeight);

		// draw label
		fill(color(0));
		textAlign(CENTER);
		text(label, x + itemWidth/2, y + itemHeight/2);
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
