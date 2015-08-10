From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Aug 2015 14:21:38 +0000
Subject: Re: [PATCH] fbcon: unconditionally initialize cursor blink interval
Message-Id: <55C8B372.8060208@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="J4WqUHKUHQnK2iMo1hPvG5q5dUpGMmvSb"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1508041215100.1151@local> <20150804203250.GA655@amd> <alpine.DEB.2.11.1508101358210.1286@local>
In-Reply-To: <alpine.DEB.2.11.1508101358210.1286@local>
To: Scot Doyle <lkml14@scotdoyle.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Liu <net147@gmail.com>, Pavel Machek <pavel@ucw.cz>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--J4WqUHKUHQnK2iMo1hPvG5q5dUpGMmvSb
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 10/08/15 17:05, Scot Doyle wrote:
> On Tue, 4 Aug 2015, Pavel Machek wrote:
>> On Tue 2015-08-04 12:33:32, Scot Doyle wrote:
>>> A sun7i-a20-olinuxino-micro fails to boot when kernel parameter
>>> vt.global_cursor_default=3D0. The value is copied to vc->vc_deccm
>>> causing the initialization of ops->cur_blink_jiffies to be skipped.
>>> Unconditionally initialize it.
>>>
>>> Reported-and-tested-by: Jonathan Liu <net147@gmail.com>
>>> Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
>>
>> Acked-by: Pavel Machek <pavel@ucw.cz>
>>
>=20
> Tomi, this one should also go in 4.2 fixes.

Thanks, I've queued for 4.2 fixes.

 Tomi


--J4WqUHKUHQnK2iMo1hPvG5q5dUpGMmvSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVyLNyAAoJEPo9qoy8lh71vPcP/3hl1tjCji35wHdrqPtChqBk
hkxZU+3X/8XcMrlVebRsb1CfUEcCWGawHkuoFgmB+CNFzgErRigquYrnlkDWKvfN
iF7To5iVwM9SCW02WsupVTuLQaXPVRe2VVrfXWx/sWX1L8W/ga4ZRzHOHXW135qH
NfUxTNxmu/jo8Kh8x2bcmKnaEfHx2klrZH50UGupjPm33vOO377d3O/Xd0gAhPpl
CPs2cLyO9weweqYsCFFUyOKE3UccR7+qUndmViNQEcqrMCU8s1MW4zIMKJB5buia
4sYFb2RJLJ1n47ric4jsvknQL3h/55XBIGcZjJ5rD5JMR3x83FR8hAFQWc5KcYRv
rjLAnk5xb054z5d18HRTGcAkb2aUeiEyH3vJc4zLH8RdBpgcrsGm3KGWNYY3v04a
ozwLEhr09Ox6I30odLHeLR8sDiOuhd9bUaupR18f+Z377FppV94/PFU6Vk5x4XSu
jzDfHHtPHXz4/zMwbP1PAa8bgiBZk+/eAbx47HRhkr7KSHnXZ5HhBFz/AmS22nPQ
3nU3r2QwhNDcKXXnxaCJ5M4zgY5lGhMgE1xsnGsU6HrO5GdsKMtsjMaGZGb15Vc+
OaGV99rSm+vupkhA7x5rM+80kVPGlj4AbAUohRJMjFUCJAewc7aOuv7/mx59sWuD
qRlwr1XMEJn444ulG8MX
=hQNz
-----END PGP SIGNATURE-----

--J4WqUHKUHQnK2iMo1hPvG5q5dUpGMmvSb--
