From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Thu, 05 Apr 2018 20:29:42 +0000
Subject: [PATCH v2 15/19] omap2: omapfb: allow building it with COMPILE_TEST
Message-Id: <f0947227675df4a774949500b6ee4cac1485b494.1522959716.git.mchehab@s-opensource.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1522959716.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1522959716.git.mchehab@s-opensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>

This driver builds cleanly with COMPILE_TEST, and it is
needed in order to allow building drivers/media omap2
driver.

So, change the logic there to allow building it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/video/fbdev/omap2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/Kconfig b/drivers/video/fbdev/omap2/Kconfig
index 0921c4de8407..82008699d253 100644
--- a/drivers/video/fbdev/omap2/Kconfig
+++ b/drivers/video/fbdev/omap2/Kconfig
@@ -1,4 +1,4 @@
-if ARCH_OMAP2PLUS
+if ARCH_OMAP2PLUS || COMPILE_TEST
 
 source "drivers/video/fbdev/omap2/omapfb/Kconfig"
 
-- 
2.14.3

