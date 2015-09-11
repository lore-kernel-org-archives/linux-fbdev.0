From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 11 Sep 2015 16:10:43 +0000
Subject: [PATCH] fbdev: put module after running driver callback
Message-Id: <1441987843-4313-1-git-send-email-dh.herrmann@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, dri-devel@lists.freedesktop.org

Currently, for each open() on an fbdev device, we pin the underlying
fbdev device and driver module. On close(), we release both. This
guarantees that the fbdev object stays around until the last FD is
released (even though it might be unregistered already).

However, currently we call module_put() *before* calling put_fb_info().
This has the side-effect that the driver module might be unloaded before
put_fb_info() calls into fbinfo->fbops->fb_destroy().

Fix this by keeping the module pinned until after we release our fbdev
reference. Note that register_framebuffer() and unregister_framebuffer()
are special as we require the driver to unregister device before
unloading. Hence, they don't need to pin the module. However, all open
handlers *have to*.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/video/fbdev/core/fbmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0705d88..4e78731 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1482,13 +1482,16 @@ __acquires(&info->lock)
 __releases(&info->lock)
 {
 	struct fb_info * const info = file->private_data;
+	struct module *owner;
 
 	mutex_lock(&info->lock);
 	if (info->fbops->fb_release)
 		info->fbops->fb_release(info,1);
-	module_put(info->fbops->owner);
+	owner = info->fbops->owner;
 	mutex_unlock(&info->lock);
+
 	put_fb_info(info);
+	module_put(owner);
 	return 0;
 }
 
-- 
2.5.1

