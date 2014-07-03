From: Ian Abbott <abbotti@mev.co.uk>
Date: Thu, 03 Jul 2014 13:46:39 +0000
Subject: [PATCH] video: da8xx-fb: preserve display width when changing HSYNC
Message-Id: <1404395199-5726-1-git-send-email-abbotti@mev.co.uk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>

When looking at this driver for a client, I noticed the code that
configures the HSYNC pulse clobbers the display width in the same
register.  It only preserves the MS part of the width in bit 3 and zeros
the LS part of the width in bits 9 to 4.  This doesn't matter during
initialization as the width is configured afterwards, but subsequent use
of the FBIPUT_HSYNC ioctl would clobber the width.

Preserve bits 9 to 0 of LCD_RASTER_TIMING_0_REG when configuring the
horizontal sync.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
I haven't tested this change, but it's pretty trivial.
---
 drivers/video/fbdev/da8xx-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 788f6b3..10c876c 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -419,7 +419,7 @@ static void lcd_cfg_horizontal_sync(int back_porch, int pulse_width,
 {
 	u32 reg;
 
-	reg = lcdc_read(LCD_RASTER_TIMING_0_REG) & 0xf;
+	reg = lcdc_read(LCD_RASTER_TIMING_0_REG) & 0x3ff;
 	reg |= (((back_porch-1) & 0xff) << 24)
 	    | (((front_porch-1) & 0xff) << 16)
 	    | (((pulse_width-1) & 0x3f) << 10);
-- 
2.0.0

