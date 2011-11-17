From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 17 Nov 2011 16:47:50 +0000
Subject: [PATCH] ARM: pxafb: fix overwriting of pixel clock and output enable polarity
Message-Id: <1321548470-20279-1-git-send-email-mkl@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

When loading the pxafb driver as a module it's possible to overwrite the
platform data via module parameters. When overwriting the pixel clock or
output enable polarity the parse_opt() function modifies the lccr3 member
of the platform data struct. Later on in pxafb_decode_mach_info() lccr3
is only evaluated if lcd_conn lcd type is not used.

This patch fixes the problem by setting pixel clock and output enable
polarity in inf->lcd_conn, too (which is handled the correct way in
pxafb_decode_mach_info()).

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/video/pxafb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 0f4e8c9..119c0a1 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1979,17 +1979,21 @@ static int __devinit parse_opt(struct device *dev, char *this_opt)
 		if (simple_strtoul(this_opt+9, NULL, 0) = 0) {
 			sprintf(s, "output enable: active low\n");
 			inf->lccr3 = (inf->lccr3 & ~LCCR3_OEP) | LCCR3_OutEnL;
+			inf->lcd_conn |= LCD_BIAS_ACTIVE_LOW;
 		} else {
 			sprintf(s, "output enable: active high\n");
 			inf->lccr3 = (inf->lccr3 & ~LCCR3_OEP) | LCCR3_OutEnH;
+			inf->lcd_conn &= ~LCD_BIAS_ACTIVE_LOW;
 		}
 	} else if (!strncmp(this_opt, "pixclockpol:", 12)) {
 		if (simple_strtoul(this_opt+12, NULL, 0) = 0) {
 			sprintf(s, "pixel clock polarity: falling edge\n");
 			inf->lccr3 = (inf->lccr3 & ~LCCR3_PCP) | LCCR3_PixFlEdg;
+			inf->lcd_conn |= LCD_PCLK_EDGE_FALL;
 		} else {
 			sprintf(s, "pixel clock polarity: rising edge\n");
 			inf->lccr3 = (inf->lccr3 & ~LCCR3_PCP) | LCCR3_PixRsEdg;
+			inf->lcd_conn &= ~LCD_PCLK_EDGE_FALL;
 		}
 	} else if (!strncmp(this_opt, "color", 5)) {
 		inf->lccr0 = (inf->lccr0 & ~LCCR0_CMS) | LCCR0_Color;
-- 
1.7.4.1

