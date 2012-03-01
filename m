From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 01 Mar 2012 15:07:28 +0000
Subject: [PATCH v2 15/57] arm: mach-shmobile: Don't initialize the hdmi_info lcd_chan field
Message-Id: <1330614490-14149-16-git-send-email-laurent.pinchart@ideasonboard.com>
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
index 407a4b6..21f4fa8 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -816,10 +816,7 @@ static struct platform_device fsi_ak4643_device = {
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
index 5a96d81..52b7cb7 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -432,10 +432,7 @@ static struct platform_device lcdc_device = {
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

