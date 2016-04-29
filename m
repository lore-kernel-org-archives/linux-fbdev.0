From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 29 Apr 2016 10:53:30 +0000
Subject: Re: [PATCH] video: fbdev: omap2: Remove deprecated regulator_can_change_voltage() usage
Message-Id: <57233D2A.5000100@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JORHPl58Du2D0fuJVcp8lJxpXJ89vDgsL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461848183-3634-1-git-send-email-peter.ujfalusi@ti.com>
In-Reply-To: <1461848183-3634-1-git-send-email-peter.ujfalusi@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, plagnioj@jcrosoft.com, laurent.pinchart@ideasonboard.com
Cc: robdclark@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--JORHPl58Du2D0fuJVcp8lJxpXJ89vDgsL
Content-Type: multipart/mixed; boundary="0Ampo0rSf4TX5xRG2Pt5fjTEJnstwVClu"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, plagnioj@jcrosoft.com,
 laurent.pinchart@ideasonboard.com
Cc: robdclark@gmail.com, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <57233D2A.5000100@ti.com>
Subject: Re: [PATCH] video: fbdev: omap2: Remove deprecated
 regulator_can_change_voltage() usage
References: <1461848183-3634-1-git-send-email-peter.ujfalusi@ti.com>
In-Reply-To: <1461848183-3634-1-git-send-email-peter.ujfalusi@ti.com>

--0Ampo0rSf4TX5xRG2Pt5fjTEJnstwVClu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 28/04/16 15:56, Peter Ujfalusi wrote:
> regulator_can_change_voltage() is deprecated and it's use is not necess=
ary
> as commit:
> 6a0028b3dd67b regulator: Deprecate regulator_can_change_voltage()
> describers it clearly.
> As there is no practical use of it it can be removed.
> At this point the regulator_set_voltage() calls can not be removed as t=
he
> DT data need to be fixed first.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/video/fbdev/omap2/omapfb/dss/dsi.c   | 12 +++++-------
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c | 12 +++++-------
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c | 12 +++++-------
>  3 files changed, 15 insertions(+), 21 deletions(-)

Thanks, queued for 4.7.

 Tomi


--0Ampo0rSf4TX5xRG2Pt5fjTEJnstwVClu--

--JORHPl58Du2D0fuJVcp8lJxpXJ89vDgsL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXIz0qAAoJEPo9qoy8lh71QAMP/Alon7H7ktVxktihPhDxTJ3Y
CyR5xzxpCk/rs8yYrkR5s3iuoZWLOPhSlEV7ai610JwGQav7+AJI56ka9BIsWX3N
VUEYhxphbycQV43N3rdllH2uXKNQTZgn2LzFOls5DJZtxweFlvRxZPwqqBixH4LL
0cfTB3wWXQab/yrsBbqtzbiBGQ782W9ntWPqXxrUNZkop/O1wSST9NbwEm+/eT4s
dfewNjh1f+G4hJzgfM2NNnZUjGds1s58Inx3bJRMpyZmWm+EHIA5/5+Au6ZTjGVV
TqFwfEznmD6weyrmR/gf24FJsgsGnkeLhV4fUDOD8Zu+reORFxb2nbRXSME97Jvd
5zm7q+3/qllpgfXuYHluOnQ9yQu8a++l6oEBoerk/CpLRPFgF2GAXL0lMSo2vlGV
5+5zYKtNYLeaK9uEMkuHEcrgp/5yNk4a0pwlJ5SkUVCKd+Kr1uwvzmcU4IQGMKo1
MfM/ZCA8Zy0VhipvoezBDgk5+hY8BzPvF1rbJ7ZR63suhKMQbdYPVUlDbsjmrZ9h
uc6Xpca6QMadEd6EUsUPYq+O8GwCne7chiQW0DGCk3DhRPMCZegbUb5L2iSbtcej
m8AmcbEz/pUvUsQrPdrtDr26Mt0Go9X9YVBFJGrXOExtQSUfArsjcwM66+kiikaj
fTg3xiEVvhCCOMoMCHHm
=S8bj
-----END PGP SIGNATURE-----

--JORHPl58Du2D0fuJVcp8lJxpXJ89vDgsL--
