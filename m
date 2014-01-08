From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 08 Jan 2014 09:42:58 +0000
Subject: Re: [PATCH 1/4] video: ep93xx: Cleanup video-ep93xx.h header
Message-Id: <52CD1DA2.2090107@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rFEXqKICb6kGI1LCknofG6qNhQ93Ti0C4"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1388384533-20458-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1388384533-20458-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--rFEXqKICb6kGI1LCknofG6qNhQ93Ti0C4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-08 11:09, Sachin Kamat wrote:
> Hi Tomi,
>=20
> On 30 December 2013 11:52, Sachin Kamat <sachin.kamat@linaro.org> wrote=
:
>> Commit a3b2924547a7 ("ARM: ep93xx: move platform_data definitions")
>> moved the file to the current location but forgot to remove the pointe=
r
>> to its previous location. Clean it up. While at it also change the hea=
der
>> file protection macros appropriately.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  include/linux/platform_data/video-ep93xx.h |   10 +++-------
>>  1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/platform_data/video-ep93xx.h b/include/linu=
x/platform_data/video-ep93xx.h
>> index d5ae11d7c453..92fc2b2232e7 100644
>> --- a/include/linux/platform_data/video-ep93xx.h
>> +++ b/include/linux/platform_data/video-ep93xx.h
>> @@ -1,9 +1,5 @@
>> -/*
>> - * arch/arm/mach-ep93xx/include/mach/fb.h
>> - */
>> -
>> -#ifndef __ASM_ARCH_EP93XXFB_H
>> -#define __ASM_ARCH_EP93XXFB_H
>> +#ifndef __VIDEO_EP93XX_H
>> +#define __VIDEO_EP93XX_H
>>
>>  struct platform_device;
>>  struct fb_videomode;
>> @@ -53,4 +49,4 @@ struct ep93xxfb_mach_info {
>>         void    (*blank)(int blank_mode, struct fb_info *info);
>>  };
>>
>> -#endif /* __ASM_ARCH_EP93XXFB_H */
>> +#endif /* __VIDEO_EP93XX_H */
>> --
>> 1.7.9.5
>>
>=20
> Gentle ping on this series..

Thanks, queued the series for 3.14.

 Tomi




--rFEXqKICb6kGI1LCknofG6qNhQ93Ti0C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzR2iAAoJEPo9qoy8lh711z4P+wdtCac4mrKhf7X6GsH/9g0/
tA7nblsSSZCJOtwtalFX2LyQZKQw+/ojYIY0i5Qh1cj3fpOFENEX68Ayf/dteWBY
uyedxtwrVnzp2rI7LRPWPXi6bLrbppYbvVTam6nhApX5p9Xy/uQSEJoIyybmRnB2
7rZSsr7ohRVEOUqTbrq5jZFkgbJJu04SBJ/4/HjvIJwrVB0zeunz5RzwtEHeBDGW
U+8JT4n4QV3wr9g/PzKY12/qPRxMy1OpjTeSxQljVbmB9ScOyFcNdwmmkcdPx6UR
+s0kh9BVXdkj8+Ji0rLWKjPi3St6fZyc1ajp6V1QLoN7I6Qdibs0Jj6UWSXE4SwF
mgp/O3NdaV6xxOrgi6un+fyENbpxOk23izg3VAiWTJw+SusHoHxc8kci6lb1/vkj
kpiRDGAljmM5RIrMNBzvQdUQQmhfhOl6HEr/g0AFCUQQKXc50ej/6C19Lb2PiXsP
bGvJ2L8/ARA2s99W/eQoWYm2wsyXuFraGcZcpi+LvjupU9jA2u+vGYMzODUTF3er
b9KQMgEPexEcK34/a7RFaaWI7hD6VBSsvFKYanCyPSVfihrgwpOLVf0t3opYCXMB
QaV1/REzdyAXWPbq5Sy56+Jc3fCJrhHChAvpPZddY+qhxvT19pqiWytpN8kxccMq
4GhCW6OQ2THKN7otmPM+
=uBF2
-----END PGP SIGNATURE-----

--rFEXqKICb6kGI1LCknofG6qNhQ93Ti0C4--
