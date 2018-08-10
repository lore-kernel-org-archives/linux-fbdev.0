From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 10 Aug 2018 11:27:57 +0000
Subject: [PATCH v3] fbcon: Do not takeover the console from atomic context
Message-Id: <20180810112757.3936-1-hdegoede@redhat.com>
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
workqueue.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add a comment fbcon.c and the commit message about why we need to use
 in_atomic here, no functional changes

Changes in v3:
-It is not possible to reliable detect if we're running in an atomic
 context, simply always do the takeover from a worker
---
 drivers/video/fbdev/core/fbcon.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index ef8b2d0b7071..5581dec102aa 100644
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
@@ -3607,8 +3620,8 @@ static int fbcon_output_notifier(struct notifier_block *nb,
 	deferred_takeover = false;
 	logo_shown = FBCON_LOGO_DONTSHOW;
 
-	for_each_registered_fb(i)
-		fbcon_fb_registered(registered_fb[i]);
+	/* We may get called in atomic context */
+	schedule_work(&fbcon_deferred_takeover_work);
 
 	return NOTIFY_OK;
 }
-- 
2.18.0
