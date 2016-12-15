From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 15 Dec 2016 14:45:47 +0000
Subject: [PATCH] MAINTAINERS: add myself as maintainer of fbdev
Message-Id: <2069699.WOeY4a5XzP@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Vetter <daniel.vetter@intel.com>

I would like to help with fbdev maintenance.  I can dedicate some time
for reviewing and handling patches but won't have time for much more.

The subsystem will remain in maintenance mode (no new drivers will be
added to it).

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 MAINTAINERS |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/MAINTAINERS
=================================--- a/MAINTAINERS	2016-12-15 15:40:31.441918231 +0100
+++ b/MAINTAINERS	2016-12-15 15:40:50.569918713 +0100
@@ -5077,9 +5077,11 @@ F:	drivers/net/wan/dlci.c
 F:	drivers/net/wan/sdla.c
 
 FRAMEBUFFER LAYER
+M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-fbdev@vger.kernel.org
+T:	git git://github.com/bzolnier/linux.git
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
-S:	Orphan
+S:	Maintained
 F:	Documentation/fb/
 F:	drivers/video/
 F:	include/video/

