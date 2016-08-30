From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Aug 2016 09:04:58 +0000
Subject: Re: [PATCH -next] video: fbdev: pxafb: add missing of_node_put() in of_get_pxafb_mode_info()
Message-Id: <fe7f9f67-2b8a-f72a-8d74-a36739c17b6d@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DAUlX7xg2dPXiCUnCkEC6W5oMKIkVh9Ku"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471078643-4815-1-git-send-email-weiyj.lk@gmail.com>
In-Reply-To: <1471078643-4815-1-git-send-email-weiyj.lk@gmail.com>
To: linux-fbdev@vger.kernel.org

--DAUlX7xg2dPXiCUnCkEC6W5oMKIkVh9Ku
Content-Type: multipart/mixed; boundary="ARAttTbvi6VotPG6BJHla8mSmsuX4eqxG";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Wei Yongjun <weiyj.lk@gmail.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Ingo Molnar <mingo@kernel.org>,
 "Luis R. Rodriguez" <mcgrof@suse.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-fbdev@vger.kernel.org
Message-ID: <fe7f9f67-2b8a-f72a-8d74-a36739c17b6d@ti.com>
Subject: Re: [PATCH -next] video: fbdev: pxafb: add missing of_node_put() in
 of_get_pxafb_mode_info()
References: <1471078643-4815-1-git-send-email-weiyj.lk@gmail.com>
In-Reply-To: <1471078643-4815-1-git-send-email-weiyj.lk@gmail.com>

--ARAttTbvi6VotPG6BJHla8mSmsuX4eqxG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/08/16 11:57, Wei Yongjun wrote:
> This node pointer is returned by of_graph_get_next_endpoint() with
> refcount incremented in this function. of_node_put() on it before
> exitting this function.
>=20
> Found by Coccinelle.
>=20
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/video/fbdev/pxafb.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index ed41fdb..ef73f14 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -2186,6 +2186,7 @@ static int of_get_pxafb_mode_info(struct device *=
dev,
>  	ret =3D of_property_read_u32(np, "bus-width", &bus_width);
>  	if (ret) {
>  		dev_err(dev, "no bus-width specified: %d\n", ret);
> +		of_node_put(np);
>  		return ret;
>  	}
>=20

Thanks, queued for 4.9.

 Tomi


--ARAttTbvi6VotPG6BJHla8mSmsuX4eqxG--

--DAUlX7xg2dPXiCUnCkEC6W5oMKIkVh9Ku
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxUw6AAoJEPo9qoy8lh71RPIP/iQlZ2joRAPg6xNTErUXHDjR
KYUmMG8RPYe0S32orWTqyLjwzFbYlgVlN9fHaACsltONLI8U+orhrDH2eP96HnUJ
qyTDGS3X/ZUyDxP2GBiuFAuC12h+ZdtPsEFD+DOD+RUrDrRrxqjLP5Vio5aDHG5o
Slg0pJDzpdZPS2cnEZXif0vE1zvuiok4b+AOfVP1k+pY+scW9D5dOC3islP8RzYM
3sZBAQAgtmuk5vE2bk1eVoijh9ngJ8AFJK31V9f95yrPmscf18ljnmgIqojdA6FB
iF7h9MSqjHGyD1vn0dYWySEXA3YwPI9LtpdU82kxuM+dffvFrF6GPiLoUQ42Mnk5
+5B3WVil8i9n0CS2K7ZLMR+Aicq6Bbff7X6lu/gGZV12ClNP91O9e+8Q87qvR0g8
pyZRUflbkAemwIUT/eJwIscz3u4cLy/wRpAg3AvXMzJEvyd2hUvfceeaDWsYjXV7
MTEbAORdB73wsKsNioJApuBB4jfBzJW+A7gxdanoAH9C5sFXw5PFEZyR1/pZUNZp
gfT6Byqqy5wYCPO8WC6/3ZD3qZRYFg6LDDqbDwpHegxPWXf65KarX42r61ecy7uH
tzzqvW3Cp605IRsbdSkKZprVSvjOc0Nnc2NhCInN6XaZVkjJvdGPSf8ycclvObDV
dNE4x4UnWTbQSDznkgUz
=Pflc
-----END PGP SIGNATURE-----

--DAUlX7xg2dPXiCUnCkEC6W5oMKIkVh9Ku--
