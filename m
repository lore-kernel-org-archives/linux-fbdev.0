From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 29 Sep 2014 10:44:57 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140929104454.GD26008@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KdquIMZPjGJQvRdI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FF1D6C.6090205@redhat.com> <20140829070116.GC13106@ulmo>
 <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 12:35:17PM +0200, Geert Uytterhoeven wrote:
> Hi Thierry,
>=20
> On Mon, Sep 29, 2014 at 12:18 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >> How is that less generic?
> >
> > It's more generic. That's the whole point.
> >
> > The difference is that with the solution I proposed we don't have to
> > keep track of all the resources. We know that firmware has set them up
> > and we know that a real driver will properly take them over at some
> > point, so duplicating what the real driver does within the simplefb
> > driver is just that, duplication. We don't allow duplication anywhere
> > else in the kernel, why should simplefb be an exception?
> >
> >> You know that you are going to call that for regulator, reset, power
> >> domains, just as you would have needed to with the proper API, unless
> >> that with this kind of solution, you would have to modify *every*
> >> framework that might interact with any resource involved in getting
> >> simplefb running?
> >
> > We have to add handling for every kind of resource either way. Also if
> > this evolves into a common pattern we can easily wrap it up in a single
> > function call.
>=20
> disable_all_power_management(), as this is not limited to clocks.

Right. But it isn't all power management either. It just shouldn't turn
everything unused off. Clocks, regulators, power domains and so on which
are used can very well be power managed.

> >> Plus, speaking more specifically about the clocks, that won't prevent
> >> your clock to be shut down as a side effect of a later clk_disable
> >> call from another driver.
>=20
> > Furthermore isn't it a bug for a driver to call clk_disable() before a
> > preceding clk_enable()? There are patches being worked on that will
> > enable per-user clocks and as I understand it they will specifically
> > disallow drivers to disable the hardware clock if other drivers are
> > still keeping them on via their own referenc.
>=20
> Calling clk_disable() preceding clk_enable() is a bug.
>=20
> Calling clk_disable() after clk_enable() will disable the clock (and
> its parents)
> if the clock subsystem thinks there are no other users, which is what will
> happen here.

Right. I'm not sure this is really applicable to this situation, though.
Either way, if there are other users of a clock then they will just as
likely want to modify the rate at which point simplefb will break just
as badly.

Thierry

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKTgmAAoJEN0jrNd/PrOhYHEQAKwVpJTSNFivzgEH0QE/zvcz
4XK6GzkfQ6j75us3Ji4BqOuyYl4znzweslmLjNvm+0pP8BSryQAmsYZJTwWgmFOb
vlSTCj6qoqkw0K7BSjUOAN51QuAeZBkpKUywSIAg41E4KlStIGNvUk2/WQiL6tTx
9AwywixuP302sTZ6gR30nt+UV1DDODXXwSrbeHlYnJ/qcU4yW281iubKIl/TZQco
EAXrTuoDBcvzXSv8bQvT3qI8rEnWMtURuAMTyn8q94NqDPtoy3N7cjONf1R+4dxB
Oj2DOFbLfP8LDz3Bx3IrRC7NfYsM5O5/L3LkIssQoEpENvMjJnwThAiLOIqpMjbH
RocotK+fftUxorDi/4JrajNU9hiMi/KXiXfbhcZo5hwwei5NZmNwi9WSrT0vJ85F
5vGMH/ejYTPoZhNb/3X43BMRHv5rO3qlQ65jecAQqZ3oeuHDdUI3Ck7ttp28Qk3b
R0X33B1PsLqFCM0Vq3oIllkoUauWuv0yTXaX/lL10HkAD4KTKrqRw52ilSYISJSZ
+4chuX3BSzr6h9d7+VwapLRhvMT3Cc+YgVQ90T4YYPNTQ3uN+GGm9+Sjl+AeyZNQ
5zoYR+2e8zqPh1i3WN6pf7sL7dB3ASwHZMqOSSHm7H9s/owvQqtCb5YPpF1GmU1n
RjgYzScIgkBl/Z3ZuaWP
=y3eA
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
