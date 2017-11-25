From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 20:44:15 +0000
Subject: [PATCH 1/5] video: smscufx: Delete an error message for a failed memory allocation in two functions
Message-Id: <2bf3be6e-1839-53cf-479a-d1cbc45015c1@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
In-Reply-To: <f12dd7c4-412d-813e-c859-e5d4b3e6d56f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Steve Glendinning <steve.glendinning@shawell.net>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 18:32:29 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/smscufx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 2275e80b5776..32de07d77184 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1309,10 +1309,8 @@ static int ufx_realloc_framebuffer(struct ufx_data *dev, struct fb_info *info)
 		 * Alloc system memory for virtual framebuffer
 		 */
 		new_fb = vmalloc(new_len);
-		if (!new_fb) {
-			pr_err("Virtual framebuffer alloc failed");
+		if (!new_fb)
 			goto error;
-		}
 
 		if (info->screen_base) {
 			memcpy(new_fb, old_fb, old_len);
@@ -1630,10 +1628,8 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	BUG_ON(!usbdev);
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (dev = NULL) {
-		dev_err(&usbdev->dev, "ufx_usb_probe: failed alloc of dev struct\n");
+	if (!dev)
 		goto error;
-	}
 
 	/* we need to wait for both usb and fbdev to spin down on disconnect */
 	kref_init(&dev->kref); /* matching kref_put in usb .disconnect fn */
-- 
2.15.0

