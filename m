From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 22 Jul 2019 08:38:51 +0000
Subject: Re: [PATCH] video: fbdev: nvidia: Remove dead code
Message-Id: <CAFqt6zaNcNdxcT2WLOvL0LTX_R9ShRNx6UW6s4k+wc=Zj2MaSg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1562782586-3994-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1562782586-3994-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@gmail.com, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Sabyasachi Gupta <sabyasachi.linux@gmail.com>

On Wed, Jul 10, 2019 at 11:41 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> This is dead code since 3.15. If there is no plan to use it
> further, this can be removed forever.

Any comment on this patch ?

>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/video/fbdev/nvidia/nv_setup.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/drivers/video/fbdev/nvidia/nv_setup.c b/drivers/video/fbdev/nvidia/nv_setup.c
> index b17acd2..2fa6866 100644
> --- a/drivers/video/fbdev/nvidia/nv_setup.c
> +++ b/drivers/video/fbdev/nvidia/nv_setup.c
> @@ -119,34 +119,10 @@ u8 NVReadMiscOut(struct nvidia_par *par)
>  {
>         return (VGA_RD08(par->PVIO, VGA_MIS_R));
>  }
> -#if 0
> -void NVEnablePalette(struct nvidia_par *par)
> -{
> -       volatile u8 tmp;
> -
> -       tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
> -       VGA_WR08(par->PCIO, VGA_ATT_IW, 0x00);
> -       par->paletteEnabled = 1;
> -}
> -void NVDisablePalette(struct nvidia_par *par)
> -{
> -       volatile u8 tmp;
> -
> -       tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
> -       VGA_WR08(par->PCIO, VGA_ATT_IW, 0x20);
> -       par->paletteEnabled = 0;
> -}
> -#endif  /*  0  */
>  void NVWriteDacMask(struct nvidia_par *par, u8 value)
>  {
>         VGA_WR08(par->PDIO, VGA_PEL_MSK, value);
>  }
> -#if 0
> -u8 NVReadDacMask(struct nvidia_par *par)
> -{
> -       return (VGA_RD08(par->PDIO, VGA_PEL_MSK));
> -}
> -#endif  /*  0  */
>  void NVWriteDacReadAddr(struct nvidia_par *par, u8 value)
>  {
>         VGA_WR08(par->PDIO, VGA_PEL_IR, value);
> --
> 1.9.1
>
