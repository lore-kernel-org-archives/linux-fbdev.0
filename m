From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 11:00:13 +0000
Subject: Re: [PATCH 4/4] [resend #2] tridentfb: Add DDC support
Message-Id: <5603D7BD.2050901@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qaEwurgqT6fwWw6bGLFJUodbKKaG4SXOd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440445048-24694-1-git-send-email-linux@rainbow-software.org>
 <1440445048-24694-4-git-send-email-linux@rainbow-software.org>
 <55E6DDC3.3030709@ti.com> <201509021404.37885.linux@rainbow-software.org>
In-Reply-To: <201509021404.37885.linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

--qaEwurgqT6fwWw6bGLFJUodbKKaG4SXOd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/09/15 15:04, Ondrej Zary wrote:

>>> +config FB_TRIDENT_DDC
>>> +	bool "DDC for Trident support"
>>> +	depends on FB_TRIDENT
>>> +	select FB_DDC
>>> +	select FB_MODE_HELPERS
>>> +	default y
>>> +	help
>>> +	  Say Y here if you want DDC support for your Trident graphics card=
=2E
>>> +
>>
>> Why would somebody not want this enabled? Is there some drawback if it=
's
>> enabled?
>=20
> It's probably an useless config option but many fbdev drivers have it. =
I have=20
> no problem removing it.

Yes, I'd rather see it removed, if no one sees any use for the option.

 Tomi


--qaEwurgqT6fwWw6bGLFJUodbKKaG4SXOd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA9e9AAoJEPo9qoy8lh71ogQP/1gGPC3UCKw+uRmHahQXghIa
zCoNRYq6oiu29K7HLvx0tMStQkZvzE9YmhCLgds+oYmBhhCxp/Kp8kJ75fca9TFm
9x9r/82yAEA31Mw2l3RXDsAMzBXnZYuQk71fY7egcaw4XPNawgSj+pvk5gO8IhRT
fIgXD6SOzM6xKcuDzF1sNgB+YLC+RNy7juycfvayU2xmD+lcyAh2NvG6FXYlaKuW
cWxAAWTiQWQwcGdqp7IlhfoOKzoVziTlZueNkOh4MpSObF+kt/Gl97mBml/vIazn
ThP5eJMK8nNP1SCuu8vf2djc9TtQVVG7QrLKsSt4SKbM3S4iiCC93nGrWhrj8nAI
lweLNC0K2zU/856QOyH/6Yo+pPW0/HwSokGm2vhdRm0amC4Bzs5Z7IuEOHXWItLg
aIeQTckIAH96TVfbTU5yMpa6Y/PXToXoRLzCnn0a/Qznk1vwA9seyPSuWZnlgFeH
EKl41am/Jc0MJsmxKKb0JdnT7RxuwO3DHRaqRhYZ1wIVRBafyblZkTD/PoP7kcKa
JGExLJkCDNNlYrMDKoSXcAw8J5hJdEcD/GmDTJ5iZDA8xWSXYBgWojwVmuXIaGBu
q0jbIEzl0jZQrnr2lIBjM2DYH916zafVbHVmNMmi/184OsnhRwBgdFVsrhLhXEZL
rMRyFU5K3cwjteRgm8qi
=OLzl
-----END PGP SIGNATURE-----

--qaEwurgqT6fwWw6bGLFJUodbKKaG4SXOd--
