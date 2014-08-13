From: Mark Brown <broonie@kernel.org>
Date: Wed, 13 Aug 2014 11:04:25 +0000
Subject: Re: [PATCH v3 00/14] Rework OMAP4+ HDMI audio support
Message-Id: <20140813110425.GL17528@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gTWbk+XkjVo/nqZ0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1407503813.git.jsarha@ti.com>
In-Reply-To: <cover.1407503813.git.jsarha@ti.com>
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com


--gTWbk+XkjVo/nqZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 08, 2014 at 04:23:41PM +0300, Jyri Sarha wrote:
> Question to ASoC maintainers:
>   Do feel it is Ok to put ASoC code outside sound/soc the way I do
>   in these patches (in patch 0006 particularly)?

I'm not thrilled about the idea, it's going to result in breakage during
API updates and more cross tree coordination needs.

--gTWbk+XkjVo/nqZ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT60Y1AAoJELSic+t+oim9ZWkP/AoVhZIk/vqI9FXmsyAnnZ6i
PrExq/+VdcFOe36gIXgSZwOxJ9565EqBCo3Z6kUP0mHKBMOaDJOGmClfr0AqXDRV
3YcL+jsK8JEgak/Ho8B+Rm4s9KXQ/pTy1BWmWxpi1Fg0qy5XD+I7QxizAC6PyXnF
t6x37a95zXUtLkeLNsARRa1pi5x1NY14okLduFK9Wi5Ls5aL2NsjGy30D+/vPP8y
xwsG79GnBdE71HcTgV59UHWBRDBrWAZubLwr6BOuhtOEgJLC+KbXDuENQsOILewU
j0i2bETdCotIXPTjZO2pEUwVvGXldG/FUg42T7ChzVM3qtEyt6DDM+A3MxFLbhkO
ouN9A0fHkdp3wfOSQ0/jyNC93v2NssYE1C8CH42omkAAwUzTkTxz3rRMM3UFQxCd
XKQbLTogK81BB2Jvjs24unUHv0LvU1TBD+h7ibJqLj6aK8sx8hAqkEvvkKoPS1j5
JgYTrHZW1cC1acIkkuaLZJrL/Uh8X2RriqTwOj5ncFlAZ/xYfarZ88SpcmOlAI9C
QlFwEE/jL0Cg/tget4aWqBHtpLbGaQ8ktMNVNF3L7lkXexVdNW+lkyNK4rXinhBf
XXJycvxb0F5itNWHzesG4VUr+xF3nj7CcYbPqdV6gvxTugW8wMa7mteG5V7aOwpa
16U7+XIR3AXBQCMDnlRe
=jtWO
-----END PGP SIGNATURE-----

--gTWbk+XkjVo/nqZ0--
