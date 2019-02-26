From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 26 Feb 2019 11:19:45 +0000
Subject: [PATCH 1/3] udlfb: delete the unused parameter for dlfb_handle_damage
Message-Id: <20190226112121.910471265@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove the unused parameter "data" and unused variable "ret".

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/video/fbdev/udlfb.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

Index: linux-4.19.25/drivers/video/fbdev/udlfb.c
=================================--- linux-4.19.25.orig/drivers/video/fbdev/udlfb.c	2019-02-25 15:42:57.000000000 +0100
+++ linux-4.19.25/drivers/video/fbdev/udlfb.c	2019-02-25 15:43:16.000000000 +0100
@@ -594,10 +594,9 @@ static int dlfb_render_hline(struct dlfb
 	return 0;
 }
 
-static int dlfb_handle_damage(struct dlfb_data *dlfb, int x, int y,
-	       int width, int height, char *data)
+static int dlfb_handle_damage(struct dlfb_data *dlfb, int x, int y, int width, int height)
 {
-	int i, ret;
+	int i;
 	char *cmd;
 	cycles_t start_cycles, end_cycles;
 	int bytes_sent = 0;
@@ -641,7 +640,7 @@ static int dlfb_handle_damage(struct dlf
 			*cmd++ = 0xAF;
 		/* Send partial buffer remaining before exiting */
 		len = cmd - (char *) urb->transfer_buffer;
-		ret = dlfb_submit_urb(dlfb, urb, len);
+		dlfb_submit_urb(dlfb, urb, len);
 		bytes_sent += len;
 	} else
 		dlfb_urb_completion(urb);
@@ -679,7 +678,7 @@ static ssize_t dlfb_ops_write(struct fb_
 				(u32)info->var.yres);
 
 		dlfb_handle_damage(dlfb, 0, start, info->var.xres,
-			lines, info->screen_base);
+			lines);
 	}
 
 	return result;
@@ -695,7 +694,7 @@ static void dlfb_ops_copyarea(struct fb_
 	sys_copyarea(info, area);
 
 	dlfb_handle_damage(dlfb, area->dx, area->dy,
-			area->width, area->height, info->screen_base);
+			area->width, area->height);
 }
 
 static void dlfb_ops_imageblit(struct fb_info *info,
@@ -706,7 +705,7 @@ static void dlfb_ops_imageblit(struct fb
 	sys_imageblit(info, image);
 
 	dlfb_handle_damage(dlfb, image->dx, image->dy,
-			image->width, image->height, info->screen_base);
+			image->width, image->height);
 }
 
 static void dlfb_ops_fillrect(struct fb_info *info,
@@ -717,7 +716,7 @@ static void dlfb_ops_fillrect(struct fb_
 	sys_fillrect(info, rect);
 
 	dlfb_handle_damage(dlfb, rect->dx, rect->dy, rect->width,
-			      rect->height, info->screen_base);
+			      rect->height);
 }
 
 /*
@@ -859,8 +858,7 @@ static int dlfb_ops_ioctl(struct fb_info
 		if (area.y > info->var.yres)
 			area.y = info->var.yres;
 
-		dlfb_handle_damage(dlfb, area.x, area.y, area.w, area.h,
-			   info->screen_base);
+		dlfb_handle_damage(dlfb, area.x, area.y, area.w, area.h);
 	}
 
 	return 0;
@@ -1065,8 +1063,7 @@ static int dlfb_ops_set_par(struct fb_in
 			pix_framebuffer[i] = 0x37e6;
 	}
 
-	dlfb_handle_damage(dlfb, 0, 0, info->var.xres, info->var.yres,
-			   info->screen_base);
+	dlfb_handle_damage(dlfb, 0, 0, info->var.xres, info->var.yres);
 
 	return 0;
 }
