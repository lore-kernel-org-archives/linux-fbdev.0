From: Bernie Thompson <bernie@plugable.com>
Date: Mon, 15 Feb 2010 14:45:49 +0000
Subject: [PATCH 2/10] udlfb: reorganize function order
Message-Id: <1266245149.4353.3289.camel@bernie-aspireone>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Reorganize the location of a few things to be closer to related code

Signed-off-by: Bernie Thompson <bernie@plugable.com>

---
 drivers/staging/udlfb/udlfb.c |   62 +++++++++++++++++++-----------------------
 drivers/staging/udlfb/udlfb.h |    3 ++
 2 files changed, 32 insertions(+), 33 deletions(-)

Index: linux-next/drivers/staging/udlfb/udlfb.c
=================================--- linux-next.orig/drivers/staging/udlfb/udlfb.c	2010-02-14 20:21:39.000000000 -0800
+++ linux-next/drivers/staging/udlfb/udlfb.c	2010-02-14 20:26:49.000000000 -0800
@@ -39,8 +39,17 @@ static struct fb_fix_screeninfo dlfb_fix
 	.accel =        FB_ACCEL_NONE,
 };
 
-#define NR_USB_REQUEST_I2C_SUB_IO 0x02
-#define NR_USB_REQUEST_CHANNEL 0x12
+/*
+ * There are many DisplayLink-based products, all with unique PIDs. We are able
+ * to support all volume ones (circa 2009) with a single driver, so we match
+ * globally on VID. TODO: Probe() needs to detect when we might be running
+ * "future" chips, and bail on those, so a compatible driver can match.
+ */
+static struct usb_device_id id_table[] = {
+	{.idVendor = 0x17e9, .match_flags = USB_DEVICE_ID_MATCH_VENDOR,},
+	{},
+};
+MODULE_DEVICE_TABLE(usb, id_table);
 
 /*
  * Inserts a specific DisplayLink controller command into the provided
@@ -252,24 +261,6 @@ error:
 	return retval;
 }
 
-/*
- * This is necessary before we can communicate with the display controller.
- */
-static int dlfb_select_std_channel(struct dlfb_data *dev)
-{
-	int ret;
-	u8 set_def_chn[] = {	   0x57, 0xCD, 0xDC, 0xA7,
-				0x1C, 0x88, 0x5E, 0x15,
-				0x60, 0xFE, 0xC6, 0x97,
-				0x16, 0x3D, 0x47, 0xF2  };
-
-	ret = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),
-			NR_USB_REQUEST_CHANNEL,
-			(USB_DIR_OUT | USB_TYPE_VENDOR), 0, 0,
-			set_def_chn, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
-	return ret;
-}
-
 
 /*
  * Query EDID from the handware, then hand it off to fbdev's edid parse
@@ -325,18 +316,6 @@ struct dloarea {
 	int x2, y2;
 };
 
-/*
- * There are many DisplayLink-based products, all with unique PIDs. We are able
- * to support all volume ones (circa 2009) with a single driver, so we match
- * globally on VID. TODO: Probe() needs to detect when we might be running
- * "future" chips, and bail on those, so a compatible driver can match.
- */
-static struct usb_device_id id_table[] = {
-	{.idVendor = 0x17e9, .match_flags = USB_DEVICE_ID_MATCH_VENDOR,},
-	{},
-};
-MODULE_DEVICE_TABLE(usb, id_table);
-
 static struct usb_driver dlfb_driver;
 
 /* thanks to Henrik Bjerregaard Pedersen for this function */
@@ -888,7 +867,6 @@ static int dlfb_ioctl(struct fb_info *in
 }
 
 /* taken from vesafb */
-
 static int
 dlfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	       unsigned blue, unsigned transp, struct fb_info *info)
@@ -952,6 +930,24 @@ static struct fb_ops dlfb_ops = {
 	.fb_blank = dlfb_blank,
 };
 
+/*
+ * This is necessary before we can communicate with the display controller.
+ */
+static int dlfb_select_std_channel(struct dlfb_data *dev)
+{
+	int ret;
+	u8 set_def_chn[] = {	   0x57, 0xCD, 0xDC, 0xA7,
+				0x1C, 0x88, 0x5E, 0x15,
+				0x60, 0xFE, 0xC6, 0x97,
+				0x16, 0x3D, 0x47, 0xF2  };
+
+	ret = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),
+			NR_USB_REQUEST_CHANNEL,
+			(USB_DIR_OUT | USB_TYPE_VENDOR), 0, 0,
+			set_def_chn, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
+	return ret;
+}
+
 static int dlfb_probe(struct usb_interface *interface,
 			const struct usb_device_id *id)
 {
Index: linux-next/drivers/staging/udlfb/udlfb.h
=================================--- linux-next.orig/drivers/staging/udlfb/udlfb.h	2010-02-14 20:21:39.000000000 -0800
+++ linux-next/drivers/staging/udlfb/udlfb.h	2010-02-14 20:26:49.000000000 -0800
@@ -26,6 +26,9 @@ struct dlfb_data {
 	u32 pseudo_palette[256];
 };
 
+#define NR_USB_REQUEST_I2C_SUB_IO 0x02
+#define NR_USB_REQUEST_CHANNEL 0x12
+
 static void dlfb_bulk_callback(struct urb *urb)
 {
 	struct dlfb_data *dev_info = urb->context;


