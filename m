From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Thu, 26 May 2011 09:09:02 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdcfb: Change BGR24 to RGB24
Message-Id: <1306400942-26956-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The ordering of the bytes in the 24 bpp RGB colour mode was
being set to BGR.

This now matches the values returned in the
struct fb_var_screeninfo .red, .green, and .blue offsets as well as
the output format of other blocs, such as the VEU

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/video/sh_mobile_lcdcfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 04f2260..a442471 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -590,7 +590,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 				tmp |= 0x03;
 				break;
 			case 24:
-				tmp |= 0x0b;
+				tmp |= 0x02;
 				break;
 			case 32:
 				break;
@@ -1178,7 +1178,7 @@ static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp,
 		var->transp.length = 0;
 		break;
 
-	case 24: /* PKF[4:0] = 01011 - RGB 888 */
+	case 24: /* PKF[4:0] = 00010 - RGB 888 */
 		var->red.offset = 16;
 		var->red.length = 8;
 		var->green.offset = 8;
-- 
1.7.1

