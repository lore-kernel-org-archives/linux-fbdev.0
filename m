From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 25 Sep 2013 11:41:53 +0000
Subject: [PATCH 5/6] video: kyro: Remove redundant break
Message-Id: <1380108594-19090-5-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'break' after return statement is redundant. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 drivers/video/kyro/fbdev.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
index c82f040..79bfb5c 100644
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -623,7 +623,6 @@ static int kyrofb_ioctl(struct fb_info *info,
 				"command instead.\n");
 			return -EINVAL;
 		}
-		break;
 	case KYRO_IOCTL_UVSTRIDE:
 		if (copy_to_user(argp, &deviceInfo.ulOverlayUVStride, sizeof(unsigned long)))
 			return -EFAULT;
-- 
1.7.9.5

