From: Ladislav Michl <ladis@linux-mips.org>
Date: Thu, 04 Jan 2018 19:37:51 +0000
Subject: [PATCH v2 2/5] video: udlfb: Remove redundant gdev variable
Message-Id: <20180104193751.GC22612@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

gdev is not really needed as the same content can be read
from udev->dev.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: None (just made patch #2)

 drivers/video/fbdev/udlfb.c | 4 +---
 include/video/udlfb.h       | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 5f68f8c720ec..d4e15d97a264 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1605,7 +1605,6 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 	kref_init(&dev->kref); /* matching kref_put in usb .disconnect fn */
 
 	dev->udev = usbdev;
-	dev->gdev = &usbdev->dev; /* our generic struct device * */
 	usb_set_intfdata(interface, dev);
 
 	pr_info("%s %s - serial #%s\n",
@@ -1670,7 +1669,7 @@ static void dlfb_init_framebuffer_work(struct work_struct *work)
 	int i;
 
 	/* allocates framebuffer driver structure, not framebuffer memory */
-	info = framebuffer_alloc(0, dev->gdev);
+	info = framebuffer_alloc(0, &dev->udev->dev);
 	if (!info) {
 		pr_err("framebuffer_alloc failed\n");
 		goto error;
@@ -1765,7 +1764,6 @@ static void dlfb_usb_disconnect(struct usb_interface *interface)
 
 	usb_set_intfdata(interface, NULL);
 	dev->udev = NULL;
-	dev->gdev = NULL;
 
 	/* if clients still have us open, will be freed on last close */
 	if (dev->fb_count = 0)
diff --git a/include/video/udlfb.h b/include/video/udlfb.h
index 1252a7a89bc0..7b4f567dd1fe 100644
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

