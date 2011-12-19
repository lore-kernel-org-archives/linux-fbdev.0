From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 19 Dec 2011 23:16:04 +0000
Subject: Re: [PATCH 3/15] i810: fix module_param bool abuse.
Message-Id: <4EEFC5B4.9000704@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <874nx2tu1v.fsf@rustcorp.com.au>
In-Reply-To: <874nx2tu1v.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>

On 12/15/2011 03:03 AM, Rusty Russell wrote:
> The driver says "module_param(ddc3, bool, 0);".  But it's not a used
> as a bool, it's used as a count.
> 
> Make it a bool.
> 
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/i810/i810_main.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
> --- a/drivers/video/i810/i810_main.c
> +++ b/drivers/video/i810/i810_main.c
> @@ -147,7 +147,7 @@ static int vyres      __devinitdata;
>  static int sync       __devinitdata;
>  static int extvga     __devinitdata;
>  static int dcolor     __devinitdata;
> -static int ddc3       __devinitdata = 2;
> +static bool ddc3      __devinitdata;
>  
>  /*------------------------------------------------------------*/
>  
> @@ -1776,7 +1776,7 @@ static void __devinit i810_init_defaults
>  	if (sync) 
>  		par->dev_flags |= ALWAYS_SYNC;
>  
> -	par->ddc_num = ddc3;
> +	par->ddc_num = (ddc3 ? 3 : 2);
>  
>  	if (bpp < 8)
>  		bpp = 8;
> @@ -1999,7 +1999,7 @@ static int __devinit i810fb_setup(char *
>  		else if (!strncmp(this_opt, "dcolor", 6))
>  			dcolor = 1;
>  		else if (!strncmp(this_opt, "ddc3", 4))
> -			ddc3 = 3;
> +			ddc3 = true;
>  		else
>  			mode_option = this_opt;
>  	}
> 

