From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 29 Nov 2019 10:29:36 +0000
Subject: [PATCH v2 06/14] video: fbmem: use const pointer for fb_ops
Message-Id: <3a27f95b424a67b3542b5906c660741daf1d4ea6.1575022735.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org

Use const for fb_ops to let us make the info->fbops pointer const in the
future.

v2: rebase

Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/core/fbmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 990550930a8e..7ddeb90337bc 100644
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
-- 
2.20.1
