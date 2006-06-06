From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/7] Detaching fbcon: Clean up exit code
Date: Tue, 06 Jun 2006 19:08:55 +0800
Message-ID: <44856247.8090405@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751235AbWFFLLJ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

To detach fbcon, it must also clean up all resources it allocated. This was
never done before because fbcon cannot be unloaded. 

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |   43 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 014afea..a8de822 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3112,6 +3112,49 @@ static void __exit fbcon_deinit_class_de
 
 static void __exit fbcon_exit(void)
 {
+	struct fb_info *info;
+	int i, j, mapped;
+
+	for (i = 0; i < FB_MAX; i++) {
+		info = registered_fb[i];
+
+		if (info && info->fbcon_par)
+			fbcon_del_cursor_timer(info);
+	}
+
+#ifdef CONFIG_ATARI
+	free_irq(IRQ_AUTO_4, fbcon_vbl_handler);
+#endif
+#ifdef CONFIG_MAC
+	if (MACH_IS_MAC && vbl_detected)
+		free_irq(IRQ_MAC_VBL, fbcon_vbl_handler);
+#endif
+
+	kfree((void *)softback_buf);
+
+	for (i = 0; i < FB_MAX; i++) {
+		mapped = 0;
+		info = registered_fb[i];
+
+		if (info == NULL)
+			continue;
+
+		for (j = 0; j < MAX_NR_CONSOLES; j++) {
+			if (con2fb_map[j] == i) {
+				con2fb_map[j] = -1;
+				mapped = 1;
+			}
+		}
+
+		if (mapped) {
+			if (info->fbops->fb_release)
+				info->fbops->fb_release(info, 0);
+			module_put(info->fbops->owner);
+			kfree(info->fbcon_par);
+			info->fbcon_par = NULL;
+		}
+	}
+
 	fbcon_deinit_class_device();
 	class_device_destroy(fb_class, MKDEV(FB_MAJOR, FB_MAX));
 }
