From: Wen Yang <wen.yang99@zte.com.cn>
Date: Mon, 03 Dec 2018 06:21:25 +0000
Subject: [PATCH] udlfb: fix potential NULL pointer dereference in dlfb_usb_probe
Message-Id: <20181203062125.34880-1-wen.yang99@zte.com.cn>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bernie Thompson <bernie@plugable.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>

This patch fixes a possible null pointer dereference in
dlfb_usb_probe, detected by the semantic patch deref_null.cocci,
with the following warning:

drivers/video/fbdev/udlfb.c:1704:11-15: ERROR: dlfb is NULL but dereferenced.

The following code has potential null pointer references:
1597         /* usb initialization */
1598         dlfb = kzalloc(sizeof(*dlfb), GFP_KERNEL);
1599         if (!dlfb) {
...
1601             goto error;
1602         }
...
1703 error:
1704         if (dlfb->info) {
1705                 dlfb_ops_destroy(dlfb->info);
1706         } else if (dlfb) {
1707                 usb_put_dev(dlfb->udev);
1708                 kfree(dlfb);
1709         }

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Bernie Thompson <bernie@plugable.com>
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC: linux-fbdev@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
CC: linux-kernel@vger.kernel.org
---
 drivers/video/fbdev/udlfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 070026a7e55a..df37cfaa2362 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1701,7 +1701,7 @@ static int dlfb_usb_probe(struct usb_interface *intf,
 	return 0;
 
 error:
-	if (dlfb->info) {
+	if (dlfb && dlfb->info) {
 		dlfb_ops_destroy(dlfb->info);
 	} else if (dlfb) {
 		usb_put_dev(dlfb->udev);
-- 
2.19.1
