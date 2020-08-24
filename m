From: Alex Dewar <alex.dewar90@gmail.com>
Date: Mon, 24 Aug 2020 17:44:03 +0000
Subject: [PATCH] video: fbdev: replace spurious snprintf() with sprintf()
Message-Id: <20200824174407.429817-1-alex.dewar90@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alex Dewar <alex.dewar90@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

par->vgapass is a u8, so if we are assuming that buf is at least
PAGE_SIZE then the extra checking is pointless.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/video/fbdev/sstfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index afe6d1b7c3a0..c05cdabeb11c 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -733,7 +733,7 @@ static ssize_t show_vgapass(struct device *device, struct device_attribute *attr
 {
 	struct fb_info *info = dev_get_drvdata(device);
 	struct sstfb_par *par = info->par;
-	return snprintf(buf, PAGE_SIZE, "%d\n", par->vgapass);
+	return sprintf(buf, "%d\n", par->vgapass);
 }
 
 static struct device_attribute device_attrs[] = {
-- 
2.28.0
