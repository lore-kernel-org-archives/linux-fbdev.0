From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 09 Jan 2011 16:33:38 +0000
Subject: [PATCH] video: imx: Update the manufacturer name
Message-Id: <1294590818-5001-1-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
-- 
1.6.0.4

