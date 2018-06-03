From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:02 +0000
Subject: [PATCH 09/21] udl-kms: use spin_lock_irq instead of spin_lock_irqsave
Message-Id: <20180603144222.335724006@twibright.com>
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
 drivers/gpu/drm/udl/udl_main.c    |   10 ++++------
 drivers/gpu/drm/udl/udl_modeset.c |    5 ++---
 2 files changed, 6 insertions(+), 9 deletions(-)

Index: linux-4.16.12/drivers/gpu/drm/udl/udl_main.c
=================================--- linux-4.16.12.orig/drivers/gpu/drm/udl/udl_main.c	2018-05-31 11:17:01.000000000 +0200
+++ linux-4.16.12/drivers/gpu/drm/udl/udl_main.c	2018-05-31 11:17:01.000000000 +0200
@@ -170,7 +170,6 @@ static void udl_free_urb_list(struct drm
 	struct list_head *node;
 	struct urb_node *unode;
 	struct urb *urb;
-	unsigned long flags;
 
 	DRM_DEBUG("Waiting for completes and freeing all render urbs\n");
 
@@ -178,12 +177,12 @@ static void udl_free_urb_list(struct drm
 	while (count--) {
 		down(&udl->urbs.limit_sem);
 
-		spin_lock_irqsave(&udl->urbs.lock, flags);
+		spin_lock_irq(&udl->urbs.lock);
 
 		node = udl->urbs.list.next; /* have reserved one with sem */
 		list_del_init(node);
 
-		spin_unlock_irqrestore(&udl->urbs.lock, flags);
+		spin_unlock_irq(&udl->urbs.lock);
 
 		unode = list_entry(node, struct urb_node, entry);
 		urb = unode->urb;
@@ -268,7 +267,6 @@ struct urb *udl_get_urb(struct drm_devic
 	struct list_head *entry;
 	struct urb_node *unode;
 	struct urb *urb = NULL;
-	unsigned long flags;
 
 	/* Wait for an in-flight buffer to complete and get re-queued */
 	ret = down_timeout(&udl->urbs.limit_sem, GET_URB_TIMEOUT);
@@ -279,14 +277,14 @@ struct urb *udl_get_urb(struct drm_devic
 		goto error;
 	}
 
-	spin_lock_irqsave(&udl->urbs.lock, flags);
+	spin_lock_irq(&udl->urbs.lock);
 
 	BUG_ON(list_empty(&udl->urbs.list)); /* reserved one with limit_sem */
 	entry = udl->urbs.list.next;
 	list_del_init(entry);
 	udl->urbs.available--;
 
-	spin_unlock_irqrestore(&udl->urbs.lock, flags);
+	spin_unlock_irq(&udl->urbs.lock);
 
 	unode = list_entry(entry, struct urb_node, entry);
 	urb = unode->urb;
Index: linux-4.16.12/drivers/gpu/drm/udl/udl_modeset.c
=================================--- linux-4.16.12.orig/drivers/gpu/drm/udl/udl_modeset.c	2018-05-31 11:17:01.000000000 +0200
+++ linux-4.16.12/drivers/gpu/drm/udl/udl_modeset.c	2018-05-31 11:17:01.000000000 +0200
@@ -366,7 +366,6 @@ static int udl_crtc_page_flip(struct drm
 {
 	struct udl_framebuffer *ufb = to_udl_fb(fb);
 	struct drm_device *dev = crtc->dev;
-	unsigned long flags;
 
 	struct drm_framebuffer *old_fb = crtc->primary->fb;
 	if (old_fb) {
@@ -377,10 +376,10 @@ static int udl_crtc_page_flip(struct drm
 
 	udl_handle_damage(ufb, 0, 0, fb->width, fb->height);
 
-	spin_lock_irqsave(&dev->event_lock, flags);
+	spin_lock_irq(&dev->event_lock);
 	if (event)
 		drm_crtc_send_vblank_event(crtc, event);
-	spin_unlock_irqrestore(&dev->event_lock, flags);
+	spin_unlock_irq(&dev->event_lock);
 	crtc->primary->fb = fb;
 
 	return 0;

