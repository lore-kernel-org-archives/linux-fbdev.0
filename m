From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 30 Jan 2013 07:58:36 +0000
Subject: Re: [PATCH] pwm-backlight: handle BL_CORE_FBBLANK state
Message-Id: <20130130075835.GA13543@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359526755-21145-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1359526755-21145-1-git-send-email-acourbot@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, gnurou@gmail.com


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2013 at 03:19:15PM +0900, Alexandre Courbot wrote:
> According to include/linux/backlight.h, the fb_blank field is to be
> removed and blank status should preferably be set by setting the
> BL_CORE_FBBLANK bit of the state field. This patch ensures this
> condition is also taken into account when updating the backlight state.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRCNKrAAoJEN0jrNd/PrOhSOkQAKDVZHTAUGff58w9kY4q4fm7
VXs1MT1VQ/nNYYmlPwtjM7fGVph/hbfqSdskvUw49mNlHEwP9XCP94A52Bjm1tSF
0+YAJQspME5AGlx7RROqFu967P9T34UBqGk0YlcXw0B+AH1hc6cpfo18xTZbMpCv
r97O6QkO968ps9agcrUk0Ohm7nH5OMt8a/IXLjUmq7MU/cN6UDGengQlmYT4znvz
+GfbXnHC3OL+N6n9i8PXZtjTfd11+dQmWzhTbw9g0E+uVHjVBpBJypDKs9vG1YaR
WB0xTlLU1w2sBOADghF8WMh8SZE6TIQPAygXdOxtAjo3MrTf5fj8VkwXOaIILFAt
+pneJiGavmJSRVRf1xedHBxgkfeHB/nFeIYkpuWGQhxlc0Gv09kZw2oTSy1FKXht
DYFtGP/MZCPg6aUfap5loLNTigK72RVzFXoEN0ImdOg/27VYTUbvCbKfPp53ZRWr
7rhcP4XIhB2AkhY9iwFxx8vY3pJKVSHPEYkYpNeo0/Km5S3zvn8Vb++4fx8Ey/Km
5jJOTuidQYNUT8tD8AYoEfyx+RIvy6Ox4fDkhw2qUbFInceE32noum+V7VcUMR/8
PWQFh3WY+iZwyuktCmM9pwAd4vH7C70oykir0SLhNH2IzAT2A3fOZCyzyAsCj66x
gpmt+IMHwq3qYm17cr3W
=kVbD
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
