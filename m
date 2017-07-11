From: Rob Clark <robdclark@gmail.com>
Date: Tue, 11 Jul 2017 13:38:21 +0000
Subject: [PATCH 2/3] fbdev: fbmem: export get/put_fb_info()
Message-Id: <20170711133822.31978-3-robdclark@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170711133822.31978-1-robdclark@gmail.com>
In-Reply-To: <20170711133822.31978-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Archit Taneja <architt@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Clark <robdclark@gmail.com>

Needed for following patch.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/video/fbdev/core/fbmem.c | 6 ++++--
 include/linux/fb.h               | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 5324358f110f..db88c7bf3afe 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -50,7 +50,7 @@ EXPORT_SYMBOL(registered_fb);
 int num_registered_fb __read_mostly;
 EXPORT_SYMBOL(num_registered_fb);
 
-static struct fb_info *get_fb_info(unsigned int idx)
+struct fb_info *get_fb_info(unsigned int idx)
 {
 	struct fb_info *fb_info;
 
@@ -65,14 +65,16 @@ static struct fb_info *get_fb_info(unsigned int idx)
 
 	return fb_info;
 }
+EXPORT_SYMBOL(get_fb_info);
 
-static void put_fb_info(struct fb_info *fb_info)
+void put_fb_info(struct fb_info *fb_info)
 {
 	if (!atomic_dec_and_test(&fb_info->count))
 		return;
 	if (fb_info->fbops->fb_destroy)
 		fb_info->fbops->fb_destroy(fb_info);
 }
+EXPORT_SYMBOL(put_fb_info);
 
 int lock_fb_info(struct fb_info *info)
 {
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a964d076b4dc..eccae50db5ed 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -650,6 +650,8 @@ extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 extern struct class *fb_class;
 
+extern struct fb_info *get_fb_info(unsigned int idx);
+extern void put_fb_info(struct fb_info *fb_info);
 extern int lock_fb_info(struct fb_info *info);
 
 static inline void unlock_fb_info(struct fb_info *info)
-- 
2.13.0

