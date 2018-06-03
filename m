From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:40:56 +0000
Subject: [PATCH 03/21] udl-kms: handle allocation failure
Message-Id: <20180603144220.065709710@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Allocations larger than PAGE_ALLOC_COSTLY_ORDER are unreliable and they
may fail anytime. This patch fixes the udl kms driver so that when a large
alloactions fails, it tries to do multiple smaller allocations.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/gpu/drm/udl/udl_main.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

Index: linux-4.16.12/drivers/gpu/drm/udl/udl_main.c
=================================--- linux-4.16.12.orig/drivers/gpu/drm/udl/udl_main.c	2018-05-31 11:16:15.000000000 +0200
+++ linux-4.16.12/drivers/gpu/drm/udl/udl_main.c	2018-05-31 11:16:15.000000000 +0200
@@ -200,17 +200,22 @@ static void udl_free_urb_list(struct drm
 static int udl_alloc_urb_list(struct drm_device *dev, int count, size_t size)
 {
 	struct udl_device *udl = dev->dev_private;
-	int i = 0;
 	struct urb *urb;
 	struct urb_node *unode;
 	char *buf;
+	size_t wanted_size = count * size;
 
 	spin_lock_init(&udl->urbs.lock);
 
+retry:
 	udl->urbs.size = size;
 	INIT_LIST_HEAD(&udl->urbs.list);
 
-	while (i < count) {
+	sema_init(&udl->urbs.limit_sem, 0);
+	udl->urbs.count = 0;
+	udl->urbs.available = 0;
+
+	while (udl->urbs.count * size < wanted_size) {
 		unode = kzalloc(sizeof(struct urb_node), GFP_KERNEL);
 		if (!unode)
 			break;
@@ -226,11 +231,16 @@ static int udl_alloc_urb_list(struct drm
 		}
 		unode->urb = urb;
 
-		buf = usb_alloc_coherent(udl->udev, MAX_TRANSFER, GFP_KERNEL,
+		buf = usb_alloc_coherent(udl->udev, size, GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			kfree(unode);
 			usb_free_urb(urb);
+			if (size > PAGE_SIZE) {
+				size /= 2;
+				udl_free_urb_list(dev);
+				goto retry;
+			}
 			break;
 		}
 
@@ -241,16 +251,14 @@ static int udl_alloc_urb_list(struct drm
 
 		list_add_tail(&unode->entry, &udl->urbs.list);
 
-		i++;
+		up(&udl->urbs.limit_sem);
+		udl->urbs.count++;
+		udl->urbs.available++;
 	}
 
-	sema_init(&udl->urbs.limit_sem, i);
-	udl->urbs.count = i;
-	udl->urbs.available = i;
-
-	DRM_DEBUG("allocated %d %d byte urbs\n", i, (int) size);
+	DRM_DEBUG("allocated %d %d byte urbs\n", udl->urbs.count, (int) size);
 
-	return i;
+	return udl->urbs.count;
 }
 
 struct urb *udl_get_urb(struct drm_device *dev)

