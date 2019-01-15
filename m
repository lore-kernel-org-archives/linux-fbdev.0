From: Petr Mladek <pmladek@suse.com>
Date: Tue, 15 Jan 2019 15:09:38 +0000
Subject: Re: [PATCH v4 1/2] fbcon: Silence fbcon logo on 'quiet' boots
Message-Id: <20190115150938.bycn3j3rleifpo2c@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181030154419.2889-1-prarit@redhat.com>
 <20190110190325.15241-1-prarit@redhat.com>
 <20190110190325.15241-2-prarit@redhat.com>
 <20190111060432.GB5766@jagdpanzerIV>
In-Reply-To: <20190111060432.GB5766@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Thierry Reding <treding@nvidia.com>

On Fri 2019-01-11 15:04:32, Sergey Senozhatsky wrote:
> On (01/10/19 14:03), Prarit Bhargava wrote:
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -649,11 +649,14 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
> >  		kfree(save);
> >  	}
> >  
> > +	if (logo_shown = FBCON_LOGO_DONTSHOW)
> > +		return;
> 
> +	if (console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
> +		return;
> 
> Would this two-liner do the trick?

But then the other functions, like fbcon_scroll() or fbcon_switch(),
would think that the logo was shown because logo_shown !FBCON_LOGO_DONTSHOW.

It might be possible to do logo_shown = FBCON_LOGO_DONTSHOW.
But I am not sure if it is safe, see below.

> 	-ss
> 
> > +
> >  	if (logo_lines > vc->vc_bottom) {
> >  		logo_shown = FBCON_LOGO_CANSHOW;
> >  		printk(KERN_INFO
> >  		       "fbcon_init: disable boot-logo (boot-logo bigger than screen).\n");
> > -	} else if (logo_shown != FBCON_LOGO_DONTSHOW) {
> > +	} else {
> >  		logo_shown = FBCON_LOGO_DRAW;
> >  		vc->vc_top = logo_lines;
> >  	}
> > @@ -1059,9 +1062,11 @@ static void fbcon_init(struct vc_data *vc, int init)
> >  
> >  	cap = info->flags;
> >  
> > -	if (vc != svc || logo_shown = FBCON_LOGO_DONTSHOW ||
> > -	    (info->fix.type = FB_TYPE_TEXT))
> > +	if (vc != svc || console_loglevel <= CONSOLE_LOGLEVEL_QUIET ||
> > +	    (info->fix.type = FB_TYPE_TEXT)) {
> >  		logo = 0;
> > +		logo_shown = FBCON_LOGO_DONTSHOW;

This has still the problem mentioned in the v3 feedback. It modifies
the global variable logo_shown even when vc != svc. You still need
check and explain why it is safe. It is not clear to me.

Best Regards,
Petr

> > +	}
> >  
> >  	if (var_to_display(p, &info->var, info))
> >  		return;
> > -- 
> > 2.17.2
> > 
