From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 10 May 2018 11:10:16 +0000
Subject: Re: [PATCH V1 1/5] qcom: wled: Rename pm8941-wled.c to qcom-wled.c
Message-Id: <20180510111015.GB6977@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ftEhullJWpWg/VHq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-2-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1525341432-15818-2-git-send-email-kgunda@codeaurora.org>
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: bjorn.andersson@linaro.org, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-05-03 15:27:08, Kiran Gunda wrote:
> pm8941-wled.c driver is supporting the WLED peripheral
> on pm8941. Rename it to qcom-wled.c so that it can support
> WLED on multiple PMICs.
>=20
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr0KJcACgkQMOfwapXb+vIBCACfdU/BG35pa+jbxl1zQluwZJYV
gl0AnA5DIMfp+UoE3Dv076pGtMJ/sJIv
=LDbK
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
