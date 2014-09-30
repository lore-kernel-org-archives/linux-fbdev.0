From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 30 Sep 2014 11:46:06 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930114605.GA23304@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929080637.GB12506@ulmo> <20140929092301.GC4388@lukather>
 <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo> <20140929113436.GA4081@lukather>
 <20140929135358.GC30998@ulmo> <20140929155718.GD4081@lukather>
 <20140930045957.GA29874@ulmo> <542A9771.2030401@redhat.com>
In-Reply-To: <542A9771.2030401@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 01:43:45PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 09/30/2014 06:59 AM, Thierry Reding wrote:
> > On Mon, Sep 29, 2014 at 05:57:18PM +0200, Maxime Ripard wrote:
>=20
> <snip>
>=20
> >> But sure, you can still try to point new issues, get an obvious and
> >> robust solution, and then discard the issue when the solution doesn't
> >> go your way...
> >=20
> > And you've already proven that you're completely unwilling to even
> > consider any other solution than what was originally proposed, so I
> > really don't see how discussing this further with you is going to be
> > productive.
>=20
> That is not true, we have seriously considered various other alternatives,
> as you know since you've participated in the discussion about them.
>=20
> And we've found them all lacking, mostly because they are 10 times as
> complicated.
>=20
> You've made your point that you don't like this solution quite loudly
> already, and we've all heard you. However you seem to be mostly alone in
> this. Even the clk maintainer has said that what we want to do is
> exactly how clocks are supposed to be used in dt.
>=20
> If you don't like this no-one is forcing you to use the clocks property
> in your own code. If it is not there, simplefb will behave exactly as
> before.
>=20
> Now since you're the only one very vocally against this, and a lot
> of people are in favor of this and have a need for this, can we
> please just get this merged and get this over with ?

Whatever. I no longer care.

Thierry

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKpf9AAoJEN0jrNd/PrOh8K4QAINTOUhOd0SKiPcWLMEcnQcs
h8w1n8VgBNfwJXB/7AyxpWMLC3vjkidYc264B4sw7kWD3zMIVZiw6FE2V/PIddth
hVXBEBg1/EFG7ri1fmJON1qvF/pNVYHgZj6xjI2C7uvWrG99yjvk36DaGxAG/E0w
LhVVUd9s+fQDC1fMM0aWJvxaNV7DL05hSZjHlEVrwNWcwWv8fQZeM63JTT1HaOXH
3hDBDF9mDMx5nt7qOaKCDRSzwgSIhefMwSRS2lKGcusxVL3MN9C62MB4239sTg5z
zLA1bkocOqtQYMJmgslNarDQYsTAkcF73L4mmhBQbWywGXLbgxuwP04g4J/BIcgZ
UsQzAUGtWwa+IVH7D+7oZP7VAOqChRsfPa7t5llCCKYxCOUFp1qtsRdyh99Yc0Z3
Mjx08s2egJs0EOkqH4x78ciS2EavTyvRc5PtYdrbqxkYIWbXDAHlntwK4i3rvWQ6
S2Lmlc+pb4SIGpvmm3YkjodlvAqJafi2gXCWo0k4oJF7UDXZliVABXEdCqGvPJjW
z4g91n4kylqIEfOI1xKa+Z2P4xsHSEOZNna3vdKACa9XrLv5VxmbEXVW4i3NXO3y
aOl/5H8jeNFFXhZt9h0jNhJ13iG8yGDf7TsG4nXpdbF14MCh+Zd/CVXzfMazo0EC
orVjNleKCP3W+nMtrLJz
=gM+I
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
