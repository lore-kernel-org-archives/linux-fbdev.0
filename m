From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 25 Feb 2015 07:04:09 +0000
Subject: Re: [PATCH] OMAPDSS: restore "name" sysfs entry.
Message-Id: <54ED73E9.1020804@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="77PGJemNsOlvpjH0J9KSiP6U2CJlU59n0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150224203706.1eafa129@notabene.brown>	<54EC5520.1020105@ti.com> <20150225073131.7fbff605@notabene.brown>
In-Reply-To: <20150225073131.7fbff605@notabene.brown>
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>

--77PGJemNsOlvpjH0J9KSiP6U2CJlU59n0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 24/02/15 22:31, NeilBrown wrote:
> On Tue, 24 Feb 2015 12:40:32 +0200 Tomi Valkeinen <tomi.valkeinen@ti.co=
m>
> wrote:
>=20
>> Hi,
>>
>> On 24/02/15 11:37, NeilBrown wrote:
>>>
>>>
>>> commit 303e4697e762dc92a40405f4e4b8aac02cd0d70b
>>>     OMAPDSS: rename display-sysfs 'name' entry
>>>
>>> broke the xorg X server on my device as it couldn't find the display
>>> any more.  It needs the 'name' file and now there isn't one.
>>>
>>> That commit claims that 'name' is not compatible with i2c or spi.
>>> i2c does register it own 'name' file, but spi does not, hence my
>>> problem - I have an spi display.
>>>
>>> So create a special case for i2c: add the name attribute for non-i2c
>>> devices.
>>
>> What X driver is that? What's it doing with the display name? Is it ju=
st
>> using the display name to show something for the user, and the returne=
d
>> value can be essentially any string?
>>
>>  Tomi
>>
>>
> /usr/lib/xorg/modules/drivers/omapfb_drv.so
> from package xserver-xorg-video-omap3 in Debian.
>=20
> I don't know where the main upstream source is, but here:
>=20
> https://gitorious.org/gnutoo-s-programs-for-shr/xf86-video-omapfb/sourc=
e/28c006c94e57ea71df11ec4fff79d7ffcfc4860f:src/omapfb-output-dss.c#L258
>=20
> is the code which reads
>    /sys/devices/platform/omapdss/display0/name
> and fails if that file cannot be opened.

Thanks. Unfortunately it looks to me that the omapfb_drv uses the
display name to configure things, and as in i2c's case the 'name' is not
the correct dss name, X will probably fail in interesting ways.

Of course, it's already broken in that way, so this fix improves the
situation for non-i2c displays. I'll have a look if I can figure out how
to fix this for all displays.

 Tomi



--77PGJemNsOlvpjH0J9KSiP6U2CJlU59n0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7XPsAAoJEPo9qoy8lh7194EP/3F5qktH5sNALdEUxItPW/T2
ItHAxu5GbLD5owb48oe2UiV4+rkk34F9AFOXuGSyvZNbYLBAuNnjQDa/dH2MHCWk
fiSTAR1ACDWOnXORlaRFI9LUnDniuQt0F+qTLyqLVpKxemxP5wAYCqzZAao2x5Cm
wDG1bhL2AQxne7dJXum9w6qPI34wflpzzDf1lEKWhq8Koo5EfD4HEhX8hEaLDZ62
pExH87nlzNUlJ0clLl0IrP/WiWW2VK2O6meWf8cSFwvJdvqzKts0AJFOcmtVsbod
5wKLoYDDr/sFE/ecJWzEqer7riPXO/6pHtAosoBQwm3UhQaO4Hxf3dh0pMDLjMgd
ju9T9/e3awH+w1AuOLbERiihu0kXb7JvyLj2v3FvkYQnHJMTz1eq+yNdiCX1LZOY
rnE8NWlEWJXa4zphyqXZUyr9G43dyJiZIMCHRCY//5C6SbcBEeUkFKPy76nmY61+
Dkn2HSnlkNc/rYBvZRKAu6zhoOCFb9XIb3rfmj7pJAR3OOVLb6NuBIyvNcZ0ly6q
ZZ8+HO739cc4G9+pEHjO5965FgscxvyvIJ+jHTxTRU6wsN9hO4BUY+B0HWF6EWmk
qnmg74ee2ykpBYYekauuQKjT15HUdm0+LAFH0bC5GZIyzYWGb2N9+UcDxi5PP/Pa
0Bkqcnr3sSkHinGOYN82
=ZZWN
-----END PGP SIGNATURE-----

--77PGJemNsOlvpjH0J9KSiP6U2CJlU59n0--
