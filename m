From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Aug 2016 08:37:43 +0000
Subject: Re: [PATCH -next] video: ARM CLCD: fix return value check in versatile_clcd_init_panel()
Message-Id: <f8e2377e-f078-3c9a-29fb-b5b45cf8f415@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CV8TktSOtWQCuQWSLHnw09lAGH1urRJG2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471051586-26189-1-git-send-email-weiyj.lk@gmail.com>
In-Reply-To: <1471051586-26189-1-git-send-email-weiyj.lk@gmail.com>
To: linux-fbdev@vger.kernel.org

--CV8TktSOtWQCuQWSLHnw09lAGH1urRJG2
Content-Type: multipart/mixed; boundary="SqJKiUCqhuiegIkkRHeTN10N5a2jdt8Om";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Wei Yongjun <weiyj.lk@gmail.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Linus Walleij <linus.walleij@linaro.org>, "Luis R. Rodriguez"
 <mcgrof@suse.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-fbdev@vger.kernel.org
Message-ID: <f8e2377e-f078-3c9a-29fb-b5b45cf8f415@ti.com>
Subject: Re: [PATCH -next] video: ARM CLCD: fix return value check in
 versatile_clcd_init_panel()
References: <1471051586-26189-1-git-send-email-weiyj.lk@gmail.com>
In-Reply-To: <1471051586-26189-1-git-send-email-weiyj.lk@gmail.com>

--SqJKiUCqhuiegIkkRHeTN10N5a2jdt8Om
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13/08/16 04:26, Wei Yongjun wrote:
> In case of error, the function syscon_node_to_regmap() returns ERR_PTR(=
)
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>=20
> Fixes: 25348160e9a4 ("video: ARM CLCD: add special panel hook for Versa=
tiles")
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/video/fbdev/amba-clcd-versatile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/=
fbdev/amba-clcd-versatile.c
> index 9a90817..56161f9 100644
> --- a/drivers/video/fbdev/amba-clcd-versatile.c
> +++ b/drivers/video/fbdev/amba-clcd-versatile.c
> @@ -528,9 +528,9 @@ int versatile_clcd_init_panel(struct clcd_fb *fb,
>  	versatile_clcd_type =3D (enum versatile_clcd)clcd_id->data;
> =20
>  	map =3D syscon_node_to_regmap(np);
> -	if (!map) {
> +	if (IS_ERR(map)) {
>  		dev_err(dev, "no Versatile syscon regmap\n");
> -		return -ENODEV;
> +		return PTR_ERR(map);
>  	}
> =20
>  	switch (versatile_clcd_type) {
>=20

Thanks, queued for v4.9.

 Tomi


--SqJKiUCqhuiegIkkRHeTN10N5a2jdt8Om--

--CV8TktSOtWQCuQWSLHnw09lAGH1urRJG2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxUXXAAoJEPo9qoy8lh71pMwP/329m4oaz9xOFwxfcQ3RSAKE
QOsV6tIFa+K7FyjcpdozuoMKtzUOfQc8tn5goGG13t0oHGVxH+JtDMIt893o8I/T
AmqIvns6WZ74pirN452rh849sAHzmwGnioi2tcuW4z10ef+XVQYxGjFPVxdgW1mt
Bh0Wv6fyTb88fRl8gF/LsqTesu7cU/zRh9bevSeNp8AHEUflqPY+aJmY3MgHaapl
u5lSHEOgPMP5MITLPYJeQtEp16+XRnj2Q/9Q2HQ9dEPVl8WpqxQVZw6EGyxOhyUd
kLZDZFNmHa/Tcg7sBnxkS+IA4uXsbIlQb7bbdti3iW/VtLDr9IKJhecepHTPaDeI
wGIlZY4UqGyP/Ezgksae2NSsX/MEi0tBxBpLJtGRQWyJ/eSazCUhPQOFVNLCbmEP
rcu1sqwnpKg/s99IEc5dN0RtHuMxUWR1RldowuRO7WbCqEM05GblPm4/sGHHqy2y
nXZ72fWma+aiHjl5bSEzryN3yLF6oHlD+zNw4T6/dPriRKD1+H3aGbKrcSTUgMR+
VZW80s4EMb1He9W7IkNog+jK2ATnzWZc6WsPkvqy14v9k7KzHL6Jq2mdbKniZoH+
kI3kfWGM5FIS6orsig2AUHfvWudO/c8t0/3vZJWCQWReKVsrwDOLZedkkelpPz5G
qTI/KUR6hiTT2y8rwoZt
=MrLe
-----END PGP SIGNATURE-----

--CV8TktSOtWQCuQWSLHnw09lAGH1urRJG2--
