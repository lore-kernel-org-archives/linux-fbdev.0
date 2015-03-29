From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 29 Mar 2015 13:42:50 +0000
Subject: [PATCH 73/86] fbdev/riva: use uapi/linux/pci_ids.h directly
Message-Id: <1427635734-24786-74-git-send-email-mst@redhat.com>
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
 drivers/video/fbdev/riva/nv_driver.c | 2 +-
 drivers/video/fbdev/riva/riva_hw.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/riva/nv_driver.c b/drivers/video/fbdev/riva/nv_driver.c
index f3694cf..f597ee5 100644
--- a/drivers/video/fbdev/riva/nv_driver.c
+++ b/drivers/video/fbdev/riva/nv_driver.c
@@ -36,7 +36,7 @@
 
 #include <linux/delay.h>
 #include <linux/pci.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include "nv_type.h"
 #include "rivafb.h"
 #include "nvreg.h"
diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index 8bdf37f..0d399f6 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -48,7 +48,7 @@
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include "riva_hw.h"
 #include "riva_tbl.h"
 #include "nv_type.h"
-- 
MST

