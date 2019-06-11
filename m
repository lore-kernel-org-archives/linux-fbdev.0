From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 11 Jun 2019 14:11:00 +0000
Subject: Re: [PATCH 28/33] fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls
Message-Id: <20190611141100.wdcnzvsxobvh5jxr@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
 <20190528090304.9388-29-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-29-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lee Jones <lee.jones@linaro.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Yisheng Xie <ysxie@foxmail.com>, Hans de Goede <hdegoede@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Jingoo Han <jingoohan1@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>

On Tue, May 28, 2019 at 11:02:59AM +0200, Daniel Vetter wrote:
> Create a new wrapper function for this, feels like there's some
> refactoring room here between the two modes.
> 
> v2: backlight notifier is also interested in the mode change event,
> it calls lcd->set_mode, of which there are 3 implementations. Thanks
> to Maarten for spotting this. So we keep that. We can ditch the differentiation
> between mode change and all mode changes (because backlight notifier
> doesn't care), and we can drop the FBINFO_MISC_USEREVENT stuff too,
> because that's just to prevent recursion between fbmem.c and fbcon.c.
> 
> While at it flatten the control flow a bit.
> 
> v3: Need to add a static inline to the dummy function.
> 
> v4: Add missing #include <fbcon.h> to sh_mob (Sam).
> 
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Yisheng Xie <ysxie@foxmail.com>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: linux-fbdev@vger.kernel.org

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/lcd.c          |  1 -
>  drivers/video/fbdev/core/fbcon.c       | 15 +++++++++------
>  drivers/video/fbdev/core/fbmem.c       | 21 ++++++++++-----------
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 12 ++----------
>  include/linux/fb.h                     |  2 --
>  include/linux/fbcon.h                  |  2 ++
>  6 files changed, 23 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
> index 151b18776add..ecdda06989d0 100644
> --- a/drivers/video/backlight/lcd.c
> +++ b/drivers/video/backlight/lcd.c
> @@ -34,7 +34,6 @@ static int fb_notifier_callback(struct notifier_block *self,
>  	switch (event) {
>  	case FB_EVENT_BLANK:
>  	case FB_EVENT_MODE_CHANGE:
> -	case FB_EVENT_MODE_CHANGE_ALL:
>  	case FB_EARLY_EVENT_BLANK:
>  	case FB_R_EARLY_EVENT_BLANK:
>  		break;
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index b5ee89f16d6c..e98551f96138 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -3009,6 +3009,15 @@ static void fbcon_set_all_vcs(struct fb_info *info)
>  		fbcon_modechanged(info);
>  }
>  
> +
> +void fbcon_update_vcs(struct fb_info *info, bool all)
> +{
> +	if (all)
> +		fbcon_set_all_vcs(info);
> +	else
> +		fbcon_modechanged(info);
> +}
> +
>  int fbcon_mode_deleted(struct fb_info *info,
>  		       struct fb_videomode *mode)
>  {
> @@ -3318,12 +3327,6 @@ static int fbcon_event_notify(struct notifier_block *self,
>  	int idx, ret = 0;
>  
>  	switch(action) {
> -	case FB_EVENT_MODE_CHANGE:
> -		fbcon_modechanged(info);
> -		break;
> -	case FB_EVENT_MODE_CHANGE_ALL:
> -		fbcon_set_all_vcs(info);
> -		break;
>  	case FB_EVENT_SET_CONSOLE_MAP:
>  		/* called with console lock held */
>  		con2fb = event->data;
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 96805fe85332..dd1a708df1a7 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -957,6 +957,7 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>  	u32 activate;
>  	struct fb_var_screeninfo old_var;
>  	struct fb_videomode mode;
> +	struct fb_event event;
>  
>  	if (var->activate & FB_ACTIVATE_INV_MODE) {
>  		struct fb_videomode mode1, mode2;
> @@ -1039,19 +1040,17 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>  	    !list_empty(&info->modelist))
>  		ret = fb_add_videomode(&mode, &info->modelist);
>  
> -	if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
> -		struct fb_event event;
> -		int evnt = (activate & FB_ACTIVATE_ALL) ?
> -			FB_EVENT_MODE_CHANGE_ALL :
> -			FB_EVENT_MODE_CHANGE;
> +	if (ret)
> +		return ret;
>  
> -		info->flags &= ~FBINFO_MISC_USEREVENT;
> -		event.info = info;
> -		event.data = &mode;
> -		fb_notifier_call_chain(evnt, &event);
> -	}
> +	event.info = info;
> +	event.data = &mode;
> +	fb_notifier_call_chain(FB_EVENT_MODE_CHANGE, &event);
>  
> -	return ret;
> +	if (flags & FBINFO_MISC_USEREVENT)
> +		fbcon_update_vcs(info, activate & FB_ACTIVATE_ALL);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(fb_set_var);
>  
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index 015a02a29d37..b8454424910d 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -15,6 +15,7 @@
>  #include <linux/ctype.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/delay.h>
> +#include <linux/fbcon.h>
>  #include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -1757,8 +1758,6 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
>  	struct sh_mobile_lcdc_chan *ch = info->par;
>  	struct fb_var_screeninfo var;
>  	struct fb_videomode mode;
> -	struct fb_event event;
> -	int evnt = FB_EVENT_MODE_CHANGE_ALL;
>  
>  	if (ch->use_count > 1 || (ch->use_count = 1 && !info->fbcon_par))
>  		/* More framebuffer users are active */
> @@ -1780,14 +1779,7 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
>  		/* Couldn't reconfigure, hopefully, can continue as before */
>  		return;
>  
> -	/*
> -	 * fb_set_var() calls the notifier change internally, only if
> -	 * FBINFO_MISC_USEREVENT flag is set. Since we do not want to fake a
> -	 * user event, we have to call the chain ourselves.
> -	 */
> -	event.info = info;
> -	event.data = &ch->display.mode;
> -	fb_notifier_call_chain(evnt, &event);
> +	fbcon_update_vcs(info, true);
>  }
>  
>  /*
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 1e66fac3124f..f9c212f9b661 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -139,8 +139,6 @@ struct fb_cursor_user {
>  #define FB_EVENT_SET_CONSOLE_MAP        0x08
>  /*      A display blank is requested       */
>  #define FB_EVENT_BLANK                  0x09
> -/*      Private modelist is to be replaced */
> -#define FB_EVENT_MODE_CHANGE_ALL	0x0B
>  /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
>  #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
>  /*      A hardware display blank early change occurred */
> diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
> index d67d7ec51ef9..de31eeb22c97 100644
> --- a/include/linux/fbcon.h
> +++ b/include/linux/fbcon.h
> @@ -15,6 +15,7 @@ void fbcon_new_modelist(struct fb_info *info);
>  void fbcon_get_requirement(struct fb_info *info,
>  			   struct fb_blit_caps *caps);
>  void fbcon_fb_blanked(struct fb_info *info, int blank);
> +void fbcon_update_vcs(struct fb_info *info, bool all);
>  #else
>  static inline void fb_console_init(void) {}
>  static inline void fb_console_exit(void) {}
> @@ -29,6 +30,7 @@ static inline void fbcon_new_modelist(struct fb_info *info) {}
>  static inline void fbcon_get_requirement(struct fb_info *info,
>  					 struct fb_blit_caps *caps) {}
>  static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
> +static inline void fbcon_update_vcs(struct fb_info *info, bool all) {}
>  #endif
>  
>  #endif /* _LINUX_FBCON_H */
> -- 
> 2.20.1
> 
