From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Mon, 03 Aug 2015 20:15:34 +0000
Subject: [PATCH] video: fbdev: pxa3xx_gcu: prepare the clocks
Message-Id: <1438632934-29506-1-git-send-email-robert.jarzmik@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>

The clocks need to be prepared before being enabled. Without it a
warning appears in the drivers probe path :

WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:707 clk_core_enable+0x84/0xa0()
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.2.0-rc3-cm-x300+ #804
Hardware name: CM-X300 module
[<c000ed50>] (unwind_backtrace) from [<c000ce08>] (show_stack+0x10/0x14)
[<c000ce08>] (show_stack) from [<c0017eb4>] (warn_slowpath_common+0x7c/0xb4)
[<c0017eb4>] (warn_slowpath_common) from [<c0017f88>] (warn_slowpath_null+0x1c/0x24)
[<c0017f88>] (warn_slowpath_null) from [<c02d30dc>] (clk_core_enable+0x84/0xa0)
[<c02d30dc>] (clk_core_enable) from [<c02d3118>] (clk_enable+0x20/0x34)
[<c02d3118>] (clk_enable) from [<c0200dfc>] (pxa3xx_gcu_probe+0x148/0x338)
[<c0200dfc>] (pxa3xx_gcu_probe) from
[<c022eccc>] (platform_drv_probe+0x30/0x94)

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 86bd457d039d..50bce45e7f3d 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -653,7 +653,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 		goto err_free_dma;
 	}
 
-	ret = clk_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable clock\n");
 		goto err_misc_deregister;
@@ -685,7 +685,7 @@ err_misc_deregister:
 	misc_deregister(&priv->misc_dev);
 
 err_disable_clk:
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return ret;
 }
-- 
2.1.4

