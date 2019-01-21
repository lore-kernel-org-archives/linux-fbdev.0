From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Mon, 21 Jan 2019 04:22:11 +0000
Subject: [PATCH] vgacon: unconfuse vc_origin when using soft scrollback
Message-Id: <nycvar.YSQ.7.76.1901202317500.1525@knanqh.ubzr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

When CONFIG_VGACON_SOFT_SCROLLBACK is selected, the VGA display memory
index and vc_visible_origin don't change when scrollback is activated.
The actual screen content is saved away and the scrollbackdata is copied
over it. However the vt code, and /dev/vcs devices in particular, still
expect vc_origin to always point at the actual screen content not the
displayed scrollback content.

So adjust vc_origin to point at the saved screen content when scrollback
is active and set it back to vc_visible_origin when restoring the screen.

This fixes /dev/vcsa<n> that return scrollback content when they
shouldn't (onli /dev/vcsa without a number should), and also fixes
/dev/vcsu that should return scrollback content when scrollback is
active but currently doesn't.

An unnecessary call to vga_set_mem_top() is also removed.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org # v4.19+

---

I tagged it for stable starting with v4.19 as this is the kernel that
introduced /dev/vcsu* which is directly affected. Users of earlier kernels
most likely won't care.

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 09731b2f68..c6b3bdbbdb 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -271,6 +271,7 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
 
 static void vgacon_restore_screen(struct vc_data *c)
 {
+	c->vc_origin = c->vc_visible_origin;
 	vgacon_scrollback_cur->save = 0;
 
 	if (!vga_is_gfx && !vgacon_scrollback_cur->restore) {
@@ -287,8 +288,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 	int start, end, count, soff;
 
 	if (!lines) {
-		c->vc_visible_origin = c->vc_origin;
-		vga_set_mem_top(c);
+		vgacon_restore_screen(c);
 		return;
 	}
 
@@ -298,6 +298,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 	if (!vgacon_scrollback_cur->save) {
 		vgacon_cursor(c, CM_ERASE);
 		vgacon_save_screen(c);
+		c->vc_origin = (unsigned long)c->vc_screenbuf;
 		vgacon_scrollback_cur->save = 1;
 	}
 
@@ -335,7 +336,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 		int copysize;
 
 		int diff = c->vc_rows - count;
-		void *d = (void *) c->vc_origin;
+		void *d = (void *) c->vc_visible_origin;
 		void *s = (void *) c->vc_screenbuf;
 
 		count *= c->vc_size_row;
