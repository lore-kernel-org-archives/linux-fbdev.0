From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 29 Nov 2019 10:29:34 +0000
Subject: [PATCH v2 04/14] video: udlfb: don't restore fb_mmap after deferred IO cleanup
Message-Id: <0f12bb51a6f2a656571cd21230b7e9d5be320db4.1575022735.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, Bernie Thompson <bernie@plugable.com>

Deferred IO now preserves the fb_ops.

Cc: Bernie Thompson <bernie@plugable.com>
Cc: linux-fbdev@vger.kernel.org
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
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
