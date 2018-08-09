From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 09 Aug 2018 11:42:15 +0000
Subject: [PATCH v2] fbcon: Do not takeover the console from atomic context
Message-Id: <20180809114215.22028-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Taking over the console involves allocating mem with GFP_KERNEL, talking
to drm drivers, etc. So this should not be done from an atomic context.

But the console-output trigger deferred console takeover may happen from an
atomic context, which leads to "BUG: sleeping function called from invalid
context" errors.

This commit fixes these errors by doing the deferred takeover from a
workqueue when the notifier runs from an atomic context.

Note this uses in_atomic, as checkpatch points out this should not be
done from driver code. But the console subsys is not really normal driver
code, specifically it plays some tricks where it disables some locking
when logging an oops, or when logging a lockdep bug when lockdep debugging
is turned on, so we need to make an exception here.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add a comment fbcon.c and the commit message about why we need to use
 in_atomic here, no functional changes
---
 drivers/video/fbdev/core/fbcon.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index ef8b2d0b7071..31f518f8dde7 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3592,7 +3592,20 @@ static int fbcon_init_device(void)
 }
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
+static void fbcon_register_existing_fbs(struct work_struct *work)
+{
+	int i;
+
+	console_lock();
+
+	for_each_registered_fb(i)
+		fbcon_fb_registered(registered_fb[i]);
+
+	console_unlock();
+}
+
 static struct notifier_block fbcon_output_nb;
+static DECLARE_WORK(fbcon_deferred_takeover_work, fbcon_register_existing_fbs);
 
 static int fbcon_output_notifier(struct notifier_block *nb,
 				 unsigned long action, void *data)
@@ -3607,8 +3620,20 @@ static int fbcon_output_notifier(struct notifier_block *nb,
 	deferred_takeover = false;
 	logo_shown = FBCON_LOGO_DONTSHOW;
 
-	for_each_registered_fb(i)
-		fbcon_fb_registered(registered_fb[i]);
+	/*
+	 * Normally all console output happens in a sleeping context, but
+	 * during oopses the kernel goes into a special mode where the
+	 * console code may not sleep. We check for this using in_atomic
+	 * as the note about in_atomic in preempt.h mentions, in_atomic
+	 * does not detect a spinlock being held when non-preemptible, so
+	 * we also check for irqs_disabled which covers this case.
+	 */
+	if (in_atomic() || irqs_disabled()) {
+		schedule_work(&fbcon_deferred_takeover_work);
+	} else {
+		for_each_registered_fb(i)
+			fbcon_fb_registered(registered_fb[i]);
+	}
 
 	return NOTIFY_OK;
 }
-- 
2.18.0

