From: Albert Herranz <albert_herranz@yahoo.es>
Date: Tue, 25 May 2010 22:17:00 +0000
Subject: [RFT PATCH 2/2] fb_defio: redo fix for non-dirty ptes
Message-Id: <1274825820-10246-2-git-send-email-albert_herranz@yahoo.es>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274825820-10246-1-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1274825820-10246-1-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: npiggin@suse.de, jayakumar.lkml@gmail.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.orgl
Cc: Albert Herranz <albert_herranz@yahoo.es>

As pointed by Nick Piggin, ->page_mkwrite provides a way to keep a page
locked until the associated PTE is marked dirty.

Re-implement the fix by using this mechanism.

LKML-Reference: <20100525160149.GE20853@laptop>
Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/video/fb_defio.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index 0e4dcdb..a3e8cc7 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -100,6 +100,16 @@ static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
 	/* protect against the workqueue changing the page list */
 	mutex_lock(&fbdefio->lock);
 
+	/*
+	 * We want the page to remain locked from ->page_mkwrite until
+	 * the PTE is marked dirty to avoid page_mkclean() being called
+	 * before the PTE is updated, which would leave the page ignored
+	 * by defio.
+	 * Do this by locking the page here and informing the caller
+	 * about it with VM_FAULT_LOCKED.
+	 */
+	lock_page(page);
+
 	/* we loop through the pagelist before adding in order
 	to keep the pagelist sorted */
 	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
@@ -121,7 +131,7 @@ page_already_added:
 
 	/* come back after delay to process the deferred IO */
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
-	return 0;
+	return VM_FAULT_LOCKED;
 }
 
 static const struct vm_operations_struct fb_deferred_io_vm_ops = {
-- 
1.7.0.4

