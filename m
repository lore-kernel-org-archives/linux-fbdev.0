From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 29 Sep 2014 11:34:36 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140929113436.GA4081@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829070116.GC13106@ulmo> <20140829141244.GH15297@lukather>
 <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo>
In-Reply-To: <20140929104454.GD26008@ulmo>
To: linux-arm-kernel@lists.infradead.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 12:44:57PM +0200, Thierry Reding wrote:
> > >> Plus, speaking more specifically about the clocks, that won't prevent
> > >> your clock to be shut down as a side effect of a later clk_disable
> > >> call from another driver.
> >=20
> > > Furthermore isn't it a bug for a driver to call clk_disable() before a
> > > preceding clk_enable()? There are patches being worked on that will
> > > enable per-user clocks and as I understand it they will specifically
> > > disallow drivers to disable the hardware clock if other drivers are
> > > still keeping them on via their own referenc.
> >=20
> > Calling clk_disable() preceding clk_enable() is a bug.
> >=20
> > Calling clk_disable() after clk_enable() will disable the clock (and
> > its parents)
> > if the clock subsystem thinks there are no other users, which is what w=
ill
> > happen here.
>=20
> Right. I'm not sure this is really applicable to this situation, though.

It's actually very easy to do. Have a driver that probes, enables its
clock, fails to probe for any reason, call clk_disable in its exit
path. If there's no other user at that time of this particular clock
tree, it will be shut down. Bam. You just lost your framebuffer.

Really, it's just that simple, and relying on the fact that some other
user of the same clock tree will always be their is beyond fragile.

> Either way, if there are other users of a clock then they will just as
> likely want to modify the rate at which point simplefb will break just
> as badly.

And this can be handled just as well. Register a clock notifier,
refuse any rate change, done. But of course, that would require having
a clock handle.

Now, how would *you* prevent such a change?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKUPLAAoJEBx+YmzsjxAg1V4QAJ7MK9SqpOJzu2AEflaMKqxQ
XEpXY0hVu/rELRvzfYSWghRsag24c8EKTcaTYfMmNSsjGnNhAIH0SnuPZo8RJ/Xx
d1gkHSdS/doPNIUi5AmsNJZHNowylbX4RAC9lgwB9d4Qh3gmPCm1gjqZPHAba7Sx
DOXdpD0jlJrpfZQGnBqp95zrKWi11D/rCR2xAehA3JzTvtAObCvtAO85JJdhWXLR
BAvTDlucku36XY1xRGHOKLa2d2xYU9KJUX//hNbkIV0fa8Uqc1ndL7tOdGR/UD1Y
T+Mp5DEsbphxEXya+gcHl0jEwwQqCvnb0mo7qGREYHA7VEIieeNuX4+EF9cFTvqt
idAYNfuZ1n4UY+sgoOsny6cBCqT/pGYag/dCBJIE4AEmLNTcYb3E/3G29k54wKSc
8Esy9a6E3lwmNdlqcWEThqgcavVd35/mvvJXD2tSSEOI5nYZwsppMtqSNh2vMZYj
fJxfhFGdruKArLMnNT/JGu1x8cv2tTETJlyCSqUIwp7CjUphls8J7Secwx4C092M
tWK925xKRHQwESJqYqwYKlh03uh5rL8FdeT9nSlQ19Ay/GPR8aaS9fYkdQ5acd0K
EkRCwpXqe/iFXdd9M1L3qrvtoFcQFUbMIz67odYDjMCK9TLKxsemTvWkL80abYil
UOj18Yk3ryUetsLG1BTT
=QMLb
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
