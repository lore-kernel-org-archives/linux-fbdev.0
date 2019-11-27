From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 27 Nov 2019 16:32:04 +0000
Subject: [PATCH 08/13] video: fbdev: make fbops member of struct fb_info a const pointer
Message-Id: <b0ff7235e8c941d6b9fcc28d5e49ceeb92d56828.1574871797.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <cover.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org

Now that we no longer modify the fbops, or hold non-const pointers to
it, we can make it const. With that, also deferred_io_private needs to
be const. After this, we can start making the fbops const all over the
place.

Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/fb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 65f2abd47745..efc5376c243a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -470,10 +470,10 @@ struct fb_info {
 #ifdef CONFIG_FB_DEFERRED_IO
 	struct delayed_work deferred_work;
 	struct fb_deferred_io *fbdefio;
-	void *deferred_io_private;
+	const void *deferred_io_private;
 #endif
 
-	struct fb_ops *fbops;
+	const struct fb_ops *fbops;
 	struct device *device;		/* This is the parent */
 	struct device *dev;		/* This is this fb device */
 	int class_flag;                    /* private sysfs flags */
-- 
2.20.1
