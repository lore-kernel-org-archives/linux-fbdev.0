From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:27:52 +0000
Subject: [WIP/RFC 14/31] arm: mach-shmobile: Don't initialize the hdmi_info lcd_chan field
Message-Id: <1316392089-27598-15-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The field is unused and will be removed. Don't initialize it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    3 ---
 arch/arm/mach-shmobile/board-mackerel.c |    3 ---
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 7085966..851e1ac 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -774,10 +774,7 @@ static struct platform_device fsi_ak4643_device = {
 static long ap4evb_clk_optimize(unsigned long target, unsigned long *best_freq,
 				unsigned long *parent_freq);
 
-static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info;
-
 static struct sh_mobile_hdmi_info hdmi_info = {
-	.lcd_chan = &sh_mobile_lcdc1_info.ch[0],
 	.flags = HDMI_SND_SRC_SPDIF,
 	.clk_optimize_parent = ap4evb_clk_optimize,
 };
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index fbb88a5..332f07e 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -431,10 +431,7 @@ static struct platform_device lcdc_device = {
 };
 
 /* HDMI */
-static struct sh_mobile_lcdc_info hdmi_lcdc_info;
-
 static struct sh_mobile_hdmi_info hdmi_info = {
-	.lcd_chan	= &hdmi_lcdc_info.ch[0],
 	.flags		= HDMI_SND_SRC_SPDIF,
 };
 
-- 
1.7.3.4

