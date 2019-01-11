From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Fri, 11 Jan 2019 06:04:32 +0000
Subject: Re: [PATCH v4 1/2] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <20190111060432.GB5766@jagdpanzerIV>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181030154419.2889-1-prarit@redhat.com>
 <20190110190325.15241-1-prarit@redhat.com>
 <20190110190325.15241-2-prarit@redhat.com>
In-Reply-To: <20190110190325.15241-2-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prarit Bhargava <prarit@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Thierry Reding <treding@nvidia.com>

On (01/10/19 14:03), Prarit Bhargava wrote:
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -649,11 +649,14 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
>  		kfree(save);
>  	}
>  
> +	if (logo_shown = FBCON_LOGO_DONTSHOW)
> +		return;

+	if (console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
+		return;

Would this two-liner do the trick?

	-ss

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
> @@ -1059,9 +1062,11 @@ static void fbcon_init(struct vc_data *vc, int init)
>  
>  	cap = info->flags;
>  
> -	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
> -	    (info->fix.type = FB_TYPE_TEXT))
> +	if (vc != svc || console_loglevel <= CONSOLE_LOGLEVEL_QUIET ||
> +	    (info->fix.type = FB_TYPE_TEXT)) {
>  		logo = 0;
> +		logo_shown = FBCON_LOGO_DONTSHOW;
> +	}
>  
>  	if (var_to_display(p, &info->var, info))
>  		return;
> -- 
> 2.17.2
> 
