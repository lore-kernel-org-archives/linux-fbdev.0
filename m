From: bernie@plugable.com
Date: Sun, 21 Aug 2011 20:34:14 +0000
Subject: [PATCH 2/5] udlfb: Search config descriptor if not at device level
Message-Id: <1313958862-5640-4-git-send-email-bernie@plugable.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1312264472-2900-2-git-send-email-bernie@plugable.com>
In-Reply-To: <1312264472-2900-2-git-send-email-bernie@plugable.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Andrew Kephart <akephart@akephart.org>

For at least one DisplayLink device, the vendor-specific information can
be found in the config descriptor instead of as a separate, device-level
descriptor.  This patch searches the current interface (of the current
config descriptor) for the DL vendor-specific descriptor.

Signed-off-by: Andrew Kephart <akephart@akephart.org>
Signed-off-by: Bernie Thompson <bernie@plugable.com>
---
 drivers/video/udlfb.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 844b371..bdd21de 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -1489,21 +1489,30 @@ static int dlfb_select_std_channel(struct dlfb_data *dev)
 }
 
 static int dlfb_parse_vendor_descriptor(struct dlfb_data *dev,
-					struct usb_device *usbdev)
+					struct usb_interface *interface)
 {
 	char *desc;
 	char *buf;
 	char *desc_end;
 
-	u8 total_len = 0;
+	int total_len = 0;
 
 	buf = kzalloc(MAX_VENDOR_DESCRIPTOR_SIZE, GFP_KERNEL);
 	if (!buf)
 		return false;
 	desc = buf;
 
-	total_len = usb_get_descriptor(usbdev, 0x5f, /* vendor specific */
-				    0, desc, MAX_VENDOR_DESCRIPTOR_SIZE);
+	total_len = usb_get_descriptor(interface_to_usbdev(interface),
+					0x5f, /* vendor specific */
+					0, desc, MAX_VENDOR_DESCRIPTOR_SIZE);
+
+	/* if not found, look in configuration descriptor */
+	if (total_len < 0) {
+		if (0 = usb_get_extra_descriptor(interface->cur_altsetting,
+			0x5f, &desc))
+			total_len = (int) desc[0];
+	}
+
 	if (total_len > 5) {
 		pr_info("vendor descriptor length:%x data:%02x %02x %02x %02x" \
 			"%02x %02x %02x %02x %02x %02x %02x\n",
@@ -1544,6 +1553,8 @@ static int dlfb_parse_vendor_descriptor(struct dlfb_data *dev,
 			}
 			desc += length;
 		}
+	} else {
+		pr_info("vendor descriptor not available (%d)\n", total_len);
 	}
 
 	goto success;
@@ -1593,7 +1604,7 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 
 	dev->sku_pixel_limit = 2048 * 1152; /* default to maximum */
 
-	if (!dlfb_parse_vendor_descriptor(dev, usbdev)) {
+	if (!dlfb_parse_vendor_descriptor(dev, interface)) {
 		pr_err("firmware not recognized. Assume incompatible device\n");
 		goto error;
 	}
-- 
1.7.4.1

