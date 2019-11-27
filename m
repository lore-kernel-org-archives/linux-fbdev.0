From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 27 Nov 2019 16:32:00 +0000
Subject: [PATCH 04/13] video: udlfb: don't restore fb_mmap after deferred IO cleanup
Message-Id: <21cc1f07daffeddf4d59f2b444796c0216274c87.1574871797.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <cover.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org, Bernie Thompson <bernie@plugable.com>

Deferred IO now preserves the fb_ops.

Cc: Bernie Thompson <bernie@plugable.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/udlfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index fe373b63ddd6..07905d385949 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1037,7 +1037,6 @@ static int dlfb_ops_release(struct fb_info *info, int user)
 		fb_deferred_io_cleanup(info);
 		kfree(info->fbdefio);
 		info->fbdefio = NULL;
-		info->fbops->fb_mmap = dlfb_ops_mmap;
 	}
 
 	dev_dbg(info->dev, "release, user=%d count=%d\n", user, dlfb->fb_count);
-- 
2.20.1
