From: Pekka Paalanen <ppaalanen@gmail.com>
Date: Thu, 04 Jun 2020 08:22:34 +0000
Subject: Re: [PATCH] fbdev: geocode: Add the missed pci_disable_device() for gx1fb_map_video_memory()
Message-Id: <20200604112234.7d840c15@eldfell.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/7zGwgSlxxHt_4_lufD_uPZr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200603092547.1424428-1-hslester96@gmail.com>
In-Reply-To: <20200603092547.1424428-1-hslester96@gmail.com>
To: Chuhong Yuan <hslester96@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-geode@lists.infradead.org, Andres Salomon <dilinger@queued.net>, David Vrabel <dvrabel@arcom.com>, Adrian Bunk <bunk@stusta.de>

--Sig_/7zGwgSlxxHt_4_lufD_uPZr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  3 Jun 2020 17:25:47 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Although gx1fb_probe() has handled the failure of gx1fb_map_video_memory()
> partly, it does not call pci_disable_device() as gx1fb_map_video_memory()
> calls pci_enable_device().
> Add the missed function call to fix the bug.
>=20
> Fixes: 53eed4ec8bcd ("[PATCH] fbdev: geode updates]")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/video/fbdev/geode/gx1fb_core.c | 37 ++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 11 deletions(-)

Hi,

there is a typo in the patch subject, the driver seems to be called
geode, not geocode.


Thanks,
pq

--Sig_/7zGwgSlxxHt_4_lufD_uPZr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl7Yr0sACgkQI1/ltBGq
qqfEDw/+KLMc9/wo+jXiWAnLH7DQ87u0JEDybMYKFKx6EpC9KBlSApWcagjDaiw7
Swy6OTzovGayh7moGisYDCTSsXsG0KyA3AmGbOhTDSjIyWYb+HPPAI9X10yMmwvo
ql4+Jl5NF5ClfmQl3FAQKcrsdcUiTMJCu9rUBtaZG4RhTS/IV8Ou78BymOtzHSU3
0W/IeutQWwjH3txsdthOe4O2mkJy3DCok0jxn76VsivoifPKxRbia8O7NH+UbFP6
7p164/E4mVaTIHzFfqvvPqfZrh4w5k6meQHRy+9TC5AE46vADO/L7wcrghqrj0dK
wXc6i16+04wreh1cQLK/37V3SGYLhILjvK+K/ERvr1utyGUoPu3pmf67qugwxSoj
RfxWJj3yMnba/H7rCVXUKak5DtMixvtLlgwWg9JM0k453H8Ma4+pPPnEs5LrVVuw
ANeolbROqLp7EDQ4nFSgLY3Jac2QH3uiUg/KyB+MMbA8HyTqHEyfPXoFQWFeEGdW
c+ZPkw+f7QOYDOxGMmMKiZb6Vut5lNbfpSOIsleOeMbeifx2xtDK8IKV5gSfeFlI
kueD9zp8FjwMZ4wDRYXpW+l8y3EQj1Dt0GDuw6f9K5Xo2a7s89jMY+2K+qJX9y5m
oa24nht3w0fptulkyk4NPiuZVMXe6s8fZ/Fwf5M5W/Dd6Ii/dEE=
=W7Eg
-----END PGP SIGNATURE-----

--Sig_/7zGwgSlxxHt_4_lufD_uPZr--
