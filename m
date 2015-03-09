From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 09 Mar 2015 12:49:53 +0000
Subject: [GIT PULL] fbdev fixes for 4.0
Message-Id: <54FD96F1.1020607@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ixiDIqJXsHarKoX9UubX7L7uND0La27Tq"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

--ixiDIqJXsHarKoX9UubX7L7uND0La27Tq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull fbdev fixes:

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff5=
39:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-fixes-4.0

for you to fetch changes up to a38bb793eaebe1178fbd8ef6ab66ccc062bad505:

  OMAPDSS: fix regression with display sysfs files (2015-02-26 10:23:15 +=
0200)

----------------------------------------------------------------
fbdev fixes for 4.0

* Fix regression in with omapdss when using i2c displays
* Fix possible null deref in fbmon
* Check kalloc return value in AMBA CLCD

----------------------------------------------------------------
Kiran Padwal (1):
      video: ARM CLCD: Add missing error check for devm_kzalloc

Sudip Mukherjee (1):
      video: fbdev: fix possible null dereference

Tomi Valkeinen (1):
      OMAPDSS: fix regression with display sysfs files

 drivers/video/fbdev/amba-clcd.c               |   3 +
 drivers/video/fbdev/core/fbmon.c              |   6 +-
 drivers/video/fbdev/omap2/dss/display-sysfs.c | 179 ++++++++++++++------=
------
 include/video/omapdss.h                       |   1 +
 4 files changed, 102 insertions(+), 87 deletions(-)


--ixiDIqJXsHarKoX9UubX7L7uND0La27Tq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/ZbxAAoJEPo9qoy8lh71iicQAJwmF4lQBFzHONg2wkVE2p0g
mpsEy0L6f2DJgE6Pxw49VdTeBEB8DCyrfGxIPNp7i4TvkQEI5K0DjTquzGkBTQgO
aoEs6IM7OBS16MlU05vk3wlotnb6+FFwTRw77ENf6jlTvvnTQUe81u6QThpaYHsf
sywV7I2yl569aJxv8RF7nc5IqQsNM6Ra8oT8yZTxm7tCJUX7eZdhnr0wUi0U08MP
d3ddZB+BR7h57658n83PYx0NtZdKGN7diu1bM4ahph4rke7ur0Cv5pRyufVPefSj
0f+8YRh42oBKBEotmMytZIuy40eEl0YP4fMaRgjkq4xcfZpKjEgB2RxjxLwbNy2y
yiCcFrBi19qHfsQy49PXcYL0wKi0ASgjI05nYDLf+QQvQ7zn3nnNO2JwSP/FWfW2
XIJ5UcvntXeuasHk6DlX+pdolHbKhj+J8sY6VpwRLZBWe4/QWgynjCzVWxCrz2mq
OOoGIdM7HSKXNy1+SbS3aOIfxMM9BqaB+dGRzs11tLAW6DISThqYMYZnJCliaBp+
dT/6iEIV/WhpE1XepWx1xGMrEffzlTUDz1ovac1p89aN8TAkTAYr6mMoT82HyL7u
uc7oPagKPHIQOJsnTNYsNLGIYEGfRQC2gz92HCkUgLhzO0iDUVRa1jTyxNhaf8rb
XLnVU88Yf9bYYkIWlAYe
=Ajp1
-----END PGP SIGNATURE-----

--ixiDIqJXsHarKoX9UubX7L7uND0La27Tq--
