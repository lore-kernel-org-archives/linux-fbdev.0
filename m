From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sat, 16 May 2015 19:31:28 +0000
Subject: [PATCH] staging: sm750fb: fix typo in fb_videomode Array
Message-Id: <20150516193128.GA1534@x230-arch.Speedport_W_724V_01011602_00_001>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

It appears that 'FB_SYNC_HOR_HIGH_ACT' should be assined to 'sync'
and 'FB_VMODE_NONINTERLACED' is a flag for 'vmode'.

In line 96 these flags are ORed and assigned to 'sync'.
Since 'FB_VMODE_NONINTERLACED' is zero, 'sync' will stay the same,
and due to C99 'vmode' is initialized to zero too.
Therefore this doesn't have any implications for runtime-behavior,
but seems to be semantically wrong.

The Patch simply changes the | to a coma. Please check if this is correct.

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 77310ff..8ff29c6 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -94,7 +94,8 @@ static const struct fb_videomode lynx750_ext[] = {
 	 FB_VMODE_NONINTERLACED},
 
 	{NULL, 60, 1360, 768, 11804, 208, 64, 23, 1, 144, 3,
-	 FB_SYNC_HOR_HIGH_ACT|FB_VMODE_NONINTERLACED},
+	 FB_SYNC_HOR_HIGH_ACT,
+	 FB_VMODE_NONINTERLACED},
 
 	/*	1360 x 768	[1.77083:1]	*/
 	{NULL,  60, 1360, 768, 11804, 208,  64, 23, 1, 144, 3,
-- 
2.3.7

