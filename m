From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 18 Jul 2018 08:44:31 +0000
Subject: Re: [PATCH 1/1] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <f8d45969-fb04-f706-de66-e51522bbf1ed@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718083633.24182-1-tzimmermann@suse.de>
 <20180718083633.24182-2-tzimmermann@suse.de>
In-Reply-To: <20180718083633.24182-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>, rostedt@goodmis.org, pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com

Hi,

On 18-07-18 10:36, Thomas Zimmermann wrote:
> If the console is unlocked during registration, the console subsystem
> generates significant amounts of warnings, which obfuscate actual
> debugging messages. Setting ignore_console_lock_warning while debugging
> console registration avoid the noise.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thank you for doing this, but there are multiple console_unlock exit
paths in do_register_framebuffer(), you missed the one in:

         if (!lock_fb_info(fb_info)) {
                 if (!lockless_register_fb)
                         console_unlock();
                 return -ENODEV;
         }

I would change this to:

         if (!lock_fb_info(fb_info)) {
                 ret = -ENODEV;
		goto unlock_console;
         }

	ret = 0;

And put a "unlock_console:" label here:

unlock_console:
    	if (!lockless_register_fb)
    		console_unlock();
	else
		ignore_console_lock_warning 			saved_ignore_console_lock_warning;

And change the final return to:

	return ret;

Otherwise this looks good to me.

Regards,

Hans





> ---
>   drivers/video/fbdev/core/fbmem.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 9e2f9d3c760e..79b489ad603d 100644
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
> @@ -1691,6 +1692,8 @@ static int do_register_framebuffer(struct fb_info *fb_info)
>   	event.info = fb_info;
>   	if (!lockless_register_fb)
>   		console_lock();
> +	else
> +		ignore_console_lock_warning = true;
>   	if (!lock_fb_info(fb_info)) {
>   		if (!lockless_register_fb)
>   			console_unlock();
> @@ -1701,6 +1704,9 @@ static int do_register_framebuffer(struct fb_info *fb_info)
>   	unlock_fb_info(fb_info);
>   	if (!lockless_register_fb)
>   		console_unlock();
> +	else
> +		ignore_console_lock_warning > +			saved_ignore_console_lock_warning;
>   	return 0;
>   }
>   
> 
