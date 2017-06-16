From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 16 Jun 2017 14:16:53 +0000
Subject: [GIT PULL] fbdev fixes for v4.12-rc6
Message-Id: <2048689.NbThvpjilr@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170616141656epcas5p2537223b3e33dc13b9703319b09f8c4fc@epcas5p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev fixes for v4.12-rc6.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 32c1431eea4881a6b17bd7c639315010aeefa452:

  Linux 4.12-rc5 (2017-06-11 16:48:20 -0700)

are available in the git repository at:

  git://github.com/bzolnier/linux.git tags/fbdev-v4.12-rc6

for you to fetch changes up to b429f96aa5cb4023b915de9c2aa6e7720a939856:

  video: fbdev: udlfb: drop log level for blanking (2017-06-14 12:40:36 +0200)

----------------------------------------------------------------
fbdev fixes for v4.12-rc6:

- fix udlfb driver to stop spamming logs (Mike Gerow)
- add missing endianness conversions in smscufx & udlfb drivers (Johan Hovold)
- fix few gcc warnings/errors (Arnd Bergmann)

----------------------------------------------------------------
Arnd Bergmann (2):
      video: fbdev: avoid int-in-bool-context warning
      video: fbdev: via: remove possibly unused variables

Johan Hovold (1):
      video: fbdev: add missing USB-descriptor endianness conversions

Mike Gerow (1):
      video: fbdev: udlfb: drop log level for blanking

 drivers/video/fbdev/core/fbmon.c   | 2 +-
 drivers/video/fbdev/smscufx.c      | 5 +++--
 drivers/video/fbdev/udlfb.c        | 9 +++++----
 drivers/video/fbdev/via/viafbdev.c | 8 +++-----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 687ebb0..41d7979 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1048,7 +1048,7 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 
 	for (i = 0; i < (128 - edid[2]) / DETAILED_TIMING_DESCRIPTION_SIZE;
 	     i++, block += DETAILED_TIMING_DESCRIPTION_SIZE)
-		if (PIXEL_CLOCK)
+		if (PIXEL_CLOCK != 0)
 			edt[num++] = block - edid;
 
 	/* Yikes, EDID data is totally useless */
diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index ec2e7e3..449fcea 100644
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
index 6a3c353..05ef657 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1105,8 +1105,8 @@ static int dlfb_ops_blank(int blank_mode, struct fb_info *info)
 	char *bufptr;
 	struct urb *urb;
 
-	pr_info("/dev/fb%d FB_BLANK mode %d --> %d\n",
-		info->node, dev->blank_mode, blank_mode);
+	pr_debug("/dev/fb%d FB_BLANK mode %d --> %d\n",
+		 info->node, dev->blank_mode, blank_mode);
 
 	if ((dev->blank_mode = FB_BLANK_POWERDOWN) &&
 	    (blank_mode != FB_BLANK_POWERDOWN)) {
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
diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index f9718f0..badee04 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -1630,16 +1630,14 @@ static void viafb_init_proc(struct viafb_shared *shared)
 }
 static void viafb_remove_proc(struct viafb_shared *shared)
 {
-	struct proc_dir_entry *viafb_entry = shared->proc_entry,
-		*iga1_entry = shared->iga1_proc_entry,
-		*iga2_entry = shared->iga2_proc_entry;
+	struct proc_dir_entry *viafb_entry = shared->proc_entry;
 
 	if (!viafb_entry)
 		return;
 
-	remove_proc_entry("output_devices", iga2_entry);
+	remove_proc_entry("output_devices", shared->iga2_proc_entry);
 	remove_proc_entry("iga2", viafb_entry);
-	remove_proc_entry("output_devices", iga1_entry);
+	remove_proc_entry("output_devices", shared->iga1_proc_entry);
 	remove_proc_entry("iga1", viafb_entry);
 	remove_proc_entry("supported_output_devices", viafb_entry);
 

