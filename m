From: bernie@plugable.com
Date: Sun, 21 Aug 2011 20:34:11 +0000
Subject: [PATCH 1/6] udlfb: add more comprehensive support for DPMS FB_BLANK_* modes
Message-Id: <1313958862-5640-1-git-send-email-bernie@plugable.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Bernie Thompson <bernie@plugable.com>

Fixes earlier problems where monitor would not return from blank

Test with any DisplayLink-based USB 2.0 graphics adapter
sudo nano /sys/class/graphics/fb?/blank
and write out single digit FB_BLANK_* code from include/linux/fb.h

Supports on (0), blank (1), suspend (2,3), powerdown (4)

Signed-off-by: Bernie Thompson <bernie@plugable.com>
---
 drivers/video/udlfb.c |   97 +++++++++++++++++++++++++++++++++++++------------
 include/video/udlfb.h |    1 +
 2 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 4e13375..844b371 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -104,17 +104,39 @@ static char *dlfb_vidreg_unlock(char *buf)
 }
 
 /*
- * On/Off for driving the DisplayLink framebuffer to the display
- *  0x00 H and V sync on
- *  0x01 H and V sync off (screen blank but powered)
- *  0x07 DPMS powerdown (requires modeset to come back)
+ * Map FB_BLANK_* to DisplayLink register
+ * DLReg FB_BLANK_*
+ * ----- -----------------------------
+ *  0x00 FB_BLANK_UNBLANK (0)
+ *  0x01 FB_BLANK (1)
+ *  0x03 FB_BLANK_VSYNC_SUSPEND (2)
+ *  0x05 FB_BLANK_HSYNC_SUSPEND (3)
+ *  0x07 FB_BLANK_POWERDOWN (4) Note: requires modeset to come back
  */
-static char *dlfb_enable_hvsync(char *buf, bool enable)
+static char *dlfb_blanking(char *buf, int fb_blank)
 {
-	if (enable)
-		return dlfb_set_register(buf, 0x1F, 0x00);
-	else
-		return dlfb_set_register(buf, 0x1F, 0x07);
+	u8 reg;
+
+	switch (fb_blank) {
+	case FB_BLANK_POWERDOWN:
+		reg = 0x07;
+		break;
+	case FB_BLANK_HSYNC_SUSPEND:
+		reg = 0x05;
+		break;
+	case FB_BLANK_VSYNC_SUSPEND:
+		reg = 0x03;
+		break;
+	case FB_BLANK_NORMAL:
+		reg = 0x01;
+		break;
+	default:
+		reg = 0x00;
+	}
+
+	buf = dlfb_set_register(buf, 0x1F, reg);
+
+	return buf;
 }
 
 static char *dlfb_set_color_depth(char *buf, u8 selection)
@@ -282,13 +304,15 @@ static int dlfb_set_video_mode(struct dlfb_data *dev,
 	wrptr = dlfb_set_base8bpp(wrptr, dev->info->fix.smem_len);
 
 	wrptr = dlfb_set_vid_cmds(wrptr, var);
-	wrptr = dlfb_enable_hvsync(wrptr, true);
+	wrptr = dlfb_blanking(wrptr, FB_BLANK_UNBLANK);
 	wrptr = dlfb_vidreg_unlock(wrptr);
 
 	writesize = wrptr - buf;
 
 	retval = dlfb_submit_urb(dev, urb, writesize);
 
+	dev->blank_mode = FB_BLANK_UNBLANK;
+
 	return retval;
 }
 
@@ -1049,32 +1073,57 @@ static int dlfb_ops_set_par(struct fb_info *info)
 	return result;
 }
 
+/* To fonzi the jukebox (e.g. make blanking changes take effect) */
+static char *dlfb_dummy_render(char *buf)
+{
+	*buf++ = 0xAF;
+	*buf++ = 0x6A; /* copy */
+	*buf++ = 0x00; /* from address*/
+	*buf++ = 0x00;
+	*buf++ = 0x00;
+	*buf++ = 0x01; /* one pixel */
+	*buf++ = 0x00; /* to address */
+	*buf++ = 0x00;
+	*buf++ = 0x00;
+	return buf;
+}
+
 /*
  * In order to come back from full DPMS off, we need to set the mode again
  */
 static int dlfb_ops_blank(int blank_mode, struct fb_info *info)
 {
 	struct dlfb_data *dev = info->par;
+	char *bufptr;
+	struct urb *urb;
 
-	if (blank_mode != FB_BLANK_UNBLANK) {
-		char *bufptr;
-		struct urb *urb;
-
-		urb = dlfb_get_urb(dev);
-		if (!urb)
-			return 0;
+	pr_info("/dev/fb%d FB_BLANK mode %d --> %d\n",
+		info->node, dev->blank_mode, blank_mode);
 
-		bufptr = (char *) urb->transfer_buffer;
-		bufptr = dlfb_vidreg_lock(bufptr);
-		bufptr = dlfb_enable_hvsync(bufptr, false);
-		bufptr = dlfb_vidreg_unlock(bufptr);
+	if ((dev->blank_mode = FB_BLANK_POWERDOWN) &&
+	    (blank_mode != FB_BLANK_POWERDOWN)) {
 
-		dlfb_submit_urb(dev, urb, bufptr -
-				(char *) urb->transfer_buffer);
-	} else {
+		/* returning from powerdown requires a fresh modeset */
 		dlfb_set_video_mode(dev, &info->var);
 	}
 
+	urb = dlfb_get_urb(dev);
+	if (!urb)
+		return 0;
+
+	bufptr = (char *) urb->transfer_buffer;
+	bufptr = dlfb_vidreg_lock(bufptr);
+	bufptr = dlfb_blanking(bufptr, blank_mode);
+	bufptr = dlfb_vidreg_unlock(bufptr);
+
+	/* seems like a render op is needed to have blank change take effect */
+	bufptr = dlfb_dummy_render(bufptr);
+
+	dlfb_submit_urb(dev, urb, bufptr -
+			(char *) urb->transfer_buffer);
+
+	dev->blank_mode = blank_mode;
+
 	return 0;
 }
 
diff --git a/include/video/udlfb.h b/include/video/udlfb.h
index 69d485a..c41f308 100644
--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -50,6 +50,7 @@ struct dlfb_data {
 	int base16;
 	int base8;
 	u32 pseudo_palette[256];
+	int blank_mode; /*one of FB_BLANK_ */
 	/* blit-only rendering path metrics, exposed through sysfs */
 	atomic_t bytes_rendered; /* raw pixel-bytes driver asked to render */
 	atomic_t bytes_identical; /* saved effort with backbuffer comparison */
-- 
1.7.4.1

