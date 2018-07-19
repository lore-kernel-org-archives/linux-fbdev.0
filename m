From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 19 Jul 2018 10:16:01 +0000
Subject: [PATCH v3 2/2] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <20180719101601.25076-3-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180719101601.25076-1-tzimmermann@suse.de>
In-Reply-To: <20180719101601.25076-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rostedt@goodmis.org, pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, hdegoede@redhat.com, akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>

If the console is unlocked during registration, the console subsystem
generates significant amounts of warnings, which obfuscate actual
debugging messages. Setting ignore_console_lock_warning while debugging
console registration avoid the noise.

v3:
	- manipulate ignore_console_lock_warning with atomic_{inc,dec}
v2:
	- restore ignore_console_lock_warning if lock_fb_info() fails

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbmem.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 9e2f9d3c760e..cb72cd6c5892 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1691,17 +1691,22 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	event.info = fb_info;
 	if (!lockless_register_fb)
 		console_lock();
+	else
+		atomic_inc(&ignore_console_lock_warning);
 	if (!lock_fb_info(fb_info)) {
-		if (!lockless_register_fb)
-			console_unlock();
-		return -ENODEV;
+		ret = -ENODEV;
+		goto unlock_console;
 	}
+	ret = 0;
 
 	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
 	unlock_fb_info(fb_info);
+unlock_console:
 	if (!lockless_register_fb)
 		console_unlock();
-	return 0;
+	else
+		atomic_dec(&ignore_console_lock_warning);
+	return ret;
 }
 
 static int do_unregister_framebuffer(struct fb_info *fb_info)
-- 
2.18.0

