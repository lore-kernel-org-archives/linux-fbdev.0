From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 20:49:36 +0000
Subject: [PATCH 1/4] video: udlfb: Delete an error message for a failed memory allocation in two functions
Message-Id: <6ae3ae6d-acd2-38d2-0350-4a9b833489ec@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
In-Reply-To: <6fb11bb4-2c1d-a939-087b-de31c42328b9@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bernie Thompson <bernie@plugable.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 24 Nov 2017 21:12:54 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/udlfb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index d44f14242016..77633c58bb9b 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1175,10 +1175,8 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 		 * Alloc system memory for virtual framebuffer
 		 */
 		new_fb = vmalloc(new_len);
-		if (!new_fb) {
-			pr_err("Virtual framebuffer alloc failed\n");
+		if (!new_fb)
 			goto error;
-		}
 
 		if (info->screen_base) {
 			memcpy(new_fb, old_fb, old_len);
@@ -1599,10 +1597,8 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 	usbdev = interface_to_usbdev(interface);
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (dev = NULL) {
-		dev_err(&interface->dev, "dlfb_usb_probe: failed alloc of dev struct\n");
+	if (!dev)
 		goto error;
-	}
 
 	kref_init(&dev->kref); /* matching kref_put in usb .disconnect fn */
 
-- 
2.15.0

