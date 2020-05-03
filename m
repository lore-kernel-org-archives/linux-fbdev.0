From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 03 May 2020 17:40:40 +0000
Subject: Re: [PATCH] video/fbdev/matroxfb: Remove dead code
Message-Id: <20200503174040.GA27362@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1588370291-7746-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1588370291-7746-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tglx@linutronix.de

Hi Souptick

On Sat, May 02, 2020 at 03:28:11AM +0530, Souptick Joarder wrote:
> These are dead code since 3.15. If there is no plan to use it further
> it can be removed forever.
Could you explain why you conclude this is dead code sine 3.15 -
and maybe point to the commit that made it dead.
I failed to look it up.
And I would assume I did not have to look it up, but that you have
provided enough background to evaluate the patch.

Sometimes dead code are kept becasue it documents something etc.
So it is not always a simple removal.

	Sam

> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/video/fbdev/matrox/matroxfb_DAC1064.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
> index 765e805..9c2a2c0 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
> @@ -603,9 +603,6 @@ static void MGA1064_ramdac_init(struct matrox_fb_info *minfo)
>  /* BIOS environ */
>  static int x7AF4 = 0x10;	/* flags, maybe 0x10 = SDRAM, 0x00 = SGRAM??? */
>  				/* G100 wants 0x10, G200 SGRAM does not care... */
> -#if 0
> -static int def50 = 0;	/* reg50, & 0x0F, & 0x3000 (only 0x0000, 0x1000, 0x2000 (0x3000 disallowed and treated as 0) */
> -#endif
>  
>  static void MGAG100_progPixClock(const struct matrox_fb_info *minfo, int flags,
>  				 int m, int n, int p)
> @@ -843,9 +840,6 @@ static int MGAG100_preinit(struct matrox_fb_info *minfo)
>  	struct matrox_hw_state *hw = &minfo->hw;
>  
>          u_int32_t reg50;
> -#if 0
> -	u_int32_t q;
> -#endif
>  
>  	DBG(__func__)
>  
> @@ -927,11 +921,6 @@ static int MGAG100_preinit(struct matrox_fb_info *minfo)
>  		mga_writeb(minfo->video.vbase, 0x0000, 0xAA);
>  		mga_writeb(minfo->video.vbase, 0x0800, 0x55);
>  		mga_writeb(minfo->video.vbase, 0x4000, 0x55);
> -#if 0
> -		if (mga_readb(minfo->video.vbase, 0x0000) != 0xAA) {
> -			hw->MXoptionReg &= ~0x1000;
> -		}
> -#endif
>  		hw->MXoptionReg |= 0x00078020;
>  	} else if (minfo->devflags.accelerator = FB_ACCEL_MATROX_MGAG200) {
>  		pci_read_config_dword(minfo->pcidev, PCI_OPTION2_REG, &reg50);
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
