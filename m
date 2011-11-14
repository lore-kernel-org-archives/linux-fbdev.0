From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 14 Nov 2011 15:01:44 +0000
Subject: [PATCH 2/3] OMAPFB: fix compilation warnings due to missing include
Message-Id: <1321282905-12939-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Fix warnings similar to this by including module.h:

drivers/video/omap/dispc.c:276:1: warning: data definition has no type
or storage class
drivers/video/omap/dispc.c:276:1: warning: type defaults to 'int' in
declaration of 'EXPORT_SYMBOL'

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap/dispc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 0ccd7ad..10f8bbe 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -18,7 +18,7 @@
  * with this program; if not, write to the Free Software Foundation, Inc.,
  * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
-#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
-- 
1.7.4.1

