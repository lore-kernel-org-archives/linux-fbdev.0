From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 11 Mar 2015 09:49:28 +0000
Subject: Re: [PATCH 4/6] staging: sm750fb: Expose hw712_fillrect externally
Message-Id: <20150311093728.GD4560@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
 <1426037325-8392-4-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426037325-8392-4-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 01:28:43AM +0000, Lorenzo Stoakes wrote:
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 4aa763b..6521c3b 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -92,7 +92,7 @@ void hw_set2dformat(struct lynx_accel * accel,int fmt)
>  /* seems sm712 RectFill command is broken,so need use BitBlt to
>   * replace it. */
>  
> -static int hw712_fillrect(struct lynx_accel * accel,
> +int hw712_fillrect(struct lynx_accel * accel,
>  				u32 base,u32 pitch,u32 Bpp,
>  				u32 x,u32 y,u32 width,u32 height,
>  				u32 color,u32 rop)
in your previous patch 3/6 you made it static now you are again
removing the static keyword. may i ask why you changed it in 3/6 if you
again change it back to original in this patch?
anyways, like Dan said, delete this function, its not used anywhere.
it will not be used also, i missed removing this function from the
vendor crude drver.

regards
sudip

> 
