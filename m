From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Jun 2018 18:36:11 +0000
Subject: [PATCH v3 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <20180626183612.321-3-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626183612.321-1-hdegoede@redhat.com>
In-Reply-To: <20180626183612.321-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Replace comments about places where the console lock should be held with
calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-New patch in v3 of this patchset

Changes in v4:
-Keep the comments about which fbcon functions need locks in place
---
 drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c910e74d46ff..cd8d52a967aa 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx, int user)
 	struct fb_info *oldinfo = NULL;
  	int found, err = 0;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	if (oldidx = newidx)
 		return 0;
 
@@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
 {
 	int i, new_idx = -1, ret = 0;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	if (!fbcon_has_console_bind)
 		return 0;
 
@@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct fb_info *info)
 {
 	int i, idx;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	idx = info->node;
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] = idx)
@@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
 static void fbcon_remap_all(int idx)
 {
 	int i;
+
+	WARN_CONSOLE_UNLOCKED();
+
 	for (i = first_fb_vc; i <= last_fb_vc; i++)
 		set_con2fb_map(i, idx, 0);
 
@@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct fb_info *info)
 {
 	int ret = 0, i, idx;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	idx = info->node;
 	fbcon_select_primary(info);
 
-- 
2.17.1

