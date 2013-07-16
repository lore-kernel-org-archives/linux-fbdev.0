From: Boris BREZILLON <b.brezillon@overkiz.com>
Date: Tue, 16 Jul 2013 15:08:14 +0000
Subject: [PATCH v3 3/7] at91/avr32/atmel_lcdfb: prepare clk before calling enable
Message-Id: <1373987294-24227-1-git-send-email-b.brezillon@overkiz.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
avoid common clk framework warnings.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/video/atmel_lcdfb.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index ece49d5..bf9c5d0 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -954,14 +954,14 @@ static int __init atmel_lcdfb_init_fbinfo(struct atmel_lcdfb_info *sinfo)
 
 static void atmel_lcdfb_start_clock(struct atmel_lcdfb_info *sinfo)
 {
-	clk_enable(sinfo->bus_clk);
-	clk_enable(sinfo->lcdc_clk);
+	clk_prepare_enable(sinfo->bus_clk);
+	clk_prepare_enable(sinfo->lcdc_clk);
 }
 
 static void atmel_lcdfb_stop_clock(struct atmel_lcdfb_info *sinfo)
 {
-	clk_disable(sinfo->bus_clk);
-	clk_disable(sinfo->lcdc_clk);
+	clk_disable_unprepare(sinfo->bus_clk);
+	clk_disable_unprepare(sinfo->lcdc_clk);
 }
 
 #ifdef CONFIG_OF
-- 
1.7.9.5

