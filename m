From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 Oct 2015 09:31:50 +0000
Subject: Re: [PATCH] uvesafb: make scaling configurable on Nvidia cards
Message-Id: <56163806.40608@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="D1VkCDBsuiigqx1KIeOmd7H2VoMmFSI5K"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1509021719170.12073@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1509021719170.12073@file01.intranet.prod.int.rdu2.redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Michal Januszewski <spock@gentoo.org>
Cc: linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org

--D1VkCDBsuiigqx1KIeOmd7H2VoMmFSI5K
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 03/09/15 00:23, Mikulas Patocka wrote:
> [ I sent this some times ago, but didn't get any response ]
>=20
>=20
> Nvidia cards have a BIOS function 0x4f14 that allows to set flat panel
> scaling. This patch adds a module parameter "scaling" that uses this
> function to set the scaling. By default, the parameter is -1, so that t=
he
> driver doesn't attempt to call the scaling function.
>=20
> This patch is useful when using the binary Nvidia graphics driver - in
> that case, the console may be only in text mode or VESA mode. By defaul=
t,
> the video card does scaling that degrades font quality and changes aspe=
ct
> ratio. This patch makes it possible to turn off the scaling and improve=

> font quality on the console.
>=20
> The allowed values depend on VESA BIOS. On my card, the following value=
s
> are allowed:
> -1	- do not change the scaling
> 0	- scale to full screen
> 1, 2	- don't scale
> 3	- scale and preserve aspect ratio
> 4	- scale with black border around
>=20
> Example use:
> echo 1 >/sys/module/uvesafb/parameters/scaling; fbset 1280x1024-60 -dep=
th 32 -a
> - this sets unscaled 1280x1024 video mode that has much sharper font th=
an
>   the scaled modes.

I have to say I don't know much about x86 video, but isn't uvesafb
supposed to be a generic driver? Adding nvidia specific features there
doesn't sound like a right way to handle this.

 Tomi


--D1VkCDBsuiigqx1KIeOmd7H2VoMmFSI5K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWFjgGAAoJEPo9qoy8lh714pAP/jfoZ2gcSk/ZYPvEeH2+2mx0
ts8/HsDQpA1bXcVkF7NPd3h6HcxQKhfkfowlidDaUfkjypIMYGyjG1Go3wV/ZjLc
Rb/2O5PoCcoxC6Ay8GgX09ylOdDOvEsxyf6Frfr2XZGp3iz74xSHokb5cLqxNS7D
/CoXduV+b7putJuj9Zu3WUDZE23CxnUI6qASw5rooDvwcs0Ksv/gMx2RRcAuSAUZ
DDLJ/v2rrWRujYxUuPd3I8Su00cHLICUWEe3JYrApZy1+XaBN+qcll7UcDoWpcpZ
z9r9yXWSOBie4pWddMpjNEcsLIYk3eQAdou2xq4qEmdKRTtjzMRy5PPEI/oypc3a
avGkBPYJ8RbTwyOsK96HdQ+yY3rr4n5Ew1k48+yNFbVRaeObcZ3l3XfLLpBmsCKO
eZjfG+yNsVSVjNBiGeOpVkkYtiFd3zL5joKQsoGfhpumZGW+vxDtoJM7TBej/Wu3
2YbuUW2Mjoz+Wvowrre9bLs9wVGQdDMe7MB5I5F/8u5vFiWZAWBnffjpX73Zw8yN
/cdJ/s6MXPFmrRyyv6LEJhGfe7xoNqq7Wp1bUxAlNrN2Vuw+Yp3HuGYhvyFysTje
Kl6lMhYgYiYpnG1jc3q+lhG3IuUQnAdO18dThInJ/N5oEay6bigphH2rMWTnjeMc
waCieREeWLiqnVVjl2+Z
=TiHF
-----END PGP SIGNATURE-----

--D1VkCDBsuiigqx1KIeOmd7H2VoMmFSI5K--
