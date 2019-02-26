From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 26 Feb 2019 11:19:46 +0000
Subject: [PATCH 2/3] udlfb: fix sleeping inside spinlock
Message-Id: <20190226112122.160829572@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If a framebuffer device is used as a console, the rendering calls
(copyarea, fillrect, imageblit) may be done with the console spinlock
held. On udlfb, these function call dlfb_handle_damage that takes a
blocking semaphore before acquiring an URB.

In order to fix the bug, this patch changes the calls copyarea, fillrect
and imageblit to offload USB work to a workqueue.

A side effect of this patch is 3x improvement in console scrolling speed
because the device doesn't have to be updated after each copyarea call.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/video/fbdev/udlfb.c |   56 +++++++++++++++++++++++++++++++++++++++++---
 include/video/udlfb.h       |    6 ++++
 2 files changed, 59 insertions(+), 3 deletions(-)

Index: linux-4.19.25/drivers/video/fbdev/udlfb.c
=================================--- linux-4.19.25.orig/drivers/video/fbdev/udlfb.c	2019-02-25 16:19:19.000000000 +0100
+++ linux-4.19.25/drivers/video/fbdev/udlfb.c	2019-02-25 16:23:05.000000000 +0100
@@ -657,6 +657,50 @@ error:
 	return 0;
 }
 
+static void dlfb_init_damage(struct dlfb_data *dlfb)
+{
+	dlfb->damage_x = INT_MAX;
+	dlfb->damage_x2 = 0;
+	dlfb->damage_y = INT_MAX;
+	dlfb->damage_y2 = 0;
+}
+
+static void dlfb_damage_work(struct work_struct *w)
+{
+	struct dlfb_data *dlfb = container_of(w, struct dlfb_data, damage_work);
+	int x, x2, y, y2;
+
+	spin_lock_irq(&dlfb->damage_lock);
+	x = dlfb->damage_x;
+	x2 = dlfb->damage_x2;
+	y = dlfb->damage_y;
+	y2 = dlfb->damage_y2;
+	dlfb_init_damage(dlfb);
+	spin_unlock_irq(&dlfb->damage_lock);
+
+	if (x < x2 && y < y2)
+		dlfb_handle_damage(dlfb, x, y, x2 - x, y2 - y);
+}
+
+static void dlfb_offload_damage(struct dlfb_data *dlfb, int x, int y, int width, int height)
+{
+	unsigned long flags;
+	int x2 = x + width;
+	int y2 = y + height;
+
+	if (x >= x2 || y >= y2)
+		return;
+
+	spin_lock_irqsave(&dlfb->damage_lock, flags);
+	dlfb->damage_x = min(x, dlfb->damage_x);
+	dlfb->damage_x2 = max(x2, dlfb->damage_x2);
+	dlfb->damage_y = min(y, dlfb->damage_y);
+	dlfb->damage_y2 = max(y2, dlfb->damage_y2);
+	spin_unlock_irqrestore(&dlfb->damage_lock, flags);
+
+	schedule_work(&dlfb->damage_work);
+}
+
 /*
  * Path triggered by usermode clients who write to filesystem
  * e.g. cat filename > /dev/fb1
@@ -693,7 +737,7 @@ static void dlfb_ops_copyarea(struct fb_
 
 	sys_copyarea(info, area);
 
-	dlfb_handle_damage(dlfb, area->dx, area->dy,
+	dlfb_offload_damage(dlfb, area->dx, area->dy,
 			area->width, area->height);
 }
 
@@ -704,7 +748,7 @@ static void dlfb_ops_imageblit(struct fb
 
 	sys_imageblit(info, image);
 
-	dlfb_handle_damage(dlfb, image->dx, image->dy,
+	dlfb_offload_damage(dlfb, image->dx, image->dy,
 			image->width, image->height);
 }
 
@@ -715,7 +759,7 @@ static void dlfb_ops_fillrect(struct fb_
 
 	sys_fillrect(info, rect);
 
-	dlfb_handle_damage(dlfb, rect->dx, rect->dy, rect->width,
+	dlfb_offload_damage(dlfb, rect->dx, rect->dy, rect->width,
 			      rect->height);
 }
 
@@ -940,6 +984,8 @@ static void dlfb_ops_destroy(struct fb_i
 {
 	struct dlfb_data *dlfb = info->par;
 
+	cancel_work_sync(&dlfb->damage_work);
+
 	if (info->cmap.len != 0)
 		fb_dealloc_cmap(&info->cmap);
 	if (info->monspecs.modedb)
@@ -1636,6 +1682,10 @@ static int dlfb_usb_probe(struct usb_int
 	dlfb->ops = dlfb_ops;
 	info->fbops = &dlfb->ops;
 
+	dlfb_init_damage(dlfb);
+	spin_lock_init(&dlfb->damage_lock);
+	INIT_WORK(&dlfb->damage_work, dlfb_damage_work);
+
 	INIT_LIST_HEAD(&info->modelist);
 
 	if (!dlfb_alloc_urb_list(dlfb, WRITES_IN_FLIGHT, MAX_TRANSFER)) {
Index: linux-4.19.25/include/video/udlfb.h
=================================--- linux-4.19.25.orig/include/video/udlfb.h	2019-02-25 16:19:19.000000000 +0100
+++ linux-4.19.25/include/video/udlfb.h	2019-02-25 16:19:19.000000000 +0100
@@ -48,6 +48,12 @@ struct dlfb_data {
 	int base8;
 	u32 pseudo_palette[256];
 	int blank_mode; /*one of FB_BLANK_ */
+	int damage_x;
+	int damage_y;
+	int damage_x2;
+	int damage_y2;
+	spinlock_t damage_lock;
+	struct work_struct damage_work;
 	struct fb_ops ops;
 	/* blit-only rendering path metrics, exposed through sysfs */
 	atomic_t bytes_rendered; /* raw pixel-bytes driver asked to render */
