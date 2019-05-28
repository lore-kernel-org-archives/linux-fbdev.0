From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:50 +0000
Subject: [PATCH 19/33] fbdev: unify unlink_framebuffer paths
Message-Id: <20190528090304.9388-20-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Mikulas Patocka <mpatocka@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>

For some reasons the pm_vt_switch_unregister call was missing from the
direct unregister_framebuffer path. Fix this.

v2: fbinfo->dev is used to decided whether unlink_framebuffer has been
called already. I botched that in v1. Make this all clearer by
inlining __unlink_framebuffer.

v3: Fix typoe in subject (Maarten).

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/video/fbdev/core/fbmem.c | 47 ++++++++++++++------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index f3bcad30d3ba..bee45e9405b8 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1722,15 +1722,30 @@ static void unbind_console(struct fb_info *fb_info)
 	console_unlock();
 }
 
-static void __unlink_framebuffer(struct fb_info *fb_info);
-
-static void do_unregister_framebuffer(struct fb_info *fb_info)
+void unlink_framebuffer(struct fb_info *fb_info)
 {
-	unbind_console(fb_info);
+	int i;
+
+	i = fb_info->node;
+	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
+		return;
+
+	if (!fb_info->dev)
+		return;
+
+	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 
 	pm_vt_switch_unregister(fb_info->dev);
 
-	__unlink_framebuffer(fb_info);
+	unbind_console(fb_info);
+
+	fb_info->dev = NULL;
+}
+EXPORT_SYMBOL(unlink_framebuffer);
+
+static void do_unregister_framebuffer(struct fb_info *fb_info)
+{
+	unlink_framebuffer(fb_info);
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
@@ -1753,28 +1768,6 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
 	put_fb_info(fb_info);
 }
 
-static void __unlink_framebuffer(struct fb_info *fb_info)
-{
-	int i;
-
-	i = fb_info->node;
-	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
-		return;
-
-	if (fb_info->dev) {
-		device_destroy(fb_class, MKDEV(FB_MAJOR, i));
-		fb_info->dev = NULL;
-	}
-}
-
-void unlink_framebuffer(struct fb_info *fb_info)
-{
-	__unlink_framebuffer(fb_info);
-
-	unbind_console(fb_info);
-}
-EXPORT_SYMBOL(unlink_framebuffer);
-
 /**
  * remove_conflicting_framebuffers - remove firmware-configured framebuffers
  * @a: memory range, users of which are to be removed
-- 
2.20.1
