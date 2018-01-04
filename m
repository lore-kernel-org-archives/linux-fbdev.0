From: Ladislav Michl <ladis@linux-mips.org>
Date: Thu, 04 Jan 2018 19:37:20 +0000
Subject: [PATCH v2 1/5] video: udlfb: Remove unnecessary local variable
Message-Id: <20180104193720.GB22612@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'urb' is not needed and can be removed.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: None (just made patch #1)

 drivers/video/fbdev/udlfb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 99ce445986b3..5f68f8c720ec 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1919,7 +1919,6 @@ static struct urb *dlfb_get_urb(struct dlfb_data *dev)
 	int ret;
 	struct list_head *entry;
 	struct urb_node *unode;
-	struct urb *urb = NULL;
 	unsigned long flags;
 
 	/* Wait for an in-flight buffer to complete and get re-queued */
@@ -1928,7 +1927,7 @@ static struct urb *dlfb_get_urb(struct dlfb_data *dev)
 		atomic_set(&dev->lost_pixels, 1);
 		pr_warn("wait for urb interrupted: %x available: %d\n",
 		       ret, dev->urbs.available);
-		goto error;
+		return NULL;
 	}
 
 	spin_lock_irqsave(&dev->urbs.lock, flags);
@@ -1941,10 +1940,7 @@ static struct urb *dlfb_get_urb(struct dlfb_data *dev)
 	spin_unlock_irqrestore(&dev->urbs.lock, flags);
 
 	unode = list_entry(entry, struct urb_node, entry);
-	urb = unode->urb;
-
-error:
-	return urb;
+	return unode->urb;
 }
 
 static int dlfb_submit_urb(struct dlfb_data *dev, struct urb *urb, size_t len)
-- 
2.15.1

