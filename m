From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Apr 2016 16:37:24 +0000
Subject: Re: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
Message-Id: <571F9944.9090900@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UUOPG9B34LWUl6nXjkDBpL2gpFrRolFhw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459355376-28507-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1459355376-28507-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org

--UUOPG9B34LWUl6nXjkDBpL2gpFrRolFhw
Content-Type: multipart/mixed; boundary="j8hpsicWeWKGwBIXU83f2d1TONO6kFwav"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Message-ID: <571F9944.9090900@ti.com>
Subject: Re: [PATCH] omapfb: Fix regulator API abuse in dss.c and hdmi4.c
References: <1459355376-28507-1-git-send-email-broonie@kernel.org>
 <56FCC3F3.7060907@ti.com> <20160331164953.GD2350@sirena.org.uk>
 <56FD5A2C.7090608@ti.com> <20160426162229.GW5995@atomide.com>
In-Reply-To: <20160426162229.GW5995@atomide.com>

--j8hpsicWeWKGwBIXU83f2d1TONO6kFwav
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26/04/16 19:22, Tony Lindgren wrote:
> Tomi,
>=20
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [160331 10:31]:
>> Tero, Tony, with a quick look, for example omap5-board-common.dtsi
>> defines ldo4_reg having range from 1.5 to 1.8. That should be changed =
to
>> 1.8 only, right? ldo1_reg has a range too, I'm not familiar with that
>> LDO's use, but it's for camera so my guess is that it should be 1.8 to=
o.
>>
>> I can have a more thorough look tomorrow, and do a test run on omap5
>> uevm (with Mark's patch).
>=20
> Any news on this fix?

I sent the DT changes to you some time ago:

http://www.spinics.net/lists/linux-omap/msg127893.html
http://www.spinics.net/lists/linux-omap/msg127894.html

We can get rid of the dss code after those are in.

 Tomi


--j8hpsicWeWKGwBIXU83f2d1TONO6kFwav--

--UUOPG9B34LWUl6nXjkDBpL2gpFrRolFhw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXH5lEAAoJEPo9qoy8lh71/zcP/0bJmexgwCcM1Z44AaVD5zKB
b3zsds0FlsKHmqB/3xvq2QfCoso0Xve7dFAZ0QFU9XhLpo7TOPAFXAAeGxq7h/ga
X9tETKsZ5F3gMXgqYDM7nGaVtLyHuvKsjgqX+nMnFE03O66FsgIqYeawGlYJXNti
U0ecM7dPO8yqBCsluLhWkEzU1+ilNFVhUaNx5AonGEBm9j9MI7aRz1GN7lo4Zl2W
S6XiClLN0wdnU0amLhxCt/7rI4VJfqUl6PESSIpPaDjUQU5YryNNtBJINwPy0DiM
W2l9189zcRRYAWC/SfRCeRXIZXKZKgUqu9EX7WgAXnPyxWN8Iuj++9svXRcbgQyu
xz+DJlSXMhem+sHriF0+c+SpCtIN8kEl+Bi0V9o2V/GeBVxdv5ogaGBqy6AtX34M
cMmdmA9uwOn1+wd0/HLNQ/BtbqtnFmAr3ejr09D/khDKSnaqusQhup2cZEXJLGU5
bHbK+sarojmSUhEWX6gKCvS5AIwtNosdd0mavao58STl5ehZN1jjmj+LzdHHczL3
hiG9ydqMGoWQp+b8wTigu91uJmdPjXGDP3oyjfpxLhjJsfQ7F2RpgWX3Y25queEm
1bkVm0Xv5iaqlYalTo0rYYh8G0kR46KSUBSa+ttlkO7M9Ni7c1D/WJKT5V2kDqtp
IcKs06yLsdS2voozPZ1t
=NJ1Y
-----END PGP SIGNATURE-----

--UUOPG9B34LWUl6nXjkDBpL2gpFrRolFhw--
