From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 30 Oct 2018 21:35:58 +0000
Subject: Re: [PATCH v3] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <0589D61E-26FF-4008-8311-E4838375D8FD@goodmis.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181030154419.2889-1-prarit@redhat.com>
In-Reply-To: <20181030154419.2889-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prarit Bhargava <prarit@redhat.com>, linux-fbdev@vger.kernel.org
Cc: Yisheng Xie <ysxie@foxmail.com>, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Thierry Reding <treding@nvidia.com>

I guess you we not very productive with that first patch ;-)

-- Steve


On October 30, 2018 5:44:19 PM GMT+02:00, Prarit Bhargava <prarit@redhat.com> wrote:
>On text-based systems the 'quiet' boot option will show printk levels
>higher than CONSOLE_LOGLEVEL_QUIET.  The displaying of the Tux logo
>during boot can cause some consoles to lose display data and as a
>result
>confuse the end user.
>
>Do not display the Tux logo on systems that are in 'quiet' boot.
>
>v2: It helps to commit all my changes before sending them.  Remove
>extra
>bracket.
>v3: buildbot error fix: fbcon can be built as part of a module so
>export console_printk
>
>Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>Cc: Hans de Goede <hdegoede@redhat.com>
>Cc: Marko Myllynen <myllynen@redhat.com>
>Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>Cc: Kees Cook <keescook@chromium.org>
>Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>Cc: Thierry Reding <treding@nvidia.com>
>Cc: Yisheng Xie <ysxie@foxmail.com>
>Cc: dri-devel@lists.freedesktop.org
>---
> drivers/video/fbdev/core/fbcon.c | 13 ++++++++-----
> kernel/printk/printk.c           |  1 +
> 2 files changed, 9 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/video/fbdev/core/fbcon.c
>b/drivers/video/fbdev/core/fbcon.c
>index 8958ccc8b1ac..08e092eaf45c 100644
>--- a/drivers/video/fbdev/core/fbcon.c
>+++ b/drivers/video/fbdev/core/fbcon.c
>@@ -649,11 +649,14 @@ static void fbcon_prepare_logo(struct vc_data
>*vc, struct fb_info *info,
> 		kfree(save);
> 	}
> 
>+	if (logo_shown = FBCON_LOGO_DONTSHOW)
>+		return;
>+
> 	if (logo_lines > vc->vc_bottom) {
> 		logo_shown = FBCON_LOGO_CANSHOW;
> 		printk(KERN_INFO
>		       "fbcon_init: disable boot-logo (boot-logo bigger than
>screen).\n");
>-	} else if (logo_shown != FBCON_LOGO_DONTSHOW) {
>+	} else {
> 		logo_shown = FBCON_LOGO_DRAW;
> 		vc->vc_top = logo_lines;
> 	}
>@@ -1051,7 +1054,7 @@ static void fbcon_init(struct vc_data *vc, int
>init)
> 	struct vc_data **default_mode = vc->vc_display_fg;
> 	struct vc_data *svc = *default_mode;
> 	struct display *t, *p = &fb_display[vc->vc_num];
>-	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
>+	int new_rows, new_cols, rows, cols, charcnt = 256;
> 	int cap, ret;
> 
> 	if (info_idx = -1 || info = NULL)
>@@ -1059,9 +1062,9 @@ static void fbcon_init(struct vc_data *vc, int
>init)
> 
> 	cap = info->flags;
> 
>-	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
>+	if (vc != svc || console_loglevel <= CONSOLE_LOGLEVEL_QUIET ||
> 	    (info->fix.type = FB_TYPE_TEXT))
>-		logo = 0;
>+		logo_shown = FBCON_LOGO_DONTSHOW;
> 
> 	if (var_to_display(p, &info->var, info))
> 		return;
>@@ -1176,7 +1179,7 @@ static void fbcon_init(struct vc_data *vc, int
>init)
> 	} else
> 		vc_resize(vc, new_cols, new_rows);
> 
>-	if (logo)
>+	if (logo_shown != FBCON_LOGO_DONTSHOW)
> 		fbcon_prepare_logo(vc, info, cols, rows, new_cols, new_rows);
> 
> 	if (vc = svc && softback_buf)
>diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>index b77150ad1965..391e390feac9 100644
>--- a/kernel/printk/printk.c
>+++ b/kernel/printk/printk.c
>@@ -66,6 +66,7 @@ int console_printk[4] = {
> 	CONSOLE_LOGLEVEL_MIN,		/* minimum_console_loglevel */
> 	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
> };
>+EXPORT_SYMBOL(console_printk);
> 
> atomic_t ignore_console_lock_warning __read_mostly = ATOMIC_INIT(0);
> EXPORT_SYMBOL(ignore_console_lock_warning);

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
