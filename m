From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 08 Jan 2014 08:31:48 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdcfb: Don't use plain 0 as NULL pointer
Message-Id: <52CD0CF4.8040900@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LQFSUXXUrn5vwr0bb1gGwnN2dbCpcKWdr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385512723-11722-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385512723-11722-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-fbdev@vger.kernel.org

--LQFSUXXUrn5vwr0bb1gGwnN2dbCpcKWdr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-07 17:17, Laurent Pinchart wrote:
> Hi Jean-Christophe and Tomi,
>=20
> Could you please pick this patch up for v3.14 ?
>=20
> On Wednesday 27 November 2013 01:38:43 Laurent Pinchart wrote:
>> This fixes a sparse warning.
>>
>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: linux-fbdev@vger.kernel.org
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard=
=2Ecom>
>> ---
>>  drivers/video/sh_mobile_lcdcfb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/sh_mobile_lcdcfb.c
>> b/drivers/video/sh_mobile_lcdcfb.c index ab85ad6..2bcc84a 100644
>> --- a/drivers/video/sh_mobile_lcdcfb.c
>> +++ b/drivers/video/sh_mobile_lcdcfb.c
>> @@ -1227,7 +1227,7 @@ static void sh_mobile_lcdc_stop(struct
>> sh_mobile_lcdc_priv *priv) /* Free the MERAM cache. */
>>  		if (ch->cache) {
>>  			sh_mobile_meram_cache_free(priv->meram_dev, ch->cache);
>> -			ch->cache =3D 0;
>> +			ch->cache =3D NULL;
>>  		}
>>
>>  	}

Queued for 3.14.

 Tomi



--LQFSUXXUrn5vwr0bb1gGwnN2dbCpcKWdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzQz0AAoJEPo9qoy8lh71pFAQAI5MPoqWZY9c3SvQ1h90P2vB
nT0CJcXSBvGhuzuc6MHccR34/w70t9iPj4ZJyHfvTUgdOn5DUaUBpXXmXzlY/VYq
6j8jHAU0GSzTkqOAfrEr0tej88K3CzBWMR4iNiJfCTt260akhSU9+UKPdWM+eJKc
rdpqjAeur87vII04Xs2NB0ad5kEsMvS1mGMMbkBENzjCs4fQrMlcdZTIkTpAggJp
2RpBZCAJTwgcJ+OmOIykXv9lj4A7VNly/Ruvm+H2YUeNrGZn34JG3t9pd2NCu8Qn
Dxh3sNCRUJEurqBfPtfsJw1eH7lynh0dAgVUBMsIiKz7x/BZ+SuouIFDFpf+Dz1g
HsQNbxMoPCiqzIPBRqZ1JMTXpeIr+RO3Df1SLRmy3UFyxpsgwouW+7ByM1HTueCO
AfP526GK9+CuDByhTD6kMFdnZWTuYG6S1jDjdtGJn42h1vNeZav8Q9DVv628nwac
kntbg6gM0WOvYGDiCCzxL7pJPclL10MQTOgDwMCxk3VPsBXG9RkD9SCEqIquZyoZ
VUr/sxhUx97/kfiyUcsNNh9RxS741sTvh6EyEU5taXXrLimF36pKZdVLCkRFur1E
BZU5s5bGFOIECWqCioQI2/NO6bps0PzgYY2W1NK2bAaBOpnr9UazzBbR+cEnHami
wp48E0gGrXPnEgoP8qQN
=kqSK
-----END PGP SIGNATURE-----

--LQFSUXXUrn5vwr0bb1gGwnN2dbCpcKWdr--
