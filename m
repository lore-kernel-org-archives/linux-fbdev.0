From: Darren Etheridge <detheridge@ti.com>
Date: Tue, 25 Jun 2013 14:22:40 +0000
Subject: [PATCH 12/23] video: da8xx-fb: fix 24bpp raster configuration
Message-Id: <1372170171-9561-13-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Manjunathappa, Prakash <prakash.pm@ti.com>

Set only LCD_V2_TFT_24BPP_MODE bit for 24bpp and LCD_V2_TFT_24BPP_UNPACK
bit along with LCD_V2_TFT_24BPP_MODE for 32bpp configuration.

Patch is tested on am335x-evm for 24bpp and da850-evm for 16bpp
configurations.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 35a33ca..7f92f37 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -550,10 +550,10 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
 	case 4:
 	case 16:
 		break;
-	case 24:
-		reg |= LCD_V2_TFT_24BPP_MODE;
 	case 32:
 		reg |= LCD_V2_TFT_24BPP_UNPACK;
+	case 24:
+		reg |= LCD_V2_TFT_24BPP_MODE;
 		break;
 
 	case 8:
-- 
1.7.0.4

