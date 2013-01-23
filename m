From: Afzal Mohammed <afzal@ti.com>
Date: Wed, 23 Jan 2013 11:52:09 +0000
Subject: [PATCH v4 02/12] video: da8xx-fb: fix 24bpp raster configuration
Message-Id: <067d65675947ebb06d58b293a6023f31c1db1e9e.1358937685.git.afzal@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1358937685.git.afzal@ti.com>
In-Reply-To: <cover.1358937685.git.afzal-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Manjunathappa,
 Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

From: "Manjunathappa, Prakash" <prakash.pm@ti.com>

Set only LCD_V2_TFT_24BPP_MODE bit for 24bpp and LCD_V2_TFT_24BPP_UNPACK
bit along with LCD_V2_TFT_24BPP_MODE for 32bpp configuration.

Patch is tested on am335x-evm for 24bpp and da850-evm for 16bpp
configurations.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/video/da8xx-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
1.7.12

