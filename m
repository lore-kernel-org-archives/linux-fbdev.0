From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 29 Nov 2019 10:29:33 +0000
Subject: [PATCH v2 03/14] video: smscufx: don't restore fb_mmap after deferred IO cleanup
Message-Id: <480dcc682481e6972e5648181d7e92120929ec6b.1575022735.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, Steve Glendinning <steve.glendinning@shawell.net>, intel-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>

Deferred IO now preserves the fb_ops.

Cc: Steve Glendinning <steve.glendinning@shawell.net>
Cc: linux-fbdev@vger.kernel.org
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/smscufx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 0e0f5bbfc5ef..e362d7da87fc 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1170,7 +1170,6 @@ static int ufx_ops_release(struct fb_info *info, int user)
 		fb_deferred_io_cleanup(info);
 		kfree(info->fbdefio);
 		info->fbdefio = NULL;
-		info->fbops->fb_mmap = ufx_ops_mmap;
 	}
 
 	pr_debug("released /dev/fb%d user=%d count=%d",
-- 
2.20.1
