From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 29 May 2015 05:48:46 +0000
Subject: Re: [PATCH v4 0/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <5567FDBE.8010701@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uhrKnp7SdvrGMT7qrdfNeMvpwuiQQvrgG"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432859434-17821-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1432859434-17821-1-git-send-email-mcgrof@do-not-panic.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>

--uhrKnp7SdvrGMT7qrdfNeMvpwuiQQvrgG
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 29/05/15 03:30, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>=20
> Tomi,
>=20
> Upon integration onto your tree of the series, "[PATCH v3 00/17] frameb=
uffer:
> simple conversions to arch_phys_wc_add()" the 0 day build bot found a
> compilation issue on the gbefb driver. I had test compiled drivers with=

> allyesconfig and allmodconfig but failed to test compile against MIPS. =
This
> driver is enabled *only for MIPS*.  For the life me I could not get a M=
IPS
> cross compiler even on debian, so what I did to test this was incorpora=
te into
> my private tree a temporary patch [0] which enables this driver to comp=
ile on
> x86 and go test compile with that as a temporary patch. The compilation=
 was
> failing since I used the info struct instead of the actual private data=

> structure. This fixes that and moves its assignment early.  Sorry about=
 that.
>=20
> The rest of the series does not require changes for integration after t=
hese
> two patch replacements. Let me know if you'd like me to respin the enti=
re
> series though, but I didn't since I figured its pointless as the patche=
s remain
> intact. For your convenience however I've rebased all these 17 patches =
onto
> your latest tree on the for-next branch, you can pull the changes with =
the
> details provided below. This v4 iteration only carries the two patches =
which
> required updates. The details of the full pull request go below this.

Thanks, I've updated the two patches, and pushed the series to my for-nex=
t.

 Tomi


--uhrKnp7SdvrGMT7qrdfNeMvpwuiQQvrgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVZ/3BAAoJEPo9qoy8lh71NrAP/1ENPV4blhGgzDEcl/ATYbs/
rHliBCVJfxxOMEmZrHbPLFhVHWhwsT6zZWYOJvsClSm1uaXzsD5PKuy/KVhf6TgD
DHErJJR7Ey/onNM/67DhHQZpASkPR3mVHe3zH9XbnrpR+VPjVF36qmJAd41F0fc1
XRMDTjgStjkrdRmobh54sr6J0E5QWnyAIBKuXfRugQaknHXu+jX6lScPo/zHALw+
pBx22QOTnbUVy82SjC5LOOL7WE8574+Ei/ZUqm/FJAXWkKM7XJdi/Sjszojuae/N
nTFFvEpjCG098ImzcRAczorElVv4Rxo9YG3n3YUwCTs5I3gcy6YDeqvZaI8jMl/I
qgaC7cXUZ+2S9d+nPIjg7wfDytoP8qSzSZj5y6/cXH6dNg//wF11vDKYqkX/cEe0
gI/JyGWq+fXDKADNwAjbc+dErPnra1uOmVfXU19uEbeELV54egAzh75w7gHVfHqv
A8fGfW6rx1yQTGAeBSCl1jMO8mZhDuIoKmjmCnSy9FYs3VunVN/4UvKV5J6FEOHN
cyMwqapYsSR2nVSSSenHDUjsR9XJbrlThX2Ge0pLj1bmrj+y1m0uAJ1gTR0JMsbQ
DEcHLITAncTCe7/Hd3Rv0SKH9MeQMfzdZqRdgrdHUDjBKqlSa06MYzqs+QFs9tj3
i0NgM2nqgjj1UYOKWD5i
=StDH
-----END PGP SIGNATURE-----

--uhrKnp7SdvrGMT7qrdfNeMvpwuiQQvrgG--
