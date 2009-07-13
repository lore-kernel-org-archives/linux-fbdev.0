From: Ali Gholami Rudi <ali@rudi.ir>
Subject: [PATCH 2/2] fbdev: add FBIOCOPYAREA ioctl
Date: Mon, 13 Jul 2009 19:50:04 +0430
Message-ID: <20090713152004.GC1297@lilem.mirepesht>
References: <20090713151709.GA1297@lilem.mirepesht>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756185AbZGMPTQ@vger.kernel.org>
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
index a90cd0f..518119a 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1035,6 +1035,25 @@ out:
 	return ret;
 }
 
+static int fb_copyarea_user(struct fb_info *info,
+			    struct fb_copyarea *copy)
+{
+	int ret = 0;
+	if (!lock_fb_info(info))
+		return -ENODEV;
+	if (copy->dx + copy->width > info->var.xres ||
+	    copy->sx + copy->width > info->var.xres ||
+	    copy->dy + copy->height > info->var.yres ||
+	    copy->sy + copy->height > info->var.yres) {
+		ret = -EINVAL;
+		goto out;
+	}
+	info->fbops->fb_copyarea(info, copy);
+out:
+	unlock_fb_info(info);
+	return ret;
+}
+
 static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
 {
@@ -1046,6 +1065,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	struct fb_cmap_user cmap;
 	struct fb_event event;
 	struct fb_fillrect fill;
+	struct fb_copyarea copy;
 	void __user *argp = (void __user *)arg;
 	long ret = 0;
 
@@ -1158,6 +1178,11 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			return -EFAULT;
 		ret = fb_fillrect_user(info, &fill);
 		break;
+	case FBIOCOPYAREA:
+		if (copy_from_user(&copy, argp, sizeof(copy)))
+			return -EFAULT;
+		ret = fb_copyarea_user(info, &copy);
+		break;
 	default:
 		if (!lock_fb_info(info))
 			return -ENODEV;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 40cc99a..f1cf8df 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -38,6 +38,7 @@ struct dentry;
 #define FBIOPUT_MODEINFO        0x4617
 #define FBIOGET_DISPINFO        0x4618
 #define FBIOFILLRECT		0x4619
+#define FBIOCOPYAREA		0x461A
 
 
 #define FB_TYPE_PACKED_PIXELS		0	/* Packed Pixels	*/
