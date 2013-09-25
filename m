From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 25 Sep 2013 11:41:52 +0000
Subject: [PATCH 4/6] video: aty: Remove redundant break
Message-Id: <1380108594-19090-4-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'break' after return statement is redundant. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/aty/atyfb_base.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 9b0f12c..28fafbf 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -1848,7 +1848,6 @@ static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 
 			return aty_waitforvblank(par, crtc);
 		}
-		break;
 
 #if defined(DEBUG) && defined(CONFIG_FB_ATY_CT)
 	case ATYIO_CLKR:
-- 
1.7.9.5

