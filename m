From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] atmel_lcdfb: New alternate pixel clock formula
Date: Wed,  4 Nov 2009 12:31:54 +0100
Message-ID: <1257334314-636-1-git-send-email-nicolas.ferre@atmel.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755158AbZKDK0L@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net
Cc: avictor.za@gmail.com, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>

at91sam9g45 non ES lots have an alternate pixel clock
calculation formula. Introduce this one with condition
on the cpu_is_xxxxx() macros.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Newer 9g45 SOC will not have good pixel clock calculation without 
this fix.
Can we schedule this fix for .32-final ? 

It depends on the newly merged macros in this patch:
"at91: at91sam9g45 family: identify several chip versions"
d8951adeba05719b9efd7ce875a3294ffdbb37ea

 drivers/video/atmel_lcdfb.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 2830ffd..d5e8010 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -484,6 +484,7 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
 	unsigned long value;
 	unsigned long clk_value_khz;
 	unsigned long bits_per_line;
+	unsigned long pix_factor = 2;
 
 	might_sleep();
 
@@ -516,20 +517,24 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
 	/* Now, the LCDC core... */
 
 	/* Set pixel clock */
+	if (cpu_is_at91sam9g45() && !cpu_is_at91sam9g45es())
+		pix_factor = 1;
+
 	clk_value_khz = clk_get_rate(sinfo->lcdc_clk) / 1000;
 
 	value = DIV_ROUND_UP(clk_value_khz, PICOS2KHZ(info->var.pixclock));
 
-	if (value < 2) {
+	if (value < pix_factor) {
 		dev_notice(info->device, "Bypassing pixel clock divider\n");
 		lcdc_writel(sinfo, ATMEL_LCDC_LCDCON1, ATMEL_LCDC_BYPASS);
 	} else {
-		value = (value / 2) - 1;
+		value = (value / pix_factor) - 1;
 		dev_dbg(info->device, "  * programming CLKVAL = 0x%08lx\n",
 				value);
 		lcdc_writel(sinfo, ATMEL_LCDC_LCDCON1,
 				value << ATMEL_LCDC_CLKVAL_OFFSET);
-		info->var.pixclock = KHZ2PICOS(clk_value_khz / (2 * (value + 1)));
+		info->var.pixclock =
+			KHZ2PICOS(clk_value_khz / (pix_factor * (value + 1)));
 		dev_dbg(info->device, "  updated pixclk:     %lu KHz\n",
 					PICOS2KHZ(info->var.pixclock));
 	}
-- 
1.5.6.5
