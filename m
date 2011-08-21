From: bernie@plugable.com
Date: Sun, 21 Aug 2011 20:34:17 +0000
Subject: [PATCH 4/6] udlfb: Add module option to do without shadow framebuffer
Message-Id: <1313958862-5640-7-git-send-email-bernie@plugable.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Stuart Hopkins <stuart@linux-depot.com>

By default, udlfb allocates a 2nd buffer to shadow what's across
the bus on the USB device.  It can operate without this shadow,
but then it cannot tell which pixels have changed, and must send all.

Saves host memory, but worsens the USB 2.0 bus bottleneck.

This option allows users in very low memory situations (e.g.
bifferboard) to optionally turn off this shadow framebuffer.

Signed-off-by: Bernie Thompson <bernie@plugable.com>
Signed-off-by: Stuart Hopkins <stuart@linux-depot.com>
---
 Documentation/fb/udlfb.txt |    5 +++++
 drivers/video/udlfb.c      |   10 ++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/fb/udlfb.txt b/Documentation/fb/udlfb.txt
index 7fdde2a..473ceed 100644
--- a/Documentation/fb/udlfb.txt
+++ b/Documentation/fb/udlfb.txt
@@ -105,6 +105,11 @@ console		Allow fbcon to attach to udlfb provided framebuffers. This
 		the first framebuffer it finds, which isn't usually what the
 		user wants in the case of USB displays.
 
+shadow		Allocate a 2nd framebuffer to shadow what's currently across
+		the USB bus in device memory. If any pixels are unchanged,
+		do not transmit. Spends host memory to save USB transfers.
+		Enabled by default. Only disable on very low memory systems.
+
 Sysfs Attributes
 ========
 
diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index f5df3d3..5a13dc5 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -72,6 +72,7 @@ MODULE_DEVICE_TABLE(usb, id_table);
 /* module options */
 static int console;   /* Optionally allow fbcon to consume first framebuffer */
 static int fb_defio;  /* Optionally enable experimental fb_defio mmap support */
+static int shadow = 1; /* Optionally disable shadow framebuffer */
 
 /* dlfb keeps a list of urbs for efficient bulk transfers */
 static void dlfb_urb_completion(struct urb *urb);
@@ -1158,7 +1159,7 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 	int new_len;
 	unsigned char *old_fb = info->screen_base;
 	unsigned char *new_fb;
-	unsigned char *new_back;
+	unsigned char *new_back = 0;
 
 	pr_warn("Reallocating framebuffer. Addresses will change!\n");
 
@@ -1190,7 +1191,8 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 		 * But with imperfect damage info we may send pixels over USB
 		 * that were, in fact, unchanged - wasting limited USB bandwidth
 		 */
-		new_back = vzalloc(new_len);
+		if (shadow)
+			new_back = vzalloc(new_len);
 		if (!new_back)
 			pr_info("No shadow/backing buffer allocated\n");
 		else {
@@ -1603,6 +1605,7 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 		usbdev->descriptor.bcdDevice, dev);
 	pr_info("console enable=%d\n", console);
 	pr_info("fb_defio enable=%d\n", fb_defio);
+	pr_info("shadow enable=%d\n", shadow);
 
 	dev->sku_pixel_limit = 2048 * 1152; /* default to maximum */
 
@@ -1960,6 +1963,9 @@ MODULE_PARM_DESC(console, "Allow fbcon to consume first framebuffer found");
 module_param(fb_defio, bool, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
 MODULE_PARM_DESC(fb_defio, "Enable fb_defio mmap support. *Experimental*");
 
+module_param(shadow, bool, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
+MODULE_PARM_DESC(shadow, "Shadow vid mem. Disable to save mem but lose perf");
+
 MODULE_AUTHOR("Roberto De Ioris <roberto@unbit.it>, "
 	      "Jaya Kumar <jayakumar.lkml@gmail.com>, "
 	      "Bernie Thompson <bernie@plugable.com>");
-- 
1.7.4.1

