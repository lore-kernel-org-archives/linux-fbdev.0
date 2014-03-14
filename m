From: Denis Carikli <denis@eukrea.com>
Date: Fri, 14 Mar 2014 10:55:51 +0000
Subject: [PATCH v15][ 1/3] video: Kconfig: fbdev: restore the broader selection of FB_IMX
Message-Id: <1394794553-14719-1-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The following patch:
  b359bb0 video: Kconfig: Allow more broad selection of the imxfb framebuffer driver.
Was accidentally reverted by this one:
  ed3b5f2 Merge branch '3.15/fb-reorder' into for-next

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v14->v15:
- New patch
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 67409e0..45fd7f3 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -327,7 +327,7 @@ config FB_SA1100
 
 config FB_IMX
 	tristate "Freescale i.MX1/21/25/27 LCD support"
-	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
+	depends on FB && ARCH_MXC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.7.9.5

