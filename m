From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 27 Aug 2018 10:04:48 +0000
Subject: Re: [PATCH V5 4/8] backlight: qcom-wled: Rename PM8941* to WLED3
Message-Id: <20180827100448.GF31905@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="m1UC1K4AOz1Ywdkx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-5-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1535106467-17843-5-git-send-email-kgunda@codeaurora.org>
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, daniel.thompson@linaro.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, lee.jones@linaro.org, linux-leds@vger.kernel.org


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-08-24 15:57:43, Kiran Gunda wrote:
> Rename the PM8941* references as WLED3 to make the driver
> generic and have WLED support for other PMICs. Also rename
> "i_boost_limit" and "i_limit" variables to "boost_i_limit"
> and "string_i_limit" respectively to resemble the corresponding
> register names.

Acked-by: Pavel Machek <pavel@ucw.cz>

> -MODULE_DESCRIPTION("pm8941 wled driver");
> +MODULE_DESCRIPTION("Qualcomm WLED driver");

"... supporting pm8941, xxx devices" ?

>  MODULE_LICENSE("GPL v2");

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluDzMAACgkQMOfwapXb+vIxDwCfSZHys4+U14pB3RnG3eNhcldU
BM4Anj4olAVu0Y51Le9DlFhi+s6FAJOG
=jfYa
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
