From: Marek Vasut <marex@denx.de>
Date: Wed, 18 Apr 2012 16:48:00 +0000
Subject: [PATCH] i.MX28: Shut down the LCD controller to avoid BootROM sampling bug
Message-Id: <1334767680-12688-1-git-send-email-marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334695011-8188-1-git-send-email-marex@denx.de>
In-Reply-To: <1334695011-8188-1-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Marek Vasut <marek.vasut@gmail.com>

If there's some traffic on the LCD controller pads, the BootROM has trouble with
sampling the bootmode from these pads when the system is restarted from Linux.
The BootROM usually ends in a loop.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Lin Tony-B19295 <B19295@freescale.com>
Cc: Linux FBDEV <linux-fbdev@vger.kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Tony Lin <tony.lin@freescale.com>
Cc: Wolfgang Denk <wd@denx.de>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Wolfgang Denk <wd@denx.de>
Tested-by: Wolfgang Denk <wd@denx.de>
---
 drivers/video/mxsfb.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 4a89f88..a265356 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -880,6 +880,18 @@ static int __devexit mxsfb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+void mxsfb_shutdown(struct platform_device *pdev)
+{
+	struct fb_info *fb_info = platform_get_drvdata(pdev);
+	struct mxsfb_info *host = to_imxfb_host(fb_info);
+
+	/*
+	 * Force stop the LCD controller as keeping it running during reboot
+	 * might interfere with the BootROM's boot mode pads sampling.
+	 */
+	writel(CTRL_RUN, host->base + LCDC_CTRL + REG_CLR);
+}
+
 static struct platform_device_id mxsfb_devtype[] = {
 	{
 		.name = "imx23-fb",
@@ -896,6 +908,7 @@ MODULE_DEVICE_TABLE(platform, mxsfb_devtype);
 static struct platform_driver mxsfb_driver = {
 	.probe = mxsfb_probe,
 	.remove = __devexit_p(mxsfb_remove),
+	.shutdown = mxsfb_shutdown,
 	.id_table = mxsfb_devtype,
 	.driver = {
 		   .name = DRIVER_NAME,
-- 
1.7.9.5

