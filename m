From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 25 Jul 2019 14:39:34 +0000
Subject: Re: [PATCH v1 1/1] backlight: drop EARLY_EVENT_BLANK support
Message-Id: <20190725143934.GH15868@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725143224.GB31803@ravnborg.org>
In-Reply-To: <20190725143224.GB31803@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Gerd Hoffmann <kraxel@redhat.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Rosin <peda@axentia.se>

On Thu, Jul 25, 2019 at 04:32:24PM +0200, Sam Ravnborg wrote:
> There was no users left - so drop the code to support EARLY_FB_BLANK.
> This patch removes the support in backlight,
> and drop the notifier in fbmem.
> 
> That EARLY_FB_BLANK is not used can be verified that no driver set any of:
> 
>     lcd_ops.early_set_power()
>     lcd_ops.r_early_set_power()
> 
> Noticed while browsing backlight code for other reasons.

Ah I didn't grep hard enough, I didn't realize that no one sets the
lcd_ops->(r_)early_set_power hooks. Nice find!

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> ---
> 
> Build tested with various architectures, configs.
> 
> Lee, Daniel - OK to commit to drm-misc-next where fbdev stuff is
> maintained today?

backlight is separate from fbdev in Lee's own tree, not in drm-misc. I
think at least.
-Daniel

> 
> Patch needs ack from Bartlomiej first of course.
> 
> 	Sam
> 
>  drivers/video/backlight/lcd.c    |  8 --------
>  drivers/video/fbdev/core/fbmem.c | 12 +-----------
>  include/linux/fb.h               |  4 ----
>  include/linux/lcd.h              | 10 ----------
>  4 files changed, 1 insertion(+), 33 deletions(-)
> 
> diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
> index d6b653aa4ee9..78b033358625 100644
> --- a/drivers/video/backlight/lcd.c
> +++ b/drivers/video/backlight/lcd.c
> @@ -39,14 +39,6 @@ static int fb_notifier_callback(struct notifier_block *self,
>  		if (event = FB_EVENT_BLANK) {
>  			if (ld->ops->set_power)
>  				ld->ops->set_power(ld, *(int *)evdata->data);
> -		} else if (event = FB_EARLY_EVENT_BLANK) {
> -			if (ld->ops->early_set_power)
> -				ld->ops->early_set_power(ld,
> -						*(int *)evdata->data);
> -		} else if (event = FB_R_EARLY_EVENT_BLANK) {
> -			if (ld->ops->r_early_set_power)
> -				ld->ops->r_early_set_power(ld,
> -						*(int *)evdata->data);
>  		} else {
>  			if (ld->ops->set_mode)
>  				ld->ops->set_mode(ld, evdata->data);
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 00fe0efeaee9..e6a1c805064f 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1058,7 +1058,7 @@ int
>  fb_blank(struct fb_info *info, int blank)
>  {	
>  	struct fb_event event;
> -	int ret = -EINVAL, early_ret;
> +	int ret = -EINVAL;
>  
>   	if (blank > FB_BLANK_POWERDOWN)
>   		blank = FB_BLANK_POWERDOWN;
> @@ -1066,21 +1066,11 @@ fb_blank(struct fb_info *info, int blank)
>  	event.info = info;
>  	event.data = &blank;
>  
> -	early_ret = fb_notifier_call_chain(FB_EARLY_EVENT_BLANK, &event);
> -
>  	if (info->fbops->fb_blank)
>   		ret = info->fbops->fb_blank(blank, info);
>  
>  	if (!ret)
>  		fb_notifier_call_chain(FB_EVENT_BLANK, &event);
> -	else {
> -		/*
> -		 * if fb_blank is failed then revert effects of
> -		 * the early blank event.
> -		 */
> -		if (!early_ret)
> -			fb_notifier_call_chain(FB_R_EARLY_EVENT_BLANK, &event);
> -	}
>  
>   	return ret;
>  }
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 50948e519897..756706b666a1 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -135,10 +135,6 @@ struct fb_cursor_user {
>  
>  /*      A display blank is requested       */
>  #define FB_EVENT_BLANK                  0x09
> -/*      A hardware display blank early change occurred */
> -#define FB_EARLY_EVENT_BLANK		0x10
> -/*      A hardware display blank revert early change occurred */
> -#define FB_R_EARLY_EVENT_BLANK		0x11
>  
>  struct fb_event {
>  	struct fb_info *info;
> diff --git a/include/linux/lcd.h b/include/linux/lcd.h
> index 851eee8fff25..238fb1dfed98 100644
> --- a/include/linux/lcd.h
> +++ b/include/linux/lcd.h
> @@ -41,16 +41,6 @@ struct lcd_ops {
>  	/* Get the LCD panel power status (0: full on, 1..3: controller
>  	   power on, flat panel power off, 4: full off), see FB_BLANK_XXX */
>  	int (*get_power)(struct lcd_device *);
> -	/*
> -	 * Enable or disable power to the LCD(0: on; 4: off, see FB_BLANK_XXX)
> -	 * and this callback would be called proir to fb driver's callback.
> -	 *
> -	 * P.S. note that if early_set_power is not NULL then early fb notifier
> -	 *	would be registered.
> -	 */
> -	int (*early_set_power)(struct lcd_device *, int power);
> -	/* revert the effects of the early blank event. */
> -	int (*r_early_set_power)(struct lcd_device *, int power);
>  	/* Enable or disable power to the LCD (0: on; 4: off, see FB_BLANK_XXX) */
>  	int (*set_power)(struct lcd_device *, int power);
>  	/* Get the current contrast setting (0-max_contrast) */
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
