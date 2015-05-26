From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Tue, 26 May 2015 15:22:39 +0000
Subject: [PATCH] staging: sm750fb: remove duplicate from fb_videomode
Message-Id: <20150526152239.GA21887@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

As suggested by Sudip this patch removes the redundant 1360x768@60
option from the fb_videomode struct array.
The removed option and the option one it differ in a typo and a flag.

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 69b18f3..d90b463 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -88,9 +88,6 @@ static const struct fb_videomode lynx750_ext[] = {
 	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	 FB_VMODE_NONINTERLACED},
 
-	{NULL, 60, 1360, 768, 11804, 208, 64, 23, 1, 144, 3,
-	 FB_SYNC_HOR_HIGH_ACT|FB_VMODE_NONINTERLACED},
-
 	/*	1360 x 768	[1.77083:1]	*/
 	{NULL,  60, 1360, 768, 11804, 208,  64, 23, 1, 144, 3,
 	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-- 
2.3.7

