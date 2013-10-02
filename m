From: David Herrmann <dh.herrmann@gmail.com>
Date: Wed, 02 Oct 2013 14:58:38 +0000
Subject: [PATCH 1/2] simplefb: fix unmapping fb during destruction
Message-Id: <1380725919-1961-1-git-send-email-dh.herrmann@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alexandre Courbot <acourbot@nvidia.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Unfortunately, fbdev does not create its own "struct device" for
framebuffers. Instead, it attaches to the device of the parent layer. This
has the side-effect that devm_* managed resources are not cleaned up on
framebuffer-destruction but rather during destruction of the
parent-device. In case of fbdev this might be too late, though.
remove_conflicting_framebuffer() may remove fbdev devices but keep the
parent device as it is.

Therefore, we now use plain ioremap() and unmap the framebuffer in the
fb_destroy() callback. Note that we must not free the device here as this
might race with the parent-device removal. Instead, we rely on
unregister_framebuffer() as barrier and we're safe.

Reported-by: Tom Gundersen <teg@jklm.no>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
Hi

I know that simplefb was supposed to stay "as simple as possible" but I really
think this series is the last set of fixes I have. Unfortunately framebuffer DRM
handover is mandatory so we cannot ignore it in simplefb.

Both patches are not critical at all and are targeted at 3.13-rc1.

Thanks
David

 drivers/video/simplefb.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 8d78106..74b016c 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -66,8 +66,15 @@ static int simplefb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	return 0;
 }
 
+static void simplefb_destroy(struct fb_info *info)
+{
+	if (info->screen_base)
+		iounmap(info->screen_base);
+}
+
 static struct fb_ops simplefb_ops = {
 	.owner		= THIS_MODULE,
+	.fb_destroy	= simplefb_destroy,
 	.fb_setcolreg	= simplefb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
@@ -212,8 +219,8 @@ static int simplefb_probe(struct platform_device *pdev)
 
 	info->fbops = &simplefb_ops;
 	info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
-	info->screen_base = devm_ioremap(&pdev->dev, info->fix.smem_start,
-					 info->fix.smem_len);
+	info->screen_base = ioremap(info->fix.smem_start,
+				    info->fix.smem_len);
 	if (!info->screen_base) {
 		framebuffer_release(info);
 		return -ENODEV;
@@ -223,6 +230,7 @@ static int simplefb_probe(struct platform_device *pdev)
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
+		iounmap(info->screen_base);
 		framebuffer_release(info);
 		return ret;
 	}
-- 
1.8.4

