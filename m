From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 18 Apr 2013 09:23:52 +0000
Subject: [PATCH] video: mxsfb: Fix colors display on lower color depth
Message-Id: <1366277032-671-1-git-send-email-maxime.ripard@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <516EBCA4.1020609@free-electrons.com>
In-Reply-To: <516EBCA4.1020609@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The current code always registers as a 32 bits display, and uses the
hardware to drop the MSB of each color to abjust to the interface width
used by the panel.

This results on 18 bits (and probably 16 bits display as well) in colors
being displayed poorly, because the MSB are obviously the most important
bits for each color definition.

The default controller behaviour when using an interface width smaller
than the color depth is to drop the LSBs of each color, which makes more
sense because you lose the least important part of the color definition.

So, to fix the colors display, just get back to the default controller
behaviour.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/mxsfb.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 755556c..2cfaf8b 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -424,11 +424,6 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 			return -EINVAL;
 		case STMLCDIF_16BIT:
 		case STMLCDIF_18BIT:
-			/* 24 bit to 18 bit mapping */
-			ctrl |= CTRL_DF24; /* ignore the upper 2 bits in
-					    *  each colour component
-					    */
-			break;
 		case STMLCDIF_24BIT:
 			/* real 24 bit */
 			break;
-- 
1.7.10.4

