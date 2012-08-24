From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 24 Aug 2012 08:55:40 +0000
Subject: Re: [PATCH 6/8] OMAPDSS: DSI: calculate dsi clock
Message-Id: <1345798540.2614.17.camel@deskari>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-8MnAUshQ7OPQyyPyKNZ2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
	 <1345729514-2441-7-git-send-email-tomi.valkeinen@ti.com>
	 <50371C47.30708@ti.com>
In-Reply-To: <50371C47.30708@ti.com>
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-8MnAUshQ7OPQyyPyKNZ2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-08-24 at 11:46 +0530, Archit Taneja wrote:
> On Thursday 23 August 2012 07:15 PM, Tomi Valkeinen wrote:

> > +	/* pck =3D TxByteClkHS * datalanes * 8 / bitsperpixel */
>=20
> This formula looks a bit simplified, we aren't considering the header=20
> and footers of long packets that will add to the DDR clock. But I guess=
=20
> not considering these would only give a higher pixel clock than needed,=
=20
> which isn't that bad.

Hmm. The TRM (omap4460) gives this formula in "10.3.4.5.12 How to
Configure the DSI PLL in Video Mode". The headers/footers etc. are
handled with adjusting the blanking periods so that DISPC and DSI Tline
times match.

But obviously they are not used for command mode transfers, so perhaps
you have a point there. Then again, at least in theory, in command mode
the DISPC pck should be configurable as high as possible because the
stall mechanism should stop DISPC when DSI has had enough. And so the
pck calculation is a bit unneeded for cmd mode, we could just configure
pck to max.

But if it's correct for video mode, and very close for cmd mode, I guess
it should be fine?

 Tomi


--=-8MnAUshQ7OPQyyPyKNZ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQN0GMAAoJEPo9qoy8lh71e2AQAIUw5LQjoe91lYk3VeyjEwfe
9m24LyrLPcHuGi2k3vg2Jbm52Z+jo3LFoisYrB2e4xZkr0Rf1hvT6qRiuArk8o3T
WU11VbrspwV205TalFD8e2MrCYQECZApGiBHCHJNV0jylR9V2CeaNmRZIHn2zZSu
e9IenIt868qHlfm2aJehao/m6L8xlOUacoaFqkVGEytt+BtrOvEvnwnA3UZkIjaS
pd+cpkB+0RWOf88Bn/8VcbP9c7lwgjmnsFAA/k1urPFXngcJmG/ouMVgNNfzaDEe
lS8S6j/5DCEsvlOwJRSWYeOCVRvqIkYeB+lsG9jmxtsJ9r2e0gSak26RzNJPmGbP
YXu1SBFnxwrPjtyeR4VXElAmoTNTKvWvhZlZ56UEyrRTKLm+1RM7bih565EoiNga
H+W7TJYzx7HL1rKkB0n/e5y6+j0nP6Raihk6oRLgod9vNV3kRW8GV+Txwga/gayO
NXL6Cyhm4W6U+4mHCIEMFYN7jGCUIuKyLMlmy7Iz0YNgnTvGykqXMz6RZIU1MUer
9cXb7F+2W3FRQlAWv8ewANfo5ogtY8MmQ1IcymS+xLcEShprI9f+nxR50XwtnJuq
7ROB+ut7HswsvVzrVyovR9m68T0Y5G3mRGihE++jsJIBcolU3BUafbHYFI8inldx
xnvZNBAULbQAg/hhc9OP
=hcmE
-----END PGP SIGNATURE-----

--=-8MnAUshQ7OPQyyPyKNZ2--

