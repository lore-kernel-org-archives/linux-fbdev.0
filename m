From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 29 Jan 2016 11:55:06 +0000
Subject: Re: [PATCH] fbdev: ssd1307fb: Fix chargepump setting
Message-Id: <56AB531A.2020805@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="P42GTvwSvsLgQW0fNLKuTr0cGFkL7ELde"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447337257-31232-1-git-send-email-julian@jusst.de>
In-Reply-To: <1447337257-31232-1-git-send-email-julian@jusst.de>
To: linux-fbdev@vger.kernel.org

--P42GTvwSvsLgQW0fNLKuTr0cGFkL7ELde
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 18/01/16 22:20, Julian Scheel wrote:
> On 15.11.15 14:36, Julian Scheel wrote:
>> The charge pump setting must have bit D4 set all time according to the=

>> SSD1306
>> App Note. Instead of doing an logical and off shifted setting bit with=

>> 0x14 it
>> must be an logical or with 0x10 to ensure D4 is set.

The code change looks ok, but I can't quite decipher the commit
description. "an logical and off shifted setting bit with 0x14"?

>> Signed-off-by: Julian Scheel <julian@jusst.de>
>> ---
>>   drivers/video/fbdev/ssd1307fb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/ssd1307fb.c
>> b/drivers/video/fbdev/ssd1307fb.c
>> index 1611215..5965a9b 100644
>> --- a/drivers/video/fbdev/ssd1307fb.c
>> +++ b/drivers/video/fbdev/ssd1307fb.c
>> @@ -389,7 +389,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *pa=
r)
>>           return ret;
>>
>>       ret =3D ssd1307fb_write_cmd(par->client,
>> -        (par->device_info->need_chargepump & 0x1 << 2) & 0x14);
>> +        0x10 | ((par->device_info->need_chargepump & 0x01) << 2));

I presume 'need_chargepump' is really supposed to be a bool, instead of
int. And if it's really bool, something like this makes it more readable
to me:

BIT(4) | (par->device_info->need_chargepump ? BIT(2) : 0)

 Tomi


--P42GTvwSvsLgQW0fNLKuTr0cGFkL7ELde
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWq1MaAAoJEPo9qoy8lh71KSEP/11wS48Ml6wcmOntW83pGsiD
B6s/thiuIXJKS3i8/E9evAQts/D8DeS1bWyeHVpbW1hBeqzo+l0JuXEwGqTQT9Xu
3K1EP7x12EWwkKxwgvY6rSpmXAHQ1I+QZ6DDx8iWvyclMBKRVZIUHXbTUCbMW4pL
yAXWVNk+lOpBMaRV5871LZdUSjPFsfY+vaAekNWtNEhN2bwRU1ILqs6kNCxbvv0x
qjtw/xMGOOSQcT4oxhD6EwJ2m/LtxfITJadN1RMpcPU0bsss6Br+Ei+wXp2t873f
Q7nJGmVcPvtRQWxWKSsd9CUhzBZFR+So52Kiv16sPL+akArW2tHP5ilEaEPMGMmw
QNGyK04OdQrBjjl7HBqbm1SMTOU0qU+mveMAjLf3ofEC5a4PP4/FimYZamCGdwVY
ctYPo1FzVKXqQ+VfWaiWR9OXIilCWvtbFJkYYBzWDd/Q6vkPDGTwNJpDqVI4Z0jP
reRiMrYe4NRNxpOSIjNKPFNmStEmfC3jfInwCes3eucMQEBMXJmF40y+aod642vR
KyBDhgnFz8KxYTvQnhVlmM2RoVUF3u8ylxhfo0KHYwPcSNgQVh2YxGYuBLOUcUYC
jkbvQBN/bFXCy1cBVZUQcDVbO44s6+EGb3kKUymJCDvyN0aIEh8aOMwO0ONC5bDf
6uxejJIbosqjsmFKPGmv
=22rW
-----END PGP SIGNATURE-----

--P42GTvwSvsLgQW0fNLKuTr0cGFkL7ELde--
