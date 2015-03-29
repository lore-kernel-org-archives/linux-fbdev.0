From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 29 Mar 2015 13:42:43 +0000
Subject: [PATCH 71/86] fbdev/i740fb: use uapi/linux/pci_ids.h directly
Message-Id: <1427635734-24786-72-git-send-email-mst@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benoit Taine <benoit.taine@lip6.fr>, linux-fbdev@vger.kernel.org

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
use the new header directly so we can drop
the wrapper in include/linux/pci_ids.h.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/video/fbdev/i740fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index a2b4204..abad615 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -21,7 +21,7 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 #include <linux/console.h>
-- 
MST

