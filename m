From: Max Staudt <mstaudt@suse.de>
Date: Wed, 25 Oct 2017 12:45:51 +0000
Subject: [RFC 03/14] bootsplash: Flush framebuffer after drawing
Message-Id: <20171025124602.28292-4-mstaudt@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org
Cc: mstaudt@suse.de, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

Framebuffers with deferred I/O need to be flushed to the screen
explicitly, since we use neither the mmap nor the file I/O abstractions
that handle this for userspace FB clients.

Example: xenfb

Some framebuffer drivers implement lazy access to the screen without
actually exposing a fbdefio interface - we also match some known ones,
currently:
 - ast
 - cirrus
 - mgag200

Signed-off-by: Max Staudt <mstaudt@suse.de>
Reviewed-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/video/fbdev/core/bootsplash.c          |  2 ++
 drivers/video/fbdev/core/bootsplash_internal.h |  1 +
 drivers/video/fbdev/core/bootsplash_render.c   | 32 ++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/video/fbdev/core/bootsplash.c b/drivers/video/fbdev/core/bootsplash.c
index 7eb2126c3a31..8f1c1c165401 100644
--- a/drivers/video/fbdev/core/bootsplash.c
+++ b/drivers/video/fbdev/core/bootsplash.c
@@ -120,6 +120,8 @@ void bootsplash_render_full(struct fb_info *info)
 		return;
 
 	bootsplash_do_render_background(info);
+
+	bootsplash_do_render_flush(info);
 }
 
 
diff --git a/drivers/video/fbdev/core/bootsplash_internal.h b/drivers/video/fbdev/core/bootsplash_internal.h
index 41d519d88baa..c0653dd7807b 100644
--- a/drivers/video/fbdev/core/bootsplash_internal.h
+++ b/drivers/video/fbdev/core/bootsplash_internal.h
@@ -67,5 +67,6 @@ extern struct splash_priv splash_global;
  */
 
 void bootsplash_do_render_background(struct fb_info *info);
+void bootsplash_do_render_flush(struct fb_info *info);
 
 #endif
diff --git a/drivers/video/fbdev/core/bootsplash_render.c b/drivers/video/fbdev/core/bootsplash_render.c
index ceb19c34fd61..460ae0168cb0 100644
--- a/drivers/video/fbdev/core/bootsplash_render.c
+++ b/drivers/video/fbdev/core/bootsplash_render.c
@@ -91,3 +91,35 @@ void bootsplash_do_render_background(struct fb_info *info)
 		}
 	}
 }
+
+
+void bootsplash_do_render_flush(struct fb_info *info)
+{
+	/* FB drivers using deferred_io (such as Xen) need to sync the
+	 * screen after modifying its contents. When the FB is mmap()ed
+	 * from userspace, this happens via a dirty pages callback, but
+	 * when modifying the FB from the kernel, there is no such thing.
+	 *
+	 * So let's issue a fake fb_copyarea (copying the FB onto itself)
+	 * to trick the FB driver into syncing the screen.
+	 *
+	 * A few DRM drivers' FB implementations are broken by not using
+	 * deferred_io when they really should - we match on the known
+	 * bad ones manually for now.
+	 */
+	if (info->fbdefio
+	    || !strcmp(info->fix.id, "astdrmfb")
+	    || !strcmp(info->fix.id, "cirrusdrmfb")
+	    || !strcmp(info->fix.id, "mgadrmfb")) {
+		struct fb_copyarea area;
+
+		area.dx = 0;
+		area.dy = 0;
+		area.width = info->var.xres;
+		area.height = info->var.yres;
+		area.sx = 0;
+		area.sy = 0;
+
+		info->fbops->fb_copyarea(info, &area);
+	}
+}
-- 
2.12.3

