From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 Dec 2015 14:25:27 +0000
Subject: [PATCH RFC 1/9] omapfb: allow compilation only if DRM_OMAP is disabled
Message-Id: <1449757535-5674-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

At the moment omapfb and omapdrm can be compiled at the same time, if
both are modules. However, they can't be both loaded, as they use the
same hardware. This has been mostly for compile testing.

To make it clear that omapfb and omapdrm are mutually exclusive drivers,
this patch makes omapfb available only if omapdrm is disabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/Kconfig b/drivers/video/fbdev/omap2/omapfb/Kconfig
index 4cb12ce68855..7ba1a22199b8 100644
--- a/drivers/video/fbdev/omap2/omapfb/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/Kconfig
@@ -1,6 +1,7 @@
 menuconfig FB_OMAP2
         tristate "OMAP2+ frame buffer support"
-        depends on FB && OMAP2_DSS && !DRM_OMAP
+        depends on FB
+        depends on DRM_OMAP = n
 
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
         select FB_CFB_FILLRECT
-- 
2.5.0

