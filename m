From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 May 2018 12:15:22 +0000
Subject: [PATCH] MAINTAINERS: make omapfb orphan
Message-Id: <20180507121522.18468-1-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org

omapfb is not maintained by me anymore, so drop my name from the
maintainers, and mark omapfb as orphan.

At some point in the future we should mark omapfb as obsolete, but there
are still some features supported by omapfb which are not supported by
omapdrm, so we're not there yet.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 MAINTAINERS | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 79bb02ff812f..1efa90eeaf5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10136,18 +10136,16 @@ F:	arch/arm/boot/dts/*am5*
 F:	arch/arm/boot/dts/*dra7*
 
 OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT (DSS2)
-M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
 L:	linux-omap@vger.kernel.org
 L:	linux-fbdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/video/fbdev/omap2/
 F:	Documentation/arm/OMAP/DSS
 
 OMAP FRAMEBUFFER SUPPORT
-M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
 L:	linux-fbdev@vger.kernel.org
 L:	linux-omap@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/video/fbdev/omap/
 
 OMAP GENERAL PURPOSE MEMORY CONTROLLER SUPPORT
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

