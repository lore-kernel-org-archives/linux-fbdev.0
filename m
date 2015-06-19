From: Greg KH <gregkh@linuxfoundation.org>
Date: Fri, 19 Jun 2015 05:09:52 +0000
Subject: Re: [PATCH 9/9] Staging: sm750fb: ddk750_swi2c.c: Shorten lines to 80 characters
Message-Id: <20150619050952.GA2990@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434689336-10647-1-git-send-email-isaac.a.travers@gmail.com>
 <1434689336-10647-10-git-send-email-isaac.a.travers@gmail.com>
In-Reply-To: <1434689336-10647-10-git-send-email-isaac.a.travers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Isaac Assegai <isaac.a.travers@gmail.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com

On Thu, Jun 18, 2015 at 09:48:56PM -0700, Isaac Assegai wrote:
> Shorten lines to be under 80 characters in ddk750_swi2c.c
> to rectify the following checkpatch warnings:
> WARNING: line over 80 characters
> 
> Signed-off-by: Isaac Assegai <isaac.a.travers@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_swi2c.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
> index 5133bcc..1e684e2 100644
> --- a/drivers/staging/sm750fb/ddk750_swi2c.c
> +++ b/drivers/staging/sm750fb/ddk750_swi2c.c
> @@ -126,7 +126,10 @@ void swI2CSCL(unsigned char value)
>  
>  	ulGPIODirection = PEEK32(g_i2cClkGPIODataDirReg);
>  	if (value) {    /* High */
> -		/* Set direction as input. This will automatically pull the signal up. */
> +		/**

Multi-line comments don't have two ** characters, that's just for
kerneldoc format, so I can't take this patch.

thanks,

greg k-h
