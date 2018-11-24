From: Colin King <colin.king@canonical.com>
Date: Sat, 24 Nov 2018 14:48:40 +0000
Subject: [PATCH] udlfb: don't call unregister_framebuffer on a null pointer
Message-Id: <20181124144840.14608-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bernie Thompson <bernie@plugable.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Just before calling unregister_framebuffer with info there is a
null check on info, implying info may possibly zero.  Calling
unregister_framebuffer with a null pointer will cause a null
pointer dereference, fix this by moving the call to the block
where info has been null checked.

Detected by CoverityScan, CID#1473969 ("Dereference after null check")

Fixes: 68a958a915ca ("udlfb: handle unplug properly")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/udlfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 070026a7e55a..cf8597f43d7e 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1735,9 +1735,9 @@ static void dlfb_usb_disconnect(struct usb_interface *intf)
 		for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++)
 			device_remove_file(info->dev, &fb_device_attrs[i]);
 		device_remove_bin_file(info->dev, &edid_attr);
+		unregister_framebuffer(info);
 	}
 
-	unregister_framebuffer(info);
 }
 
 static struct usb_driver dlfb_driver = {
-- 
2.19.1
