From: Prarit Bhargava <prarit@redhat.com>
Date: Thu, 10 Jan 2019 19:03:24 +0000
Subject: [PATCH v4 1/2] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <20190110190325.15241-2-prarit@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181030154419.2889-1-prarit@redhat.com>
 <20190110190325.15241-1-prarit@redhat.com>
In-Reply-To: <20190110190325.15241-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Thierry Reding <treding@nvidia.com>

On text-based systems the 'quiet' boot option will show printk levels
higher than CONSOLE_LOGLEVEL_QUIET.  The displaying of the Tux logo
during boot can cause some consoles to lose display data and as a result
confuse the end user.

Do not display the Tux logo on systems that are in 'quiet' boot.

v2: It helps to commit all my changes before sending them.  Remove extra
bracket.
v3: buildbot error fix: fbcon can be built as part of a module so export console_printk
v4: move console_printk change to separate patch, and drop logo cleanup

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Marko Myllynen <myllynen@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/core/fbcon.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8976190b6c1f..66e37bdff1d9 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -649,11 +649,14 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 		kfree(save);
 	}
 
+	if (logo_shown = FBCON_LOGO_DONTSHOW)
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
@@ -1059,9 +1062,11 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	cap = info->flags;
 
-	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
-	    (info->fix.type = FB_TYPE_TEXT))
+	if (vc != svc || console_loglevel <= CONSOLE_LOGLEVEL_QUIET ||
+	    (info->fix.type = FB_TYPE_TEXT)) {
 		logo = 0;
+		logo_shown = FBCON_LOGO_DONTSHOW;
+	}
 
 	if (var_to_display(p, &info->var, info))
 		return;
-- 
2.17.2
