From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 07 Jan 2018 16:02:21 +0000
Subject: [PATCH v3 1/3] video: smscufx: Less checks in ufx_usb_probe() after error detection
Message-Id: <03be4276-520e-1d22-1c6e-e35c8df2b1e8@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0@epcas2p1.samsung.com>
 <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
 <1736749.UIs06O4xc5@amdc3058>
 <a36fa112-40a1-703c-c2ac-ce7e88bb8609@users.sourceforge.net>
In-Reply-To: <a36fa112-40a1-703c-c2ac-ce7e88bb8609@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steve Glendinning <steve.glendinning@shawell.net>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 Jan 2018 15:56:11 +0100

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

v3:
This update suggestion was rebased on source files from the software
"Linux next-20180105".

v2:
A call of the function "fb_dealloc_cmap" was preserved for the exception
handling at the end.

 drivers/video/fbdev/smscufx.c | 46 ++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 8db7085e5d1a..893daeb1ffd9 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1620,8 +1620,8 @@ static int ufx_usb_probe(struct usb_interface *interface,
 {
 	struct usb_device *usbdev;
 	struct ufx_data *dev;
-	struct fb_info *info = NULL;
-	int retval = -ENOMEM;
+	struct fb_info *info;
+	int retval;
 	u32 id_rev, fpga_rev;
 
 	/* usb initialization */
@@ -1631,7 +1631,7 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev = NULL) {
 		dev_err(&usbdev->dev, "ufx_usb_probe: failed alloc of dev struct\n");
-		goto error;
+		return -ENOMEM;
 	}
 
 	/* we need to wait for both usb and fbdev to spin down on disconnect */
@@ -1652,9 +1652,8 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	dev_dbg(dev->gdev, "fb_defio enable=%d\n", fb_defio);
 
 	if (!ufx_alloc_urb_list(dev, WRITES_IN_FLIGHT, MAX_TRANSFER)) {
-		retval = -ENOMEM;
 		dev_err(dev->gdev, "ufx_alloc_urb_list failed\n");
-		goto error;
+		goto e_nomem;
 	}
 
 	/* We don't register a new USB class. Our client interface is fbdev */
@@ -1662,9 +1661,8 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	/* allocates framebuffer driver structure, not framebuffer memory */
 	info = framebuffer_alloc(0, &usbdev->dev);
 	if (!info) {
-		retval = -ENOMEM;
 		dev_err(dev->gdev, "framebuffer_alloc failed\n");
-		goto error;
+		goto e_nomem;
 	}
 
 	dev->info = info;
@@ -1675,7 +1673,7 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	retval = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (retval < 0) {
 		dev_err(dev->gdev, "fb_alloc_cmap failed %x\n", retval);
-		goto error;
+		goto destroy_modedb;
 	}
 
 	INIT_DELAYED_WORK(&dev->free_framebuffer_work,
@@ -1736,26 +1734,20 @@ static int ufx_usb_probe(struct usb_interface *interface,
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
+	fb_dealloc_cmap(&info->cmap);
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
2.15.1

