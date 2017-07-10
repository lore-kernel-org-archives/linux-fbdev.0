From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Mon, 10 Jul 2017 14:48:55 +0000
Subject: [PATCH] fbdev: make get_fb_unmapped_area depends of !MMU
Message-Id: <1499698135-24526-1-git-send-email-benjamin.gaignard@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, noralf@tronnes.org, dri-devel@lists.freedesktop.org, emil.l.velikov@gmail.com, yannick.fertre@st.com
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Even if CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA flag is selected
do not compile and use get_fb_unmapped_area() if CONFIG_MMU is
also set. This will avoid mmap errors when compiling multi
architectures at same time.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/video/fbdev/core/fbmem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 069fe79..16b5aef 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1492,7 +1492,7 @@ static long fb_compat_ioctl(struct file *file, unsigned int cmd,
 	return 0;
 }
 
-#ifdef CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA
+#if defined(CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA) && !defined(CONFIG_MMU)
 unsigned long get_fb_unmapped_area(struct file *filp,
 				   unsigned long addr, unsigned long len,
 				   unsigned long pgoff, unsigned long flags)
@@ -1519,7 +1519,8 @@ unsigned long get_fb_unmapped_area(struct file *filp,
 	.open =		fb_open,
 	.release =	fb_release,
 #if defined(HAVE_ARCH_FB_UNMAPPED_AREA) || \
-    defined(CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA)
+	(defined(CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA) && \\
+	 !defined(CONFIG_MMU))
 	.get_unmapped_area = get_fb_unmapped_area,
 #endif
 #ifdef CONFIG_FB_DEFERRED_IO
-- 
1.9.1

