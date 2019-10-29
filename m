From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 29 Oct 2019 18:23:20 +0000
Subject: [PATCH] fbdev: potential information leak in do_fb_ioctl()
Message-Id: <20191029182320.GA17569@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andrea Righi <righi.andrea@gmail.com>
Cc: linux-fbdev@vger.kernel.org, security@kernel.org, Kees Cook <keescook@chromium.org>, kernel-janitors@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Julia Lawall <Julia.Lawall@lip6.fr>, Gerd Hoffmann <kraxel@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>

The "fix" struct has a 2 byte hole after ->ywrapstep and the
"fix = info->fix;" assignment doesn't necessarily clear it.  It depends
on the compiler.

Fixes: 1f5e31d7e55a ("fbmem: don't call copy_from/to_user() with mutex held")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I have 13 more similar places to patch...  I'm not totally sure I
understand all the issues involved.

 drivers/video/fbdev/core/fbmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 6f6fc785b545..b4ce6a28aed9 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1109,6 +1109,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			ret = -EFAULT;
 		break;
 	case FBIOGET_FSCREENINFO:
+		memset(&fix, 0, sizeof(fix));
 		lock_fb_info(info);
 		fix = info->fix;
 		if (info->flags & FBINFO_HIDE_SMEM_START)
-- 
2.20.1
