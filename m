From: Ladislav Michl <ladis@linux-mips.org>
Date: Mon, 11 Dec 2017 21:42:33 +0000
Subject: [PATCH 5/6] video: udlfb: Remove redundant gdev variable
Message-Id: <20171211214233.GF29173@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

gdev is not really needed as the same content can be read
from udev->dev.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/video/fbdev/udlfb.c | 4 +---
 include/video/udlfb.h       | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 3d757b10a73c..2b22b09e5c3c 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1601,7 +1601,6 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 	kref_init(&dlfb->kref); /* matching kref_put in usb .disconnect fn */
 
 	dlfb->udev = usbdev;
-	dlfb->gdev = &usbdev->dev; /* our generic struct device * */
 	usb_set_intfdata(interface, dlfb);
 
 	pr_info("%s %s - serial #%s\n",
@@ -1665,7 +1664,7 @@ static void dlfb_init_framebuffer_work(struct work_struct *work)
 	int i;
 
 	/* allocates framebuffer driver structure, not framebuffer memory */
-	info = framebuffer_alloc(0, dlfb->gdev);
+	info = framebuffer_alloc(0, &dlfb->udev->dev);
 	if (!info)
 		goto error;
 
@@ -1755,7 +1754,6 @@ static void dlfb_usb_disconnect(struct usb_interface *interface)
 
 	usb_set_intfdata(interface, NULL);
 	dlfb->udev = NULL;
-	dlfb->gdev = NULL;
 
 	/* if clients still have us open, will be freed on last close */
 	if (dlfb->fb_count = 0)
diff --git a/include/video/udlfb.h b/include/video/udlfb.h
index 7310224acb7f..0cabe6b09095 100644
--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -35,7 +35,6 @@ struct urb_list {
 
 struct dlfb_data {
 	struct usb_device *udev;
-	struct device *gdev; /* &udev->dev */
 	struct fb_info *info;
 	struct urb_list urbs;
 	struct kref kref;
-- 
2.15.1

