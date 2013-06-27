From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 27 Jun 2013 06:31:04 +0000
Subject: Re: [PATCH linux-next] fb: make fp_get_options name argument const
Message-Id: <51CBDC28.9080808@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2TSFNNGPUEREABXBCPLSH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371565386-23335-1-git-send-email-vincent.stehle@freescale.com> <51CAEAD5.40601@ti.com> <1927037966.2377585.1372310085417.JavaMail.root@redhat.com>
In-Reply-To: <1927037966.2377585.1372310085417.JavaMail.root@redhat.com>
To: David Airlie <airlied@redhat.com>
Cc: =?UTF-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@freescale.com>, linux-next@vger.kernel.org, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, trivial@kernel.org

------enig2TSFNNGPUEREABXBCPLSH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 27/06/13 08:14, David Airlie wrote:
>>>
>>>
>>> Hi,
>>>
>>> I remarked this warning while building linux-next with imx_v6_v7_defc=
onfig.
>>> Is changing fb_get_options prototype "permitted", please?
>>
>> I don't see how changing the parameter to const could break anything, =
so
>> I've applied this to fbdev-3.11 branch.
>>
>=20
> Hi Tomi,
>=20
> What tree does Jean-Christophe PLAGNIOL-VILLARD control?

git://git.kernel.org/pub/scm/linux/kernel/git/plagnioj/linux-fbdev.git

> he said he merged the original patch to fix this from Ville, but I've n=
o idea
> where it ended up, so I just didn't merge it to drm-next at the time.
>=20
> Message-Id: <1370619787-15341-3-git-send-email-ville.syrjala@linux.inte=
l.com>
>=20
> is the original properly attributed fix.

Hmm, ok. He asked me to collect fbdev patches as he's been away, so I
went through my inbox and picked up what's there. I can't see the patch
from Ville in Jean-Christophe's tree.

Jean-Christophe, have you taken that (and maybe other patches) but you
haven't pushed them to the kernel.org tree?

 Tomi



------enig2TSFNNGPUEREABXBCPLSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRy9wrAAoJEPo9qoy8lh71E9IP/3GtphqrqvVpae4pnjYfXurP
eBq+00MaNsEHGhFNg4luJBvuZBZqfDnWzGf3YbweoMTsTW7gLKnzKiusu3DPSCG+
5Gv0LYA6WZIzRyEgBvYXGcatjOWIkiwagsUckjtJWSiJWQhNbyhhUFH5tPxC1ZCo
QhfvS9g3c136YHPuOmzYXhloAK44giq5Rwq4xlQTQG3lyRli02T3vdeyjdndO5gY
ds2yhuTEhmuqsq4Tz5w2tTBt9Yd130ZSiBpcdemjKSb5ZofsYNGbt0CDk90xGYrL
poIHlKRfn9+yAuFJqFBXQRgK8IdkPSz7mcv87oQYY+KxNsMjNfu2xn9QG9PAHEMe
QWYf8eLfH2FBqW4i86oTWoaiGAuGVoB8tWMKJfGS/VRgHxbtrkQITP92s2PVCaFc
Kdfyvmut1oGnw/JXDgLPkdBybDYAZF3D7H3qL4OnAo/knxA+/zLCH+H4RT1XPJhN
wtWqTYLlEozM/g/96f+/TBQNXWvuoZOPvQpXdEEJuax2lpKW+uCXDfanAPT4lT+q
9G2rO7JREGHs3WGhqKICOTejusFDDys1g3j+8UCM2hye3L9KLjzm28VWQD4n6reL
Zr3U5nDaFZEhEvotZrliP4xXniivIfIU+wI8Y5REFts0MX18PJiauDfOuKawOEgQ
R8JRTzUQbY4uW+dSh8Q/
=In6L
-----END PGP SIGNATURE-----

------enig2TSFNNGPUEREABXBCPLSH--
