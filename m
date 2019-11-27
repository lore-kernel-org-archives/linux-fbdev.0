From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 27 Nov 2019 16:32:02 +0000
Subject: [PATCH 06/13] video: fbmem: use const pointer for fb_ops
Message-Id: <7550581b21a54500021d9a1b2b9b91ba075d19d1.1574871797.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <cover.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org

Use const for fb_ops to let us make the info->fbops pointer const in the
future.

Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/core/fbmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 86b06a599f96..003f494ccaba 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1079,7 +1079,7 @@ EXPORT_SYMBOL(fb_blank);
 static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			unsigned long arg)
 {
-	struct fb_ops *fb;
+	const struct fb_ops *fb;
 	struct fb_var_screeninfo var;
 	struct fb_fix_screeninfo fix;
 	struct fb_cmap cmap_from;
@@ -1292,7 +1292,7 @@ static long fb_compat_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
 	struct fb_info *info = file_fb_info(file);
-	struct fb_ops *fb;
+	const struct fb_ops *fb;
 	long ret = -ENOIOCTLCMD;
 
 	if (!info)
@@ -1332,7 +1332,7 @@ static int
 fb_mmap(struct file *file, struct vm_area_struct * vma)
 {
 	struct fb_info *info = file_fb_info(file);
-	struct fb_ops *fb;
+	const struct fb_ops *fb;
 	unsigned long mmio_pgoff;
 	unsigned long start;
 	u32 len;
-- 
2.20.1
