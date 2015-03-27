From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Fri, 27 Mar 2015 23:31:37 +0000
Subject: Re: [PATCH v1 09/47] vidoe: fbdev: atyfb: remove and fix MTRR MMIO "hole" work around
Message-Id: <20150327233137.GP5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-10-git-send-email-mcgrof@do-not-panic.com>
 <CALCETrWXk0KVU__DXpGj4RSyY1K7dyjv2h5qJBrZT8psEyM-cQ@mail.gmail.com>
 <20150327201201.GL5622@wotan.suse.de>
 <CALCETrX9g6FzSnVmBow58_7cxrn21iCS+Xt8F+ThnJjukkyLmw@mail.gmail.com>
In-Reply-To: <CALCETrX9g6FzSnVmBow58_7cxrn21iCS+Xt8F+ThnJjukkyLmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 27, 2015 at 02:21:34PM -0700, Andy Lutomirski wrote:
> On Fri, Mar 27, 2015 at 1:12 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> > On Fri, Mar 20, 2015 at 04:52:18PM -0700, Andy Lutomirski wrote:
> >> On Fri, Mar 20, 2015 at 4:17 PM, Luis R. Rodriguez
> >> <mcgrof@do-not-panic.com> wrote:
> >> > diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
> >> > index 8025624..8875e56 100644
> >> > --- a/drivers/video/fbdev/aty/atyfb_base.c
> >> > +++ b/drivers/video/fbdev/aty/atyfb_base.c
> >> > @@ -2630,21 +2630,10 @@ static int aty_init(struct fb_info *info)
> >> >
> >> >  #ifdef CONFIG_MTRR
> >> >         par->mtrr_aper = -1;
> >> > -       par->mtrr_reg = -1;
> >> >         if (!nomtrr) {
> >> > -               /* Cover the whole resource. */
> >> > -               par->mtrr_aper = mtrr_add(par->res_start, par->res_size,
> >> > +               par->mtrr_aper = mtrr_add(info->fix.smem_start,
> >> > +                                         info->fix.smem_len,
> >> >                                           MTRR_TYPE_WRCOMB, 1);
> >> > -               if (par->mtrr_aper >= 0 && !par->aux_start) {
> >> > -                       /* Make a hole for mmio. */
> >> > -                       par->mtrr_reg = mtrr_add(par->res_start + 0x800000 -
> >> > -                                                GUI_RESERVE, GUI_RESERVE,
> >> > -                                                MTRR_TYPE_UNCACHABLE, 1);
> >> > -                       if (par->mtrr_reg < 0) {
> >> > -                               mtrr_del(par->mtrr_aper, 0, 0);
> >> > -                               par->mtrr_aper = -1;
> >> > -                       }
> >> > -               }
> >> >         }
> >> >  #endif
> >> >
> >> > @@ -2776,10 +2765,6 @@ aty_init_exit:
> >> >         par->pll_ops->set_pll(info, &par->saved_pll);
> >> >
> >> >  #ifdef CONFIG_MTRR
> >> > -       if (par->mtrr_reg >= 0) {
> >> > -               mtrr_del(par->mtrr_reg, 0, 0);
> >> > -               par->mtrr_reg = -1;
> >> > -       }
> >> >         if (par->mtrr_aper >= 0) {
> >> >                 mtrr_del(par->mtrr_aper, 0, 0);
> >> >                 par->mtrr_aper = -1;
> >> > @@ -3466,7 +3451,7 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
> >> >         }
> >> >
> >> >         info->fix.mmio_start = raddr;
> >> > -       par->ati_regbase = ioremap(info->fix.mmio_start, 0x1000);
> >> > +       par->ati_regbase = ioremap_nocache(info->fix.mmio_start, 0x1000);
> >>
> >> Double-check me, but I think that ioremap_nocache + WC MTRR = WC.
> >
> > Precicely, in this case the WC hole was obtained by using MTRR WC. This
> > patch removes that WC hole trick and now we can be explciit about
> > only wanting ioremap_nocache() on the registers, that is WC is not
> > desired here and is not used. The patch does not highlight the fact
> > that there was left in place another ioremap() call for the framebuffer:
> >
> > info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
> >
> > That is the one that later after this patch we use ioremap_wc() for.
> > This patch just removes the hole solution. That's all.
> >
> 
> I don't understand.
> 
> If I read it right, there's a 2^n byte BAR.  You're requesting WC for
> the whole think using arch_phys_wc_add.

I believe there is a misunderstanding of order of changes.

Let's split when we use mtrr_add() Vs arch_phys_wc_add() to avoid
confusion as in this patch we don't yet use arch_phys_wc_add(). That
is done in the next patch.

The commit log describes best the state of affairs prior to this
patch:

    The atyfb driver uses an MTRR work around since some
    cards use the same PCI BAR for the framebuffer and MMIO.
    In such cards the last page is used for MMIO, the rest for
    the framebuffer, so on those cards we ioremap() the MMIO
    page alone, then again ioremap() the full framebuffer
    including the MMIO space *and* ___then___ use an MTRR with
    MTRR_TYPE_WRCOMB on the full PCI BAR... and finally "hole"
    in an MTRR_TYPE_UNCACHABLE MTRR only for MMIO.

Then this patch drops the MTRR_TYPE_UNCACHABLE rewrite thing
and instead corrects the ioremap() call for the framebuffer
to only be called for the framebuffer alone. For the MMIO
area we adjust to use then ioremap_nocache(). The MTRR left
is now only *for the framebuffer* and it should not be touching
the MMIO area. So the MMIO area has its own ioremap_nocache()
area alone, the framebuffer is left with an ioremap() followed
by an mtrr_add() call.

The next patch replaces the mtrr_add() with arch_phys_wc_add()
and then also uses ioremap_wc().

> On a PAT system that has no effect and all is well.

Yeah we're not doing arch_phys_wc_add() on the entire PCI BAR.
That was dumb, this fixes that, and on this patch mtrr_add()
is still used.

> On a non-PAT system, it adds an MTRR.  That
> means that you need to override the MTRR somehow for the mmio regs,
> and UC- won't do the trick.

We don't need to solve that problem here as the MTRR should only
be for the framebuffer.

  Luis
