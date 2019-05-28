From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:03:02 +0000
Subject: [PATCH 31/33] fbcon: Document what I learned about fbcon locking
Message-Id: <20190528090304.9388-32-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <ysxie@foxmail.com>

It's not pretty.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index fbd28aeff307..d6ba3610ee83 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -88,6 +88,25 @@
 #  define DPRINTK(fmt, args...)
 #endif
 
+/*
+ * FIXME: Locking
+ *
+ * - fbcon state itself is protected by the console_lock, and the code does a
+ *   pretty good job at making sure that lock is held everywhere it's needed.
+ *
+ * - access to the registered_fb array is entirely unprotected. This should use
+ *   proper object lifetime handling, i.e. get/put_fb_info. This also means
+ *   switching from indices to proper pointers for fb_info everywhere.
+ *
+ * - fbcon doesn't bother with fb_lock/unlock at all. This is buggy, since it
+ *   means concurrent access to the same fbdev from both fbcon and userspace
+ *   will blow up. To fix this all fbcon calls from fbmem.c need to be moved out
+ *   of fb_lock/unlock protected sections, since otherwise we'll recurse and
+ *   deadlock eventually. Aside: Due to these deadlock issues the fbdev code in
+ *   fbmem.c cannot use locking asserts, and there's lots of callers which get
+ *   the rules wrong, e.g. fbsysfs.c entirely missed fb_lock/unlock calls too.
+ */
+
 enum {
 	FBCON_LOGO_CANSHOW	= -1,	/* the logo can be shown */
 	FBCON_LOGO_DRAW		= -2,	/* draw the logo to a console */
-- 
2.20.1
