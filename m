From: Mark Brown <broonie@kernel.org>
Date: Fri, 21 Nov 2014 16:38:15 +0000
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Message-Id: <20141121163815.GT3815@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eEMbiT5PVwodlmOQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1415803064.git.jsarha@ti.com>
 <20141112222344.GU3815@sirena.org.uk>
 <54646648.5030807@ti.com>
 <546DC9A0.8060700@ti.com>
 <20141121112317.GQ3815@sirena.org.uk>
 <546F2BA3.9050203@ti.com>
In-Reply-To: <546F2BA3.9050203@ti.com>
To: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com


--eEMbiT5PVwodlmOQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 21, 2014 at 02:10:11PM +0200, Jyri Sarha wrote:

> OMAP HDMI audio is fundamentally different to the case on Armada or on BBB.
> In omap the whole HDMI IP is integrated to the SoC and there really is no
> codec in the ASoC sense. The the cpu-dai transmits the audio directly to
> hdmi wire and there is no i2s bus involved. So this case should not be mixed
> with the patches Jean-Francois working on. The code is also orthogonal in
> that sense that the latest omap-hdmi-audio uses the generic dymmy codec.

The discussion seemed to be about what to do with unplugged connections
which isn't what you're talking about there and does seem like an area
where we should at least be aiming for common behaviour even if not a
common implementation.

There's also all the stuff about parsing EDIDs for capabilities which
would seem to be related to that but seems to have gone off into the
weeds.

--eEMbiT5PVwodlmOQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb2p2AAoJECTWi3JdVIfQq8YH/i3MInS0Eb59xtMT5mVcW8nO
CxYacQ/f6F/APa9sFkKnMmXHjRRGEukPIXdGD5ywckrfmhtX7FKYoEiqxeOFg1Us
IQgQPrQoiTAmlIOcOLRZTFdoAR+8leJ0qyUralsO1SkXOXqXr22oLFWzqez1Jt4W
qcP+3RhXoF3aDytD8yuvIxcBp0WEC/JlO6FKIChQC9W+yMjScuCU/Hvjo8ODvHy3
kcHXVLY6lABFNJUXg59FbSVrJlG0UQHYmUFaihF/hLMgDiR5l48i4WGpxuRPo6LO
lITjKIa4kNtA78jTmkZGOfH6UHxN78vRxiIV/+9ucQYmhdobB0iZi6K86dHTLJc=
=iGAJ
-----END PGP SIGNATURE-----

--eEMbiT5PVwodlmOQ--
