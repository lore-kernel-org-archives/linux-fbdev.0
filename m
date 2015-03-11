From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 11 Mar 2015 09:42:01 +0000
Subject: Re: [PATCH 3/6] staging: sm750fb: Make internal functions static
Message-Id: <20150311093001.GC4560@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
 <1426037325-8392-3-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426037325-8392-3-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2015 at 01:28:42AM +0000, Lorenzo Stoakes wrote:
> This patch declares externally unavailable functions static. This fixes the
> following sparse warnings:-
<snip>
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 6521c3b..4aa763b 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -92,7 +92,7 @@ void hw_set2dformat(struct lynx_accel * accel,int fmt)
>  /* seems sm712 RectFill command is broken,so need use BitBlt to
>   * replace it. */
>  
> -int hw712_fillrect(struct lynx_accel * accel,
> +static int hw712_fillrect(struct lynx_accel * accel,
>  				u32 base,u32 pitch,u32 Bpp,
>  				u32 x,u32 y,u32 width,u32 height,
>  				u32 color,u32 rop)
this is introducing a build warning, better remove this from your patch
and send a separate patch to remove the function as this function is
not used anywhere.

regards
sudip

> -- 
> 2.3.2
> 
