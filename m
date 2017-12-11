From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 11 Dec 2017 21:41:27 +0000
Subject: [PATCH 3/6] video: udlfb: Remove unnecessary local variable
Message-Id: <20171211214127.GD29173@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'urb' is not needed and can be removed.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/video/fbdev/udlfb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 4abf538c9b72..f74facaed8cc 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1919,7 +1918,6 @@ static struct urb *dlfb_get_urb(struct dlfb_data *dlfb)
 	int ret;
 	struct list_head *entry;
 	struct urb_node *unode;
-	struct urb *urb = NULL;
 	unsigned long flags;
 
 	/* Wait for an in-flight buffer to complete and get re-queued */
@@ -1928,7 +1926,7 @@ static struct urb *dlfb_get_urb(struct dlfb_data *dlfb)
 		atomic_set(&dlfb->lost_pixels, 1);
 		pr_warn("wait for urb interrupted: %x available: %d\n",
 		       ret, dlfb->urbs.available);
-		goto error;
+		return NULL;
 	}
 
 	spin_lock_irqsave(&dlfb->urbs.lock, flags);
@@ -1941,10 +1939,7 @@ static struct urb *dlfb_get_urb(struct dlfb_data *dlfb)
 	spin_unlock_irqrestore(&dlfb->urbs.lock, flags);
 
 	unode = list_entry(entry, struct urb_node, entry);
-	urb = unode->urb;
-
-error:
-	return urb;
+	return unode->urb;
 }
 
 static int dlfb_submit_urb(struct dlfb_data *dlfb, struct urb *urb, size_t len)
-- 
2.15.1

