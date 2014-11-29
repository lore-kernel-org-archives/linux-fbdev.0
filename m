From: Mark Brown <broonie@kernel.org>
Date: Sat, 29 Nov 2014 11:32:30 +0000
Subject: Re: [PATCH v7.1 09/19] ASoC: omap-hdmi-audio: Add platform device for OMAP HDMI audio support
Message-Id: <20141129113230.GC7712@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EqMiG03fNEfpmvTL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1415803064.git.jsarha@ti.com>
 <9a528990bbe116d9bb073f690b835c847b3fa0bf.1415803065.git.jsarha@ti.com>
In-Reply-To: <9a528990bbe116d9bb073f690b835c847b3fa0bf.1415803065.git.jsarha@ti.com>
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com


--EqMiG03fNEfpmvTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2014 at 04:41:00PM +0200, Jyri Sarha wrote:
> The platform device should only be registered from OMAPDSS HDMI
> driver. The platform driver registers and unregisters all ASoC
> components needed for OMAP HDMI audio.

So, this basically seems fine but I'm looking at this code and I'm not
really seeing a huge amount of OMAP specificness here.  Why is this an
OMAP driver and not something more generic - can't we have other HDMI
controllers offering the same interface?  There's a few serial numbers
that would need filing off but since the ASoC driver is basically just
interface matching and not talking to the hardware it looks like it
ought to be usable by more than just OMAP.

--EqMiG03fNEfpmvTL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUea7NAAoJECTWi3JdVIfQ0X8H/0Y3bNETmcOTTVhJ9DT/6weI
euk6WVkAborw1stVRQQwblkdZRis66LjCpHTCNGgut8RUXqbQo1If1QIZgY0Q7Gg
CAzmNgRZVVyP7irda/SywKzstfRdBVEf/d/pIiyeAkRu3IgF23NvSIkkBMOWHax/
0/vNpmS1FC/RvLP22fP5EmNeuQKvHA2xF+PlX9yLkB5fqW7tgGF4oSJ5Bma1kuEQ
rdGEwCYWbREaaS+Yzbt+1YpcsDFBSrVR36p0LlL+GLLMTF5lgr8uLYRyIjS7pyGZ
cZquXpPgnMpNZ2r5FjlYhMw++MOP451qstnkdqqvSArQZXCrMGj3T3hiBq5CfbY=
=5ctB
-----END PGP SIGNATURE-----

--EqMiG03fNEfpmvTL--
