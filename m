From: Fabio Erculiani <lxnay@sabayon.org>
Date: Tue, 24 May 2011 19:54:31 +0000
Subject: [PATCH] fbmem: fix race condition between register_framebuffer() and fb_open()
Message-Id: <1306266871-12464-1-git-send-email-lxnay@sabayon.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: lethal@linux-sh.org, linux-kernel@vger.kernel.org, Fabio Erculiani <lxnay@sabayon.org>

register_framebuffer() acquires registration_lock, then calls
do_register_framebuffer() which calls fb_notifier_call_chain()
which calls fb_open() which calls get_fb_info() which tries
(at last) to acquire registration_lock again.
This is a workaround.

Signed-off-by: Fabio Erculiani <lxnay@sabayon.org>
---
 drivers/video/fbmem.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 5aac00e..b9831a0 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1628,6 +1628,11 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	event.info = fb_info;
 	if (!lock_fb_info(fb_info))
 		return -ENODEV;
+
+	/* FIXME: unlock registration mutex before registration
+	 * notification is sent, in order to avoid deadlock.
+	 */
+	mutex_unlock(&registration_lock);
 	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
 	unlock_fb_info(fb_info);
 	return 0;
@@ -1692,7 +1697,13 @@ register_framebuffer(struct fb_info *fb_info)
 
 	mutex_lock(&registration_lock);
 	ret = do_register_framebuffer(fb_info);
-	mutex_unlock(&registration_lock);
+	if (ret != 0)
+		/*
+		 * FIXME: mutex is unlocked only if ret = 0.
+		 * This is the second part of the workaround
+		 * that prevents deadlocking.
+		 */
+		mutex_unlock(&registration_lock);
 
 	return ret;
 }
-- 
1.7.5.rc1

