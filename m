From: Prarit Bhargava <prarit@redhat.com>
Date: Mon, 29 Oct 2018 13:02:32 +0000
Subject: [PATCH] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <20181029130232.31661-1-prarit@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Thierry Reding <treding@nvidia.com>

A variant of this patch has been in Fedora since at least 2010 and
AFAWCT there haven't been any complaints about the change in behavior.

https://src.fedoraproject.org/cgit/rpms/kernel.git/tree/silence-fbcon-logo.patch

P.

---8<---

On text-based systems the 'quiet' boot option will show printk levels
higher than CONSOLE_LOGLEVEL_QUIET.  The displaying of the Tux logo
during boot can cause some consoles to lose display data and as a result
confuse the end user.

Do not display the Tux logo on systems that are in 'quiet' boot.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Marko Myllynen <myllynen@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/video/fbdev/core/fbcon.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 75ebbbf0a1fb..a2f2c7ea11ef 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -650,11 +650,14 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 		kfree(save);
 	}
 
+	if (logo_shown = FBCON_LOGO_DONTSHOW) {
+		return;
+
 	if (logo_lines > vc->vc_bottom) {
 		logo_shown = FBCON_LOGO_CANSHOW;
 		printk(KERN_INFO
 		       "fbcon_init: disable boot-logo (boot-logo bigger than screen).\n");
-	} else if (logo_shown != FBCON_LOGO_DONTSHOW) {
+	} else {
 		logo_shown = FBCON_LOGO_DRAW;
 		vc->vc_top = logo_lines;
 	}
@@ -1052,7 +1055,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct vc_data *svc = *default_mode;
 	struct display *t, *p = &fb_display[vc->vc_num];
-	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
+	int new_rows, new_cols, rows, cols, charcnt = 256;
 	int cap, ret;
 
 	if (info_idx = -1 || info = NULL)
@@ -1060,9 +1063,9 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	cap = info->flags;
 
-	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
+	if (vc != svc || console_loglevel <= CONSOLE_LOGLEVEL_QUIET ||
 	    (info->fix.type = FB_TYPE_TEXT))
-		logo = 0;
+		logo_shown = FBCON_LOGO_DONTSHOW;
 
 	if (var_to_display(p, &info->var, info))
 		return;
@@ -1178,7 +1181,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 	} else
 		vc_resize(vc, new_cols, new_rows);
 
-	if (logo)
+	if (logo_shown != FBCON_LOGO_DONTSHOW)
 		fbcon_prepare_logo(vc, info, cols, rows, new_cols, new_rows);
 
 	if (vc = svc && softback_buf)
-- 
2.14.5
