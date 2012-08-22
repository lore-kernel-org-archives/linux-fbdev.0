From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 22 Aug 2012 05:42:05 +0000
Subject: Re: [PATCH v4 1/3] Runtime Interpreted Power Sequences
Message-Id: <20120822054205.GA28845@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345097337-24170-1-git-send-email-acourbot@nvidia.com>
 <1345097337-24170-2-git-send-email-acourbot@nvidia.com>
 <1345535069.4085.7.camel@deskari> <1562509.b0FYTUZ1D8@percival>
 <20120821083329.GA28992@avionic-0098.adnet.avionic-design.de>
 <1345539465.4085.22.camel@deskari>
 <20120821091306.GA4819@avionic-0098.mockup.avionic-design.de>
 <1345542860.4085.40.camel@deskari>
 <20120821165738.GY7995@opensource.wolfsonmicro.com>
In-Reply-To: <20120821165738.GY7995-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 05:57:38PM +0100, Mark Brown wrote:
> On Tue, Aug 21, 2012 at 12:54:20PM +0300, Tomi Valkeinen wrote:
>=20
> > However, if we already have a generic driver for that type of panel,
> > (which we would need anyway for the DT based approach), the developer
> > only needs to add the name of the panel and the data for the power
> > sequence to the panel driver's database, which is about the same amount
> > of work as with DT.
>=20
> > So it's really just a question of where to put the data in question, DT
> > or driver. Both contain the same data, and the data structure may also
> > be the same. In DT's case it just needs to be parsed first, whereas in
> > database case you'll enter the data in structs.
>=20
> I think the device tree idiomatic way of doing this is to have a bunch
> of .dtsi files for the panels which then get included by reference in
> the board files.  This isn't helpful to people working on non-DT
> architectures though.

One problem that's likely to crop up here again is that the panels won't
be properly describable in the DT. Typically there is no device that can
be addressed by the CPU. This is the same as for backlights and fixed
regulators.

Thierry

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQNHEtAAoJEN0jrNd/PrOhUUIQAJDp2eepbgrmwXCTk4WKJ8mS
seP2HOS9qyr4MfJemkP2jTBtFLb0H4xuyT7Npv2AWPsuoRk//ifmfgyOGw7xQabY
tj9e8KmGQIEXx0TTOV0qxP9fo3+A+HS8itYvvc0u8+QmRkmj7Z6eIY7jTXQjVSPe
QcvHQqPcYnIZTfbg1l9GEeXFTJwr7iDlnVMwtttoDkX8rRsj1+YfpMkk4DvkPCwh
vdcTlTIz/0eJnk1sp7MffE1muFGiVy+wOBMnBe6MgQ2gjseh/yPtBlkQa2U6bik2
Usr/+lwZ6MTKYa0VKA4Ct8YvK4Ep15s4rEaO9OUHUBCV4H3KtkOm7YMwNEw2tre4
gYHi+yH3dIm9LgN+e372A6kqquBa553ClqtFfy5yZd1/nVKWEF1VnHnH3arV3vHR
jJsRHajbrE1EZkbdmTV9WdSAZaqru4MWMCGBRVGskviABXboAwlPIU6NVWZspXtn
paLLMzFY0kzNz6WLMSKg9leDoO+2PrPFfUR8RQUpH1uWvGQUiGWbA7KeI8+HPX30
g2WgAKTzql9O6Rkf3H/85LbqM5WOYg9NBn7FsKWNi6yUVLQj4TYio2QDrggl4G7b
pTTKK/gfxfl2pSd7qQBUgvvKhCwkUNwim2asr4iZJ0AomAj5rMRLEedeLHDsRoSQ
mDDcSMWoaaklQj/lcMaQ
=yaLS
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
