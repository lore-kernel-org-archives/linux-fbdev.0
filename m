From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:06 +0000
Subject: [PATCH 13/21] udlfb: dont switch if we are switching to the same videomode
Message-Id: <20180603144223.728956901@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

The udlfb driver reprograms the hardware everytime the user switches the
console, that makes quite unusable when working on the console.

This patch makes the driver remember the videomode we are in and avoid
reprogramming the hardware if we switch to the same videomode.

We mask the "activate" field and the "FB_VMODE_SMOOTH_XPAN" flag when
comparing the videomode, because they cause spurious switches when
switching to and from the Xserver.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/video/fbdev/udlfb.c |   18 ++++++++++++++++--
 include/video/udlfb.h       |    1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

Index: linux-4.17-rc7/drivers/video/fbdev/udlfb.c
=================================--- linux-4.17-rc7.orig/drivers/video/fbdev/udlfb.c	2018-05-31 14:49:52.000000000 +0200
+++ linux-4.17-rc7/drivers/video/fbdev/udlfb.c	2018-05-31 14:49:52.000000000 +0200
@@ -1041,10 +1041,24 @@ static int dlfb_ops_set_par(struct fb_in
 	int result;
 	u16 *pix_framebuffer;
 	int i;
+	struct fb_var_screeninfo fvs;
+
+	/* clear the activate field because it causes spurious miscompares */
+	fvs = info->var;
+	fvs.activate = 0;
+	fvs.vmode &= ~FB_VMODE_SMOOTH_XPAN;
+
+	if (!memcmp(&dlfb->current_mode, &fvs, sizeof(struct fb_var_screeninfo)))
+		return 0;
 
 	result = dlfb_set_video_mode(dlfb, &info->var);
 
-	if ((result = 0) && (dlfb->fb_count = 0)) {
+	if (result)
+		return result;
+
+	dlfb->current_mode = fvs;
+
+	if (dlfb->fb_count = 0) {
 
 		/* paint greenscreen */
 
@@ -1056,7 +1070,7 @@ static int dlfb_ops_set_par(struct fb_in
 				   info->screen_base);
 	}
 
-	return result;
+	return 0;
 }
 
 /* To fonzi the jukebox (e.g. make blanking changes take effect) */
Index: linux-4.17-rc7/include/video/udlfb.h
=================================--- linux-4.17-rc7.orig/include/video/udlfb.h	2018-05-31 14:49:52.000000000 +0200
+++ linux-4.17-rc7/include/video/udlfb.h	2018-05-31 14:49:52.000000000 +0200
@@ -56,6 +56,7 @@ struct dlfb_data {
 	atomic_t bytes_identical; /* saved effort with backbuffer comparison */
 	atomic_t bytes_sent; /* to usb, after compression including overhead */
 	atomic_t cpu_kcycles_used; /* transpired during pixel processing */
+	struct fb_var_screeninfo current_mode;
 };
 
 #define NR_USB_REQUEST_I2C_SUB_IO 0x02

