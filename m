From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 01 Aug 2012 14:01:21 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120801140121.GB19957@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZfOjI3PrQbgiZnxM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120731105640.GD16155@avionic-0098.adnet.avionic-design.de>
 <20120731141328.GS4468@opensource.wolfsonmicro.com>
 <20120731142216.GA19591@avionic-0098.adnet.avionic-design.de>
 <20120731142607.GV4468@opensource.wolfsonmicro.com>
 <20120731143235.GA21126@avionic-0098.adnet.avionic-design.de>
 <20120731153941.GF4468@opensource.wolfsonmicro.com>
 <20120801074113.GF29673@avionic-0098.adnet.avionic-design.de>
 <20120801132651.GU11892@opensource.wolfsonmicro.com>
 <20120801133814.GA19771@avionic-0098.adnet.avionic-design.de>
 <20120801135531.GW11892@opensource.wolfsonmicro.com>
In-Reply-To: <20120801135531.GW11892-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2012 at 02:55:31PM +0100, Mark Brown wrote:
> On Wed, Aug 01, 2012 at 03:38:14PM +0200, Thierry Reding wrote:
> > On Wed, Aug 01, 2012 at 02:26:51PM +0100, Mark Brown wrote:
>=20
> > > This is why __devinit data will only be discarded when this is not
> > > possible.
>=20
> > That's exactly my point. But I seem to have miserably failed to get that
> > across. =3D)
>=20
> We must be talking at cross purposes then.  What I'm saying is that the
> framework shouldn't rely on platform data and should assume that the
> kernel might be configured so it can be discarded (by copying most
> likely).

Yes. I think this should be solved by the power_seq_build() function
which uses the platform data description of the sequence and builds it
into something for internal use that doesn't rely on anything in the
platform data.

Thierry

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQGTaxAAoJEN0jrNd/PrOhLqEP/05y+bxKQvC1868DzGqLgol/
2SXAJyQp3CZrc3QNcOB8gxa8cocnTlwIpAmDN8tyBnNYH8YJTcGTI4N2xEQDsTMh
7mhCUdbONE0DwprM29vIzcWKHcUNz/chZMAhdFTugcVgIx0+FUOF9LeYcvlkl67a
ilYszPoMlVldvkLHy/A0/SCYjNJNAs2elHGWYlEmqsxFe8PxpMBpT2/eD/2VMZs3
JunOJsCyW+DNmS+uJBnuqzU9Kvkb8hOkO3dE+/4/2b08f+D8O82ekkQHB9XkWV2j
auqtMDf9yFSo/W1pyAHcHY9Fmz0x0GEGK85Ea3PL12BZOPkI0oAvJBCIRSXb1jBG
LC8VZmbV6UViS7qO5msB4CMY/kp6mtIhtdKWKrm9CyfDzZXvNqBHqhAU4LRxahk9
aqEYmJUDSAKudOq51TisaiHQoicOMNxnMwXD/KLwGUV+Xo/niNOttX2kiSP888Q7
NP0fcwCEc67EIchfBlxsN1PCr5sM8N6rTDjaB+VKfJhgqKsthr0o8/Hxar09UFzS
bbSIjxknnJVDWKIz/qU3DwnTRzpVx+7d+Si45ghfbzCGuuNdP/sw3MhLrFogkmwf
Lqc3J93uNpPy7zdDK8nFtOFu1Hr3PGDgMq8cAXH49OM8bJCHUvApyehdgTzdEHiL
b/DdJl+5uojR3XkIGElt
=Qr+A
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
