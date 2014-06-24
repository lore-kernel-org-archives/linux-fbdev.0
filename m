From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Jun 2014 11:06:00 +0000
Subject: Re: [PATCH v1] fbdev: add cea modes and properties
Message-Id: <53A95B98.3080709@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pCs9rWlkMhhHMHuJvILUe7hvv5rA29SdU"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401153457-27027-1-git-send-email-cfreeman@nvidia.com>
In-Reply-To: <1401153457-27027-1-git-send-email-cfreeman@nvidia.com>
To: linux-fbdev@vger.kernel.org

--pCs9rWlkMhhHMHuJvILUe7hvv5rA29SdU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Oops. Please reply to this address instead of the iki.fi one.

 Tomi

On 24/06/14 14:02, Tomi Valkeinen wrote:
> Hi,
>=20
> On 27/05/14 04:17, cfreeman@nvidia.com wrote:
>> From: Christopher Freeman <cfreeman@nvidia.com>
>>
>> This is a port of two patches from Android source to fill in all
>> 64 cea modes as well as specify the aspect ratios for those modes.
>=20
> I was testing this a bit with omapfb and my monitor. I don't see the
> aspect ratio flags set properly for all modes for some reason.
>=20
> This is a debug print of the modes from my monitor, from the modedb
> after adding two EDID blocks to it.
>=20
> 0: 1920x1200 pck 154012000, sync 2, vmode 0, flags 11: detailed first
> 1: 720x400 pck 26171000, sync 0, vmode 0, flags 8: calc
> 2: 640x480 pck 25200000, sync 0, vmode 0, flags 4: vesa
> 3: 640x480 pck 31500000, sync 0, vmode 0, flags 4: vesa
> 4: 800x600 pck 40000000, sync 3, vmode 0, flags 4: vesa
> 5: 800x600 pck 49500000, sync 3, vmode 0, flags 4: vesa
> 6: 832x624 pck 53433000, sync 0, vmode 0, flags 8: calc
> 7: 1024x768 pck 65002000, sync 0, vmode 0, flags 4: vesa
> 8: 1024x768 pck 78802000, sync 3, vmode 0, flags 4: vesa
> 9: 1280x1024 pck 135007000, sync 3, vmode 0, flags 4: vesa
> 10: 1152x864 pck 108003000, sync 3, vmode 0, flags 4: vesa
> 11: 1280x960 pck 108003000, sync 3, vmode 0, flags 6: standard vesa
> 12: 1600x1000 pck 132802000, sync 0, vmode 0, flags 0:
> 13: 1600x1200 pck 162022000, sync 3, vmode 0, flags 6: standard vesa
> 14: 1680x1050 pck 146864000, sync 0, vmode 0, flags 0:
> 15: 1920x1200 pck 193236000, sync 0, vmode 0, flags 0:
> 16: 1920x1080 pck 74250000, sync 3, vmode 1, flags 11: detailed first
> 17: 1920x1080 pck 74250000, sync 3, vmode 1, flags 1: detailed
> 18: 1280x720 pck 74250000, sync 3, vmode 0, flags 1: detailed
> 19: 1280x720 pck 74250000, sync 3, vmode 0, flags 1: detailed
> 20: 1920x1080 pck 74250000, sync 3, vmode 1, flags 80: 16:9
> 21: 1440x480 pck 27000000, sync 0, vmode 1, flags 140: 4:3 repeat
> 22: 1920x1080 pck 148500000, sync 3, vmode 0, flags 80: 16:9
> 23: 720x576 pck 27000000, sync 0, vmode 0, flags 40: 4:3
> 24: 1280x720 pck 74250000, sync 3, vmode 0, flags 80: 16:9
> 25: 1920x1080 pck 74250000, sync 3, vmode 1, flags 80: 16:9
> 26: 1440x576 pck 27000000, sync 0, vmode 1, flags 140: 4:3 repeat
> 27: 1920x1080 pck 148500000, sync 3, vmode 0, flags 80: 16:9
> 28: 2880x480 pck 108003000, sync 0, vmode 0, flags 140: 4:3 repeat
> 29: 1440x240 pck 27000000, sync 0, vmode 0, flags 180: 16:9 repeat
> 30: 1440x480 pck 27000000, sync 0, vmode 1, flags 180: 16:9 repeat
>=20
> For some reason some of the 16:9 modes do not have the flag, like mode
> 16. Any ideas?
>=20
>> diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
>> index fb795c3..a65a787 100644
>> --- a/include/uapi/linux/fb.h
>> +++ b/include/uapi/linux/fb.h
>> @@ -226,6 +226,10 @@ struct fb_bitfield {
>>  #define FB_VMODE_SMOOTH_XPAN	512	/* smooth xpan possible (internally =
used) */
>>  #define FB_VMODE_CONUPDATE	512	/* don't update x/yoffset	*/
>> =20
>> +#define FB_FLAG_RATIO_4_3	64
>> +#define FB_FLAG_RATIO_16_9	128
>> +#define FB_FLAG_PIXEL_REPEAT	256
>> +
>=20
> The rest of the bits are defined in include/linux/fb.h. Why did you add=

> these three bits here?
>=20
>  Tomi
>=20
>=20



--pCs9rWlkMhhHMHuJvILUe7hvv5rA29SdU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqVuYAAoJEPo9qoy8lh71UjQP/2QjtpBuMYHzZmEU8S4/prD+
E7cV9YbnXzWE1ysvCgEcSptLeaSMlwpmL7fUn3R3loGTGE3daSRQo+gyPmPSgSIA
a3nhKHWZH1rOJdc4hY37NzaR/MyBHigDl+URmE/0cwf0GnwkEX0B54/1Vv6/uYf/
rDHwIxJkHVISaiY6eF5Dp7V7xLy4iFsQKH/SJNpHnnefnCkvrm43gbs7DqhpePvh
aCDgzXzEo6N/M9XjIO97erLPJmFdpdO8AVT+gcu5TRuyPmdvUtcD7PmWsSCAJNcT
VreLTVlNMOshKEf/eb3xhxHIVKHJcWZVVnBeSHj4aAg0EsHG5V2tiownOExZI2iP
TVsS8PjHt1VFqkCGyAl33g2OXKCWaR44AAM+ptBzmptjj6tWuUHBThqWc5PUWKIX
YEA5HDfEDV48JHAlV7S64L8F3MWnAa2EaKhY1T+UI0cAMdS13R16qkAVhfmidXJM
DNK6buxn0R+C1rb5KLdDIzeGXbSnGiiAvzhI3NUCQvELMKBXwWh+iXhW6I4V9kl9
uS7QKbTlC8VKWe9JB8+mVm7wzd9riTkSv+OF5HSMzxQF4gzdDcUHRphFTM08bmMl
8y976g1Z1FWSwPpb2ykAUj/r4BHKMHP0XS0T4I6VqTZ0onaLVZf/q3WW4xNFEBfR
t6UrxTdAqm3tmMzoUwsZ
=WlPN
-----END PGP SIGNATURE-----

--pCs9rWlkMhhHMHuJvILUe7hvv5rA29SdU--
