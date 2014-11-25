From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Nov 2014 18:10:20 +0000
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Message-Id: <20141125181020.GJ7712@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TDAnSvu4oNjXIbzm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1415803064.git.jsarha@ti.com>
 <20141112222344.GU3815@sirena.org.uk>
 <54646648.5030807@ti.com>
 <546DC9A0.8060700@ti.com>
 <20141121112317.GQ3815@sirena.org.uk>
 <546F317B.9030004@ti.com>
 <20141121161435.GS3815@sirena.org.uk>
 <5472E9D7.7000908@ti.com>
 <20141124173920.GL7712@sirena.org.uk>
 <54744B4C.2030105@ti.com>
In-Reply-To: <54744B4C.2030105@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com


--TDAnSvu4oNjXIbzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2014 at 11:26:36AM +0200, Tomi Valkeinen wrote:
> On 24/11/14 19:39, Mark Brown wrote:

> >> The whole series is about HDMI audio, not video.

> > You know exactly what I mean - the early patches are in drivers/video,
> > don't touch anything outside of that and have no obvious dependencies.

> My point was, there's no particular reason to apply those patches
> individually. It's an independent series, about HDMI audio, and applying
> only some of the earlier patches does not improve the kernel in visible
> manner.

Can you please apply them, I'll try to get round to reviewing the audio
bits soon but either these will need applying if the rest of it's OK or
if there does turn out to be a problem they cut down on the size of the
series.  I really do want to read it closely, but hopefully by the
weekend.

--TDAnSvu4oNjXIbzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdMYLAAoJECTWi3JdVIfQQPgH/A6vSSwUvvI/MUvLc/A8qIH7
u3LJ1gXi6Hf+5jieAqtauaeg+vPDoQ3vreE+zShUWQWycBsI5iU71Eqv0ZyvOFnS
9L2XShwPCn71puUzByjdbnEmcdf5s3iBCq99Zo6UqPXRTob0u7jtEG6a237TEGrz
gUKId/CgM+0WspPeuH3ryIvw2drQEzyvy/egnwUxo5ISdFNL0eJRT6Z1lfZwNEyr
ZZSMYpBT/whsXilHPePg0oFwEh2u+zq+Hl2MBHY4rYtWZjwSrWfDulaQdl/m/5DX
IfU6ISAX6f5SGebLFmGVoj+rRtz/1/L4pGReZ/yehAwOCP3DA8IO/mjkTlcxBcM=
=72E2
-----END PGP SIGNATURE-----

--TDAnSvu4oNjXIbzm--
