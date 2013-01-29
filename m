From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Jan 2013 02:39:31 +0000
Subject: [PATCH RESEND v4] video: imxfb: Do not crash on reboot
Message-Id: <1359427171-18109-1-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Issuing a "reboot" command after the LCD times out causes the following
warnings:

Requesting system reboot
------------[ cut here ]------------
WARNING: at drivers/clk/clk.c:471 clk_disable+0x24/0x50()
Modules linked in:
[<c001ad90>] (unwind_backtrace+0x0/0xf4) from [<c0025aac>] (warn_slowpath_common+0x48/0x60)
[<c0025aac>] (warn_slowpath_common+0x48/0x60) from [<c0025ae0>] (warn_slowpath_null+0x1c/0x24)
[<c0025ae0>] (warn_slowpath_null+0x1c/0x24) from [<c03960a0>] (clk_disable+0x24/0x50)
[<c03960a0>] (clk_disable+0x24/0x50) from [<c02695a0>] (imxfb_disable_controller+0x48/0x7c)
[<c02695a0>] (imxfb_disable_controller+0x48/0x7c) from [<c029d838>] (platform_drv_shutdown+0x18/0x1c)
[<c029d838>] (platform_drv_shutdown+0x18/0x1c) from [<c02990fc>] (device_shutdown+0x48/0x14c)
[<c02990fc>] (device_shutdown+0x48/0x14c) from [<c003d09c>] (kernel_restart_prepare+0x2c/0x3c)
[<c003d09c>] (kernel_restart_prepare+0x2c/0x3c) from [<c003d0e4>] (kernel_restart+0xc/0x48)
[<c003d0e4>] (kernel_restart+0xc/0x48) from [<c003d1e8>] (sys_reboot+0xc0/0x1bc)
[<c003d1e8>] (sys_reboot+0xc0/0x1bc) from [<c0014ca0>] (ret_fast_syscall+0x0/0x2c)
---[ end trace da6b502ca79c854f ]---
------------[ cut here ]------------
WARNING: at drivers/clk/clk.c:380 clk_unprepare+0x1c/0x2c()
Modules linked in:
[<c001ad90>] (unwind_backtrace+0x0/0xf4) from [<c0025aac>] (warn_slowpath_common+0x48/0x60)
[<c0025aac>] (warn_slowpath_common+0x48/0x60) from [<c0025ae0>] (warn_slowpath_null+0x1c/0x24)
[<c0025ae0>] (warn_slowpath_null+0x1c/0x24) from [<c0396338>] (clk_unprepare+0x1c/0x2c)
[<c0396338>] (clk_unprepare+0x1c/0x2c) from [<c02695a8>] (imxfb_disable_controller+0x50/0x7c)
[<c02695a8>] (imxfb_disable_controller+0x50/0x7c) from [<c029d838>] (platform_drv_shutdown+0x18/0x1c)
[<c029d838>] (platform_drv_shutdown+0x18/0x1c) from [<c02990fc>] (device_shutdown+0x48/0x14c)
[<c02990fc>] (device_shutdown+0x48/0x14c) from [<c003d09c>] (kernel_restart_prepare+0x2c/0x3c)
[<c003d09c>] (kernel_restart_prepare+0x2c/0x3c) from [<c003d0e4>] (kernel_restart+0xc/0x48)
[<c003d0e4>] (kernel_restart+0xc/0x48) from [<c003d1e8>] (sys_reboot+0xc0/0x1bc)
[<c003d1e8>] (sys_reboot+0xc0/0x1bc) from [<c0014ca0>] (ret_fast_syscall+0x0/0x2c)
---[ end trace da6b502ca79c8550 ]---
------------[ cut here ]------------

This happens because "reboot" triggers imxfb_shutdown(), which calls
imxfb_disable_controller with the clocks already disabled.

To prevent this, add a clock enabled status so that we can check if the clocks
are enabled before disabling them. 

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v3:
- Changed from 'clks_enabled' to 'enabled' 
Changes since v2:
- Use a better naming for the clk enabled variable
- Return immediately in imxfb_enable_controller/imxfb_disable_controller
if the the clocks are already enabled/disabled.
Changes since v1:
- Protect the whole function instead of only the clocks
 drivers/video/imxfb.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index cf2688d..ce7de9f 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -134,6 +134,7 @@ struct imxfb_info {
 	struct clk		*clk_ipg;
 	struct clk		*clk_ahb;
 	struct clk		*clk_per;
+	int			enabled;
 
 	/*
 	 * These are the addresses we mapped
@@ -513,6 +514,10 @@ static void imxfb_exit_backlight(struct imxfb_info *fbi)
 
 static void imxfb_enable_controller(struct imxfb_info *fbi)
 {
+
+	if (fbi->enabled)
+		return;
+
 	pr_debug("Enabling LCD controller\n");
 
 	writel(fbi->screen_dma, fbi->regs + LCDC_SSA);
@@ -533,6 +538,7 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
 	clk_prepare_enable(fbi->clk_ipg);
 	clk_prepare_enable(fbi->clk_ahb);
 	clk_prepare_enable(fbi->clk_per);
+	fbi->enabled = 1;
 
 	if (fbi->backlight_power)
 		fbi->backlight_power(1);
@@ -542,6 +548,9 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
 
 static void imxfb_disable_controller(struct imxfb_info *fbi)
 {
+	if (!fbi->enabled)
+		return;
+
 	pr_debug("Disabling LCD controller\n");
 
 	if (fbi->backlight_power)
@@ -552,6 +561,7 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
 	clk_disable_unprepare(fbi->clk_per);
 	clk_disable_unprepare(fbi->clk_ipg);
 	clk_disable_unprepare(fbi->clk_ahb);
+	fbi->enabled = 0;
 
 	writel(0, fbi->regs + LCDC_RMCR);
 }
-- 
1.7.9.5

