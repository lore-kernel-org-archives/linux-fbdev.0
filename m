From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 23 Mar 2015 11:22:05 +0000
Subject: Re: [PATCH 08/13] staging: sm750: comment formating
Message-Id: <20150323112205.GE10964@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150322231340.GA17233@x230-arch.club.entropia.de>
In-Reply-To: <20150322231340.GA17233@x230-arch.club.entropia.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Mar 23, 2015 at 12:13:41AM +0100, Michel von Czettritz wrote:
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 54857ba..ab58987 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -74,19 +74,19 @@ static inline void myspin_unlock(spinlock_t *sl)
>  		spin_unlock(sl);
>  }
>  static const struct fb_videomode lynx750_ext[] = {
> -	/*  	1024x600-60 VESA 	[1.71:1]	*/
> +	/*	1024x600-60 VESA	[1.71:1]*/

Leave a space before the "*/"

> @@ -610,7 +610,7 @@ static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
>  	var = &info->var;
>  	ret = 0;
>  
> -	//pr_debug("regno=%d,red=%d,green=%d,blue=%d\n",regno,red,green,blue);
> +	/*pr_debug("regno=%d,red=%d,green=%d,blue=%d\n",regno,red,green,blue);*/

Just delete these.  Also, missing spaces next to /* and */.

regards,
dan carpenter

