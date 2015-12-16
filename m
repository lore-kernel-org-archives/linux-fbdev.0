From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 16 Dec 2015 15:36:04 +0000
Subject: Re: [PATCH 00/23] OMAPDSS: misc patches
Message-Id: <567184E4.4090703@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7JgT6VVStQg2umH2toFwKkUr3o0gFSRGG"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449676791-26304-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449676791-26304-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-fbdev@vger.kernel.org

--7JgT6VVStQg2umH2toFwKkUr3o0gFSRGG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/12/15 22:24, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> Thank you for the patches.
>=20
> On Wednesday 09 December 2015 17:59:28 Tomi Valkeinen wrote:
>> Hi,
>>
>> Here is a pile of smallish patches for omapdss, forward ported from TI=
's
>> product kernel (which means they have had some testing).
>>
>> Many of these patches prepare the omapdss driver for writeback by clea=
ning
>> up writeback related code, and adding bits here and there for register=

>> level writeback support. The patch to add writeback support itself is
>> missing, as it's still not in a stable state.
>=20
> For 1/23, 2/13, 20/23, 21/23 and 23/23,
>=20
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks for the review!

 Tomi


--7JgT6VVStQg2umH2toFwKkUr3o0gFSRGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcYTkAAoJEPo9qoy8lh71XJUP/jjWifE0qz+iwHWI17zYxNmN
Rkj4rgiXH2MrauLuosbT2YFjQ3YLSDyhrWIofVr1+PuVRwbq43DQxDtE1HmbT2YZ
jjqS+29PqihM/xLBn2lL1KtmCbpB4jrL14fR7eGif5HSxcVpFYYNqzVghbjjFIB0
cbWPjso1ivUnejpHt4yqw85A/RiCe4iPmX5JqDm2oxeA9kj8Cn2C3KINCBcPOfcQ
CSbjA1ilrI+HEHIrRm1LAtbgVMHz94g3KfVwS/8hWqZ4IEvGGTE+P7NEdWIXUQ/F
Av/7Pxv6QPcBvrNCb+G8LCHz7rPjeFeuIcZ+/hZ40+zKbRCJFGDXgceKJdg+GMyb
S8Jxf7gkgmO5Ol43+tRtK0zqg7Asx5ay9jaxXgm5f2SGcadWVFsjbUQ3XpCOWNF6
IeheSBsUHSpAAU/5hd/V2E3RNGLgkXxnL0ptgQ2GEwpM8u2uMzw7rmm+BB6LC6cK
tAh+kdFOATn+AR/MpMl0juZsK/vdl/5RITQdhzIJfXCZFu5FYabQaQFCk9UGb8/g
4Mo+JRtB+ipC6gwSLTWq+rO06y/x+HwNb5f70X1Tji1Psa+fsRb0Snz241RiCWHJ
hbX6R42/8PUBAiOe3BNvenjzucYetkmpWpDJpnAGNwQAr8DPhZ5Xj3WCvApceN4M
TxGIhFdvdShMJaOhcz6A
=FOpm
-----END PGP SIGNATURE-----

--7JgT6VVStQg2umH2toFwKkUr3o0gFSRGG--
