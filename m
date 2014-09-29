From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 29 Sep 2014 15:57:18 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140929155718.GD4081@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="q9KOos5vDmpwPx9o"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo> <20140929113436.GA4081@lukather>
 <20140929135358.GC30998@ulmo>
In-Reply-To: <20140929135358.GC30998@ulmo>
To: linux-arm-kernel@lists.infradead.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 03:54:00PM +0200, Thierry Reding wrote:
> On Mon, Sep 29, 2014 at 01:34:36PM +0200, Maxime Ripard wrote:
> > On Mon, Sep 29, 2014 at 12:44:57PM +0200, Thierry Reding wrote:
> > > > >> Plus, speaking more specifically about the clocks, that won't pr=
event
> > > > >> your clock to be shut down as a side effect of a later clk_disab=
le
> > > > >> call from another driver.
> > > >=20
> > > > > Furthermore isn't it a bug for a driver to call clk_disable() bef=
ore a
> > > > > preceding clk_enable()? There are patches being worked on that wi=
ll
> > > > > enable per-user clocks and as I understand it they will specifica=
lly
> > > > > disallow drivers to disable the hardware clock if other drivers a=
re
> > > > > still keeping them on via their own referenc.
> > > >=20
> > > > Calling clk_disable() preceding clk_enable() is a bug.
> > > >=20
> > > > Calling clk_disable() after clk_enable() will disable the clock (and
> > > > its parents)
> > > > if the clock subsystem thinks there are no other users, which is wh=
at will
> > > > happen here.
> > >=20
> > > Right. I'm not sure this is really applicable to this situation, thou=
gh.
> >=20
> > It's actually very easy to do. Have a driver that probes, enables its
> > clock, fails to probe for any reason, call clk_disable in its exit
> > path. If there's no other user at that time of this particular clock
> > tree, it will be shut down. Bam. You just lost your framebuffer.
> >=20
> > Really, it's just that simple, and relying on the fact that some other
> > user of the same clock tree will always be their is beyond fragile.
>=20
> Perhaps the meaning clk_ignore_unused should be revised, then. What you
> describe isn't at all what I'd expect from such an option. And it does
> not match the description in Documentation/kernel-parameters.txt either.

Well, it never says that it also prevent them from being disabled
later on. But it's true it's not very explicit.

> > > Either way, if there are other users of a clock then they will just as
> > > likely want to modify the rate at which point simplefb will break just
> > > as badly.
> >=20
> > And this can be handled just as well. Register a clock notifier,
> > refuse any rate change, done. But of course, that would require having
> > a clock handle.
> >=20
> > Now, how would *you* prevent such a change?
>=20
> Like I said in the other thread. If you have two drivers that use the
> same clock but need different frequencies you've lost anyway.

Except that the driver that has the most logic (ie not simplefb) will
have a way to recover and deal with that. You prevented the clock rate
*and* your system can react, I guess you actually won.

But sure, you can still try to point new issues, get an obvious and
robust solution, and then discard the issue when the solution doesn't
go your way...

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKYFeAAoJEBx+YmzsjxAgvtQP/1NIpVRbtrx3E6tj6m27Xup+
f56VfM7HBq0l1DV6h413KPNI9iW2KuoJKhi6XIPK5EcGK5TKCDZL4GtvpWdEOG33
X3BGwvpzDtDO7/BUr1THs7Qu1jlBiodTOqZPBrGHTBYo58vgJXJJ7VF1ZM6t3zn6
p8IP//ZVzDwiB9QcPRSCtNw0nkntMRwT+alJdeAkgVAWRgeiDl/kjxE0SPLgYDgs
mDJ2KsibvmenvR+spMbYrN3AIq7XK2bYq36rfbjcruwd0uHpmCkKAHrWFforEBWI
+syBO90l8yESzAi1K43/lZitaZasxv735lLMtaQKJl+0ItbP7+WOE53HNQlyaVIq
b/i3hd2Kp0+ZNTQ8d2WL2hJKlnRZtvQ6g/S3Eu9ExTgpZ0r+qL2GXUnSnsElA1C/
S5frS2eRFRoQONSqbFP9gltzgu9EQakc6Ira0N9vVQDp+RCBKb5XieXmysCo4knO
fnPt6DHMBtAb6QkSSlQZ3Or/SJi0e6BsXxiKIx4FK4RjBuVbHmPzVm6ZOSS8NRD9
RBPjkDMHpgSdLiN9FDWWkwx+SqWLalTTAGJvtnGM3ffsveok7aN/vgrIlidXT2aW
34Xibbo8yndV1GId6dQeEvBrpEfpSZ6+M90Wl02FnKL5uUijLnOvUdNjPyIAVGm2
NDf25oIof9FMnfLN++LB
=c49i
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
