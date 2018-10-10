From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 10 Oct 2018 10:36:06 +0000
Subject: [PATCH] udlfb: fix some inconsistent NULL checking
Message-Id: <20181010103606.GA14563@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bernie Thompson <bernie@plugable.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

In the current kernel, then kzalloc() can't fail for small allocations,
but if it did fail then we would have a NULL dereference in the error
handling.  Also in dlfb_usb_disconnect() if "info" were NULL then it
would cause an Oops inside the unregister_framebuffer() function but it
can't be NULL so let's remove that check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 070026a7e55a..1d034dddc556 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1598,7 +1598,7 @@ static int dlfb_usb_probe(struct usb_interface *intf,
 	dlfb = kzalloc(sizeof(*dlfb), GFP_KERNEL);
 	if (!dlfb) {
 		dev_err(&intf->dev, "%s: failed to allocate dlfb\n", __func__);
-		goto error;
+		return -ENOMEM;
 	}
 
 	INIT_LIST_HEAD(&dlfb->deferred_free);
@@ -1703,7 +1703,7 @@ static int dlfb_usb_probe(struct usb_interface *intf,
 error:
 	if (dlfb->info) {
 		dlfb_ops_destroy(dlfb->info);
-	} else if (dlfb) {
+	} else {
 		usb_put_dev(dlfb->udev);
 		kfree(dlfb);
 	}
@@ -1730,12 +1730,10 @@ static void dlfb_usb_disconnect(struct usb_interface *intf)
 	/* this function will wait for all in-flight urbs to complete */
 	dlfb_free_urb_list(dlfb);
 
-	if (info) {
-		/* remove udlfb's sysfs interfaces */
-		for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++)
-			device_remove_file(info->dev, &fb_device_attrs[i]);
-		device_remove_bin_file(info->dev, &edid_attr);
-	}
+	/* remove udlfb's sysfs interfaces */
+	for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++)
+		device_remove_file(info->dev, &fb_device_attrs[i]);
+	device_remove_bin_file(info->dev, &edid_attr);
 
 	unregister_framebuffer(info);
 }
