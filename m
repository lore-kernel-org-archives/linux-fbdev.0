From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 20:45:26 +0000
Subject: [PATCH 2/5] video: smscufx: Less checks in ufx_usb_probe() after error detection
Message-Id: <73df7ce0-c4b0-aec7-ee7e-74f55a0fe708@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
In-Reply-To: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steve Glendinning <steve.glendinning@shawell.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 19:47:51 +0100

Up to four checks could be repeated by the ufx_usb_probe() function
during error handling even if the relevant properties can be determined
for the involved variables before by source code analysis.

* Return directly after a call of the function "kzalloc" failed
  at the beginning.

* Adjust jump targets so that extra checks can be omitted at the end.

* Delete initialisations for the variables "info" and "retval"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/smscufx.c | 45 +++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 32de07d77184..08271dafd138 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1619,8 +1619,8 @@ static int ufx_usb_probe(struct usb_interface *interface,
 {
 	struct usb_device *usbdev;
 	struct ufx_data *dev;
-	struct fb_info *info = NULL;
-	int retval = -ENOMEM;
+	struct fb_info *info;
+	int retval;
 	u32 id_rev, fpga_rev;
 
 	/* usb initialization */
@@ -1629,7 +1629,7 @@ static int ufx_usb_probe(struct usb_interface *interface,
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
-		goto error;
+		return -ENOMEM;
 
 	/* we need to wait for both usb and fbdev to spin down on disconnect */
 	kref_init(&dev->kref); /* matching kref_put in usb .disconnect fn */
@@ -1649,9 +1649,8 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	dev_dbg(dev->gdev, "fb_defio enable=%d\n", fb_defio);
 
 	if (!ufx_alloc_urb_list(dev, WRITES_IN_FLIGHT, MAX_TRANSFER)) {
-		retval = -ENOMEM;
 		dev_err(dev->gdev, "ufx_alloc_urb_list failed\n");
-		goto error;
+		goto e_nomem;
 	}
 
 	/* We don't register a new USB class. Our client interface is fbdev */
@@ -1659,9 +1658,8 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	/* allocates framebuffer driver structure, not framebuffer memory */
 	info = framebuffer_alloc(0, &usbdev->dev);
 	if (!info) {
-		retval = -ENOMEM;
 		dev_err(dev->gdev, "framebuffer_alloc failed\n");
-		goto error;
+		goto e_nomem;
 	}
 
 	dev->info = info;
@@ -1672,7 +1670,7 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	retval = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (retval < 0) {
 		dev_err(dev->gdev, "fb_alloc_cmap failed %x\n", retval);
-		goto error;
+		goto destroy_modedb;
 	}
 
 	INIT_DELAYED_WORK(&dev->free_framebuffer_work,
@@ -1733,26 +1731,19 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	return 0;
 
 error:
-	if (dev) {
-		if (info) {
-			if (info->cmap.len != 0)
-				fb_dealloc_cmap(&info->cmap);
-			if (info->monspecs.modedb)
-				fb_destroy_modedb(info->monspecs.modedb);
-			vfree(info->screen_base);
-
-			fb_destroy_modelist(&info->modelist);
-
-			framebuffer_release(info);
-		}
-
-		kref_put(&dev->kref, ufx_free); /* ref for framebuffer */
-		kref_put(&dev->kref, ufx_free); /* last ref from kref_init */
-
-		/* dev has been deallocated. Do not dereference */
-	}
-
+destroy_modedb:
+	fb_destroy_modedb(info->monspecs.modedb);
+	vfree(info->screen_base);
+	fb_destroy_modelist(&info->modelist);
+	framebuffer_release(info);
+put_ref:
+	kref_put(&dev->kref, ufx_free); /* ref for framebuffer */
+	kref_put(&dev->kref, ufx_free); /* last ref from kref_init */
 	return retval;
+
+e_nomem:
+	retval = -ENOMEM;
+	goto put_ref;
 }
 
 static void ufx_usb_disconnect(struct usb_interface *interface)
-- 
2.15.0

