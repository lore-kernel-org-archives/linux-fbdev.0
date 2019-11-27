From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 27 Nov 2019 16:32:03 +0000
Subject: [PATCH 07/13] video: omapfb: use const pointer for fb_ops
Message-Id: <609dbe6eefdfd0138aa5d2d4ceeb58684811dc6e.1574871797.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <cover.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org, linux-omap@vger.kernel.org

Use const for fb_ops to let us make the info->fbops pointer const in the
future.

Cc: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 702cca59bda1..e8a304f84ea8 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1052,7 +1052,7 @@ static int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd,
 {
 	struct omapfb_plane_struct *plane = fbi->par;
 	struct omapfb_device	*fbdev = plane->fbdev;
-	struct fb_ops		*ops = fbi->fbops;
+	const struct fb_ops *ops = fbi->fbops;
 	union {
 		struct omapfb_update_window	update_window;
 		struct omapfb_plane_info	plane_info;
-- 
2.20.1
