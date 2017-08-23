From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 23 Aug 2017 16:12:41 +0000
Subject: Re: [PATCH] drivers: video: Fix 80 character limit and remove unnecessary space
Message-Id: <5135691.E4iXgiitH9@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170821140419epcas1p44df6f964a3977e1305cd4845cfcef783@epcas1p4.samsung.com>
        <1503324231-10675-1-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1503324231-10675-1-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org


Hi,

Please use a more descriptive patch subject, i.e.
"fbdev: vgastate: fix checkpatch.pl reported warnings".

Please also cc: fbdev mailing list (linux-fbdev@vger.kernel.org
on fbdev patches).

On Monday, August 21, 2017 07:33:51 PM Himanshu Jha wrote:
> Fixes the following checkpatch warnings:
> WARNING: line over 80 characters
> WARNING: space prohibited between function name and open parenthesis '('
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/video/vgastate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/vgastate.c b/drivers/video/vgastate.c
> index 548c751..a52283d 100644
> --- a/drivers/video/vgastate.c
> +++ b/drivers/video/vgastate.c
> @@ -31,8 +31,9 @@ struct regstate {
>  	__u8 misc;
>  };
>  
> -static inline unsigned char vga_rcrtcs(void __iomem *regbase, unsigned short iobase,
> -				       unsigned char reg)
> +static inline unsigned char vga_rcrtcs(void __iomem *regbase,
> +						unsigned short iobase,
> +							unsigned char reg)

This is not an improvement and doesn't conform to the kernel CodingStyle.

It should be:

static inline unsigned char vga_rcrtcs(void __iomem *regbase,
				       unsigned short iobase,
				       unsigned char reg)

>  {
>  	vga_w(regbase, iobase + 0x4, reg);
>  	return vga_r(regbase, iobase + 0x5);
> @@ -454,8 +455,9 @@ int save_vga(struct vgastate *state)
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL(save_vga);
>  
> -int restore_vga (struct vgastate *state)
> +int restore_vga(struct vgastate *state)
>  {
>  	if (state->vidstate = NULL)
>  		return 1;
> @@ -480,8 +482,6 @@ int restore_vga (struct vgastate *state)
>  	vga_cleanup(state);
>  	return 0;
>  }
> -
> -EXPORT_SYMBOL(save_vga);
>  EXPORT_SYMBOL(restore_vga);
>  
>  MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

