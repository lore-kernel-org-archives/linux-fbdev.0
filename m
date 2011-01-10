From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Mon, 10 Jan 2011 11:47:41 +0000
Subject: [PATCH v2] video: imx: Update the manufacturer's name
Message-Id: <1294660061-4141-1-git-send-email-fabio.estevam@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

i.MX processors are currently manufactured by Freescale, not Motorola.

Make the manufacturer's name consistent.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Improved commit message
- Replaced Motorola reference in imxfb.c

 drivers/video/Kconfig |    2 +-
 drivers/video/imxfb.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 55dc6fb..0ac30ef 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -414,7 +414,7 @@ config FB_SA1100
 	  Y here.
 
 config FB_IMX
-	tristate "Motorola i.MX LCD support"
+	tristate "Freescale i.MX LCD support"
 	depends on FB && (HAVE_FB_IMX || ARCH_MX1 || ARCH_MX2)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 1ab2c25..69bd4a5 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -974,6 +974,6 @@ static void __exit imxfb_cleanup(void)
 module_init(imxfb_init);
 module_exit(imxfb_cleanup);
 
-MODULE_DESCRIPTION("Motorola i.MX framebuffer driver");
+MODULE_DESCRIPTION("Freescale i.MX framebuffer driver");
 MODULE_AUTHOR("Sascha Hauer, Pengutronix");
 MODULE_LICENSE("GPL");
-- 
1.6.0.4


