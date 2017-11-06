From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Mon, 06 Nov 2017 22:31:18 +0000
Subject: [PATCH] video: fbdev: sm501fb: mark expected switch fall-through in sm501fb_blank_crt
Message-Id: <20171106223117.GA705@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/video/fbdev/sm501fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 076dd27..7085cc0 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1008,6 +1008,7 @@ static int sm501fb_blank_crt(int blank_mode, struct fb_info *info)
 	case FB_BLANK_POWERDOWN:
 		ctrl &= ~SM501_DC_CRT_CONTROL_ENABLE;
 		sm501_misc_control(fbi->dev->parent, SM501_MISC_DAC_POWER, 0);
+		/* fall through */
 
 	case FB_BLANK_NORMAL:
 		ctrl |= SM501_DC_CRT_CONTROL_BLANK;
-- 
2.7.4

