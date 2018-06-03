From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:14 +0000
Subject: [PATCH 21/21] udlfb: use spin_lock_irq instead of spin_lock_irqsave
Message-Id: <20180603144226.532332020@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

spin_lock_irqsave and spin_unlock_irqrestore is inteded to be called from
a context where it is unknown if interrupts are enabled or disabled (such
as interrupt handlers). From a process context, we should call
spin_lock_irq and spin_unlock_irq, that avoids the costly pushf and popf
instructions.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/video/fbdev/udlfb.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: linux-4.17-rc7/drivers/video/fbdev/udlfb.c
=================================--- linux-4.17-rc7.orig/drivers/video/fbdev/udlfb.c	2018-06-03 13:17:46.000000000 +0200
+++ linux-4.17-rc7/drivers/video/fbdev/udlfb.c	2018-06-03 13:17:46.000000000 +0200
@@ -1855,18 +1855,17 @@ static void dlfb_free_urb_list(struct dl
 	struct list_head *node;
 	struct urb_node *unode;
 	struct urb *urb;
-	unsigned long flags;
 
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
 		down(&dlfb->urbs.limit_sem);
 
-		spin_lock_irqsave(&dlfb->urbs.lock, flags);
+		spin_lock_irq(&dlfb->urbs.lock);
 
 		node = dlfb->urbs.list.next; /* have reserved one with sem */
 		list_del_init(node);
 
-		spin_unlock_irqrestore(&dlfb->urbs.lock, flags);
+		spin_unlock_irq(&dlfb->urbs.lock);
 
 		unode = list_entry(node, struct urb_node, entry);
 		urb = unode->urb;
@@ -1944,7 +1943,6 @@ static struct urb *dlfb_get_urb(struct d
 	int ret;
 	struct list_head *entry;
 	struct urb_node *unode;
-	unsigned long flags;
 
 	/* Wait for an in-flight buffer to complete and get re-queued */
 	ret = down_timeout(&dlfb->urbs.limit_sem, GET_URB_TIMEOUT);
@@ -1956,14 +1954,14 @@ static struct urb *dlfb_get_urb(struct d
 		return NULL;
 	}
 
-	spin_lock_irqsave(&dlfb->urbs.lock, flags);
+	spin_lock_irq(&dlfb->urbs.lock);
 
 	BUG_ON(list_empty(&dlfb->urbs.list)); /* reserved one with limit_sem */
 	entry = dlfb->urbs.list.next;
 	list_del_init(entry);
 	dlfb->urbs.available--;
 
-	spin_unlock_irqrestore(&dlfb->urbs.lock, flags);
+	spin_unlock_irq(&dlfb->urbs.lock);
 
 	unode = list_entry(entry, struct urb_node, entry);
 	return unode->urb;

