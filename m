From: Ali Gholami Rudi <ali@rudi.ir>
Subject: [PATCH 1/2] fbdev: add FBIOFILLRECT ioctl
Date: Mon, 13 Jul 2009 19:48:41 +0430
Message-ID: <20090713151841.GB1297@lilem.mirepesht>
References: <20090713151709.GA1297@lilem.mirepesht>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756195AbZGMPTR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090713151709.GA1297@lilem.mirepesht>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrea Righi <righi.andrea@gmail.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, Greg Kroah-Hartman <gregkh@suse.de>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Philippe De Muyter <phdm@macqel.be>, linux-kernel@vger.kernel.org

Signed-off-by: Ali Gholami Rudi <ali@rudi.ir>
---
 drivers/video/fbmem.c |   25 +++++++++++++++++++++++++
 include/linux/fb.h    |    1 +
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index a85c818..a90cd0f 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1016,6 +1016,25 @@ fb_blank(struct fb_info *info, int blank)
  	return ret;
 }
 
+static int fb_fillrect_user(struct fb_info *info,
+			    struct fb_fillrect *fill)
+{
+	int ret = 0;
+	if (fill->rop != ROP_COPY && fill->rop != ROP_XOR)
+		return -EINVAL;
+	if (!lock_fb_info(info))
+		return -ENODEV;
+	if (fill->dx + fill->width > info->var.xres ||
+	    fill->dy + fill->height > info->var.yres) {
+		ret = -EINVAL;
+		goto out;
+	}
+	info->fbops->fb_fillrect(info, fill);
+out:
+	unlock_fb_info(info);
+	return ret;
+}
+
 static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
 {
@@ -1026,6 +1045,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	struct fb_cmap cmap_from;
 	struct fb_cmap_user cmap;
 	struct fb_event event;
+	struct fb_fillrect fill;
 	void __user *argp = (void __user *)arg;
 	long ret = 0;
 
@@ -1133,6 +1153,11 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		release_console_sem();
 		unlock_fb_info(info);
 		break;
+	case FBIOFILLRECT:
+		if (copy_from_user(&fill, argp, sizeof(fill)))
+			return -EFAULT;
+		ret = fb_fillrect_user(info, &fill);
+		break;
 	default:
 		if (!lock_fb_info(info))
 			return -ENODEV;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f847df9..40cc99a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -37,6 +37,7 @@ struct dentry;
 #define FBIOGET_HWCINFO         0x4616
 #define FBIOPUT_MODEINFO        0x4617
 #define FBIOGET_DISPINFO        0x4618
+#define FBIOFILLRECT		0x4619
 
 
 #define FB_TYPE_PACKED_PIXELS		0	/* Packed Pixels	*/
