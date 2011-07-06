From: bernie@plugable.com
Date: Wed, 06 Jul 2011 00:04:11 +0000
Subject: [PATCH] drivers/video/udlfb bind framebuffer to interface.
Message-Id: <1309910651-3483-1-git-send-email-bernie@plugable.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Kay Sievers <kay.sievers@vrfy.org>

Udlfb has been binding the framebuffer device to its parent, which
isn't correct and causes confusion with operations like udev remove.

Coming plug and play multiseat support is dependent on this fix.

Signed-off-by: Bernie Thompson <bernie@plugable.com>
---
 drivers/video/udlfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 816a4fd..c6584c9 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -1549,7 +1549,7 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 	/* We don't register a new USB class. Our client interface is fbdev */
 
 	/* allocates framebuffer driver structure, not framebuffer memory */
-	info = framebuffer_alloc(0, &usbdev->dev);
+	info = framebuffer_alloc(0, &interface->dev);
 	if (!info) {
 		retval = -ENOMEM;
 		pr_err("framebuffer_alloc failed\n");
-- 
1.7.4.1

