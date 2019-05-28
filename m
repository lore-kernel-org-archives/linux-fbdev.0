From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:57 +0000
Subject: [PATCH 26/33] fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
Message-Id: <20190528090304.9388-27-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Peter Rosin <peda@axentia.se>, Mikulas Patocka <mpatocka@redhat.com>, Rob Clark <robdclark@gmail.com>

With the recursion broken in the previous patch we can drop the
FBINFO_MISC_USEREVENT flag around calls to fb_blank - recursion
prevention was it's only job.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c   | 5 ++---
 drivers/video/fbdev/core/fbmem.c   | 3 ---
 drivers/video/fbdev/core/fbsysfs.c | 2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index a4617067ff24..b5ee89f16d6c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2386,9 +2386,8 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 			ops->cursor_flash = (!blank);
 
-			if (!(info->flags & FBINFO_MISC_USEREVENT))
-				if (fb_blank(info, blank))
-					fbcon_generic_blank(vc, info, blank);
+			if (fb_blank(info, blank))
+				fbcon_generic_blank(vc, info, blank);
 		}
 
 		if (!blank)
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d6713dce9e31..25ae466ba593 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1194,10 +1194,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
-		info->flags |= FBINFO_MISC_USEREVENT;
 		ret = fb_blank(info, arg);
-		info->flags &= ~FBINFO_MISC_USEREVENT;
-
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
 		unlock_fb_info(info);
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 252d4f52d2a5..882b471d619e 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -310,9 +310,7 @@ static ssize_t store_blank(struct device *device,
 
 	arg = simple_strtoul(buf, &last, 0);
 	console_lock();
-	fb_info->flags |= FBINFO_MISC_USEREVENT;
 	err = fb_blank(fb_info, arg);
-	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
 	/* might again call into fb_blank */
 	fbcon_fb_blanked(fb_info, arg);
 	console_unlock();
-- 
2.20.1
