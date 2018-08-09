From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Aug 2018 10:03:09 +0000
Subject: Re: [PATCH fix for 4.19] fbcon: Do not takeover the console from atomic context
Message-Id: <1667652.5c9CXM81DN@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180806155422epcas2p137fabf6869ce6217c0f34266f19f978c@epcas2p1.samsung.com>
 <20180806155416.15752-1-hdegoede@redhat.com>
In-Reply-To: <20180806155416.15752-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday, August 06, 2018 05:54:16 PM Hans de Goede wrote:
> Taking over the console involves allocating mem with GFP_KERNEL, talking
> to drm drivers, etc. So this should not be done from an atomic context.
> 
> But the console-output trigger deferred console takeover may happen from an
> atomic context, which leads to "BUG: sleeping function called from invalid
> context" errors.
> 
> This commit fixes these errors by doing the deferred takeover from a
> workqueue when the notifier runs from an atomic context.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

checkpatch.pl complains about in_atomic use:

ERROR: do not use in_atomic in drivers
#51: FILE: drivers/video/fbdev/core/fbcon.c:3623:
+       if (in_atomic() || irqs_disabled()) {

please also see the comment in preempt.h:

/*
 * Are we running in atomic context?  WARNING: this macro cannot
 * always detect atomic context; in particular, it cannot know about
 * held spinlocks in non-preemptible kernels.  Thus it should not be
 * used in the general case to determine whether sleeping is possible.
 * Do not use in_atomic() in driver code.
 */
#define in_atomic()	(preempt_count() != 0)

Therefore please explain why it is fine to use in_atomic in fbcon's case.

> ---
>  drivers/video/fbdev/core/fbcon.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index ef8b2d0b7071..4e5997d53fc4 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -3592,7 +3592,20 @@ static int fbcon_init_device(void)
>  }
>  
>  #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> +static void fbcon_register_existing_fbs(struct work_struct *work)
> +{
> +	int i;
> +
> +	console_lock();
> +
> +	for_each_registered_fb(i)
> +		fbcon_fb_registered(registered_fb[i]);
> +
> +	console_unlock();
> +}
> +
>  static struct notifier_block fbcon_output_nb;
> +static DECLARE_WORK(fbcon_deferred_takeover_work, fbcon_register_existing_fbs);
>  
>  static int fbcon_output_notifier(struct notifier_block *nb,
>  				 unsigned long action, void *data)
> @@ -3607,8 +3620,12 @@ static int fbcon_output_notifier(struct notifier_block *nb,
>  	deferred_takeover = false;
>  	logo_shown = FBCON_LOGO_DONTSHOW;
>  
> -	for_each_registered_fb(i)
> -		fbcon_fb_registered(registered_fb[i]);
> +	if (in_atomic() || irqs_disabled()) {
> +		schedule_work(&fbcon_deferred_takeover_work);
> +	} else {
> +		for_each_registered_fb(i)
> +			fbcon_fb_registered(registered_fb[i]);
> +	}
>  
>  	return NOTIFY_OK;
>  }

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

