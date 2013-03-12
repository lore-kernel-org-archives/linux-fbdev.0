From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 12 Mar 2013 10:19:36 +0000
Subject: [PATCH 3/5] videomode: create enum for videomode's display flags
Message-Id: <1363083578-17062-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Instead of having plain defines for the videomode's flags, add an enum
for the flags. This makes the flags clearer to use, as the enum tells
which values can be used with the flags field.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 include/video/display_timing.h |   28 +++++++++++++++++-----------
 include/video/videomode.h      |    2 +-
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/video/display_timing.h b/include/video/display_timing.h
index a8a4be5..b63471d 100644
--- a/include/video/display_timing.h
+++ b/include/video/display_timing.h
@@ -12,16 +12,22 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 
-#define DISPLAY_FLAGS_HSYNC_LOW		BIT(0)
-#define DISPLAY_FLAGS_HSYNC_HIGH	BIT(1)
-#define DISPLAY_FLAGS_VSYNC_LOW		BIT(2)
-#define DISPLAY_FLAGS_VSYNC_HIGH	BIT(3)
-#define DISPLAY_FLAGS_DE_LOW		BIT(4)	/* data enable flag */
-#define DISPLAY_FLAGS_DE_HIGH		BIT(5)
-#define DISPLAY_FLAGS_PIXDATA_POSEDGE	BIT(6)	/* drive data on pos. edge */
-#define DISPLAY_FLAGS_PIXDATA_NEGEDGE	BIT(7)	/* drive data on neg. edge */
-#define DISPLAY_FLAGS_INTERLACED	BIT(8)
-#define DISPLAY_FLAGS_DOUBLESCAN	BIT(9)
+enum display_flags {
+	DISPLAY_FLAGS_HSYNC_LOW		= BIT(0),
+	DISPLAY_FLAGS_HSYNC_HIGH	= BIT(1),
+	DISPLAY_FLAGS_VSYNC_LOW		= BIT(2),
+	DISPLAY_FLAGS_VSYNC_HIGH	= BIT(3),
+
+	/* data enable flag */
+	DISPLAY_FLAGS_DE_LOW		= BIT(4),
+	DISPLAY_FLAGS_DE_HIGH		= BIT(5),
+	/* drive data on pos. edge */
+	DISPLAY_FLAGS_PIXDATA_POSEDGE	= BIT(6),
+	/* drive data on neg. edge */
+	DISPLAY_FLAGS_PIXDATA_NEGEDGE	= BIT(7),
+	DISPLAY_FLAGS_INTERLACED	= BIT(8),
+	DISPLAY_FLAGS_DOUBLESCAN	= BIT(9),
+};
 
 /*
  * A single signal can be specified via a range of minimal and maximal values
@@ -69,7 +75,7 @@ struct display_timing {
 	struct timing_entry vback_porch;	/* ver. back porch */
 	struct timing_entry vsync_len;		/* ver. sync len */
 
-	unsigned int flags;			/* display flags */
+	enum display_flags flags;		/* display flags */
 };
 
 /*
diff --git a/include/video/videomode.h b/include/video/videomode.h
index f4ae6ed..8b12e60 100644
--- a/include/video/videomode.h
+++ b/include/video/videomode.h
@@ -29,7 +29,7 @@ struct videomode {
 	u32 vback_porch;
 	u32 vsync_len;
 
-	unsigned int flags; /* display flags */
+	enum display_flags flags; /* display flags */
 };
 
 /**
-- 
1.7.10.4

