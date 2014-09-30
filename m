From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 30 Sep 2014 08:54:32 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930085429.GB4059@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XOIedfhf+7KOe/yw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929162814.GE4081@lukather> <20140930052110.GC29874@ulmo>
 <20140930075258.GH4081@lukather>
In-Reply-To: <20140930075258.GH4081@lukather>
To: linux-arm-kernel@lists.infradead.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 09:52:58AM +0200, Maxime Ripard wrote:
> On Tue, Sep 30, 2014 at 07:21:11AM +0200, Thierry Reding wrote:
> > On Mon, Sep 29, 2014 at 06:28:14PM +0200, Maxime Ripard wrote:
> > > On Mon, Sep 29, 2014 at 03:47:15PM +0200, Thierry Reding wrote:
[...]
> > > > What happened in the Snow example is that regulators that were
> > > > previously on would all of a sudden be automatically disabled on bo=
ot
> > > > because there was now a driver that registered them with a generic
> > > > framework.
> > > >=20
> > > > The same thing is going to happen with simplefb for your device. If=
 you
> > > > later realize that you need a regulator to keep the panel going, yo=
u'll
> > > > have to add code to your firmware to populate the corresponding
> > > > properties, otherwise the regulator will end up unused and will be
> > > > automatically disabled. At the same time you're going to break upst=
ream
> > > > for all users of your old firmware because it doesn't add that prop=
erty
> > > > yet.
> > > >
> > > > And the same will continue to happen for every new type of resource
> > > > you're going to add.
> > >=20
> > > Sure, we can add any resources we will need. Regulators, reset lines,
> > > pm domains, allocated memory, but I'm not really sure this is what you
> > > want, right?
> >=20
> > No it's not what I want. *You* want to add resource management to this
> > driver. What I'm saying is that if we start adding clocks then we can no
> > longer say no to resets or regulators or power domains either.
>=20
> Yes, because resource management can be more than just "keep the thing
> enabled". It might also be about not modifying anything, just like we
> saw for the clocks, but that might also apply to regulators voltage.

We've already determined that simplefb can't do anything meaningful with
the resources other than keep them in the status quo. It simply doesn't
have enough knowledge to do so. It doesn't know the exact pixel clock or
what voltage the attached panel needs.

> And the only way I can think of to deal with that properly is to have
> resources management in the driver.

My point is that if we had a proper way to tell the kernel not to do
anything with resources owned by firmware, then the driver wouldn't
have to do anything with the resources.

> > > I really start to consider adding a sunxi-uboot-fb, that would just
> > > duplicate the source code of simplefb but also taking the
> > > clocks. Somehow, I feel like it will be easier (and definitely less of
> > > a hack than using the generic common clock API).
> >=20
> > You're not getting it are you? What makes you think sunxi-uboot-fb is
> > going to be any different? This isn't about a name.
>=20
> At least, we would get to do any binding and resource management we
> want. And that's a big win.

So instead of trying to understand the concerns that I've expressed and
constructively contribute to finding a solution that works for everybody
you'd rather go and write a driver from scratch. Way to go.

I've already said that I'm not saying strictly no to these patches, but
what I want to see happen is some constructive discussion about whether
we can find better ways to do it. If we can't then I'm all for merging
these patches. Fortunately other (sub)threads have been somewhat more
constructive and actually come up with alternatives that should make
everyone happier.

If you're going to do SoC-specific bindings and resource management you
are in fact implementing what Grant suggested in a subthread. You're
implementing a dummy driver only for resource management, which isn't
really a bad thing. It can serve as a placeholder for now until you add
the real driver. And you can also use the simplefb driver to provide
the framebuffer.

Thierry

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKm/FAAoJEN0jrNd/PrOhORYP/jcveaC5X8uD3n5btGakdWoj
1cPn422j7nJOGMZznQjNu92bUGr9BoePkuh8HrOZrU3UnzQZo54szKe5EH2OHXlp
l0QHEyner3JNWjlpXLTO0QvNDHGKj4ViXiTTwY91glvHjFkjuB0G5xzMqpNfyIl9
vxzD+McQfHrVx3MGu2nDNU2xF3xmQLL1/Z9t7QGGlRyVrV7bTkVwXbFF3rnpb5Cc
KncwPRJDA5l/ZEyG2nvMV0EPrNvPW8cqlwCe6PI0WawOfuMKih2ESNBoN6faJ6Hl
xIUaDF8sIsXE/HJ7LS4eHchW4hul/hET57+2BNbLvdjOJPuk4/OcAizTLtNTu/tk
VBXStlxsF7g7J6SgqB7kYJqzGS2d/T6M+egrX1aa1awtVKUm0ZwD4B9yLG6QozSv
c69hJ2bpXPKhXPK6h3gTOB2IXcGkAqp+vqbxR8oNPZxhejTaFMsOZsdG3sDCUjVl
1VdnSnSDeuQp74lZ0RmK6/Ysy0a4YySqNwdfGWNPG24TieAueA09bWV+lHIEyx6c
bCFrRdOzRNKqOWJLD1V1s2yjeYWMI6esozFZC+rp/vuYVKTBJMGVATu869K2J/IY
RD/sFMg09nlnop6O1dODBK471lbdVqUXhQ9YgkN4wewb/VfeH7vI0KuBUhdjYdki
7RmBj1ZHhMHdZuHrFO3g
=nKU0
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
