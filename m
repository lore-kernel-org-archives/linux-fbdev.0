From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 18 Jul 2012 15:46:57 +0000
Subject: [PATCH v2 2/2] arm: da850: configure LCDC fifo threshold
Message-Id: <1342625697-7515-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Configure fifo threshold in raster dma_control register to
512 bytes. This reduces LCDC underflow errors.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Seems like version 1 of this patch did not reach fbdev mailing list.
Since v1:
No change, resending it as other patch in series has changed.
 arch/arm/mach-davinci/devices-da8xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index d1624a3..783eab6 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -546,6 +546,7 @@ static struct lcd_ctrl_config lcd_cfg = {
 	.sync_edge		= 0,
 	.sync_ctrl		= 1,
 	.raster_order		= 0,
+	.fifo_th		= 6,
 };
 
 struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata = {
-- 
1.7.1

