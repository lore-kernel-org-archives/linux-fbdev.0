From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 20 Dec 2018 16:31:57 +0000
Subject: Re: [PATCH v3] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <3de54c0d-3e9b-769f-5cc6-e69dbb399426@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181030154456epcas4p19e91c78daad3f1f48e8260601e5fdfec@epcas4p1.samsung.com>
 <20181030154419.2889-1-prarit@redhat.com>
In-Reply-To: <20181030154419.2889-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prarit Bhargava <prarit@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Thierry Reding <treding@nvidia.com>


[ added Petr & Sergey to Cc: ]

Hi,

On 10/30/2018 04:44 PM, Prarit Bhargava wrote:
> On text-based systems the 'quiet' boot option will show printk levels
> higher than CONSOLE_LOGLEVEL_QUIET.  The displaying of the Tux logo
> during boot can cause some consoles to lose display data and as a result
> confuse the end user.
> 
> Do not display the Tux logo on systems that are in 'quiet' boot.
> 
> v2: It helps to commit all my changes before sending them.  Remove extra
> bracket.
> v3: buildbot error fix: fbcon can be built as part of a module so export console_printk
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Marko Myllynen <myllynen@redhat.com>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/video/fbdev/core/fbcon.c | 13 ++++++++-----
>  kernel/printk/printk.c           |  1 +
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 8958ccc8b1ac..08e092eaf45c 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -649,11 +649,14 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
>  		kfree(save);
>  	}
>  
> +	if (logo_shown = FBCON_LOGO_DONTSHOW)
> +		return;
> +
>  	if (logo_lines > vc->vc_bottom) {
>  		logo_shown = FBCON_LOGO_CANSHOW;
>  		printk(KERN_INFO
>  		       "fbcon_init: disable boot-logo (boot-logo bigger than screen).\n");
> -	} else if (logo_shown != FBCON_LOGO_DONTSHOW) {
> +	} else {
>  		logo_shown = FBCON_LOGO_DRAW;
>  		vc->vc_top = logo_lines;
>  	}
> @@ -1051,7 +1054,7 @@ static void fbcon_init(struct vc_data *vc, int init)
>  	struct vc_data **default_mode = vc->vc_display_fg;
>  	struct vc_data *svc = *default_mode;
>  	struct display *t, *p = &fb_display[vc->vc_num];
> -	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
> +	int new_rows, new_cols, rows, cols, charcnt = 256;
>  	int cap, ret;
>  
>  	if (info_idx = -1 || info = NULL)
> @@ -1059,9 +1062,9 @@ static void fbcon_init(struct vc_data *vc, int init)
>  
>  	cap = info->flags;
>  
> -	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
> +	if (vc != svc || console_loglevel <= CONSOLE_LOGLEVEL_QUIET ||
>  	    (info->fix.type = FB_TYPE_TEXT))
> -		logo = 0;
> +		logo_shown = FBCON_LOGO_DONTSHOW;

"logo" variable removal is an unrelated change which actually
changes the code behavior ("logo_shown" will be now modified
also for "vc != svc" and "info->fix.type = FB_TYPE_TEXT" cases).

Please either drop it or explain in the patch description why
it is a safe thing to do.

>  	if (var_to_display(p, &info->var, info))
>  		return;
> @@ -1176,7 +1179,7 @@ static void fbcon_init(struct vc_data *vc, int init)
>  	} else
>  		vc_resize(vc, new_cols, new_rows);
>  
> -	if (logo)
> +	if (logo_shown != FBCON_LOGO_DONTSHOW)
>  		fbcon_prepare_logo(vc, info, cols, rows, new_cols, new_rows);
>  
>  	if (vc = svc && softback_buf)
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index b77150ad1965..391e390feac9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -66,6 +66,7 @@ int console_printk[4] = {
>  	CONSOLE_LOGLEVEL_MIN,		/* minimum_console_loglevel */
>  	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
>  };
> +EXPORT_SYMBOL(console_printk);

You need printk Maintainers Ack on it.

>  atomic_t ignore_console_lock_warning __read_mostly = ATOMIC_INIT(0);
>  EXPORT_SYMBOL(ignore_console_lock_warning);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
