From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2015 03:05:08 +0000
Subject: Re: [PATCH 4/5] staging: sm7xxfb: define new macros
Message-Id: <20150715030508.GA20352@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436256877-10754-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1436256877-10754-5-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1436256877-10754-5-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

On Tue, Jul 07, 2015 at 01:44:36PM +0530, Sudip Mukherjee wrote:
> Define and use some new macros to work with different situations
> based on little-endian and big-endian.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/staging/sm7xxfb/sm7xx.h   | 19 ++++++++++++++++
>  drivers/staging/sm7xxfb/sm7xxfb.c | 48 ++++++++-------------------------------
>  2 files changed, 29 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/sm7xxfb/sm7xx.h b/drivers/staging/sm7xxfb/sm7xx.h
> index 31a21bd..6905177 100644
> --- a/drivers/staging/sm7xxfb/sm7xx.h
> +++ b/drivers/staging/sm7xxfb/sm7xx.h
> @@ -95,3 +95,22 @@ struct modeinit {
>  	unsigned char init_cr30_cr4d[SIZE_CR30_CR4D];
>  	unsigned char init_cr90_cra7[SIZE_CR90_CRA7];
>  };
> +
> +#ifdef __BIG_ENDIAN
> +#define pal_rgb(r, g, b, val)	(((r & 0xf800) >> 8) | \
> +				((g & 0xe000) >> 13) | \
> +				((g & 0x1c00) << 3) | \
> +				((b & 0xf800) >> 3))
> +#define big_addr		0x800000
> +#define mmio_addr		0x00800000
> +#define seqw17			smtc_seqw(0x17, 0x30)
> +#define big_pixel_depth(p, d)	{if (p = 24) {p = 32; d = 32; } }
> +#define big_swap(p)		((p & 0xff00ff00 >> 8) | (p & 0x00ff00ff << 8))
> +#else
> +#define pal_rgb(r, g, b, val)	val
> +#define big_addr		0
> +#define mmio_addr		0x00c00000
> +#define seqw17

Odd, empty macros are not good, because:

> -#ifdef __BIG_ENDIAN
>  		if (sfb->fb->var.bits_per_pixel = 32)
> -			smtc_seqw(0x17, 0x30);
> -#endif
> +			seqw17;

That just looks wrong :(

