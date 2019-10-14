From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:03 +0000
Subject: [PATCH v2 02/15] fbdev: Export FBPIXMAPSIZE
Message-Id: <20191014140416.28517-3-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

This constant is required by DRM's fbdev conversion helpers. Define it in
fbdev's public header file.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbmem.c | 2 --
 include/linux/fb.h               | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index e828fcccce40..f02377e959dc 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -43,8 +43,6 @@
      *  Frame buffer device initialization and setup routines
      */
 
-#define FBPIXMAPSIZE	(1024 * 8)
-
 static DEFINE_MUTEX(registration_lock);
 
 struct fb_info *registered_fb[FB_MAX] __read_mostly;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 372f1f6ae42e..e17d3e1d86ad 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -199,6 +199,8 @@ struct fb_pixmap {
 	void (*readio) (struct fb_info *info, void *dst, void __iomem *src, unsigned int size);
 };
 
+#define FBPIXMAPSIZE	(1024 * 8)
+
 #ifdef CONFIG_FB_DEFERRED_IO
 struct fb_deferred_io {
 	/* delay between mkwrite and deferred handler */
-- 
2.23.0
