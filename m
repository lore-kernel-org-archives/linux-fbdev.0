From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 11 Dec 2017 21:41:56 +0000
Subject: [PATCH 4/6] video: udlfb: Delete error messages for failed allocations
Message-Id: <20171211214156.GE29173@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Omit extra messages for an allocation failures, as those
are already reported by failed functions.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/video/fbdev/udlfb.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index f74facaed8cc..3d757b10a73c 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1173,10 +1173,8 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb, struct fb_info *info
 		 * Alloc system memory for virtual framebuffer
 		 */
 		new_fb = vmalloc(new_len);
-		if (!new_fb) {
-			pr_err("Virtual framebuffer alloc failed\n");
+		if (!new_fb)
 			goto error;
-		}
 
 		if (info->screen_base) {
 			memcpy(new_fb, old_fb, old_len);
@@ -1597,10 +1595,8 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 	usbdev = interface_to_usbdev(interface);
 
 	dlfb = kzalloc(sizeof(*dlfb), GFP_KERNEL);
-	if (dlfb = NULL) {
-		dev_err(&interface->dev, "dlfb_usb_probe: failed alloc of dev struct\n");
+	if (!dlfb)
 		goto error;
-	}
 
 	kref_init(&dlfb->kref); /* matching kref_put in usb .disconnect fn */
 
@@ -1635,7 +1631,6 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 
 	if (!dlfb_alloc_urb_list(dlfb, WRITES_IN_FLIGHT, MAX_TRANSFER)) {
 		retval = -ENOMEM;
-		pr_err("dlfb_alloc_urb_list failed\n");
 		goto error;
 	}
 
@@ -1671,10 +1666,8 @@ static void dlfb_init_framebuffer_work(struct work_struct *work)
 
 	/* allocates framebuffer driver structure, not framebuffer memory */
 	info = framebuffer_alloc(0, dlfb->gdev);
-	if (!info) {
-		pr_err("framebuffer_alloc failed\n");
+	if (!info)
 		goto error;
-	}
 
 	dlfb->info = info;
 	info->par = dlfb;
@@ -1682,10 +1675,8 @@ static void dlfb_init_framebuffer_work(struct work_struct *work)
 	info->fbops = &dlfb_ops;
 
 	retval = fb_alloc_cmap(&info->cmap, 256, 0);
-	if (retval < 0) {
-		pr_err("fb_alloc_cmap failed %x\n", retval);
+	if (retval < 0)
 		goto error;
-	}
 
 	INIT_DELAYED_WORK(&dlfb->free_framebuffer_work,
 			  dlfb_free_framebuffer_work);
-- 
2.15.1

