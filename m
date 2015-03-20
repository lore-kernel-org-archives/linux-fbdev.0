From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 20 Mar 2015 23:52:18 +0000
Subject: Re: [PATCH v1 09/47] vidoe: fbdev: atyfb: remove and fix MTRR MMIO "hole" work around
Message-Id: <CALCETrWXk0KVU__DXpGj4RSyY1K7dyjv2h5qJBrZT8psEyM-cQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com> <1426893517-2511-10-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-10-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 20, 2015 at 4:17 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> The atyfb driver uses an MTRR work around since some
> cards use the same PCI BAR for the framebuffer and MMIO.
> In such cards the last page is used for MMIO, the rest for
> the framebuffer, so on those cards we ioremap() the MMIO
> page alone, then again ioremap() the full framebuffer
> including the MMIO space *and* ___then___ use an MTRR with
> MTRR_TYPE_WRCOMB on the full PCI BAR... and finally "hole"
> in an MTRR_TYPE_UNCACHABLE MTRR only for MMIO.
>
> This is a terrible fucking work around, and should by no means
> be necessary however evidence through a large series of conversion
> of drivers to ioremap_wc() for the framebuffer shows that around
> the time MTRR started becoming popular devices did not have things
> lined up for easily separating the framebuffer and MMIO register
> access. In some cases a driver requires significant intrusive
> changes in order to make the split for an ioremap() for MMIO registers
> and another ioremap_wc() for the framebuffer, at other times a
> bit of careful study of the driver suffices. This example driver
> falls into the later category.
>
> We can replace the MTRR MTRR_TYPE_UNCACHABLE
> work around by using ioremap_nocache(), the length of the
> MMIO space should already be correct. The other part we
> need to correct is ensuring we ioremap() for the framebuffer
> only the required size. Since the ioremap() happens early
> on probe for PCI devices before aty_init() where we typically
> adjust the length and know how to do it, we can fix this by
> pegging the bus type as PCI on PCI probe, and finally fudging
> and framebuffer length just as we do on aty_init().
>
> The last thing we do must do to remain sane is ensure we
> use the info->fix.smem_start and info->fix.smem_len for
> the framebuffer MTRR as we know that is always well adjusted.
> The *one* concern here would be if the MTRR is not in units
> of 4K __but__ we already know that in the PCI case this cannot
> happen, in the shared space setting the MTRR would be up to
> 0x7ff000 and assuming a 4K page:
>
> ; 0x7ff000 / 0x1000
>         2047
>
> Also, internally when MTRR is used mtrr_add() will use mtrr_check()
> and that should splat a warning when the MTRR base and size are
> not compatible with what is expected for MTRR usage.
>
> This fix lets us nuke the MTRR_TYPE_UNCACHABLE MTRR "hole".
>
> Cc: Suresh Siddha <suresh.b.siddha@intel.com>
> Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  drivers/video/fbdev/aty/atyfb.h      |  1 -
>  drivers/video/fbdev/aty/atyfb_base.c | 28 ++++++----------------------
>  2 files changed, 6 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/video/fbdev/aty/atyfb.h b/drivers/video/fbdev/aty/atyfb.h
> index 1f39a62..89ec439 100644
> --- a/drivers/video/fbdev/aty/atyfb.h
> +++ b/drivers/video/fbdev/aty/atyfb.h
> @@ -184,7 +184,6 @@ struct atyfb_par {
>         spinlock_t int_lock;
>  #ifdef CONFIG_MTRR
>         int mtrr_aper;
> -       int mtrr_reg;
>  #endif
>         u32 mem_cntl;
>         struct crtc saved_crtc;
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
> index 8025624..8875e56 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -2630,21 +2630,10 @@ static int aty_init(struct fb_info *info)
>
>  #ifdef CONFIG_MTRR
>         par->mtrr_aper = -1;
> -       par->mtrr_reg = -1;
>         if (!nomtrr) {
> -               /* Cover the whole resource. */
> -               par->mtrr_aper = mtrr_add(par->res_start, par->res_size,
> +               par->mtrr_aper = mtrr_add(info->fix.smem_start,
> +                                         info->fix.smem_len,
>                                           MTRR_TYPE_WRCOMB, 1);
> -               if (par->mtrr_aper >= 0 && !par->aux_start) {
> -                       /* Make a hole for mmio. */
> -                       par->mtrr_reg = mtrr_add(par->res_start + 0x800000 -
> -                                                GUI_RESERVE, GUI_RESERVE,
> -                                                MTRR_TYPE_UNCACHABLE, 1);
> -                       if (par->mtrr_reg < 0) {
> -                               mtrr_del(par->mtrr_aper, 0, 0);
> -                               par->mtrr_aper = -1;
> -                       }
> -               }
>         }
>  #endif
>
> @@ -2776,10 +2765,6 @@ aty_init_exit:
>         par->pll_ops->set_pll(info, &par->saved_pll);
>
>  #ifdef CONFIG_MTRR
> -       if (par->mtrr_reg >= 0) {
> -               mtrr_del(par->mtrr_reg, 0, 0);
> -               par->mtrr_reg = -1;
> -       }
>         if (par->mtrr_aper >= 0) {
>                 mtrr_del(par->mtrr_aper, 0, 0);
>                 par->mtrr_aper = -1;
> @@ -3466,7 +3451,7 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
>         }
>
>         info->fix.mmio_start = raddr;
> -       par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
> +       par->ati_regbase = ioremap_nocache(info->fix.mmio_start, 0x1000);

Double-check me, but I think that ioremap_nocache + WC MTRR = WC.  I
think we might need ioremap_nocache_me_harder (or maybe ioremap_x86_uc
if you prefer that bikeshed color) for this.
