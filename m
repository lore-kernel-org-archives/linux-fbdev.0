From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 01 Oct 2014 07:30:47 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141001073043.GA18463@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo> <20140929113436.GA4081@lukather>
 <20140929135358.GC30998@ulmo> <20140930213753.19023.17605@quantum>
In-Reply-To: <20140930213753.19023.17605@quantum>
To: linux-arm-kernel@lists.infradead.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 02:37:53PM -0700, Mike Turquette wrote:
> Quoting Thierry Reding (2014-09-29 06:54:00)
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
> From e156ee56cbe26c9e8df6619dac1a993245afc1d5 Mon Sep 17 00:00:00 2001
> From: Mike Turquette <mturquette@linaro.org>
> Date: Tue, 30 Sep 2014 14:24:38 -0700
> Subject: [PATCH] doc/kernel-parameters.txt: clarify clk_ignore_unused
>=20
> Refine the definition around clk_ignore_unused, which caused some
> confusion recently on the linux-fbdev and linux-arm-kernel mailing
> lists[0].
>=20
> [0] http://lkml.kernel.org/r/<20140929135358.GC30998@ulmo>
>=20
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> ---
> Thierry,
>=20
> Please let me know if this wording makes the feature more clear.

I think that's better than before, but I don't think it's accurate yet.
As pointed out by Maxime unused clock may still be disabled if it's part
of a tree and that tree is being disabled because there are no users
left.

What I had argued is that it's unexpected behaviour, because the clock
is still unused (or becomes unused again), therefore shouldn't be
disabled at that point either.

So if you want to keep the current behaviour where an unused clock can
still be disabled depending on what other users do, then I think it'd be
good to mention that as a potential caveat.

Thierry

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUK62jAAoJEN0jrNd/PrOhk7MP/0i+Ur9r6nbZD+Dgy6qioXhH
joX8fe6mf4VLd9OhT6MOa+Ou60mfkmt/9v1J4cnDI7Mdn22VFbAICx4qKfWlWcj/
HALhOuhBrGd4KzuAAnlJFo+6rwp+CHS8mKRp1DVsU/NqTeJA+2Bl9bYzzLgCw1Mo
uMZ1X13YhMmjotiX+S/mpTKL0/jv6ZSRPz48NPRLqUQkf4LNwODuRneqq7Hu0p61
7jN3jRI8/umppzw8K1GaK/orgMv30bU1XEAFlrzGL2ZwkjA9i5+PmdIxGcqyFHRf
26RIFaKHlhLgwx8D3IRAsBlA/PqQwTN5N75Kv78p2Tkjjj5X35ZkY2UwP4oWlw6H
j+kHRqn5WSolWXXuETSptrIPaNNGSwpFCobnSVBZSlxFfTLfbOUzxdI76unJiozb
erW9UTk/I0zqb79Phi4SUBavYAvlKS7R2AKD5OdoowMbknRoQU5rT1ftTmBBWDhi
InFzeFoggyOzW0yHYa687bCOLxM3LV2aLC9cDNnSV5kfTWOy6waVLIiBWDp8yNdH
V9pbbcXdxeyc38KGlxjwDvvAj58qG0tsJ9e4dFauCmNbmbuRJ55NKvXIi9/R47Nd
AebR8SmZkWW79Dj3fa3L1mUsxmshiBV9lGlR4hHQDCyRmaunAGVl8ljyus+Coz95
c6sID7mW0JGrD6vT/BxC
=3o/O
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
