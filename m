From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 08:02:08 +0000
Subject: [PATCH] MAINTAINERS: update fbdev entries
Message-Id: <1474963329-28852-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove Jean-Christophe from the maintainers, and remove links to
old unmaintained web pages and git trees.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---

Jean-Christophe hasn't done any fbdev work for years, hasn't responded to any
emails, and now emails to him bounce back.

 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d00098c..fbb78a8522da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4881,12 +4881,9 @@ F:	drivers/net/wan/dlci.c
 F:	drivers/net/wan/sdla.c
 
 FRAMEBUFFER LAYER
-M:	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
 M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
 L:	linux-fbdev@vger.kernel.org
-W:	http://linux-fbdev.sourceforge.net/
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/plagnioj/linux-fbdev.git
 S:	Maintained
 F:	Documentation/fb/
 F:	drivers/video/
-- 
2.7.4

