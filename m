From: "Janorkar, Mayuresh" <mayur@ti.com>
Date: Mon, 03 Jan 2011 11:13:40 +0000
Subject: [PATCH 2/2] Adding a timings for panel-taal in mode database
Message-Id: <EAF47CD23C76F840A9E7FCE10091EFAB03232B6B13@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Adding a new entry n mode database file for PANEL-TAAL.
PANEL-TAAL is the default panel used for OMAP boards. The resolution is 864 X 480.
This new entry would enable us to make use of bootarg omapfb.mode.

Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
---
 drivers/video/modedb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index db88092..0f8018d 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -227,6 +227,9 @@ static const struct fb_videomode modedb[] = {
        /* 800x520i @ 50 Hz, 15.625 kHz hsync (PAL RGB) */
 	{ NULL, 50, 800, 520, 58823, 144, 64, 72, 28, 80, 5,
 	  0, FB_VMODE_INTERLACED },
+	/* 864x480 @ 60 Hz, 35.15 kHz hsync */
+	{ NULL, 60, 864, 480, 27777, 1, 1, 1, 1, 0, 0,
+	  0, FB_VMODE_NONINTERLACED },
 };
 
 #ifdef CONFIG_FB_MODE_HELPERS
-- 
1.7.0.4

