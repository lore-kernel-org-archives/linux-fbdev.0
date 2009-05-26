From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] atyfb: Fix HP OmniBook 500 reboot
	hang
Date: Wed, 27 May 2009 01:08:35 +0300
Message-ID: <20090526220834.GO6520@sci.fi>
References: <1243292714-21193-1-git-send-email-syrjala@sci.fi>
	<20090526134918.096d49c4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1M94pP-0003R1-96
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 May 2009 22:08:59 +0000
Received: from smtp5.welho.com ([213.243.153.39])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M94pN-0003sP-0B for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 May 2009 22:08:59 +0000
Content-Disposition: inline
In-Reply-To: <20090526134918.096d49c4.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, May 26, 2009 at 01:49:18PM -0700, Andrew Morton wrote:
> On Tue, 26 May 2009 02:05:14 +0300
> Ville Syrjala <syrjala@sci.fi> wrote:
> =

> > Apparently HP OmniBook 500's BIOS doesn't like the way atyfb reprograms
> > the hardware. The BIOS will simply hang after a reboot. Fix the problem
> > by restoring the hardware to it's original state on reboot.
> > =

> >
> > ...
> >
> > @@ -3502,6 +3503,11 @@ static int __devinit atyfb_pci_probe(struct pci_=
dev *pdev, const struct pci_devi
> >  	par->mmap_map[1].prot_flag =3D _PAGE_E;
> >  #endif /* __sparc__ */
> >  =

> > +	mutex_lock(&reboot_lock);
> > +	if (!reboot_info)
> > +		reboot_info =3D info;
> > +	mutex_unlock(&reboot_lock);
> =

> This looks risky to me.  We save away a pointer to a structure which
> was created by framebuffer_alloc().  What guarantee is there that this
> memory is still valid when the reboot happens later on?

atyfb_remove() will clear the pointer before freeing the memory. The
mutex is supposed to make sure that the structure won't be freed while =

the reboot notifier is executing.

Hmm. I suppose I might have to grab the fb_info lock there too to
protect against other fb activity happening at the same time.

I also noticed that I managed to misplace reboot_info pointer clearing
a bit. It should really be in atyfb_pci_remove() instead of
atyfb_remove() since it's set in atyfb_pci_probe().

> >  	return 0;
> >  =

> >  err_release_io:
> > @@ -3613,9 +3619,14 @@ static void __devexit atyfb_remove(struct fb_inf=
o *info)
> >  {
> >  	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
> >  =

> > +	mutex_lock(&reboot_lock);
> > +	if (reboot_info =3D=3D info)
> > +		reboot_info =3D NULL;
> > +	mutex_unlock(&reboot_lock);
> > +
> >  	/* restore video mode */
> > -	aty_set_crtc(par, &saved_crtc);
> > -	par->pll_ops->set_pll(info, &saved_pll);
> > +	aty_set_crtc(par, &par->saved_crtc);
> > +	par->pll_ops->set_pll(info, &par->saved_pll);
> >  =

> >  	unregister_framebuffer(info);
> >  =

> > @@ -3808,6 +3819,39 @@ static int __init atyfb_setup(char *options)
> >  }
> >  #endif  /*  MODULE  */
> >  =

> > +static int atyfb_reboot_notify(struct notifier_block *nb,
> > +			       unsigned long code, void *unused)
> > +{
> > +	struct atyfb_par *par;
> > +
> > +	if (code !=3D SYS_RESTART)
> > +		return NOTIFY_DONE;
> > +
> > +	mutex_lock(&reboot_lock);
> > +
> > +	if (!reboot_info)
> > +		goto out;
> > +
> > +	par =3D reboot_info->par;
> > +
> > +	/*
> > +	 * HP OmniBook 500's BIOS doesn't like the state of the
> > +	 * hardware after atyfb has been used. Restore the hardware
> > +	 * to the original state to allow succesful reboots.
> =

> "successful" ;)

Right.

> > +	 */
> > +	aty_set_crtc(par, &par->saved_crtc);
> > +	par->pll_ops->set_pll(reboot_info, &par->saved_pll);
> > +
> > + out:
> > +	mutex_unlock(&reboot_lock);
> > +
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block atyfb_reboot_notifier =3D {
> > +	.notifier_call =3D atyfb_reboot_notify,
> > +};
> > +
> >  static int __init atyfb_init(void)
> >  {
> >      int err1 =3D 1, err2 =3D 1;
> > @@ -3826,11 +3870,18 @@ static int __init atyfb_init(void)
> >      err2 =3D atyfb_atari_probe();
> >  #endif
> >  =

> > -    return (err1 && err2) ? -ENODEV : 0;
> > +    if (err1 && err2)
> > +	return -ENODEV;
> > +
> > +    register_reboot_notifier(&atyfb_reboot_notifier);
> > +
> > +    return 0;
> >  }
> =

> ick.  Please feel free to repair the indenting in atyfb_init().

The indentation is broken in other parts of the driver too. I'll make
a separate cosmetics patch to clean it all up.

> >  static void __exit atyfb_exit(void)
> >  {
> > +	unregister_reboot_notifier(&atyfb_reboot_notifier);
> > +
> >  #ifdef CONFIG_PCI
> >  	pci_unregister_driver(&atyfb_driver);
> >  #endif
> =

> So we do the restoration for all supported devices on all machines,
> even though it's only known to be needed on one card on one machine.
> =

> Hopefully that's safe, but a more cautious approach would use a
> whitelist of some form.  I don't have enough experience with these
> things to be able to judge the risk.

It should be safe in theory :) If the restoration breaks on some system
then the probe error handling and remove handling are also broken since
they do the same stuff. But to be honest I didn't test it on other
systems. I could do a DMI match but I'm not sure the extra complexity
is actually warranted. I'll give it a spin on a few other systems in
any case.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT =

is a gathering of tech-side developers & brand creativity professionals. Me=
et
the minds behind Google Creative Lab, Visual Complexity, Processing, & =

iPhoneDevCamp as they present alongside digital heavyweights like Barbarian =

Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com =
