From: David Herrmann <dh.herrmann@googlemail.com>
Date: Sun, 12 Aug 2012 14:53:22 +0000
Subject: [PATCH 08/11] fblog: cache framebuffer BLANK and SUSPEND states
Message-Id: <1344783205-2384-9-git-send-email-dh.herrmann@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344783205-2384-1-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1344783205-2384-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, David Herrmann <dh.herrmann@googlemail.com>

We must cache these states so we will never draw to the framebuffer while
it is suspended or blanked.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/video/console/fblog.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/video/console/fblog.c b/drivers/video/console/fblog.c
index aed77dc..8bcd0ce 100644
--- a/drivers/video/console/fblog.c
+++ b/drivers/video/console/fblog.c
@@ -33,6 +33,8 @@
 enum fblog_flags {
 	FBLOG_KILLED,
 	FBLOG_OPEN,
+	FBLOG_SUSPENDED,
+	FBLOG_BLANKED,
 };
 
 struct fblog_fb {
@@ -264,6 +266,7 @@ static int fblog_event(struct notifier_block *self, unsigned long action,
 	struct fb_event *event = data;
 	struct fb_info *info = event->info;
 	struct fblog_fb *fb;
+	int *blank;
 
 	switch(action) {
 	case FB_EVENT_FB_REGISTERED:
@@ -291,6 +294,44 @@ static int fblog_event(struct notifier_block *self, unsigned long action,
 		if (fb)
 			fblog_close(fb, true);
 		break;
+	case FB_EVENT_SUSPEND:
+		/* This is called when the low-level display driver suspends the
+		 * video system. We should not access the video system while it
+		 * is suspended. This is called with the console lock held. */
+		mutex_lock(&fblog_registration_lock);
+		fb = fblog_fbs[info->node];
+		mutex_unlock(&fblog_registration_lock);
+
+		if (fb)
+			set_bit(FBLOG_SUSPENDED, &fb->flags);
+		break;
+	case FB_EVENT_RESUME:
+		/* This is called when the low-level display driver resumes
+		 * operating. It is called with the console lock held. */
+		mutex_lock(&fblog_registration_lock);
+		fb = fblog_fbs[info->node];
+		mutex_unlock(&fblog_registration_lock);
+
+		if (fb)
+			clear_bit(FBLOG_SUSPENDED, &fb->flags);
+		break;
+	case FB_EVENT_BLANK:
+		/* This gets called _after_ the framebuffer was successfully
+		 * blanked. The console-lock is always held while fb_blank is
+		 * called and during this callback. */
+		mutex_lock(&fblog_registration_lock);
+		fb = fblog_fbs[info->node];
+		mutex_unlock(&fblog_registration_lock);
+
+		if (!fb)
+			break;
+
+		blank = (int*)event->data;
+		if (*blank = FB_BLANK_UNBLANK)
+			clear_bit(FBLOG_BLANKED, &fb->flags);
+		else
+			set_bit(FBLOG_BLANKED, &fb->flags);
+		break;
 	}
 
 	return 0;
-- 
1.7.11.4

