From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 07 Aug 2019 08:54:27 +0000
Subject: Re: [PATCH] video/fbdev/aty128fb: Remove dead code
Message-Id: <CAFqt6zZMgowAd-UvdEjydF=9HPY7bvXpWuzCqBLS7+3j_Dkgig@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1564514053-4571-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1564514053-4571-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>, b.zolnierkie@samsung.com, "David S. Miller" <davem@davemloft.net>, mpatocka@redhat.com, syrjala@sci.fi, sam@ravnborg.org, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:38 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> This is dead code since 3.15. If there is no plan to use it
> further, this can be removed forever.

Any comment on this patch ?

>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/video/fbdev/aty/aty128fb.c   | 18 ------------------
>  drivers/video/fbdev/aty/atyfb_base.c | 29 -----------------------------
>  2 files changed, 47 deletions(-)
>
> diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
> index 8504e19..fc1e45d 100644
> --- a/drivers/video/fbdev/aty/aty128fb.c
> +++ b/drivers/video/fbdev/aty/aty128fb.c
> @@ -487,11 +487,6 @@ static int aty128_encode_var(struct fb_var_screeninfo *var,
>                               const struct aty128fb_par *par);
>  static int aty128_decode_var(struct fb_var_screeninfo *var,
>                               struct aty128fb_par *par);
> -#if 0
> -static void aty128_get_pllinfo(struct aty128fb_par *par, void __iomem *bios);
> -static void __iomem *aty128_map_ROM(struct pci_dev *pdev,
> -                                   const struct aty128fb_par *par);
> -#endif
>  static void aty128_timings(struct aty128fb_par *par);
>  static void aty128_init_engine(struct aty128fb_par *par);
>  static void aty128_reset_engine(const struct aty128fb_par *par);
> @@ -1665,19 +1660,6 @@ static void aty128_st_pal(u_int regno, u_int red, u_int green, u_int blue,
>                           struct aty128fb_par *par)
>  {
>         if (par->chip_gen = rage_M3) {
> -#if 0
> -               /* Note: For now, on M3, we set palette on both heads, which may
> -                * be useless. Can someone with a M3 check this ?
> -                *
> -                * This code would still be useful if using the second CRTC to
> -                * do mirroring
> -                */
> -
> -               aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) |
> -                           DAC_PALETTE_ACCESS_CNTL);
> -               aty_st_8(PALETTE_INDEX, regno);
> -               aty_st_le32(PALETTE_DATA, (red<<16)|(green<<8)|blue);
> -#endif
>                 aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) &
>                             ~DAC_PALETTE_ACCESS_CNTL);
>         }
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
> index 72bcfbe..6dda5d8 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -1188,19 +1188,6 @@ static int aty_crtc_to_var(const struct crtc *crtc,
>                 (c_sync ? FB_SYNC_COMP_HIGH_ACT : 0);
>
>         switch (pix_width) {
> -#if 0
> -       case CRTC_PIX_WIDTH_4BPP:
> -               bpp = 4;
> -               var->red.offset = 0;
> -               var->red.length = 8;
> -               var->green.offset = 0;
> -               var->green.length = 8;
> -               var->blue.offset = 0;
> -               var->blue.length = 8;
> -               var->transp.offset = 0;
> -               var->transp.length = 0;
> -               break;
> -#endif
>         case CRTC_PIX_WIDTH_8BPP:
>                 bpp = 8;
>                 var->red.offset = 0;
> @@ -1466,11 +1453,6 @@ static int atyfb_set_par(struct fb_info *info)
>                 var->bits_per_pixel,
>                 par->crtc.vxres * var->bits_per_pixel / 8);
>  #endif /* CONFIG_BOOTX_TEXT */
> -#if 0
> -       /* switch to accelerator mode */
> -       if (!(par->crtc.gen_cntl & CRTC_EXT_DISP_EN))
> -               aty_st_le32(CRTC_GEN_CNTL, par->crtc.gen_cntl | CRTC_EXT_DISP_EN, par);
> -#endif
>  #ifdef DEBUG
>  {
>         /* dump non shadow CRTC, pll, LCD registers */
> @@ -2396,17 +2378,6 @@ static int aty_init(struct fb_info *info)
>                         par->pll_ops = &aty_pll_ibm514;
>                         break;
>  #endif
> -#if 0 /* dead code */
> -               case CLK_STG1703:
> -                       par->pll_ops = &aty_pll_stg1703;
> -                       break;
> -               case CLK_CH8398:
> -                       par->pll_ops = &aty_pll_ch8398;
> -                       break;
> -               case CLK_ATT20C408:
> -                       par->pll_ops = &aty_pll_att20c408;
> -                       break;
> -#endif
>                 default:
>                         PRINTKI("aty_init: CLK type not implemented yet!");
>                         par->pll_ops = &aty_pll_unsupported;
> --
> 1.9.1
>
