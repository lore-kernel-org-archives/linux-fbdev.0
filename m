From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 13 Nov 2017 09:45:46 +0000
Subject: [PATCH] fbcon: Initialize ops->info early
Message-Id: <20171113094546.16593-1-thierry.reding@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Kees Cook <keescook@chromium.org>

From: Thierry Reding <treding@nvidia.com>

During console takeover, which happens for all DRM/KMS setups using the
fbdev helpers, fbcon_startup() is called before fbcon_init() and as a
result con2fb_acquire_newinfo() will not be called (info->fbcon_par was
set to non-NULL in fbcon_startup()) to assign ops->info.

This causes the cursor_timer_handler() to unreference a NULL pointer.

Avoid this by unconditionally assigning ops->info during fbcon_startup()
so that it will be available early, but keep the additional assignment
in con2fb_acquire_newinfo() to support console remapping at runtime.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/video/fbdev/core/fbcon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 3b4a96379128..929ca472c524 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -962,6 +962,7 @@ static const char *fbcon_startup(void)
 	ops->graphics = 1;
 	ops->cur_rotate = -1;
 	ops->cur_blink_jiffies = HZ / 5;
+	ops->info = info;
 	info->fbcon_par = ops;
 	if (initial_rotation != -1)
 		p->con_rotate = initial_rotation;
-- 
2.14.1

