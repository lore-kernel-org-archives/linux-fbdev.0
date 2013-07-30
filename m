From: Darren Etheridge <detheridge@ti.com>
Date: Tue, 30 Jul 2013 18:26:20 +0000
Subject: [PATCH v2 13/24] video: da8xx-fb: enable sync lost intr for v2 ip
Message-Id: <1375208791-15781-14-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Afzal Mohammed <afzal@ti.com>

The interrupt handler explicitly has code that handles the sync lost
interrupt.  However the sync lost interrupt is never actually being
enabled in the LCD controller, therefore this interrupt code path is not
being exercised.  This fix simply enables the generation of the sync
lost interrupt by the LCD controller so it can be dealt with
appropriately by the interrupt handler.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index e172a4a..dec333e 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -318,7 +318,7 @@ static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
 			reg_int = lcdc_read(LCD_INT_ENABLE_SET_REG) |
 				LCD_V2_END_OF_FRAME0_INT_ENA |
 				LCD_V2_END_OF_FRAME1_INT_ENA |
-				LCD_FRAME_DONE;
+				LCD_FRAME_DONE | LCD_SYNC_LOST;
 			lcdc_write(reg_int, LCD_INT_ENABLE_SET_REG);
 		}
 		reg_dma |= LCD_DUAL_FRAME_BUFFER_ENABLE;
-- 
1.7.0.4

