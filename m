From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 10 Sep 2014 14:15:53 +0000
Subject: [PATCH] video: ARM CLCD: Fix color model capabilities for DT platforms
Message-Id: <1410358553-2344-1-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The DT-based panel capabilities selection was picking up
a subset of available modes based on hardware configuration.
This was wrong, as the capabilities describe available
memory models and adapt the display controller to them
that the RGB output is wired up correctly (as in: R and
B components are not swapped).

This patch fixes it by removing the unnecessary limitation.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/video/fbdev/amba-clcd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index a7b6217..6ad23bd 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -639,9 +639,7 @@ static int clcdfb_of_init_tft_panel(struct clcd_fb *fb, u32 r0, u32 g0, u32 b0)
 		if (g0 != panels[i].g0)
 			continue;
 		if (r0 = panels[i].r0 && b0 = panels[i].b0)
-			fb->panel->caps = panels[i].caps & CLCD_CAP_RGB;
-		if (r0 = panels[i].b0 && b0 = panels[i].r0)
-			fb->panel->caps = panels[i].caps & CLCD_CAP_BGR;
+			fb->panel->caps = panels[i].caps;
 	}
 
 	return fb->panel->caps ? 0 : -EINVAL;
-- 
1.9.1

