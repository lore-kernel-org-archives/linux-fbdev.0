From: Jani Nikula <jani.nikula@intel.com>
Date: Tue, 03 Dec 2019 16:38:47 +0000
Subject: [PATCH v3 05/12] video: fbdev: make fbops member of struct fb_info a const pointer
Message-Id: <700c6b52c39c6e7babaa921f583eac354714d9fc.1575390740.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575390740.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org

Now that we no longer modify the fbops, or hold non-const pointers to
it, we can make it const. After this, we can start making the fbops
const all over the place.

Cc: linux-fbdev@vger.kernel.org
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index a6ad528990de..6557fabdea62 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -472,7 +472,7 @@ struct fb_info {
 	struct fb_deferred_io *fbdefio;
 #endif
 
-	struct fb_ops *fbops;
+	const struct fb_ops *fbops;
 	struct device *device;		/* This is the parent */
 	struct device *dev;		/* This is this fb device */
 	int class_flag;                    /* private sysfs flags */
-- 
2.20.1
