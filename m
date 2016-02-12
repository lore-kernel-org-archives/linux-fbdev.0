From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 12 Feb 2016 07:40:57 +0000
Subject: Re: [PATCH v2 0/3] fbdev: omap2: panel-dpi: support reset-gpios and vcc regulator
Message-Id: <56BD8C89.6040609@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8VqNLw9jaT1gfN38J57CQsg9ivskFWdaJ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-fbdev@vger.kernel.org

--8VqNLw9jaT1gfN38J57CQsg9ivskFWdaJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 01/02/16 12:07, Uwe Kleine-K=C3=B6nig wrote:
> Hello Tomi,
>=20
> On Sun, Dec 20, 2015 at 12:13:19PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> Hello,
>>
>> these patches are what is remaining from my previous series sent
>> starting with
>> Message-Id: 1449753107-11410-1-git-send-email-uwe@kleine-koenig.org .
>>
>> I split out the changes to
>> Documentation/devicetree/bindings/video/panel-dpi.txt in a (single)
>> separate patch. Also I changed the behaviour of the reset gpio to neve=
r
>> assert it because there are too many different needs.
>>
>> Have fun
>> Uwe
>>
>> Uwe Kleine-K=C3=B6nig (3):
>>   devicetree/bindings: add reset-gpios and vcc-supply for panel-dpi
>>   fbdev: omap2: panel-dpi: make (limited) use of a reset gpio
>>   fbdev: omap2: panel-dpi: implement support for a vcc regulator
>=20
> you didn't comment these patches, do you have them still on your radar?=


Sorry, my mainline radar has been suspended for a while. I'll get back
to fbdev next week.

 Tomi


--8VqNLw9jaT1gfN38J57CQsg9ivskFWdaJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWvYyJAAoJEPo9qoy8lh71vnAQAJJHmmpJ3IYJBv9sLcPd3ZPz
dOEd4ER6pm9Oovl76J+/xKvzpBRp0RjmSJACIR+Dsny9GvQ9SY1ngJUSByKBal1O
vlPd2c2QhTPSEzc/ldwMH+1z7Wvo+9sXj56wxrHFDmNLJ+tiGYU/i/JF4vdv0A7j
8sRkIWyX/0EjI+WJt8UJ6Rthy9MCR2uZfv6wWm0E+YFGIBpcsc7Q4vs0xZLyFhgR
M9BtKT62BWHkpuKWX876mTJIsMqB3zLcJZF530ZSFLa5LWPbF8m7hvqGJoCpnPIB
kIlduH2K5MzXs5rckzejwjahv75Jgf9Q4ffpN2MTlrDCTV8hUHeGq6s5scoMklSQ
2fy0PhJCIh9jqCdPsCRDmau3/iHNuTM44/hj09TNRhJP9FNYu1wWWXLcuKmlpk1y
C1WfUFCCKBEC/UFRSXFkRfUg+kRo2bfsMunYNGEU2IJ15NbNynAKxXKMZWJctaHK
P7iHgs4IAfq0lzqSzOGB69v9h4+8fmotfiQFkvaTBPame0obe+czPRSb/HB+nJQo
FgjxJhm9zTVVsOSOCXZeVXqLDOXq7Ml9PMW0hXnUVir+u4izx3E1B5Z7nAs1+amD
gICiKvAui+adwhuLog/Au+grwvsES/PbRcSOuZfxjs8KAxzSwazZ1MsziKd4VZtt
8xpqg1qFAdmdUBy5lYZT
=cssL
-----END PGP SIGNATURE-----

--8VqNLw9jaT1gfN38J57CQsg9ivskFWdaJ--
