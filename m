From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 22 Aug 2018 08:54:04 +0000
Subject: [PATCH 3/4] fbdev: Add FBINFO_HIDE_SMEM_START flag
Message-Id: <20180822085405.10787-3-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: linux-fbdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>

DRM drivers really, really, really don't want random userspace to
share buffer behind it's back, bypassing the dma-buf buffer sharing
machanism. For that reason we've ruthlessly rejected any IOCTL
exposing the physical address of any graphics buffer.

Unfortunately fbdev comes with that built-in. We could just set
smem_start to 0, but that means we'd have to hand-roll our own fb_mmap
implementation. For good reasons many drivers do that, but
smem_start/length is still super convenient.

Hence instead just stop the leak in the ioctl, to keep fb mmap working
as-is. A second patch will set this flag for all drm drivers.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/video/fbdev/core/fbmem.c | 4 ++++
 include/linux/fb.h               | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 609438d2465b..549d0f86fcf3 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1116,6 +1116,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		if (!lock_fb_info(info))
 			return -ENODEV;
 		fix = info->fix;
+		if (info->flags & FBINFO_HIDE_SMEM_START)
+			fix.smem_start = 0;
 		unlock_fb_info(info);
 
 		ret = copy_to_user(argp, &fix, sizeof(fix)) ? -EFAULT : 0;
@@ -1326,6 +1328,8 @@ static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,
 	if (!lock_fb_info(info))
 		return -ENODEV;
 	fix = info->fix;
+	if (info->flags & FBINFO_HIDE_SMEM_START)
+		fix.smem_start = 0;
 	unlock_fb_info(info);
 	return do_fscreeninfo_to_user(&fix, compat_ptr(arg));
 }
diff --git a/include/linux/fb.h b/include/linux/fb.h
index fa8c6f9c9c3a..f42b09ca71f8 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -456,6 +456,13 @@ struct fb_tile_ops {
  * and host endianness. Drivers should not use this flag.
  */
 #define FBINFO_BE_MATH  0x100000
+/*
+ * Hide smem_start in the FBIOGET_FSCREENINFO IOCTL. This is used by modern DRM
+ * drivers to stop userspace from trying to share buffers behind the kernel's
+ * back. Instead dma-buf based buffer sharing should be used.
+ */
+#define FBINFO_HIDE_SMEM_START  0x200000
+
 
 struct fb_info {
 	atomic_t count;
-- 
2.18.0
