From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 07 Mar 2012 10:09:18 +0000
Subject: Re: [PATCH] pxafb: do console locking before calling fb_blank()
Message-Id: <4F5733CE.2060900@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330264322-5938-1-git-send-email-anarsoul@gmail.com>
In-Reply-To: <1330264322-5938-1-git-send-email-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/26/2012 01:52 PM, Vasily Khoruzhick wrote:
> Otherwise we hit WARN_CONSOLE_UNLOCKED in do_unblank_screen
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/pxafb.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index 1d1e4f1..c176561 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -54,6 +54,7 @@
>  #include <linux/mutex.h>
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
> +#include <linux/console.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/io.h>
> @@ -730,9 +731,12 @@ static int overlayfb_open(struct fb_info *info, int user)
>  	if (user = 0)
>  		return -ENODEV;
>  
> -	if (ofb->usage++ = 0)
> +	if (ofb->usage++ = 0) {
>  		/* unblank the base framebuffer */
> +		console_lock();
>  		fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
> +		console_unlock();
> +	}
>  
>  	return 0;
>  }

