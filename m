From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/8] fbcon: Console Rotation - Add support to rotate the logo
Date: Mon, 07 Nov 2005 19:03:55 +0800
Message-ID: <436F349B.3030903@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5Ah-0004RT-FD
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:28:19 -0800
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZ5Ag-0006Hq-SO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:28:19 -0800
Received: by xproxy.gmail.com with SMTP id i28so364656wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 03:28:18 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add support for rotating and positioning of the logo. Rotation and position
depends on 'int rotate' parameter added to fb_prepare_logo() and
fb_show_logo().

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 drivers/video/console/fbcon.c |    5 -
 drivers/video/fbmem.c         |  130 +++++++++++++++++++++++++++++++++++++-----
 include/linux/fb.h            |    4 -
 3 files changed, 122 insertions(+), 17 deletions(-)


diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index b5d678c..26935e2 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -499,6 +499,7 @@ static void fbcon_prepare_logo(struct vc
 			       int cols, int rows, int new_cols, int new_rows)
 {
 	/* Need to make room for the logo */
+	struct fbcon_ops *ops = info->fbcon_par;
 	int cnt, erase = vc->vc_video_erase_char, step;
 	unsigned short *save = NULL, *r, *q;
 
@@ -508,7 +509,7 @@ static void fbcon_prepare_logo(struct vc
 	 */
 	if (fb_get_color_depth(&info->var, &info->fix) == 1)
 		erase &= ~0x400;
-	logo_height = fb_prepare_logo(info);
+	logo_height = fb_prepare_logo(info, ops->rotate);
 	logo_lines = (logo_height + vc->vc_font.height - 1) /
 		vc->vc_font.height;
 	q = (unsigned short *) (vc->vc_origin +
@@ -2073,7 +2074,7 @@ static int fbcon_switch(struct vc_data *
 
 		logo_shown = fg_console;
 		/* This is protected above by initmem_freed */
-		fb_show_logo(info);
+		fb_show_logo(info, ops->rotate);
 		update_region(vc,
 			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
 			      vc->vc_size_row * (vc->vc_bottom -
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index e2667dd..7a2a8fa 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -323,9 +323,103 @@ static struct logo_data {
 	const struct linux_logo *logo;
 } fb_logo;
 
-int fb_prepare_logo(struct fb_info *info)
+static void fb_rotate_logo_ud(const u8 *in, u8 *out, u32 width, u32 height)
+{
+	u32 size = width * height, i;
+
+	out += size - 1;
+
+	for (i = size; i--; )
+		*out-- = *in++;
+}
+
+static void fb_rotate_logo_cw(const u8 *in, u8 *out, u32 width, u32 height)
+{
+	int i, j, w = width - 1;
+
+	for (i = 0; i < height; i++)
+		for (j = 0; j < width; j++)
+			out[height * j + w - i] = *in++;
+}
+
+static void fb_rotate_logo_ccw(const u8 *in, u8 *out, u32 width, u32 height)
+{
+	int i, j, w = width - 1;
+
+	for (i = 0; i < height; i++)
+		for (j = 0; j < width; j++)
+			out[height * (w - j) + i] = *in++;
+}
+
+static void fb_rotate_logo(struct fb_info *info, u8 *dst,
+			   struct fb_image *image, int rotate)
+{
+	u32 tmp;
+
+	if (rotate == FB_ROTATE_UD) {
+		image->dx = info->var.xres - image->width;
+		image->dy = info->var.yres - image->height;
+		fb_rotate_logo_ud(image->data, dst, image->width,
+				  image->height);
+	} else if (rotate == FB_ROTATE_CW) {
+		tmp = image->width;
+		image->width = image->height;
+		image->height = tmp;
+		image->dx = info->var.xres - image->height;
+		fb_rotate_logo_cw(image->data, dst, image->width,
+				  image->height);
+	} else if (rotate == FB_ROTATE_CCW) {
+		tmp = image->width;
+		image->width = image->height;
+		image->height = tmp;
+		image->dy = info->var.yres - image->width;
+		fb_rotate_logo_ccw(image->data, dst, image->width,
+				   image->height);
+	}
+
+	image->data = dst;
+}
+
+static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
+			    int rotate)
+{
+	int x;
+
+	if (rotate == FB_ROTATE_UR) {
+		for (x = 0; x < num_online_cpus() &&
+			     x * (fb_logo.logo->width + 8) <=
+			     info->var.xres - fb_logo.logo->width; x++) {
+			info->fbops->fb_imageblit(info, image);
+			image->dx += fb_logo.logo->width + 8;
+		}
+	} else if (rotate == FB_ROTATE_UD) {
+		for (x = 0; x < num_online_cpus() &&
+			     x * (fb_logo.logo->width + 8) <=
+			     info->var.xres - fb_logo.logo->width; x++) {
+			info->fbops->fb_imageblit(info, image);
+			image->dx -= fb_logo.logo->width + 8;
+		}
+	} else if (rotate == FB_ROTATE_CW) {
+		for (x = 0; x < num_online_cpus() &&
+			     x * (fb_logo.logo->width + 8) <=
+			     info->var.yres - fb_logo.logo->width; x++) {
+			info->fbops->fb_imageblit(info, image);
+			image->dy += fb_logo.logo->width + 8;
+		}
+	} else if (rotate == FB_ROTATE_CCW) {
+		for (x = 0; x < num_online_cpus() &&
+			     x * (fb_logo.logo->width + 8) <=
+			     info->var.yres - fb_logo.logo->width; x++) {
+			info->fbops->fb_imageblit(info, image);
+			image->dy -= fb_logo.logo->width + 8;
+		}
+	}
+}
+
+int fb_prepare_logo(struct fb_info *info, int rotate)
 {
 	int depth = fb_get_color_depth(&info->var, &info->fix);
+	int yres;
 
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
@@ -358,10 +452,16 @@ int fb_prepare_logo(struct fb_info *info
 	/* Return if no suitable logo was found */
 	fb_logo.logo = fb_find_logo(depth);
 	
-	if (!fb_logo.logo || fb_logo.logo->height > info->var.yres) {
+	if (rotate == FB_ROTATE_UR || rotate == FB_ROTATE_UD)
+		yres = info->var.yres;
+	else
+		yres = info->var.xres;
+
+	if (fb_logo.logo && fb_logo.logo->height > yres) {
 		fb_logo.logo = NULL;
 		return 0;
 	}
+
 	/* What depth we asked for might be different from what we get */
 	if (fb_logo.logo->type == LINUX_LOGO_CLUT224)
 		fb_logo.depth = 8;
@@ -372,12 +472,11 @@ int fb_prepare_logo(struct fb_info *info
 	return fb_logo.logo->height;
 }
 
-int fb_show_logo(struct fb_info *info)
+int fb_show_logo(struct fb_info *info, int rotate)
 {
 	u32 *palette = NULL, *saved_pseudo_palette = NULL;
-	unsigned char *logo_new = NULL;
+	unsigned char *logo_new = NULL, *logo_rotate = NULL;
 	struct fb_image image;
-	int x;
 
 	/* Return if the frame buffer is not mapped or suspended */
 	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
@@ -417,25 +516,30 @@ int fb_show_logo(struct fb_info *info)
 		fb_set_logo(info, fb_logo.logo, logo_new, fb_logo.depth);
 	}
 
+	image.dx = 0;
+	image.dy = 0;
 	image.width = fb_logo.logo->width;
 	image.height = fb_logo.logo->height;
-	image.dy = 0;
 
-	for (x = 0; x < num_online_cpus() * (fb_logo.logo->width + 8) &&
-	     x <= info->var.xres-fb_logo.logo->width; x += (fb_logo.logo->width + 8)) {
-		image.dx = x;
-		info->fbops->fb_imageblit(info, &image);
+	if (rotate) {
+		logo_rotate = kmalloc(fb_logo.logo->width *
+				      fb_logo.logo->height, GFP_KERNEL);
+		if (logo_rotate)
+			fb_rotate_logo(info, logo_rotate, &image, rotate);
 	}
-	
+
+	fb_do_show_logo(info, &image, rotate);
+
 	kfree(palette);
 	if (saved_pseudo_palette != NULL)
 		info->pseudo_palette = saved_pseudo_palette;
 	kfree(logo_new);
+	kfree(logo_rotate);
 	return fb_logo.logo->height;
 }
 #else
-int fb_prepare_logo(struct fb_info *info) { return 0; }
-int fb_show_logo(struct fb_info *info) { return 0; }
+int fb_prepare_logo(struct fb_info *info, int rotate) { return 0; }
+int fb_show_logo(struct fb_info *info, int rotate) { return 0; }
 #endif /* CONFIG_LOGO */
 
 static int fbmem_read_proc(char *buf, char **start, off_t offset,
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 51791dc..357dd3a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -825,8 +825,8 @@ extern void cfb_imageblit(struct fb_info
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
 extern int unregister_framebuffer(struct fb_info *fb_info);
-extern int fb_prepare_logo(struct fb_info *fb_info);
-extern int fb_show_logo(struct fb_info *fb_info);
+extern int fb_prepare_logo(struct fb_info *fb_info, int rotate);
+extern int fb_show_logo(struct fb_info *fb_info, int rotate);
 extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
 extern void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx,
 				u32 height, u32 shift_high, u32 shift_low, u32 mod);



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
