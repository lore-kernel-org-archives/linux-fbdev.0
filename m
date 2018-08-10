From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Aug 2018 15:22:15 +0000
Subject: Re: [PATCH v3] fbcon: Do not takeover the console from atomic context
Message-Id: <18266775.E32RSncY74@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180810112805epcas1p17ec5ad2f046683aad683edcae22777b2@epcas1p1.samsung.com>
 <20180810112757.3936-1-hdegoede@redhat.com>
In-Reply-To: <20180810112757.3936-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Friday, August 10, 2018 01:27:57 PM Hans de Goede wrote:
> Taking over the console involves allocating mem with GFP_KERNEL, talking
> to drm drivers, etc. So this should not be done from an atomic context.
> 
> But the console-output trigger deferred console takeover may happen from an
> atomic context, which leads to "BUG: sleeping function called from invalid
> context" errors.
> 
> This commit fixes these errors by doing the deferred takeover from a
> workqueue.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch queued for 4.19, thanks.

> @@ -3607,8 +3620,8 @@ static int fbcon_output_notifier(struct notifier_block *nb,
>  	deferred_takeover = false;
>  	logo_shown = FBCON_LOGO_DONTSHOW;
>  
> -	for_each_registered_fb(i)
> -		fbcon_fb_registered(registered_fb[i]);
> +	/* We may get called in atomic context */
> +	schedule_work(&fbcon_deferred_takeover_work);

After above change gcc now complains about unused variable:

drivers/video/fbdev/core/fbcon.c: In function ‘fbcon_output_notifier’:
drivers/video/fbdev/core/fbcon.c:3613:6: warning: unused variable ‘i’ [-Wunused-variable]
  int i;
      ^

I fixed this while applying the patch.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
