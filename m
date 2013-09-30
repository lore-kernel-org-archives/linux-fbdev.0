From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 30 Sep 2013 07:52:00 +0000
Subject: Re: [PATCH 00/10] Convert to module_platform_driver() in video driver
Message-Id: <52492DA0.90903@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xtBIB3NK8EeJJqIJHJWChCXLu5qKcJQmO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380432730-7263-1-git-send-email-hanjun.guo@linaro.org>
In-Reply-To: <1380432730-7263-1-git-send-email-hanjun.guo@linaro.org>
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org

--xtBIB3NK8EeJJqIJHJWChCXLu5qKcJQmO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 29/09/13 08:32, Hanjun Guo wrote:
> This patch set just did one simple thing: convert to module_platform_dr=
iver()
> in video driver to simplify the code.
>=20
> Hanjun Guo (10):
>   Video / hecubafb: Use module_platform_driver() to simplify code
>   Video / bfin-t350mcqb-fb: Use module_platform_driver() to simplify
>     code
>   Video / metronomefb: Use module_platform_driver() to simplify code
>   Video / jz4740_fb: Use module_platform_driver() to simplify code
>   Video / da8xx-fb: Use module_platform_driver() to simplify code
>   Video / cobalt_lcdfb: Use module_platform_driver() to simplify code
>   Video / broadsheetfb: Use module_platform_driver() to simplify code
>   Video / bf54x-lq043fb: Use module_platform_driver() to simplify code
>   Video / au1200fb: Use module_platform_driver() to simplify code
>   Video / au1100fb: Use module_platform_driver() to simplify code
>=20
>  drivers/video/au1100fb.c         |   14 +-------------
>  drivers/video/au1200fb.c         |   16 +---------------
>  drivers/video/bf54x-lq043fb.c    |   14 +-------------
>  drivers/video/bfin-t350mcqb-fb.c |   14 +-------------
>  drivers/video/broadsheetfb.c     |   14 +-------------
>  drivers/video/cobalt_lcdfb.c     |   14 +-------------
>  drivers/video/da8xx-fb.c         |   14 +-------------
>  drivers/video/hecubafb.c         |   14 +-------------
>  drivers/video/jz4740_fb.c        |   13 +------------
>  drivers/video/metronomefb.c      |   14 +-------------
>  10 files changed, 10 insertions(+), 131 deletions(-)

Thanks, queuing for 3.13.

 Tomi




--xtBIB3NK8EeJJqIJHJWChCXLu5qKcJQmO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSSS2jAAoJEPo9qoy8lh71CZIQAKyaXyrMz4quQcXi6rIb7OH+
ZBirTFOYbzHJkAOS0FE5tAjPqx3v2oO87VHS37/Wh2ZUosNij0/7XJoA9w4qHvXS
FlW1UpUUtz/9mgQhEzO+ykNiMsyCq+iqz1YrYr+AQp2MdiNdAiFXEDcNPsMvXwhZ
KGixdxBhRyOJ+GuCET5RUZlkdGL4PsP1ApzgiMr1QjAFB8mZ07tOfCrk0xukTJ2n
3J859KKwEk8VLZqmaEAUAwokcFo3tUc1PPsC/fxufqRsRDyifIg+hK7ew8D6A5Uf
gaVwR4HaHKYbhoxfHCyFWpfdNspcqkKRtbwbZxhbAICrGWWMECgnz/cyrUtP6ouP
nJUqysA37ixSsNh6BGR90xmEw2zdvgu4bdGdWhk8kzEh0OjvnMbsQpQZiu4rS2t1
YUofr8Yo5b1yqUFKUGQPLnOe4B4H6YhU/Mf1N6EcAQbdqt88Gmy8Q4zKwFw0+4Z/
DhpyfftW0KqLJCv/NEnEo3IHrvoFX86SDFpna+HXr1Ysnpj5o9ejfiQ7n+fVgUHy
ZUUIny2K2TAE8pUizrOW8s201vJZd1DKY65yR2O0qi0/DQ0jlkge7LQX2h0fpO89
FFzkcjlYwFv+UppW1b3HLcutaxaU9cTF13sCx9qbP58vrwMqp8f6hvFlgX6UbbSj
v3YyCCjg+y8h1hHVjXTG
=qVA9
-----END PGP SIGNATURE-----

--xtBIB3NK8EeJJqIJHJWChCXLu5qKcJQmO--
