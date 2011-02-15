From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Tue, 15 Feb 2011 08:41:21 +0000
Subject: Re: [PATCH] ARM: PXA: Make PXA27x/PXA3xx overlay actually work
Message-Id: <201102151041.21560.anarsoul@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1296679619-32666-1-git-send-email-anarsoul@gmail.com>
	<AANLkTi=AfxN73pSNZ5RiTiTWfxR7PhcyJUyXzzeaYNWw@mail.gmail.com>
In-Reply-To: <AANLkTi=AfxN73pSNZ5RiTiTWfxR7PhcyJUyXzzeaYNWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 15 February 2011 09:35:44 Eric Miao wrote:

> Or maybe simply:
> 
> 	if (lcd_readl(ofb->fbi, OVL1C1) & OVLxC1_OEN)
> 		return;

You mean if (!lcd_readl.....) return? Then OK.

> this makes this block of change much cleaner.
> 
> > -       lcd_writel(ofb->fbi, OVL1C1, ofb->control[0] & ~OVLxC1_OEN);
> > +       if (lcd_readl(ofb->fbi, OVL1C1) & OVLxC1_OEN) {
> > +               lcd_writel(ofb->fbi, OVL1C1, ofb->control[0] &

<skip>

> >  static struct pxafb_layer_ops ofb_ops[] = {
> > @@ -720,12 +726,10 @@ static int overlayfb_open(struct fb_info *info, int
> > user) if (user = 0)
> >                return -ENODEV;
> > 
> > -       /* allow only one user at a time */
> > -       if (atomic_inc_and_test(&ofb->usage))
> > -               return -EBUSY;
> > +       if (ofb->usage++ = 0)
> > +               /* unblank the base framebuffer */
> > +               fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
> 
> The change above allows multiple user at a time? Then I guess
> some other places need to be changed accordingly to avoid the
> racing conditions.

For multiple users driver needs some rework indeed.

> If this is a feature request, can we postpone it to subsequent
> patches?

I prefer to fix it later.

> >        lcd_writel(fbi, FDADR0, fbi->fdadr[0]);
> > -       lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
> > +       if (fbi->lccr0 & LCCR0_SDS)
> > +               lcd_writel(fbi, FDADR1, fbi->fdadr[1]);
> 
> My original intention was to simplify the code a bit by ignoring
> LCCR0_SDS, as FDADR1 would not take effect if not enabled even
> if it's being read/written.

It leads to potential race condition when you try to reconfigure main plane 
and overlay1 simultaneously.

> > +#ifdef CONFIG_FB_PXA_OVERLAY
> > +       if (cpu_is_pxa27x())
> > +               fbi->lccr0 |= LCCR0_OUC;
> > +#endif
> > +
> 
> I seem to remember LCCR0_OUC is still valid on pxa3xx, did you
> do some test on pxa3xx as well?

Sorry, I have no any pxa3xx boards.
 
Regards
Vasily
