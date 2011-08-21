From: bernie@plugable.com
Date: Sun, 21 Aug 2011 20:35:39 +0000
Subject: [PATCH 6/6] udlfb: Enable fbcon access to framebuffer by default
Message-Id: <1313958939-5681-6-git-send-email-bernie@plugable.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Bernie Thompson <bernie@plugable.com>

Signed-off-by: Bernie Thompson <bernie@plugable.com>
---
 Documentation/fb/udlfb.txt |   10 ++++++----
 drivers/video/udlfb.c      |    4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/fb/udlfb.txt b/Documentation/fb/udlfb.txt
index c6d90a6..57d2f29 100644
--- a/Documentation/fb/udlfb.txt
+++ b/Documentation/fb/udlfb.txt
@@ -107,16 +107,18 @@ fb_defio	Make use of the fb_defio (CONFIG_FB_DEFERRED_IO) kernel
 		Disable when running with X server that supports reporting
 		changed regions via ioctl, as this method is simpler,
 		more stable, and higher performance.
+		default: fb_defio=1
 
-console	Allow fbcon to attach to udlfb provided framebuffers. This
-		is disabled by default because fbcon will aggressively consume
-		the first framebuffer it finds, which isn't usually what the
-		user wants in the case of USB displays.
+console	Allow fbcon to attach to udlfb provided framebuffers.
+		Can be disabled if fbcon and other clients
+		(e.g. X with --shared-vt) are in conflict.
+		default: console=1
 
 shadow		Allocate a 2nd framebuffer to shadow what's currently across
 		the USB bus in device memory. If any pixels are unchanged,
 		do not transmit. Spends host memory to save USB transfers.
 		Enabled by default. Only disable on very low memory systems.
+		default: shadow=1
 
 Sysfs Attributes
 ========
diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 5207bd2..c8857da 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -70,7 +70,7 @@ static struct usb_device_id id_table[] = {
 MODULE_DEVICE_TABLE(usb, id_table);
 
 /* module options */
-static int console;   /* Optionally allow fbcon to consume first framebuffer */
+static int console = 1; /* Allow fbcon to open framebuffer */
 static int fb_defio = 1;  /* Detect mmap writes using page faults */
 static int shadow = 1; /* Optionally disable shadow framebuffer */
 
@@ -1958,7 +1958,7 @@ static int dlfb_submit_urb(struct dlfb_data *dev, struct urb *urb, size_t len)
 }
 
 module_param(console, bool, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
-MODULE_PARM_DESC(console, "Allow fbcon to consume first framebuffer found");
+MODULE_PARM_DESC(console, "Allow fbcon to open framebuffer");
 
 module_param(fb_defio, bool, S_IWUSR | S_IRUSR | S_IWGRP | S_IRGRP);
 MODULE_PARM_DESC(fb_defio, "Page fault detection of mmap writes");
-- 
1.7.4.1

