From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 29 Mar 2015 13:42:47 +0000
Subject: [PATCH 72/86] fbdev/i810: use uapi/linux/pci_ids.h directly
Message-Id: <1427635734-24786-73-git-send-email-mst@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
use the new header directly so we can drop
the wrapper in include/linux/pci_ids.h.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/video/fbdev/i810/i810_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev/i810/i810_main.c
index bb674e4..c4e13bb 100644
--- a/drivers/video/fbdev/i810/i810_main.c
+++ b/drivers/video/fbdev/i810/i810_main.c
@@ -37,7 +37,7 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <linux/resource.h>
 #include <linux/unistd.h>
 #include <linux/console.h>
-- 
MST

