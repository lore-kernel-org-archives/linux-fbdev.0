From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:09 +0000
Subject: [PATCH 16/21] udlfb: handle allocation failure
Message-Id: <20180603144224.714382188@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Allocations larger than PAGE_ALLOC_COSTLY_ORDER are unreliable and they
may fail anytime. This patch fixes the udlfb driver so that when a large
alloactions fails, it tries to do multiple smaller allocations.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/video/fbdev/udlfb.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

Index: linux-4.17-rc7/drivers/video/fbdev/udlfb.c
=================================--- linux-4.17-rc7.orig/drivers/video/fbdev/udlfb.c	2018-06-03 13:17:38.000000000 +0200
+++ linux-4.17-rc7/drivers/video/fbdev/udlfb.c	2018-06-03 13:17:38.000000000 +0200
@@ -1843,17 +1843,22 @@ static void dlfb_free_urb_list(struct dl
 
 static int dlfb_alloc_urb_list(struct dlfb_data *dlfb, int count, size_t size)
 {
-	int i = 0;
 	struct urb *urb;
 	struct urb_node *unode;
 	char *buf;
+	size_t wanted_size = count * size;
 
 	spin_lock_init(&dlfb->urbs.lock);
 
+retry:
 	dlfb->urbs.size = size;
 	INIT_LIST_HEAD(&dlfb->urbs.list);
 
-	while (i < count) {
+	sema_init(&dlfb->urbs.limit_sem, 0);
+	dlfb->urbs.count = 0;
+	dlfb->urbs.available = 0;
+
+	while (dlfb->urbs.count * size < wanted_size) {
 		unode = kzalloc(sizeof(*unode), GFP_KERNEL);
 		if (!unode)
 			break;
@@ -1866,11 +1871,16 @@ static int dlfb_alloc_urb_list(struct dl
 		}
 		unode->urb = urb;
 
-		buf = usb_alloc_coherent(dlfb->udev, MAX_TRANSFER, GFP_KERNEL,
+		buf = usb_alloc_coherent(dlfb->udev, size, GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			kfree(unode);
 			usb_free_urb(urb);
+			if (size > PAGE_SIZE) {
+				size /= 2;
+				dlfb_free_urb_list(dlfb);
+				goto retry;
+			}
 			break;
 		}
 
@@ -1881,14 +1891,12 @@ static int dlfb_alloc_urb_list(struct dl
 
 		list_add_tail(&unode->entry, &dlfb->urbs.list);
 
-		i++;
+		up(&dlfb->urbs.limit_sem);
+		dlfb->urbs.count++;
+		dlfb->urbs.available++;
 	}
 
-	sema_init(&dlfb->urbs.limit_sem, i);
-	dlfb->urbs.count = i;
-	dlfb->urbs.available = i;
-
-	return i;
+	return dlfb->urbs.count;
 }
 
 static struct urb *dlfb_get_urb(struct dlfb_data *dlfb)

