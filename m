From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 May 2016 08:21:03 +0000
Subject: [GIT PULL] fbdev changes for 4.7
Message-Id: <573EC8EF.2090909@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UpCJ3vq0MEtEBjRGmOA42ciP0PX60IhU8"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--UpCJ3vq0MEtEBjRGmOA42ciP0PX60IhU8
Content-Type: multipart/mixed; boundary="s2rbMAWfDcIOfiFeKb5uQSRXxdgNUqrPW"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <573EC8EF.2090909@ti.com>
Subject: [GIT PULL] fbdev changes for 4.7

--s2rbMAWfDcIOfiFeKb5uQSRXxdgNUqrPW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull the fbdev changes for v4.7.

 Tomi

The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547=
c9:

  Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-4.7

for you to fetch changes up to ab366b40b8513e7590858229ecbb5e1434a52b54:

  fbdev: Use IS_ENABLED() instead of checking for built-in or module (201=
6-05-13 15:14:38 +0300)

----------------------------------------------------------------
fbdev changes for 4.7

* imxfb: fix lcd power up
* small fixes and cleanups

----------------------------------------------------------------
Alexey Khoroshilov (1):
      fbdev: fbmem: implement error handling in fbmem_init()

Andy Lutomirski (1):
      efifb: Don't show the mapping VA

Eric Engestrom (1):
      Documentation: fb: fix spelling mistakes

Javier Martinez Canillas (1):
      fbdev: Use IS_ENABLED() instead of checking for built-in or module

Julian Scheel (1):
      fbdev: ssd1307fb: Fix charge pump setting

Peter Ujfalusi (1):
      video: fbdev: omap2: Remove deprecated regulator_can_change_voltage=
() usage

Simon Horman (1):
      fbdev: sh_mipi_dsi: remove driver

Uwe Kleine-K=C3=B6nig (2):
      video: fbdev: imxfb: fix semantic of .get_power and .set_power
      video: fbdev: imxfb: add some error handling

Wang Hongcheng (1):
      video: AMBA CLCD: Remove unncessary include in amba-clcd.c

 Documentation/fb/udlfb.txt                   |   6 +-
 drivers/video/Kconfig                        |   4 -
 drivers/video/fbdev/Kconfig                  |   1 -
 drivers/video/fbdev/Makefile                 |   1 -
 drivers/video/fbdev/amba-clcd.c              |   2 -
 drivers/video/fbdev/core/fbmem.c             |  20 +-
 drivers/video/fbdev/efifb.c                  |   6 +-
 drivers/video/fbdev/imxfb.c                  |  44 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c   |  12 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c |  12 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c |  12 +-
 drivers/video/fbdev/sh_mipi_dsi.c            | 587 ---------------------=
------
 drivers/video/fbdev/ssd1307fb.c              |   2 +-
 drivers/video/fbdev/via/accel.c              |   2 +-
 drivers/video/fbdev/via/via-core.c           |   4 +-
 include/video/sh_mipi_dsi.h                  |  59 ---
 16 files changed, 73 insertions(+), 701 deletions(-)
 delete mode 100644 drivers/video/fbdev/sh_mipi_dsi.c
 delete mode 100644 include/video/sh_mipi_dsi.h


--s2rbMAWfDcIOfiFeKb5uQSRXxdgNUqrPW--

--UpCJ3vq0MEtEBjRGmOA42ciP0PX60IhU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPsjvAAoJEPo9qoy8lh71I0UP/A4xKZ4tntVpqmqvgUmB0Lpf
/hyG3Nf25LnZztb5fs19upQAC1BZn9HZu8Vjv211DmMtXdPqhxHLFzOcm0mdj+df
7b5ObXMAbCre9W/7CuuKKO6V/Pq3KKUE3xwibMzrxSq88jmulJ/wn+JFwqDsxIEa
CI4MjD9LCSOQln1rtWKWmFovml/YJoW995Yg5bojO0wc+4sspOoDyYdVbCn/7CAI
Qhlmrs2MezMM86RfVz/0p2skO+Dycwm5NdKB9g72OHugKDBT7xTkF6cJjURHpGat
7q9NoHCf/L3hczlj7s3PW0Z8jifn57vjO6xKhsJGXDd5g7fC87C1VJtVf7rrbd6c
jgHD1hen1r3rAlGwoPm1IYRAfVS/OnJl/LSi/6lKtYOD0GtNYdh2qCmjVFpzmmmg
0m/i4ebDRtxFKk00ysxoO21kRqpR8RkNf/YTcXKD0ps514mI759xTZuRDUn9BKfQ
NYMkYsSjHyobG6eCDcAIK5+laa1M+19BMYGg94AVeGdRhRv0ncI9fKpWb/5EomcK
lnCCmhCXrLVZCouT+TW/EkHX8+dImjhmAxrR3/jrhkoc222OYAUM3zhXfHCoDcYl
kCJfc22x67CrKrROAD9tHmVccx1eBWCd8UGT9XEExDRoPcYiqY9VNcpQ+YpRqrJN
6ZDv3Gurl3aVphrToeD6
=b5ed
-----END PGP SIGNATURE-----

--UpCJ3vq0MEtEBjRGmOA42ciP0PX60IhU8--
