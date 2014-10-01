From: Mark Brown <broonie@kernel.org>
Date: Wed, 01 Oct 2014 17:05:17 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141001170517.GF4273@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CX2kZGZwrCIhBPP7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo>
 <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo> <20140930173928.GH4273@sirena.org.uk>
 <20141001074139.GB18463@ulmo>
 <CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>
 <20141001123250.GY4273@sirena.org.uk> <20141001124800.GA21733@ulmo>
In-Reply-To: <20141001124800.GA21733@ulmo>
To: linux-arm-kernel@lists.infradead.org


--CX2kZGZwrCIhBPP7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 01, 2014 at 02:48:02PM +0200, Thierry Reding wrote:
> On Wed, Oct 01, 2014 at 01:32:50PM +0100, Mark Brown wrote:

> > So don't do that if you're worried about it then, provide the bits of DT
> > that hook everything up from the start or otherwise describe things as
> > being in use.

> "Otherwise describe things as being in use" doesn't work for clocks for
> example. And Mike already said he wasn't willing to add something like
> an always-on DT property for clocks.

That's not the only way of doing things - another way would be to have a
stub driver that just holds the resources while working on getting a
full one in place for example.

--CX2kZGZwrCIhBPP7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULDRMAAoJECTWi3JdVIfQOwMH/A0cSdCTitWH7nbDFRKLNB8+
3E2X4WLDmGPiQ+yGHRUQ1f+//PI9Fy2Fml0jMqc+sqocTLQEr0GbygcLte6POmwQ
b7FIjcC7nOW2Grou1s84vbnZyVFJto4ZuIqvOLBThb1kM0I5/jWsUCGiGKhNK+rQ
DAOrg3qGchDw34Q3DiwNN0RvDOQvcqfkfRkAfk3Pe6dZlTSzhLIK9gIX/HIbPRWv
VW1OyddQFgdHP1Mkvn0cbeSlFbgJ+8lPvhqfUAaJdtbqCL5IftXSbGu7VohLTDHu
K+4Sc4z31Yak1V8w+RUasOXYYOcDtrt00BIzkd8IFolyOZx75AWm0onQo3wHAZQ=
=omc5
-----END PGP SIGNATURE-----

--CX2kZGZwrCIhBPP7--
