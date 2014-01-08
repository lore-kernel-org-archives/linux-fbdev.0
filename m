From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 08 Jan 2014 13:32:17 +0000
Subject: Re: [PATCH] video: imxfb: Use regulator API with LCD class for powering
Message-Id: <52CD5361.50205@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="avaKhsAOa7LbTgoG1nKC998ucNaACBD4D"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
 <20131223082107.GF26070@S2101-09.ap.freescale.net>
 <1387787053.605757144@f413.i.mail.ru>
 <20131223082842.GI26070@S2101-09.ap.freescale.net>
In-Reply-To: <20131223082842.GI26070@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org

--avaKhsAOa7LbTgoG1nKC998ucNaACBD4D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-23 10:28, Shawn Guo wrote:
> On Mon, Dec 23, 2013 at 12:24:13PM +0400, Alexander Shiyan wrote:
>>> On Sat, Dec 21, 2013 at 03:08:00PM +0400, Alexander Shiyan wrote:
>>>> This patch replaces custom lcd_power() callback with
>>>> regulator API over LCD class.
>>>
>>> FYI.  Denis' effort on this already goes to v13.
>>>
>>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/285326
>>
>> Hmm, OK, but having LCD class could resolve our problems with contrast=
 control.
>> https://www.mail-archive.com/devicetree@vger.kernel.org/msg07660.html
>=20
> I just want to make sure you two are aware of each other's work.

So, should I ignore this patch, or...?

 Tomi



--avaKhsAOa7LbTgoG1nKC998ucNaACBD4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzVNhAAoJEPo9qoy8lh71O2oP/1m21JpkyGBMk6uYcbvCJ3OJ
vfCu5+ooz61ta9z+/63Z96UDtU3TCVj07crVvgDHlQLTuaWBt6BhGRkQloM4KTsy
qD1ABp9tPorfj2nFVZFqkzHZJeK412BpI+EWEY/tlAryAZ02BmjxB9qUeuaRQu/o
W3OLZ8VLR3xs68zEGMPTdZ216080YxTlDWTeUbx3YRRRurXxif+0R0pUjYdav6fa
7kinyUmJDcVdBRyDSlzLSVw8HwW+xiuXk/oO31ZAZLni5DllttWrc4JjOXrx1vaH
9fHh659RWsbZ5R+Uoc1zWTfFEotI6pQptkpzo6IbY8sTJ3h2Tlpf53m72FN3o12Y
RNq3oP6/+iOfUSDAzyb3QgPicndr6V7N05lyy89u02g7a4Zk7l9lr0USqH2FjWVY
3h1Uyn2zC4Jvg5RRLLo2oZbiLqclF0bBbK2tvW2sKFTc1GQ9Hk+iAABAiqlPLvN3
RW/mmdYRLdtXS/75DXZc34rXWzARZ74ccwhPcYwd7PKpws3LNymqINuuZJ6m+tI5
R59W9nM043DxTW7nN6pseKugiJk42xU8ae816ftqrASzaegJnxROTyWlev+YAubv
eCHI0gyfgeWta5pAszPdnxsITQFzdwERxWCZz5yiPXd0H3w/ZvKSyi4o5PjnEmg7
l5/8pCEWXm/+Bw1N9J3i
=JN8q
-----END PGP SIGNATURE-----

--avaKhsAOa7LbTgoG1nKC998ucNaACBD4D--
