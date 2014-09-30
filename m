From: Mark Brown <broonie@kernel.org>
Date: Tue, 30 Sep 2014 17:39:28 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930173928.GH4273@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fd5uyaI9j6xoeUBo"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <20140929114643.GB4081@lukather> <20140929134708.GB30998@ulmo>
 <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo>
In-Reply-To: <20140930050923.GB29874@ulmo>
To: linux-arm-kernel@lists.infradead.org


--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 30, 2014 at 07:09:24AM +0200, Thierry Reding wrote:
> On Mon, Sep 29, 2014 at 04:55:17PM +0100, Mark Brown wrote:

> > So long as we're ensuring that when we don't start supporting resources
> > without DT additions or at least require DT additions to actively manage
> > them (which can then include simplefb hookup) we should be fine.

> I'm not sure I understand what you mean. If we add a driver for the PMIC
> that exposes these regulators and then add a DT node for the PMIC, we'd
> still need to fix the firmware to generate the appropriate DT properties
> to allow simplefb to enable the regulators.

No, you don't.  It's only if you start describing the regulators in the
PMIC in DT that you run into problems.  Unconfigured regulators won't be
touched.

> So unless firmware is updated at the same time, regulators will get
> disabled because they are unused.

That won't happen unless the regulators are explicitly described, if
they are described as unused then this will of course happen.

--fd5uyaI9j6xoeUBo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKurQAAoJECTWi3JdVIfQk1QH/058WAj1QFJPK5BsgXUkuLVp
QByE5dM/wQDInQ2EwsJ7ZYNWT04LGs8bqEkHb4PgxLFn1XbMhArsGWDIn7VmjWvc
OpHUKqU51RkOWR/mqgjylhqrAN2Z6s2KJQT9WuDodw60M5VlqInWA0mMeEPYS++j
asfsyYp7YsKML/rPWlkabf7DilmvXjiegsPoc7fK4NKyH1io4bnrzJrVMwyfvHq7
ATNF+KM7pJoytxr+kZ7bKcPucFY8vMrGyYDtKlIKgWP3CUD4+sZH4TK7J31CVZpy
lN5Te5bDc09uvq2HduZwyXUyG+RHZaEpesWcmWHP3Pp5bvf1AuJIOGaABbS4cv0=
=emkX
-----END PGP SIGNATURE-----

--fd5uyaI9j6xoeUBo--
