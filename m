From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 02 Aug 2018 11:28:40 +0000
Subject: [PATCH fix for 4.19 2/3] fbcon: Only defer console takeover if the current console driver is the dum
Message-Id: <20180802112841.27679-3-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180802112841.27679-1-hdegoede@redhat.com>
In-Reply-To: <20180802112841.27679-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

We rely on dummycon's output notifier mechanism to defer the takeover.

If say vgacon is the current console driver then dummycon will never get
used so its output notifier will also never get called and fbcon never
takes over. This commit fixes this by only deferring the console takeover
if the current console driver is the dummycon driver.

This commit also moves the entirety of fbcon_start under the console_lock,
since the conswitchp which fbcon_start now checks is protected by it.

This commit also inlines fbcon_register_output_notifier, since we now
need a #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER in fbcon_start
anyways because of the write access to the deferred_takeover variable,
this has the added advantage that it puts the
dummycon_register_output_notifier() call directly after the "conswitchp !&dummy_con" comparison making it clear why that check is there.

Note the arch setup code will set conswitchp to either dummy_con or
vga_con, in the cases where it gets set to vga_con even though their is
no vga_con present we rely on vga_con_startup() to set conswitchp to
dummy_con. vga_con_startup() is guaranteed to happen before
fb_console_init() as it gets called as a console_initcall where as
fb_console_init() gets called as a subsys_initcall.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/fbdev/core/fbcon.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index e30d3a138c97..ef8b2d0b7071 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3612,36 +3612,32 @@ static int fbcon_output_notifier(struct notifier_block *nb,
 
 	return NOTIFY_OK;
 }
-
-static void fbcon_register_output_notifier(void)
-{
-	fbcon_output_nb.notifier_call = fbcon_output_notifier;
-	dummycon_register_output_notifier(&fbcon_output_nb);
-}
-#else
-static inline void fbcon_register_output_notifier(void) {}
 #endif
 
 static void fbcon_start(void)
 {
+	WARN_CONSOLE_UNLOCKED();
+
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
+	if (conswitchp != &dummy_con)
+		deferred_takeover = false;
+
 	if (deferred_takeover) {
-		fbcon_register_output_notifier();
+		fbcon_output_nb.notifier_call = fbcon_output_notifier;
+		dummycon_register_output_notifier(&fbcon_output_nb);
 		return;
 	}
+#endif
 
 	if (num_registered_fb) {
 		int i;
 
-		console_lock();
-
 		for_each_registered_fb(i) {
 			info_idx = i;
 			break;
 		}
 
 		do_fbcon_takeover(0);
-		console_unlock();
-
 	}
 }
 
@@ -3724,8 +3720,8 @@ void __init fb_console_init(void)
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
 		con2fb_map[i] = -1;
 
-	console_unlock();
 	fbcon_start();
+	console_unlock();
 }
 
 #ifdef MODULE
-- 
2.18.0

