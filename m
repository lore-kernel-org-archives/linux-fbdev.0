From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Add CONFIG_FB_PRE_INIT_FB option to VT and fbcon
Date: Thu, 23 Apr 2009 13:49:52 -0700
Message-ID: <20090423134952.5328923a.akpm@linux-foundation.org>
References: <1240348380-15674-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756275AbZDWUwM@vger.kernel.org>
In-Reply-To: <1240348380-15674-1-git-send-email-agust@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, agust@denx.de

On Tue, 21 Apr 2009 23:13:00 +0200
Anatolij Gustschin <agust@denx.de> wrote:

> On many embedded systems there is a requirement while
> booting to inherit display controller configuration and
> frame buffer contents from the state set by the bootloader
> (e.g. splash screen). Using frame buffer console later
> by some application should be possible too.
> 
> VT and fbcon code clears and also partially overwrites
> frame buffer content after registering FB driver.
> This patch adds CONFIG_FB_PRE_INIT_FB option to VT/fbcon
> to prevent overwriting the frame buffer content while
> initialization and later after blanking interval expired.
> 
> CONFIG_FB_PRE_INIT_FB option is used by MB862xx frame
> buffer driver currently.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  drivers/char/vt.c             |   10 ++++++++++
>  drivers/video/console/fbcon.c |    7 +++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/char/vt.c b/drivers/char/vt.c
> index 08151d4..dd357ff 100644
> --- a/drivers/char/vt.c
> +++ b/drivers/char/vt.c
> @@ -172,7 +172,11 @@ int do_poke_blanked_console;
>  int console_blanked;
>  
>  static int vesa_blank_mode; /* 0:none 1:suspendV 2:suspendH 3:powerdown */
> +#ifdef CONFIG_FB_PRE_INIT_FB
> +static int blankinterval;
> +#else
>  static int blankinterval = 10*60*HZ;
> +#endif
>  static int vesa_off_interval;

What does this change do?  Puts in a magic delay?  It looks like a
hack?  Please describe the operation here in some detail.  Once I
understand what it does, I expect I'll be asking if it can be done in
some more deterministic manner.

>  static DECLARE_WORK(console_work, console_callback);
> @@ -695,8 +699,10 @@ void redraw_screen(struct vc_data *vc, int is_switch)
>  			update_attr(vc);
>  			clear_buffer_attributes(vc);
>  		}
> +#ifndef CONFIG_FB_PRE_INIT_FB
>  		if (update && vc->vc_mode != KD_GRAPHICS)
>  			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
> +#endif
>  	}
>  	set_cursor(vc);
>  	if (is_switch) {
> @@ -777,7 +783,11 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
>  		return -ENOMEM;
>  	    }
>  	    vc->vc_kmalloced = 1;
> +#ifdef CONFIG_FB_PRE_INIT_FB
> +	    vc_init(vc, vc->vc_rows, vc->vc_cols, 0);
> +#else
>  	    vc_init(vc, vc->vc_rows, vc->vc_cols, 1);
> +#endif
>  	    vcs_make_sysfs(currcons);
>  	    atomic_notifier_call_chain(&vt_notifier_list, VT_ALLOCATE, &param);
>  	}
> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> index 471a9a6..40c0fa1 100644
> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -1057,6 +1057,9 @@ static void fbcon_init(struct vc_data *vc, int init)
>  	if (p->userfont)
>  		charcnt = FNTCHARCNT(p->fontdata);
>  
> +#ifdef CONFIG_FB_PRE_INIT_FB
> +	vc->vc_deccm = 0;
> +#endif
>  	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
>  	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
>  	if (charcnt == 256) {
> @@ -3038,7 +3041,11 @@ static int fbcon_fb_registered(struct fb_info *info)
>  		}
>  
>  		if (info_idx != -1)
> +#ifdef CONFIG_FB_PRE_INIT_FB
> +			ret = fbcon_takeover(0);
> +#else
>  			ret = fbcon_takeover(1);
> +#endif
>  	} else {
>  		for (i = first_fb_vc; i <= last_fb_vc; i++) {
>  			if (con2fb_map_boot[i] == idx)

I think this change is so small that it doesn't justify the addition of
a new Kconfig parameter.

We could do this via a new kernel boot option, and/or via a module
parameter to fbcon.

Or, if the MB862xx driver can get control early enough then perhaps
the driver can inform the core code that it wants the framebuffer
memory to be preserved.

Either way, adding yet-another-config-option is the most
user-unfriendly way of implementing this fix and should be a last
resort, please.
