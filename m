From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 13 Jan 2015 11:31:10 +0000
Subject: Re: [PATCH] fbdev: geocode: remove unneeded NULL check
Message-Id: <54B501FE.1010006@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QXL71rawlXQK1KKngNHHEsiA3aooWl3cs"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420548302-11489-1-git-send-email-sudipm.mukherjee@gmail.com> <1420548302-11489-2-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1420548302-11489-2-git-send-email-sudipm.mukherjee@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--QXL71rawlXQK1KKngNHHEsiA3aooWl3cs
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/01/15 14:45, Sudip Mukherjee wrote:
> the check for info is not required as we are checking it immediately
> after gxfb_init_fbinfo() and lxfb_init_fbinfo() and returnig -ENOMEM
> if it is NULL.
>=20
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
> Hi Tomi,
> This patch is similar to my last patch which you have already queued
> for 3.20. if you can revert that then i can send you a single patch
> with all these three changes together.

No need for that, two separate patches is fine. So queued for 3.20.

 Tomi



--QXL71rawlXQK1KKngNHHEsiA3aooWl3cs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtQH+AAoJEPo9qoy8lh715w8P/Rlcu9kJmuJsT9EXKnHjtmFh
XJDrRSeIP/bceY+SDbeND7/uxcBBHPnek3v4/VNlGesLLvB15PWVU9hXvz/bH43W
Dd8OP7f5KXpWvpw3uXDl/WZlhnrPqV42VT7IQe4+hSQqkPhjlTxhrbAmpGtMz0rA
FUmk9AHy66kKPtH8zG6aiFXJF+b66DfwoaijM4s/hLs1fsT2PhmomTGIyO7B+cHN
ZTibDavJB8eYglTvbSVy+mLgG9UaT4aDgd2OBu5PiqV76jHpAIIJd1vt2CLm7Br2
OsLEeqiLJkio/Fk7Wmybw4l8dgpbUfnIJOPij4EupiLqnZJUzU6KUH/onUxsgIWa
2jn4AuktdMsYFRjUIoi2ANpz7PrVP6rx098VZumAQju1ACfv1/KL5KEjhpfcQE4K
yV6AvhO8lgvibfNx08HbeG464mUTy08PydOu4CZGPfMqZplq3QmfM7H0hecDkswi
p5IDtHg/sRQWRlOnHWKkcEqhc2NTwGWvwlw0rUdNE+sA65kvd5aInh6Vzr1GrcwP
59H77IN1YePrc0QylelEIJynwGPOraEWiBj3oJNRNUjiet8l6Ht3JyfSMdaCZOgw
/90sL2uAyt+3oz85V91sXpygeqkrahV83pRDaLgWKmF66m16OG8S0q7AqurEJwtl
Qw3PnXwtt/KJIl+sufp4
=OPmz
-----END PGP SIGNATURE-----

--QXL71rawlXQK1KKngNHHEsiA3aooWl3cs--
