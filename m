From: Johan Hovold <johan@kernel.org>
Date: Fri, 12 May 2017 10:17:25 +0000
Subject: [PATCH] video: fbdev: add missing USB-descriptor endianness conversions
Message-Id: <20170512101725.2207-1-johan@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add the missing endianness conversions when printing the USB
device-descriptor idVendor, idProduct and bcdDevice fields during probe.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/video/fbdev/smscufx.c | 5 +++--
 drivers/video/fbdev/udlfb.c   | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index ec2e7e353685..449fceaf79d5 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1646,8 +1646,9 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	dev_dbg(dev->gdev, "%s %s - serial #%s\n",
 		usbdev->manufacturer, usbdev->product, usbdev->serial);
 	dev_dbg(dev->gdev, "vid_%04x&pid_%04x&rev_%04x driver's ufx_data struct at %p\n",
-		usbdev->descriptor.idVendor, usbdev->descriptor.idProduct,
-		usbdev->descriptor.bcdDevice, dev);
+		le16_to_cpu(usbdev->descriptor.idVendor),
+		le16_to_cpu(usbdev->descriptor.idProduct),
+		le16_to_cpu(usbdev->descriptor.bcdDevice), dev);
 	dev_dbg(dev->gdev, "console enable=%d\n", console);
 	dev_dbg(dev->gdev, "fb_defio enable=%d\n", fb_defio);
 
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 6a3c353de7c3..a868cbb51a34 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1613,8 +1613,9 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 	pr_info("%s %s - serial #%s\n",
 		usbdev->manufacturer, usbdev->product, usbdev->serial);
 	pr_info("vid_%04x&pid_%04x&rev_%04x driver's dlfb_data struct at %p\n",
-		usbdev->descriptor.idVendor, usbdev->descriptor.idProduct,
-		usbdev->descriptor.bcdDevice, dev);
+		le16_to_cpu(usbdev->descriptor.idVendor),
+		le16_to_cpu(usbdev->descriptor.idProduct),
+		le16_to_cpu(usbdev->descriptor.bcdDevice), dev);
 	pr_info("console enable=%d\n", console);
 	pr_info("fb_defio enable=%d\n", fb_defio);
 	pr_info("shadow enable=%d\n", shadow);
-- 
2.13.0

