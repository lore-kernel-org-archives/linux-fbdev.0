From: Guruswamy Senthilvadivu <svadivu@ti.com>
Date: Tue, 22 Jun 2010 11:57:23 +0000
Subject: [PATCH v4 2/3] OMAP: DSS2: OMAPFB: make VRFB depends on OMAP2,3
Message-Id: <1277207827-15833-3-git-send-email-svadivu@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277207827-15833-1-git-send-email-svadivu@ti.com>
 <1277207827-15833-2-git-send-email-svadivu@ti.com>
In-Reply-To: <1277207827-15833-2-git-send-email-svadivu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com
Cc: Guruswamy Senthilvadivu <svadivu@ti.com>

config VRFB should depend on ARCH_OMAP2 or ARCH_OMAP3.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/omapfb/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/omapfb/Kconfig b/drivers/video/omap2/omapfb/Kconfig
index 43496d6..65149b2 100644
--- a/drivers/video/omap2/omapfb/Kconfig
+++ b/drivers/video/omap2/omapfb/Kconfig
@@ -3,7 +3,7 @@ menuconfig FB_OMAP2
         depends on FB && OMAP2_DSS
 
 	select OMAP2_VRAM
-	select OMAP2_VRFB
+	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
         select FB_CFB_FILLRECT
         select FB_CFB_COPYAREA
         select FB_CFB_IMAGEBLIT
-- 
1.5.4.7

