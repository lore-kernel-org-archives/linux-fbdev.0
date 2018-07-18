From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 18 Jul 2018 09:34:27 +0000
Subject: Re: [PATCH v2 1/1] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <fb6c5298-75b5-d7be-b00f-842c4514d46e@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718093002.4596-1-tzimmermann@suse.de>
 <20180718093002.4596-2-tzimmermann@suse.de>
In-Reply-To: <20180718093002.4596-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>, rostedt@goodmis.org, pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com

Hi,

On 18-07-18 11:30, Thomas Zimmermann wrote:
> If the console is unlocked during registration, the console subsystem
> generates significant amounts of warnings, which obfuscate actual
> debugging messages. Setting ignore_console_lock_warning while debugging
> console registration avoid the noise.
> 
> v2:
> 	- restore ignore_console_lock_warning if lock_fb_info() fails
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Patch looks good to me, thanks:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For "[PATCH v2] console: Replace #if 1 with a bool to ignore"
Petr wrote:

"Acked-by: Petr Mladek <pmladek@suse.com>

I assume that it will go via fbdev tree with the other changes
unless I hear otherwise."

So that patch and this one can both be picked up by Bartlomiej for
merging through the fbdev tree when he is back.

Regards,

Hans





> ---
>   drivers/video/fbdev/core/fbmem.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 9e2f9d3c760e..432c26eeabfb 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1627,6 +1627,7 @@ static int do_register_framebuffer(struct fb_info *fb_info)
>   	int i, ret;
>   	struct fb_event event;
>   	struct fb_videomode mode;
> +	bool saved_ignore_console_lock_warning = ignore_console_lock_warning;
>   
>   	if (fb_check_foreignness(fb_info))
>   		return -ENOSYS;
> @@ -1691,17 +1692,23 @@ static int do_register_framebuffer(struct fb_info *fb_info)
>   	event.info = fb_info;
>   	if (!lockless_register_fb)
>   		console_lock();
> +	else
> +		ignore_console_lock_warning = true;
>   	if (!lock_fb_info(fb_info)) {
> -		if (!lockless_register_fb)
> -			console_unlock();
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto unlock_console;
>   	}
> +	ret = 0;
>   
>   	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
>   	unlock_fb_info(fb_info);
> +unlock_console:
>   	if (!lockless_register_fb)
>   		console_unlock();
> -	return 0;
> +	else
> +		ignore_console_lock_warning > +			saved_ignore_console_lock_warning;
> +	return ret;
>   }
>   
>   static int do_unregister_framebuffer(struct fb_info *fb_info)
> 
