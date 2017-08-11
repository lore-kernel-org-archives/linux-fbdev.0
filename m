From: Anton Vasilyev <vasilyev@ispras.ru>
Date: Fri, 11 Aug 2017 12:59:01 +0000
Subject: [PATCH] video: fbdev: udlfb: Fix use after free on dlfb_usb_probe error path
Message-Id: <1502456341-1783-1-git-send-email-vasilyev@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bernie Thompson <bernie@plugable.com>
Cc: Anton Vasilyev <vasilyev@ispras.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

If dlfb_usb_probe drops to error path then there is only one
kref_init() call and no kref_get(), so second kref_put() leads to
use after free.

The patch removes superfluous kref_put on dlfb_usb_probe error path.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/video/fbdev/udlfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 05ef657..f71b49f 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1655,7 +1655,6 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 error:
 	if (dev) {
 
-		kref_put(&dev->kref, dlfb_free); /* ref for framebuffer */
 		kref_put(&dev->kref, dlfb_free); /* last ref from kref_init */
 
 		/* dev has been deallocated. Do not dereference */
-- 
2.7.4

