From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:03 +0000
Subject: [PATCH 10/21] udl-kms: dont spam the syslog with debug messages
Message-Id: <20180603144222.665783968@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

The udl kms driver writes messages to the syslog whenever some application
opens or closes /dev/fb0 and whenever the user switches between the
Xserver and the console.

This patch changes the priority of these messages to debug.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/gpu/drm/udl/udl_fb.c      |    6 +++---
 drivers/gpu/drm/udl/udl_modeset.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-4.17-rc7/drivers/gpu/drm/udl/udl_fb.c
=================================--- linux-4.17-rc7.orig/drivers/gpu/drm/udl/udl_fb.c	2018-06-03 13:17:58.000000000 +0200
+++ linux-4.17-rc7/drivers/gpu/drm/udl/udl_fb.c	2018-06-03 13:42:48.000000000 +0200
@@ -179,7 +179,7 @@ static int udl_fb_mmap(struct fb_info *i
 
 	pos = (unsigned long)info->fix.smem_start + offset;
 
-	pr_notice("mmap() framebuffer addr:%lu size:%lu\n",
+	pr_debug("mmap() framebuffer addr:%lu size:%lu\n",
 		  pos, size);
 
 	/* We don't want the framebuffer to be mapped encrypted */
@@ -237,7 +237,7 @@ static int udl_fb_open(struct fb_info *i
 	}
 #endif
 
-	pr_notice("open /dev/fb%d user=%d fb_info=%p count=%d\n",
+	pr_debug("open /dev/fb%d user=%d fb_info=%p count=%d\n",
 		  info->node, user, info, ufbdev->fb_count);
 
 	return 0;
@@ -262,7 +262,7 @@ static int udl_fb_release(struct fb_info
 	}
 #endif
 
-	pr_warn("released /dev/fb%d user=%d count=%d\n",
+	pr_debug("released /dev/fb%d user=%d count=%d\n",
 		info->node, user, ufbdev->fb_count);
 
 	return 0;
Index: linux-4.17-rc7/drivers/gpu/drm/udl/udl_modeset.c
=================================--- linux-4.17-rc7.orig/drivers/gpu/drm/udl/udl_modeset.c	2018-06-03 13:17:58.000000000 +0200
+++ linux-4.17-rc7/drivers/gpu/drm/udl/udl_modeset.c	2018-06-03 13:41:56.000000000 +0200
@@ -243,7 +243,7 @@ static int udl_crtc_write_mode_to_hw(str
 
 	memcpy(buf, udl->mode_buf, udl->mode_buf_len);
 	retval = udl_submit_urb(dev, urb, udl->mode_buf_len);
-	DRM_INFO("write mode info %d\n", udl->mode_buf_len);
+	DRM_DEBUG("write mode info %d\n", udl->mode_buf_len);
 	return retval;
 }
 

