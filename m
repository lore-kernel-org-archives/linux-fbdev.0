From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 20 Jul 2018 21:21:29 +0000
Subject: Re: [PATCH V4 6/8] backlight: qcom-wled: Add support for WLED4 peripheral
Message-Id: <20180720212128.GA13883@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-7-git-send-email-kgunda@codeaurora.org>
 <e5bdf2fe-321a-f2e5-22f5-c886f019ac1a@linaro.org>
In-Reply-To: <e5bdf2fe-321a-f2e5-22f5-c886f019ac1a@linaro.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Kiran Gunda <kgunda@codeaurora.org>, bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >@@ -332,6 +529,7 @@ static u32 wled_values(const struct wled_var_cfg *cf=
g, u32 idx)
> >  }
> >  #define	WLED3	3
> >+#define	WLED4	4
>=20
> Are these macros always going to define 3 to be 3 and 4 to be 4. If so we
> probably don't need them (and they should be removed from patch 5/8 too).
>=20
> There is a degree of nitpicking here however. The rest looks OK to me.

Really nitpicking, and I don't care much either way, but as natural
numbering would be 0-based, I'd keep the defines.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltSUlgACgkQMOfwapXb+vKc9wCgl+DW32Mu1D+P2T/k85doKKNP
auoAn2rci/ZciPj1uUoVBrhTrw4JuCcw
=H4GY
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
