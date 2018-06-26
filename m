From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Jun 2018 13:55:34 +0000
Subject: [PATCH v3 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <20180626135535.2990-3-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626135535.2990-1-hdegoede@redhat.com>
In-Reply-To: <20180626135535.2990-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Replace comments about places where the console lock should be held with
calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-New patch in v3 of this patchset
---
 drivers/video/fbdev/core/fbcon.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c910e74d46ff..ac2cbdf710ee 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -817,8 +817,6 @@ static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
  *
  *	Maps a virtual console @unit to a frame buffer device
  *	@newidx.
- *
- *	This should be called with the console lock held.
  */
 static int set_con2fb_map(int unit, int newidx, int user)
 {
@@ -828,6 +826,8 @@ static int set_con2fb_map(int unit, int newidx, int user)
 	struct fb_info *oldinfo = NULL;
  	int found, err = 0;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	if (oldidx = newidx)
 		return 0;
 
@@ -3039,11 +3039,12 @@ static inline int fbcon_unbind(void)
 }
 #endif /* CONFIG_VT_HW_CONSOLE_BINDING */
 
-/* called with console_lock held */
 static int fbcon_fb_unbind(int idx)
 {
 	int i, new_idx = -1, ret = 0;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	if (!fbcon_has_console_bind)
 		return 0;
 
@@ -3089,11 +3090,12 @@ static int fbcon_fb_unbind(int idx)
 	return ret;
 }
 
-/* called with console_lock held */
 static int fbcon_fb_unregistered(struct fb_info *info)
 {
 	int i, idx;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	idx = info->node;
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] = idx)
@@ -3127,10 +3129,12 @@ static int fbcon_fb_unregistered(struct fb_info *info)
 	return 0;
 }
 
-/* called with console_lock held */
 static void fbcon_remap_all(int idx)
 {
 	int i;
+
+	WARN_CONSOLE_UNLOCKED();
+
 	for (i = first_fb_vc; i <= last_fb_vc; i++)
 		set_con2fb_map(i, idx, 0);
 
@@ -3172,11 +3176,12 @@ static inline void fbcon_select_primary(struct fb_info *info)
 }
 #endif /* CONFIG_FRAMEBUFFER_DETECT_PRIMARY */
 
-/* called with console_lock held */
 static int fbcon_fb_registered(struct fb_info *info)
 {
 	int ret = 0, i, idx;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	idx = info->node;
 	fbcon_select_primary(info);
 
@@ -3325,7 +3330,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		ret = fbcon_fb_unregistered(info);
 		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
-		/* called with console lock held */
 		con2fb = event->data;
 		ret = set_con2fb_map(con2fb->console - 1,
 				     con2fb->framebuffer, 1);
-- 
2.17.1

