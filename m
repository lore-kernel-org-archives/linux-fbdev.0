From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 20 Jun 2017 20:05:38 +0000
Subject: Re: [PATCH] staging: sm750fb: move common locking code to a macro
Message-Id: <20170620200538.krwizqgsyk5rqe22@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170620165013.11013-1-mail@dbalan.in>
In-Reply-To: <20170620165013.11013-1-mail@dbalan.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dhananjay Balan <mail@dbalan.in>
Cc: sudipm.mukherjee@gmail.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org

On Tue, Jun 20, 2017 at 06:50:13PM +0200, Dhananjay Balan wrote:
> The locking and unlocking code used by copy routines is common, so
> moved it to a macro.
> 
> Signed-off-by: Dhananjay Balan <mail@dbalan.in>
> ---
>  drivers/staging/sm750fb/sm750.c | 81 ++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 386d4adcd91d..d8ab83aea46d 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -156,12 +156,25 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
>  	return 0;
>  }
>  
> +/*
> + * If not using spin_lock, system will die if user frequently loads and
> + * immediately unloads driver (dual)
> + */
> +#define dual_safe_call(func, ...)					\
> +	do {								\
> +		if (sm750_dev->fb_count > 1)				\
> +			spin_lock(&sm750_dev->slock);			\
> +		func(__VA_ARGS__);					\
> +		if (sm750_dev->fb_count > 1)				\
> +			spin_unlock(&sm750_dev->slock);			\
> +	} while (0)
> +

I feel like this is the wrong approach.  You could just make a small
lock function and a small unlock function.  Except that if statement
seems kind of bogus.  What happens if ->fb_count is 0 when we lock and
1 when we unlock?  Why not lock unconditionally?  It is not likely to be
contested if there are no other users.

>  static void lynxfb_ops_fillrect(struct fb_info *info,
>  				const struct fb_fillrect *region)
>  {
>  	struct lynxfb_par *par;
>  	struct sm750_dev *sm750_dev;
> -	unsigned int base, pitch, Bpp, rop;
> +	unsigned int base, pitch, bit_pp, rop;

This part has nothing to do with locking...  *frowny face*

regards,
dan carpenter


