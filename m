From: Mark Brown <broonie@kernel.org>
Date: Fri, 01 Aug 2014 18:48:05 +0000
Subject: Re: [PATCH] video: amba-clcd: Select FB_MODE_HELPERS
Message-Id: <20140801184805.GN30458@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IiH5iyEqjK6f5lUg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1406908430-18487-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1406908430-18487-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org


--IiH5iyEqjK6f5lUg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 01, 2014 at 07:27:03PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 01, 2014 at 04:53:50PM +0100, Mark Brown wrote:

> > The AMBA CLCD driver uses fb_videomode_from_videomode() so it needs to
> > select DB_MODE_HELPERS as well as VIDEOMODE_HELPERS.

> It doesn't, not as I designed it at least.  It depends what other people
> have done to my driver...

Ah, sorry - I didn't notice that this is as a result of an out of tree
patch I'm carrying adding DT support (which I'd forgotten all about as
I've needed it for so long).  Please disregard this patch.

--IiH5iyEqjK6f5lUg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2+DiAAoJELSic+t+oim9q+oQAIQP6c7Y+AYlic+5/UMmpGMZ
uTT62fja80XVfx4ztLqIgPXPtIHBDZIAuY1ySi+heQjXSDVEydWbVsZH2uKiMpu6
fVdSxxY6V4ywNtDYTFn3fRUmL+ZaLezw2T31wlUdcgFLM/k0TldflBdanoFsDO6p
KlbXl6jiJYkrtcE6N88g8CHetQmPsDCP+ilPko+YTyhm87nkmQWT/L9Uw3Rl3GaY
2GdTss02PqQRHPQOd1s043jhCLb5/wW9AlAfqu7clmJ5v5H3x41cmdetB+sZWI7N
2qi6sjDoHUSGtP27yFhovoD+DueXMS5BgKpERp7wfeVjYPL3s/5biSmN84mk0HOj
Skz5f2JTqt3w9graUMa6DPFwW5DHd26jw8R6sKAKWoGH6dORM9NVa++U5Ib4sH3V
aymsTodYqHweJbk3Slv0k7Ry6ENB9fMl+spQqyGCnis7H2vNGtF/1uozj8FpHFzO
qVIMQ3+SbGyx0DOoZuANdmC/0g2kqcQjshUlPLDoIZt74nQzbI5RCfjK5BFe5ItL
zVes/wkYeJseDWt35rR1bRC9UBNU3blBJC4nAWkTLOqnB85KNVxX2hSFnb/EdR8p
TyKYfMoemOgBaK7HVT9lMDXnkAFoiXvQOPqqCSqjup4DdbbkLXXc7cwW+amqGSXY
bLxgsbueZ7m1ZPPSaZSe
=8FpZ
-----END PGP SIGNATURE-----

--IiH5iyEqjK6f5lUg--
