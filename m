From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 14 Nov 2016 11:44:53 +0000
Subject: [GIT PULL] fbdev fixes for 4.9
Message-Id: <b74835d1-b878-55ec-65d3-dd3766a5b194@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PPMWDjxPD0ofx10b5fjBo5CS93wblLK2q"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--PPMWDjxPD0ofx10b5fjBo5CS93wblLK2q
Content-Type: multipart/mixed; boundary="Xg0gSujnsCNKmFn5KvhQugOJ713R299Dr";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <b74835d1-b878-55ec-65d3-dd3766a5b194@ti.com>
Subject: [GIT PULL] fbdev fixes for 4.9

--Xg0gSujnsCNKmFn5KvhQugOJ713R299Dr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull two fbdev fixes for 4.9.

 Tomi

The following changes since commit a909d3e636995ba7c349e2ca5dbb528154d4ac=
30:

  Linux 4.9-rc3 (2016-10-29 13:52:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-4.9

for you to fetch changes up to 1746aff3dba0f7530688e405e7802eeca928665f:

  Fix loading of module radeonfb on PowerMac (2016-11-14 13:27:54 +0200)

----------------------------------------------------------------
fbdev fixes for 4.9

* Fix CLCD regression on Vexpress
* Fix loading of radeonfb on PowerMac

----------------------------------------------------------------
Linus Walleij (1):
      video: ARM CLCD: fix Vexpress regression

Mathieu Malaterre (1):
      Fix loading of module radeonfb on PowerMac

 drivers/video/fbdev/amba-clcd-versatile.c |  4 ++--
 drivers/video/fbdev/aty/radeon_base.c     | 22 ++++++++++++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)


--Xg0gSujnsCNKmFn5KvhQugOJ713R299Dr--

--PPMWDjxPD0ofx10b5fjBo5CS93wblLK2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYKaO1AAoJEPo9qoy8lh71X18QAIqLAitJAJorHW9wvHUx8xp6
p62TND1WV+7r+MVuzd99OkTA0o9e6vN7LGPoCgmrhk3wGKB72B/OjmxcrTc2roBe
SexO4fBUFBaN2XZHrdWR/rxdalt2OsM1JcJl1jRg2+PhBZxw7TUoKMoF7/ua/a9l
rur8TaWy+wZvLV5yr+3deOfh/qAfDn2VFouW+qZvwK+B2lygr+K4X3Yxxk9d5h3/
HINtMdC+tWMCB6hCc0fwLGhKOr1xB2uC/7edFCN7HGvxxKegerGl4ftplOXe2Pz4
TYc0WVGrJUoUayQR+gk90tuwrSiJDyM8Y4ZXWbLnCW6qiuAfTdI5uOHE1VWenbEo
UtPaLUcYJfGfTkIupm982yMDzJaOcjkQSBs/o7gPBN016FsVa790KxSJNhfixHl1
SUfxJxpxkahTlZIHrc3ncW6Xe4hlaHqlQYbH/4SmtaByAxMs50CSbMXQ7Bu2fT1e
nWWHy5+B/4wE9ouzdr6bf8eV/BdAvtesp135pQbHjZMY8SFUVlJ2i6P0/T8+hU5b
B592ojkAwkJd/mJ1tZ8MpGVfdvzsiaUVT8t3koaQOJgDiWh1KvBz05cj+1zh2hCE
6inm7Mex/tKUJ+bjxiA8/ruooAxd+1TtMR+uFtSAFfeogRDJJss9aW6Qe/Yk9PJj
oYFuB98qXCRC0xCYDmw8
=C0zk
-----END PGP SIGNATURE-----

--PPMWDjxPD0ofx10b5fjBo5CS93wblLK2q--
