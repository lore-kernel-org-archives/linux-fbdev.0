From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 12 Mar 2013 10:19:37 +0000
Subject: [PATCH 4/5] videomode: remove timing_entry_index
Message-Id: <1363083578-17062-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Display timing's fields have minimum, typical and maximum values. These
can be accessed by using timing_entry_index enum, and
display_timing_get_value() function.

There's no real need for this extra complexity. The values can be
accessed more easily by just using the min/typ/max fields.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/video/videomode.c      |   18 +++++++++---------
 include/video/display_timing.h |   25 -------------------------
 2 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/video/videomode.c b/drivers/video/videomode.c
index 810afff..a3d95f2 100644
--- a/drivers/video/videomode.c
+++ b/drivers/video/videomode.c
@@ -20,16 +20,16 @@ int videomode_from_timing(const struct display_timings *disp,
 	if (!dt)
 		return -EINVAL;
 
-	vm->pixelclock = display_timing_get_value(&dt->pixelclock, TE_TYP);
-	vm->hactive = display_timing_get_value(&dt->hactive, TE_TYP);
-	vm->hfront_porch = display_timing_get_value(&dt->hfront_porch, TE_TYP);
-	vm->hback_porch = display_timing_get_value(&dt->hback_porch, TE_TYP);
-	vm->hsync_len = display_timing_get_value(&dt->hsync_len, TE_TYP);
+	vm->pixelclock = dt->pixelclock.typ;
+	vm->hactive = dt->hactive.typ;
+	vm->hfront_porch = dt->hfront_porch.typ;
+	vm->hback_porch = dt->hback_porch.typ;
+	vm->hsync_len = dt->hsync_len.typ;
 
-	vm->vactive = display_timing_get_value(&dt->vactive, TE_TYP);
-	vm->vfront_porch = display_timing_get_value(&dt->vfront_porch, TE_TYP);
-	vm->vback_porch = display_timing_get_value(&dt->vback_porch, TE_TYP);
-	vm->vsync_len = display_timing_get_value(&dt->vsync_len, TE_TYP);
+	vm->vactive = dt->vactive.typ;
+	vm->vfront_porch = dt->vfront_porch.typ;
+	vm->vback_porch = dt->vback_porch.typ;
+	vm->vsync_len = dt->vsync_len.typ;
 
 	vm->flags = dt->flags;
 
diff --git a/include/video/display_timing.h b/include/video/display_timing.h
index b63471d..5d0259b 100644
--- a/include/video/display_timing.h
+++ b/include/video/display_timing.h
@@ -39,12 +39,6 @@ struct timing_entry {
 	u32 max;
 };
 
-enum timing_entry_index {
-	TE_MIN = 0,
-	TE_TYP = 1,
-	TE_MAX = 2,
-};
-
 /*
  * Single "mode" entry. This describes one set of signal timings a display can
  * have in one setting. This struct can later be converted to struct videomode
@@ -91,25 +85,6 @@ struct display_timings {
 	struct display_timing **timings;
 };
 
-/* get value specified by index from struct timing_entry */
-static inline u32 display_timing_get_value(const struct timing_entry *te,
-					   enum timing_entry_index index)
-{
-	switch (index) {
-	case TE_MIN:
-		return te->min;
-		break;
-	case TE_TYP:
-		return te->typ;
-		break;
-	case TE_MAX:
-		return te->max;
-		break;
-	default:
-		return te->typ;
-	}
-}
-
 /* get one entry from struct display_timings */
 static inline struct display_timing *display_timings_get(const struct
 							 display_timings *disp,
-- 
1.7.10.4

