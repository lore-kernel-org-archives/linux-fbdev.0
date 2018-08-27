From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 27 Aug 2018 09:49:42 +0000
Subject: Re: [PATCH V5 1/8] backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
Message-Id: <20180827094942.GC31905@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0vzXIDBeUiKkjNJl"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-2-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1535106467-17843-2-git-send-email-kgunda@codeaurora.org>
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-08-24 15:57:40, Kiran Gunda wrote:
> pm8941-wled.c driver is supporting the WLED peripheral
> on pm8941. Rename it to qcom-wled.c so that it can support
> WLED on multiple PMICs.
>=20
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluDyTYACgkQMOfwapXb+vKHhgCeMpcjzzRmYUR+qKOubQZk79MN
twsAnj71ap1/mc79IShd39VHPOuO+lpm
=rNK8
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
