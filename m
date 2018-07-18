From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 18 Jul 2018 08:36:33 +0000
Subject: [PATCH 1/1] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <20180718083633.24182-2-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718083633.24182-1-tzimmermann@suse.de>
In-Reply-To: <20180718083633.24182-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rostedt@goodmis.org, pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, hdegoede@redhat.com, akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>

If the console is unlocked during registration, the console subsystem
generates significant amounts of warnings, which obfuscate actual
debugging messages. Setting ignore_console_lock_warning while debugging
console registration avoid the noise.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 9e2f9d3c760e..79b489ad603d 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1627,6 +1627,7 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	int i, ret;
 	struct fb_event event;
 	struct fb_videomode mode;
+	bool saved_ignore_console_lock_warning = ignore_console_lock_warning;
 
 	if (fb_check_foreignness(fb_info))
 		return -ENOSYS;
@@ -1691,6 +1692,8 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	event.info = fb_info;
 	if (!lockless_register_fb)
 		console_lock();
+	else
+		ignore_console_lock_warning = true;
 	if (!lock_fb_info(fb_info)) {
 		if (!lockless_register_fb)
 			console_unlock();
@@ -1701,6 +1704,9 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	unlock_fb_info(fb_info);
 	if (!lockless_register_fb)
 		console_unlock();
+	else
+		ignore_console_lock_warning +			saved_ignore_console_lock_warning;
 	return 0;
 }
 
-- 
2.18.0

