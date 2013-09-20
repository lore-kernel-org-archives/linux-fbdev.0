From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Sep 2013 09:03:54 +0000
Subject: Re: [PATCH 1/1] video: grvga: Use module_platform_driver
Message-Id: <523C0F7A.90505@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nqOeX3dpf8Op9bVmoPXXDNAuOS1v1d6Na"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379658938-18080-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1379658938-18080-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--nqOeX3dpf8Op9bVmoPXXDNAuOS1v1d6Na
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/09/13 09:35, Sachin Kamat wrote:
> module_platform_driver removes some boilerplate code and makes
> it simple.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Kristoffer Glembo <kristoffer@gaisler.com>
> ---
>  drivers/video/grvga.c |   14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Thanks, applied for 3.13.

 Tomi



--nqOeX3dpf8Op9bVmoPXXDNAuOS1v1d6Na
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSPA96AAoJEPo9qoy8lh71dycP/0o4oTgjZM6nGj1YzBzOph9Z
awQxSrDgcMutDUEPt+067eTe5VvTw4PPFDjh49q6+ozQttCAFXF3P9+ni3sTRJDD
JWsw08x0ZIpB4dQ9fyTm38+DSppxClITRkpFsu+vM2b6BFE2JaD/pzqyyGpkdFcc
fLQ/XQVhNmMZq9/ueq6fjPEYuK7kXMdpm3lYuf1zwFNcvpa1zGEHWMf3sR6BHbwY
cLV65BNnzae7SfIgTvzKjavquQZsrL9GpD9pSB79h25n3k+NnDvtSfvrA9FTJs/m
i5poDDnIIHn10nID2nwKHy4fehZ1C4+3DLQLO9SI1/k5QiZdAwMP7t3Jf7QipZ9Y
mqlHKRVD+0dooaBdTp6IybqRWOOasMDvxiCROgFv+LaVdaSm4zMsU3bI6CO/Z0nV
e50ig0Q5aq/Pi/UuejJ8fl9y3iGU7JAZ4BGZ+3lBZEocW2UOkT4msuUpfXEKDNig
SvTWJYLcRzYXy/3CMmqMXByv4CI8WsamXjmS16f25wlELXULgkb6B8HSmYuu7Nc+
FUUeVWgpy7boF0euRICbBUU5yFRFg6dmMqz0mI2+cqPmpO/0+Ap+QN+EnZ5YICQq
/3vlLGIu6fdseqrxWlqxWY9QzlbMpvlDmqbpFTaBSULWW5uCBlDi+IeexxLjI+3B
/oxSIkcdPbhPqa1gaRM2
=yHi5
-----END PGP SIGNATURE-----

--nqOeX3dpf8Op9bVmoPXXDNAuOS1v1d6Na--
