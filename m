From: Prarit Bhargava <prarit@redhat.com>
Date: Tue, 29 Jan 2019 13:43:50 +0000
Subject: [PATCH v5 2/2] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <20190129134350.24049-3-prarit@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190129134350.24049-1-prarit@redhat.com>
In-Reply-To: <20190129134350.24049-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Thierry Reding <treding@nvidia.com>

On text-based systems the 'quiet' boot option will show printk levels
higher than CONSOLE_LOGLEVEL_QUIET.  The displaying of the Tux logo
during boot can cause some consoles to lose display data and as a result
confuse the end user.

Do not display the Tux logo on systems that are in 'quiet' boot.

v2: It helps to commit all my changes before sending them.  Remove extra
bracket.
v3: buildbot error fix: fbcon can be built as part of a module so export console_printk
v4: move console_printk change to separate patch, and drop logo cleanup
v5: Only set FBCON_LOGO_DONTSHOW for console loglevel

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Marko Myllynen <myllynen@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/core/fbcon.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index bfa1360ec750..59b626356983 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -656,11 +656,14 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
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
@@ -1066,6 +1069,9 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	cap = info->flags;
 
+	if (console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
+		logo_shown = FBCON_LOGO_DONTSHOW;
+
 	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
 	    (info->fix.type = FB_TYPE_TEXT))
 		logo = 0;
-- 
2.17.2
