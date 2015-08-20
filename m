From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Aug 2015 07:56:26 +0000
Subject: Re: [PATCH] fbdev: remove unnecessary memset in vfb
Message-Id: <55D5882A.7080202@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ARXSLT2wB99UFEmuqxUxb1tWwDp35T9ta"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434632512-128161-1-git-send-email-marcinch7@gmail.com>
In-Reply-To: <1434632512-128161-1-git-send-email-marcinch7@gmail.com>
To: Marcin Chojnacki <marcinch7@gmail.com>, plagnioj@jcrosoft.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--ARXSLT2wB99UFEmuqxUxb1tWwDp35T9ta
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 18/06/15 16:01, Marcin Chojnacki wrote:
> In vfb_probe memory is allocated using rvmalloc which automatically
> sets the allocated memory to zero. This patch removes the second
> unnecessary memset in vfb_probe.
>=20
> Signed-off-by: Marcin Chojnacki <marcinch7@gmail.com>
> ---
>  drivers/video/fbdev/vfb.c | 8 --------
>  1 file changed, 8 deletions(-)

Thanks, queued for 4.3.

 Tomi


--ARXSLT2wB99UFEmuqxUxb1tWwDp35T9ta
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1YgqAAoJEPo9qoy8lh712nUP/2g15cDiUYd4c34xtxjQQjCn
8oQrqZ3ciZmo/4wq0HVgQANhEYq3W9olsI/wmgOLb4nNAygnj1Qvkd6QTm1r6/ZL
F9HzuQoqH0dXMRcCkkZSJtET26W5anEgiUHqkbXGfiUoKotbEUxCpz/XxuApBlQ+
07AI1JSQ+sR2EZAHCjT2CflX2rlXqGkXLdmAZ57VRC2HHsb6vb7WowVKPbl97GlF
TGzVOEw7ZxW4b81/pFSBG6OYiYLcVoe93quYFBe6blN4FNBUgTWSSQzbGJB4Vks6
TRApWlgM0ptUVmzSzfoccEFu4Im8KiqzAhY+mzcjQK6w5GqlpQlYZYGe+JBYPYSc
HGwVfd8SbJUB17r+yxAthyHOulE/WnmK/xq+bxHEJYSl+9LhrAZ0zSEctPMLI7Wy
A5nBe7jZwLDx/6WlkLd/IlrFxg3EK/h/2Px3MTJrhMNVA1AqCAluSJed06+0AEza
1GcF8nMBUOZyF4piZBZd0y9PUK5hM+kHtpb1LpCdhqIX3gloWjMbyu7/ARsrYges
eSW9u7otx3u1Dc3AymRGI1yc09BPJfsDMNm4vvcXlD+VmhW1/qP4HjvOzb77ID1i
00oNPIHs6YWo8Ot43TVRfiu3/JdDKW4FVKwXfamtvmHImuMxkRMD0EPGlJMigj+s
VFxZr/XoSFbeudtAaRBx
=TcrX
-----END PGP SIGNATURE-----

--ARXSLT2wB99UFEmuqxUxb1tWwDp35T9ta--
