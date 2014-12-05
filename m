From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 05 Dec 2014 11:41:06 +0000
Subject: Re: [PATCH 2/3] video: fbdev: Check Standard Timing against DMT
Message-Id: <548199D2.7010101@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mJsJqpDhMDL59xNwf8onwgKnuOhV8GQc6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417643369-20603-2-git-send-email-davidu@nvidia.com>
In-Reply-To: <1417643369-20603-2-git-send-email-davidu@nvidia.com>
To: linux-fbdev@vger.kernel.org

--mJsJqpDhMDL59xNwf8onwgKnuOhV8GQc6
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/12/14 06:08, David Ung wrote:
>>> diff --git a/drivers/video/fbdev/core/modedb.c
>>> b/drivers/video/fbdev/core/modedb.c
>>> index 0b57c1df..858a97e 100644
>>> --- a/drivers/video/fbdev/core/modedb.c
>>> +++ b/drivers/video/fbdev/core/modedb.c
>>> @@ -497,6 +497,90 @@ const struct fb_videomode vesa_modes[] =3D {
>>>  	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED,
>> FB_MODE_IS_VESA },
>>> };  EXPORT_SYMBOL(vesa_modes);
>>> +
>>> +const struct dmt_videomode dmt_modes[DMT_SIZE] =3D {
>>> +	{ 0x01, 0x0000, 0x000000, &vesa_modes[0] },
>>> +	{ 0x02, 0x3119, 0x000000, &vesa_modes[1] },
>>> +	{ 0x03, 0x0000, 0x000000, &vesa_modes[2] },
>>> +	{ 0x04, 0x3140, 0x000000, &vesa_modes[3] },
>>> +	{ 0x05, 0x314c, 0x000000, &vesa_modes[4] },
>>> +	{ 0x06, 0x314f, 0x000000, &vesa_modes[5] },
>>> +	{ 0x07, 0x3159, 0x000000, &vesa_modes[6] },
>>> +	{ 0x08, 0x0000, 0x000000, &vesa_modes[7] },
>>> +	{ 0x09, 0x4540, 0x000000, &vesa_modes[8] },
>>> +	{ 0x0a, 0x454c, 0x000000, &vesa_modes[9] },
>>> +	{ 0x0b, 0x454f, 0x000000, &vesa_modes[10] },
>>> +	{ 0x0c, 0x4559, 0x000000, &vesa_modes[11] },
>>> +	{ 0x0d, 0x0000, 0x000000, 0 },
>>> +	{ 0x0e, 0x0000, 0x000000, 0 },
>>
>> You've filled only some of the modes in this table. What's the logic w=
hich
>> modes are left out?
>>
>=20
> For DMT id 0xd, it has no STD 2byte id, no 3byte CVT code and no mode t=
imings
> currently defined in vesa_modes struct.
> There is 80 DMT ids, but only 43 vesa_modes defined in fbdev.  So I've =
left those
> entries empty.  If we eventually have all the VESA timings, the last co=
lumn could
> be eliminated.

Ok. So you added the modes to vesa_modes table that you were interested
in for your use case, and then filled the dmt_modes table with the modes
that were available in vesa_modes?

That's ok, I just want to understand the logic for which modes you added
and which you left out.

 Tomi



--mJsJqpDhMDL59xNwf8onwgKnuOhV8GQc6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgZnSAAoJEPo9qoy8lh71DEMQAJTSY2mFkG3OVC6UPU9Fh4gm
bRyN4aJbPiZwcpdQxjWBpVSKFI+vXdANWz6j1HP1AZtJY373R/2xj9UygaDpW/ZD
wM/bvoELxTSs+I35NirwYy12w4SFlbSkU2hRxYoUsGbfpAGVyHPbkl/FBz+9TiHf
i07dXAkUphK+dfK2KqxxkehMQu6MXLBoNGfc521W1L4Lvpaz73/cNFccwSQ7eEk4
gXBouQIxKl/1E1UA1jndsPNZtoFSDrL8aM+lCGN/HYwqLg9+QzUKeqR82gO1zash
lrnMMxppF3A1aArv0T2/K54qDUIkGOwgy7bLL7O+EogEvX394i5FmteyRTTi1HUC
WbAPDRtERQq2DBN+nFWM5ZxhNmUx8ebJp8WpCRH07Y8Nerxb75GqEylwH9dpgXv/
ipNPJ3+COgLHVTr1z59OSg6Ma4miupICCrUa9rbfFvPGOjxfU8Fn30+du8uiPNPh
2BtszqHh5BYgkhHAYxjlXy1kw1PXBEGLmFoXeHgR5EiuBZ8Vta53bdwArWVyoa+s
hT/nCua5TzQijTMEkG/vUsJXmBlpCPsiy/kTzDhmjUjGopA+mwvYCCbDqt+abmc8
77lEbiAYqt4iLJ0TaGSb2It0MkmpdfU26fw3qC51HumSHPaIm06aOyU/QIqO/XP4
8d6g8OPBq4rxyZ7YSoQ6
=I8Km
-----END PGP SIGNATURE-----

--mJsJqpDhMDL59xNwf8onwgKnuOhV8GQc6--
