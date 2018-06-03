From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:40:55 +0000
Subject: [PATCH 02/21] udl-kms: change down_interruptible to down
Message-Id: <20180603144219.723405624@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

If we leave urbs around, it causes not only leak, but also memory
corruption. This patch fixes the function udl_free_urb_list, so that it
always waits for all urbs that are in progress.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/gpu/drm/udl/udl_main.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Index: linux-4.16.12/drivers/gpu/drm/udl/udl_main.c
=================================--- linux-4.16.12.orig/drivers/gpu/drm/udl/udl_main.c	2018-05-31 10:23:42.000000000 +0200
+++ linux-4.16.12/drivers/gpu/drm/udl/udl_main.c	2018-05-31 10:28:11.000000000 +0200
@@ -170,18 +170,13 @@ static void udl_free_urb_list(struct drm
 	struct list_head *node;
 	struct urb_node *unode;
 	struct urb *urb;
-	int ret;
 	unsigned long flags;
 
 	DRM_DEBUG("Waiting for completes and freeing all render urbs\n");
 
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
-
-		/* Getting interrupted means a leak, but ok at shutdown*/
-		ret = down_interruptible(&udl->urbs.limit_sem);
-		if (ret)
-			break;
+		down(&udl->urbs.limit_sem);
 
 		spin_lock_irqsave(&udl->urbs.lock, flags);
 

