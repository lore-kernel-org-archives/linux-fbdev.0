From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 Dec 2016 08:34:12 +0000
Subject: [PATCH] fbdev: remove current maintainer
Message-Id: <1481186052-4987-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove Tomi Valkeinen from fbdev maintainer and mark fbdev as orphan.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---

I just don't have time to even pretend I maintain fbdev, so mark it as Orphan.

Anyone want to pick fbdev maintainership?

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 851b89b9edcb..fc2790eb4e84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4968,10 +4968,9 @@ F:	drivers/net/wan/dlci.c
 F:	drivers/net/wan/sdla.c
 
 FRAMEBUFFER LAYER
-M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
 L:	linux-fbdev@vger.kernel.org
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
-S:	Maintained
+S:	Orphan
 F:	Documentation/fb/
 F:	drivers/video/
 F:	include/video/
-- 
2.7.4

