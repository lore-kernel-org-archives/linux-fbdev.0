From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Jan 2015 07:54:30 +0000
Subject: Re: [PATCH v2] video: fbdev: fix sys_copyarea
Message-Id: <54CB38B6.3010202@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cut5KCQ2F0ktVoMK5qat9wchFBlw3GDHl"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421889589-16362-1-git-send-email-mans@mansr.com>
In-Reply-To: <1421889589-16362-1-git-send-email-mans@mansr.com>
To: Mans Rullgard <mans@mansr.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--cut5KCQ2F0ktVoMK5qat9wchFBlw3GDHl
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 22/01/15 03:19, Mans Rullgard wrote:
> The sys_copyarea() function performs the same operation as
> cfb_copyarea() but using normal memory access instead of I/O
> accessors.  Since the introduction of sys_copyarea(), there
> have been two fixes to cfb_copyarea():
>=20
> - 00a9d699 ("framebuffer: fix cfb_copyarea")
> - 5b789da8 ("framebuffer: fix screen corruption when copying")
>=20
> This patch incorporates the fixes into sys_copyarea() as well.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> Changed in v2:
>  - Fixed wrong first/last calculation in bitcpy_rev()
> ---
>  drivers/video/fbdev/core/syscopyarea.c | 137 ++++++++++++++++---------=
--------
>  1 file changed, 65 insertions(+), 72 deletions(-)

Thanks, queued for 3.20.

This makes me wonder, though, if the sys and cfb versions could be
somehow combined...

 Tomi



--cut5KCQ2F0ktVoMK5qat9wchFBlw3GDHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyzi2AAoJEPo9qoy8lh71jugP/iAieYeB8kSLDwQczrIF237/
HhMrrLyHCWICF/L6qGej8QonOQSJln5DAeQCxXIUFfUS/3/BD5JlUCzYUpOn4rZI
IQg5oIEvn5DGdbHieUuHBb/URLw1EQlH0EioJQw1nrrvHNITX7PWXwn2wexwZ6Hp
2q/CZrUau6/B1yo4u1XXVgNfizpZrQAu27Nb5swpJg14au+YDgc4G61GAiKQ8grd
cL22dJJDUSkOA8xNcGWDY4JOrj91XEqltI9PlmFj/fy0qinAmssc379yZeIDMhoV
W/aV6I6WAK55ZIqC+y3MWgRQA4RQem7ago2vDDHDCf50BwEtFHFkuY/clWzEpmSe
dt46UDhWOoW/0rrwfVOi/qWDndIgjHDxkR06+6rJWVASOEDj88CH8Ibz8/jn1RLu
iNqK9W2YmMEZ5DGC5RwNONM6c4GbWlfRlaYCn7hOP7zApaq9lhhcTPhCkudTu2DY
xl4FAqWlj2lVZRGQxIfP8SkH20EcgksSqXG1To0yu1d8OJ3LYbulByto/fRe2HWd
HgG6DP5u7L7hwJqdEprUE/A3kOD5Js686p3RKDramV9YTS+lwMwivDPFgpfv3tvY
qJKIUcMwBNU1s5E8AGgoIAX2wQJ4laTBZM9jKEFo8XPp8wMivjSzZ+U+5S4UO+6w
j+B33VjzriZY5KHfNRkB
=tO3j
-----END PGP SIGNATURE-----

--cut5KCQ2F0ktVoMK5qat9wchFBlw3GDHl--
