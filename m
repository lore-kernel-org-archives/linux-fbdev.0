From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 29 Sep 2014 14:00:57 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140929140055.GD30998@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="a2FkP9tdjPU2nyhF"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo>
 <CAMuHMdXrc4ED0N0Etb-mgCRc437spsxuNZ6Nq_15zhFXSt8Nug@mail.gmail.com>
In-Reply-To: <CAMuHMdXrc4ED0N0Etb-mgCRc437spsxuNZ6Nq_15zhFXSt8Nug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 01:32:44PM +0200, Geert Uytterhoeven wrote:
> Hi Thierry,
>=20
> On Mon, Sep 29, 2014 at 12:44 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >> >> You know that you are going to call that for regulator, reset, power
> >> >> domains, just as you would have needed to with the proper API, unle=
ss
> >> >> that with this kind of solution, you would have to modify *every*
> >> >> framework that might interact with any resource involved in getting
> >> >> simplefb running?
> >> >
> >> > We have to add handling for every kind of resource either way. Also =
if
> >> > this evolves into a common pattern we can easily wrap it up in a sin=
gle
> >> > function call.
> >>
> >> disable_all_power_management(), as this is not limited to clocks.
> >
> > Right. But it isn't all power management either. It just shouldn't turn
> > everything unused off. Clocks, regulators, power domains and so on which
> > are used can very well be power managed.
>=20
> No they can't, as the clock/regulator/PM domain core cannot know if any
> of the used ones are also used by a shim driver like simplefb.
> Clocks and regulators may be shared. PM domains can contain multiple
> hardware blocks. Without more knowledge, the only safe thing is not
> disabling anything.

Indeed. That's a shame. In the most common case that probably won't
matter all that much, given that the real driver can be expected to load
within a reasonable amount of time.

> >> >> Plus, speaking more specifically about the clocks, that won't preve=
nt
> >> >> your clock to be shut down as a side effect of a later clk_disable
> >> >> call from another driver.
> >>
> >> > Furthermore isn't it a bug for a driver to call clk_disable() before=
 a
> >> > preceding clk_enable()? There are patches being worked on that will
> >> > enable per-user clocks and as I understand it they will specifically
> >> > disallow drivers to disable the hardware clock if other drivers are
> >> > still keeping them on via their own referenc.
> >>
> >> Calling clk_disable() preceding clk_enable() is a bug.
> >>
> >> Calling clk_disable() after clk_enable() will disable the clock (and
> >> its parents)
> >> if the clock subsystem thinks there are no other users, which is what =
will
> >> happen here.
> >
> > Right. I'm not sure this is really applicable to this situation, though.
>=20
> Yes it is: if all users of a clock/regulator/PM domain are gone, it will
> be disabled. Bad luck for simplefb still needing them.

Hmm... if all users are gone, then aren't the resources unused again and
should therefore be ignored?

Thierry

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKWYXAAoJEN0jrNd/PrOhZi4P/iWwOpWPWR28KXu7UZBRLA7h
4ybJlcoeb4iocOzQmSrHft2WF8ekGDN70rQnYHdS8Ze+lATzcaVt/LiYqdjIMgOE
vCyfT4ydFT+pHkKUjkI2JfB2d6QwpTiR0cOzYts00xjScsQyU3Zi/lPNsi1/TZIv
7AAZaGgeN5Wjo8oyUfdNRcvkZe1iG3F8zip7vAokoyZv0tg97zF+7tz8NxvL2Zuz
L+R+kTcmmNSHrtyBwvnzrU0ocwkiCQHk+vlxSQ/f3XtRQ7wH0LJBJWD6l0HGqNRO
2O4GOo1QH4tyrWagwaqnbKmkRJibeh48Qpjgv9F2Hmr/chiU3wX/TAJ6q2m1dynl
NpEG+RC1v4MTtf7OZtle3iIVe8dXcuaGZQDb6gGP6eBbaduSxnlepzVceKqF0ryh
w6S8csggp2JZ6uHbQZcQF7atYGk51mx5CPJy82neRe+KYbalPMV0qqfCl/9usdJV
kuvgll19HG18T7Gljs8jJ05I9kG60p95ynNzR+bXmINNPqNPBd0dJ24uZ8hFyGrs
RJofWtfgrv4EVU+lIt/yjJiL0GFCpVWve3CpmHDR8s8KXxtZ0WI6C23JbuKo9rri
4Fo7QfejzXnk5r7DydD5pBa8g8YHgPqIFmjkoGKqdssD9H2ysVe9oUc8rPVRwha0
2VGvm15DraCM2kAZxZHK
=J2VI
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
