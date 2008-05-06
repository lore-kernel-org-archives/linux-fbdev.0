From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] atmel_lcdfb: fix pixclok divider calculation
Date: Tue, 06 May 2008 19:36:08 +0200
Message-ID: <48209708.3020807@atmel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765381AbYEFQeu@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com
Cc: Per Hedblom <per.hedblom@abem.se>, Roel Kluin <12o3l@tiscali.nl>, Jan Weber <jw022609@uni-greifswald.de>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-kernel@vger.kernel.org

Fix divider calculation and allow CLKVAL = 0 (divisor 2)

It was not possible to get the clock value 0 (divisor 2) because 
the test "<=0" force the BYPASS bit to be activated instead.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Thanks a lot to Jan, Per, Roel and Haavard for sending me
similar patches.

 drivers/video/atmel_lcdfb.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -441,13 +441,12 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
 
 	value = DIV_ROUND_UP(clk_value_khz, PICOS2KHZ(info->var.pixclock));
 
-	value = (value / 2) - 1;
-	dev_dbg(info->device, "  * programming CLKVAL = 0x%08lx\n", value);
-
-	if (value <= 0) {
+	if (value < 2) {
 		dev_notice(info->device, "Bypassing pixel clock divider\n");
 		lcdc_writel(sinfo, ATMEL_LCDC_LCDCON1, ATMEL_LCDC_BYPASS);
 	} else {
+		value = (value / 2) - 1;
+		dev_dbg(info->device, "  * programming CLKVAL = 0x%08lx\n", value);
 		lcdc_writel(sinfo, ATMEL_LCDC_LCDCON1, value << ATMEL_LCDC_CLKVAL_OFFSET);
 		info->var.pixclock = KHZ2PICOS(clk_value_khz / (2 * (value + 1)));
 		dev_dbg(info->device, "  updated pixclk:     %lu KHz\n",
