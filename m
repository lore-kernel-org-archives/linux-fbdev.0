From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 11:35:44 +0000
Subject: Re: [PATCH 06/32] OMAPDSS: DPI: fix regulators for DT
Message-Id: <51A73990.5040709@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2EDNKKAIJBQEPIMERRIPQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-7-git-send-email-tomi.valkeinen@ti.com> <20130530111253.GJ19468@game.jcrosoft.org>
In-Reply-To: <20130530111253.GJ19468@game.jcrosoft.org>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

------enig2EDNKKAIJBQEPIMERRIPQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/05/13 14:12, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 12:34 Thu 30 May     , Tomi Valkeinen wrote:
>> On some platforms DPI requires a regulator to be enabled to power up t=
he
>> output pins. This regulator is, for some reason, currently attached to=

>> the virtual omapdss device, instead of the DPI device. This does not
>> work for DT, as the regulator mappings need to be described in the DT
>> data, and the virtual omapdss device is not present there.
>>
>> Fix the issue by acquiring the regulator in the DPI device. To retain
>> compatibility with the current board files, the old method of getting
>> the regulator is kept. The old method can be removed when the board
>> files have been changed to pass the regulator to DPI.
>=20
> as discuss with Arnd we should handle regular enable and disable at dev=
ice
> probe for every device as we do for pinctrl

I'm not sure what you mean. Enable of what? The regulator? Why would we
enable it in the device's probe, as the device may never even be used?

Or do you mean regulator_get()? Doing that in DPI driver's probe is
problematic, as not all boards have any panels using DPI, and thus they
may not have the regulator set up, but all boards have the DPI device
added automatically. So for those boards the DPI probe would fail,
always, if we tried to get the regulator.

 Tomi



------enig2EDNKKAIJBQEPIMERRIPQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRpzmQAAoJEPo9qoy8lh7178MP/jqiuUSCrUGMPrlOEj7Ujx5B
elzSifZ9sN9jdMO3Syb03YIxKIZpV+9r6eP+QSYhhDIG4+O+zNq8DsMVcw2+uz5Q
ZyBm63I7aoV/HVH9HqG3sRo2nibi83JHcHg2XjFlTuxSlXp2V/eL/aQX/lgL2a5f
AF4wmOwH3tVP381BPZdI003ZF/tsOa1URxcRq1FgiCj3A7BjnDawavXZ29hVcZbF
9G8rbh1psTAw/0dxxVebfzkSQWeexENgQjxflpl7Yk4tqc9aIvJzI3H0vzkSlE3s
gAHmDN3xvnHtfpE77oSN98pkn6nYMu0gQKWwy3/lAiCsGifmvPNNbrVKqSrv7kqz
NHMWX1twHGh6xOfxEIPEP3aDLeIdzW1YWTSB92igeq8K1DTdhYyT5e9J6+hRayFz
FekBLCWHG4WzAAij/8D7Md6CCXxaR4FXmhu9HHVRi8uuVS5HFhL0OxP4+j1DmeG4
DX+oWA4EK6SoG6unAC+pbr/HZc5GfUaf4+1VlHCgSR+TU5iMQT8whdGWKNX5DqAl
Me+Qs+5nWKVoAzCCrv6qWoiFTDr3zkZlVlG+IYUD7dp6frPvTXZrabHpXL1J2VY7
yjLKlibrty5udBqiYexFIno4N5784edppxckJOLRX9IBHmMW14n+VTbB0xHMzXJm
BYNr3/ULbmirdMqfhoqq
=1WFa
-----END PGP SIGNATURE-----

------enig2EDNKKAIJBQEPIMERRIPQ--
