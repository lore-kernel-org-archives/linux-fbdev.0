From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:56 +0000
Subject: [PATCH 25/33] fbmem: pull fbcon_fb_blanked out of fb_blank
Message-Id: <20190528090304.9388-26-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Peter Rosin <peda@axentia.se>, Hans de Goede <hdegoede@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Rob Clark <robdclark@gmail.com>

There's a callchain of:

fbcon_fb_blanked -> do_(un)blank_screen -> consw->con_blank
	-> fbcon_blank -> fb_blank

Things don't go horribly wrong because the BKL console_lock safes the
day, but that's about it. And the seeming recursion is broken in 2
ways:
- Starting from the fbdev ioctl we set FBINFO_MISC_USEREVENT, which
  tells the fbcon_blank code to not call fb_blank. This was required
  to not deadlock when recursing on the fb_notifier_chain mutex.
- Starting from the con_blank hook we're getting saved by the
  console_blanked checks in do_blank/unblank_screen. Or at least
  that's my theory.

Anyway, recursion isn't awesome, so let's stop it. Breaking the
recursion avoids the need to be in the FBINFO_MISC_USEREVENT critical
section, so lets move it out of that too.

The astute reader will notice that fb_blank seems to require
lock_fb_info(), which the fbcon code seems to ignore. I have no idea
how to fix that problem, so let's keep ignoring it.

v2: I forgot the sysfs blanking code.

v3: Fix typo in callchain in the commmit message (Sam).

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/video/fbdev/core/fbmem.c   | 4 +++-
 drivers/video/fbdev/core/fbsysfs.c | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 9366fbe99a58..d6713dce9e31 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1068,7 +1068,6 @@ fb_blank(struct fb_info *info, int blank)
 	event.data = &blank;
 
 	early_ret = fb_notifier_call_chain(FB_EARLY_EVENT_BLANK, &event);
-	fbcon_fb_blanked(info, blank);
 
 	if (info->fbops->fb_blank)
  		ret = info->fbops->fb_blank(blank, info);
@@ -1198,6 +1197,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		info->flags |= FBINFO_MISC_USEREVENT;
 		ret = fb_blank(info, arg);
 		info->flags &= ~FBINFO_MISC_USEREVENT;
+
+		/* might again call into fb_blank */
+		fbcon_fb_blanked(info, arg);
 		unlock_fb_info(info);
 		console_unlock();
 		break;
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 5f329278e55f..252d4f52d2a5 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
+#include <linux/fbcon.h>
 #include <linux/console.h>
 #include <linux/module.h>
 
@@ -305,12 +306,15 @@ static ssize_t store_blank(struct device *device,
 {
 	struct fb_info *fb_info = dev_get_drvdata(device);
 	char *last = NULL;
-	int err;
+	int err, arg;
 
+	arg = simple_strtoul(buf, &last, 0);
 	console_lock();
 	fb_info->flags |= FBINFO_MISC_USEREVENT;
-	err = fb_blank(fb_info, simple_strtoul(buf, &last, 0));
+	err = fb_blank(fb_info, arg);
 	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
+	/* might again call into fb_blank */
+	fbcon_fb_blanked(fb_info, arg);
 	console_unlock();
 	if (err < 0)
 		return err;
-- 
2.20.1
