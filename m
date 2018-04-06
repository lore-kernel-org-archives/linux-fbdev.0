From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Fri, 06 Apr 2018 15:33:20 +0000
Subject: [PATCH 2/2] media: omapfb: relax compilation if COMPILE_TEST
Message-Id: <c318fd1c9f79995c6c2e4e82ca99ff494b2afb7b.1523028795.git.mchehab@s-opensource.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <96572680e698fc554310e18cd6a166a0fb3bf32c.1523028795.git.mchehab@s-opensource.com>
In-Reply-To: <96572680e698fc554310e18cd6a166a0fb3bf32c.1523028795.git.mchehab@s-opensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>

The dependency of DRM_OMAP = n can be relaxed for just
compilation test.

This allows building the omap3isp driver with allyesconfig
on ARM.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/video/fbdev/omap2/omapfb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/Kconfig b/drivers/video/fbdev/omap2/omapfb/Kconfig
index e6226aeed17e..e42794a5e26c 100644
--- a/drivers/video/fbdev/omap2/omapfb/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/Kconfig
@@ -4,7 +4,7 @@ config OMAP2_VRFB
 menuconfig FB_OMAP2
         tristate "OMAP2+ frame buffer support"
         depends on FB
-        depends on DRM_OMAP = n
+        depends on DRM_OMAP = n || COMPILE_TEST
 
         select FB_OMAP2_DSS
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
-- 
2.14.3

