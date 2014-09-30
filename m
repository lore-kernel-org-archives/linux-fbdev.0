From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 30 Sep 2014 04:59:59 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930045957.GA29874@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo> <20140929113436.GA4081@lukather>
 <20140929135358.GC30998@ulmo> <20140929155718.GD4081@lukather>
In-Reply-To: <20140929155718.GD4081@lukather>
To: linux-arm-kernel@lists.infradead.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 05:57:18PM +0200, Maxime Ripard wrote:
> On Mon, Sep 29, 2014 at 03:54:00PM +0200, Thierry Reding wrote:
> > On Mon, Sep 29, 2014 at 01:34:36PM +0200, Maxime Ripard wrote:
> > > On Mon, Sep 29, 2014 at 12:44:57PM +0200, Thierry Reding wrote:
> > > > > >> Plus, speaking more specifically about the clocks, that won't =
prevent
> > > > > >> your clock to be shut down as a side effect of a later clk_dis=
able
> > > > > >> call from another driver.
> > > > >=20
> > > > > > Furthermore isn't it a bug for a driver to call clk_disable() b=
efore a
> > > > > > preceding clk_enable()? There are patches being worked on that =
will
> > > > > > enable per-user clocks and as I understand it they will specifi=
cally
> > > > > > disallow drivers to disable the hardware clock if other drivers=
 are
> > > > > > still keeping them on via their own referenc.
> > > > >=20
> > > > > Calling clk_disable() preceding clk_enable() is a bug.
> > > > >=20
> > > > > Calling clk_disable() after clk_enable() will disable the clock (=
and
> > > > > its parents)
> > > > > if the clock subsystem thinks there are no other users, which is =
what will
> > > > > happen here.
> > > >=20
> > > > Right. I'm not sure this is really applicable to this situation, th=
ough.
> > >=20
> > > It's actually very easy to do. Have a driver that probes, enables its
> > > clock, fails to probe for any reason, call clk_disable in its exit
> > > path. If there's no other user at that time of this particular clock
> > > tree, it will be shut down. Bam. You just lost your framebuffer.
> > >=20
> > > Really, it's just that simple, and relying on the fact that some other
> > > user of the same clock tree will always be their is beyond fragile.
> >=20
> > Perhaps the meaning clk_ignore_unused should be revised, then. What you
> > describe isn't at all what I'd expect from such an option. And it does
> > not match the description in Documentation/kernel-parameters.txt either.
>=20
> Well, it never says that it also prevent them from being disabled
> later on. But it's true it's not very explicit.

It says:

	Keep all clocks already enabled by bootloader on,
	even if no driver has claimed them. ...

There's no "until" or anything there, so I interpret that as
indefinitely.

> > > > Either way, if there are other users of a clock then they will just=
 as
> > > > likely want to modify the rate at which point simplefb will break j=
ust
> > > > as badly.
> > >=20
> > > And this can be handled just as well. Register a clock notifier,
> > > refuse any rate change, done. But of course, that would require having
> > > a clock handle.
> > >=20
> > > Now, how would *you* prevent such a change?
> >=20
> > Like I said in the other thread. If you have two drivers that use the
> > same clock but need different frequencies you've lost anyway.
>=20
> Except that the driver that has the most logic (ie not simplefb) will
> have a way to recover and deal with that.

You're making an assumption here. Why would the driver have such logic
if nothing ever prevented it from setting the rate properly before.

> But sure, you can still try to point new issues, get an obvious and
> robust solution, and then discard the issue when the solution doesn't
> go your way...

And you've already proven that you're completely unwilling to even
consider any other solution than what was originally proposed, so I
really don't see how discussing this further with you is going to be
productive.

Thierry

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKjjNAAoJEN0jrNd/PrOhK+QP/RJc2LMdO/cJYpWdXwnPt9zB
DEKOAFivicx5zkTAtNlY0faYS8Prp86B8ybzors1eoGQvC25BXVT2hW4YpvOsrMU
vlPwZB/1BwlrJM5tbF5Pluf/tw/vym8u69FR5Zf7uomwvDzE/hq+4vv4kAXw8vzj
061MTq1qeLwAcN8ZTdXOnJcfd+OkQhLxiqnD/3jAq++lFGX8+VRQNN46ge1xO8TO
PP42ARwtnbKZ2n8nJDBK5Mcfhds1BnfwElQ+yKLa1FLwhWo0Cr+tyPm5KztOd3i5
m3jkxE7sNtSt6GsvIYli3kRehLmJZ7aK/V1Wc23VM+AGozCJdFXJH8R/gssufFtZ
N200s9DAEqyv8eEHycoPyetYN9XRhtLd2hoXZAt2WsUg8/EK4XVNHplEBIq3zuqv
QVW8TtPRHfqQWvvIVDFea57rEUmjweN1haepRldB9UEzdKzG6KVsp+7kJ9KVbvj5
kCFdwEBd9viac8inr1j7qD9AFnOHfuIueXzc6/xKuZT9QsNlLxsINbrKldXSUP5K
Bbe1b2Zha/1UJ5hLtyALGENJiWBEjnDVzIcUgDu00gsw3P1O3D3jXXhyUFhZCrdC
auXzgDBD3EuY39dms2+nTbE8DXUQci98gwzdd6Iuy5Wau/8/WaHdhDDD/SMQbj94
PslQWI65J1RlAYpaagkA
=JY2t
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
