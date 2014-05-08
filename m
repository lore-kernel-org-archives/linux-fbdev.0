From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 May 2014 10:47:19 +0000
Subject: Re: [PATCH v2] video: mx3fb: Add backlight support
Message-Id: <536B60B7.10304@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8OidD1nqRpVuJku413rV0aUTs0CngQ3Sc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1399273010-24706-1-git-send-email-alexander.stein@systec-electronic.com>
In-Reply-To: <1399273010-24706-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-fbdev@vger.kernel.org

--8OidD1nqRpVuJku413rV0aUTs0CngQ3Sc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/05/14 09:56, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---

Please always have a commit description, even if it's more or less the
same as the subject.

Is the backlight PWM hardware part of the display hardware on mx3fb? If
so, I guess it's ok to have the backlight in the fb driver, as you're
doing here.

 Tomi



--8OidD1nqRpVuJku413rV0aUTs0CngQ3Sc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTa2C3AAoJEPo9qoy8lh71/XYP/0z3PmK+X4SeOc9p27cDgvyn
mDDZSefqssw4pgq/iHJZJudEspvFOe5h18bAfMFXfgl1vQLzn2BRxuKRo6IL8Vid
38JIVaj8+ZyGfAZZaY772CcEBN0p1Aw5NOzVICvUh4ugQoh7hBRPDkdTAxBGPrdD
hRQZhoD1imotjVRAO37yltn3AFuFA09VAHrmM40tmbMSZqjD11CLyfjLDwefQI3F
MAkGdb3w/LTsN0wzDzTaW5AN8xZvfPbdclu1vuRB90GjSBXltij/wlpeAmfCCMl0
yaRh9r4B2G8gw5WYDD6wt8OoDigPpq4SQWJg7yWXpEQ5IJsHC+1BzLT/fBZ5YdaM
CKV5m1iWqG/42DxfiHkSRA/P69uD42zkcUEpCLwHzOzuJUzCK4s9Fuz2u5EScdn1
bPg4q3NQFzxflyeTuSgt8GFO5nyzo1YxI6CF+H+6Lf12UcsEgfqQ2IjbufbxmJjH
05hbaLpN2tZrY+rnSLa/uT9xuNP9BC34rt8xiLkgq2hE6aVetvzDr4vwY20XREih
I9F587u+Kai0Q6Vymywk1qO/NPFIX/tkrpkct4tS/9mRrLYFRmAug8957teboFNV
ymKRfnE7yBCSeoVActTGRI/dXQ7tMi8RbUr1yQveBuGpntkJZ8Nio5HJHja/93PP
zigXEAOJAOOlYery0Auq
=tBoA
-----END PGP SIGNATURE-----

--8OidD1nqRpVuJku413rV0aUTs0CngQ3Sc--
