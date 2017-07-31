From: David Lechner <david@lechnology.com>
Date: Mon, 31 Jul 2017 19:09:45 +0000
Subject: [PATCH v2 2/2] fbcon: add VT notifier for VT_UPDATE event
Message-Id: <1501528185-9976-3-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501528185-9976-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501528185-9976-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

This adds notifier callback for VT events. We are currently interested
in the VT_UPDATE event, which indicates there was some major change to
the VT. This is used to redraw the margins. For example when the console
is inverted we receive the VT_UPDATE event. The color of the margins depend
on the inverted state, so it is necessary redraw the margins at this time.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/video/console/fbcon.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 12ded23..8e7ac2f 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3329,6 +3329,28 @@ static int fbcon_event_notify(struct notifier_block *self,
 	return ret;
 }
 
+static int vt_notifier_call(struct notifier_block *blk,
+			    unsigned long code, void *_param)
+{
+	struct vt_notifier_param *param = _param;
+	struct vc_data *vc = param->vc;
+
+	switch (code) {
+	case VT_UPDATE:
+		/*
+		 * This event could indicate that the terminal has been
+		 * inverted (or there was some other major change), in which
+		 * case we need to re-draw the margins.
+		 */
+		if (con_is_visible(vc) && vc->vc_mode = KD_TEXT)
+			fbcon_clear_margins(vc, 0);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
 /*
  *  The console `switch' structure for the frame buffer based console
  */
@@ -3364,6 +3386,10 @@ static struct notifier_block fbcon_event_notifier = {
 	.notifier_call	= fbcon_event_notify,
 };
 
+static struct notifier_block vt_notifier_block = {
+	.notifier_call = vt_notifier_call,
+};
+
 static ssize_t store_rotate(struct device *device,
 			    struct device_attribute *attr, const char *buf,
 			    size_t count)
@@ -3612,6 +3638,7 @@ static int __init fb_console_init(void)
 
 	console_lock();
 	fb_register_client(&fbcon_event_notifier);
+	register_vt_notifier(&vt_notifier_block);
 	fbcon_device = device_create(fb_class, NULL, MKDEV(0, 0), NULL,
 				     "fbcon");
 
@@ -3650,6 +3677,7 @@ static void __exit fbcon_deinit_device(void)
 static void __exit fb_console_exit(void)
 {
 	console_lock();
+	unregister_vt_notifier(&vt_notifier_block);
 	fb_unregister_client(&fbcon_event_notifier);
 	fbcon_deinit_device();
 	device_destroy(fb_class, MKDEV(0, 0));
-- 
2.7.4

