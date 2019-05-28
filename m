From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:03:04 +0000
Subject: [PATCH 33/33] backlight: simplify lcd notifier
Message-Id: <20190528090304.9388-34-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>

With all the work I've done on replacing fb notifier calls with direct
calls into fbcon the backlight/lcd notifier is the only user left.

It will only receive events now that it cares about, hence we can
remove this check.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/lcd.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index ecdda06989d0..d6b653aa4ee9 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -30,17 +30,6 @@ static int fb_notifier_callback(struct notifier_block *self,
 	struct lcd_device *ld;
 	struct fb_event *evdata = data;
 
-	/* If we aren't interested in this event, skip it immediately ... */
-	switch (event) {
-	case FB_EVENT_BLANK:
-	case FB_EVENT_MODE_CHANGE:
-	case FB_EARLY_EVENT_BLANK:
-	case FB_R_EARLY_EVENT_BLANK:
-		break;
-	default:
-		return 0;
-	}
-
 	ld = container_of(self, struct lcd_device, fb_notif);
 	if (!ld->ops)
 		return 0;
-- 
2.20.1
