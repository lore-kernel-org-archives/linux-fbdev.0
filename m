From: Finn Thain <fthain@telegraphics.com.au>
Date: Thu, 06 Feb 2020 23:01:13 +0000
Subject: [PATCH v2 0/3] Improve MIPS Magnum support
Message-Id: <cover.1581030073.git.fthain@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, linux-mips@vger.kernel.org

A few minor patches are needed to more easily boot a MIPS Magnum build
under QEMU. This series fixes a build failure in the g364fb driver and
modifies jazz_defconfig for use with 'qemu-system-mips64el -M magnum'.

Note that QEMU's dp8393x implementation has bugs, one of which prevents
the Linux jazzsonic driver from probing the chip. I have fixed the bugs
that I know of in a series of patches at,
https://github.com/fthain/qemu/commits/sonic

Changed since v1:
 - Added reviewed-by and tested-by tags from Philippe Mathieu-Daud=C3=A9.
 - Rebased.


Finn Thain (3):
  fbdev/g364fb: Fix build failure
  mips/jazz: Remove redundant settings and shrink jazz_defconfig
  mips/jazz: Update jazz_defconfig for MIPS Magnum

 arch/mips/configs/jazz_defconfig | 267 ++-----------------------------
 drivers/video/fbdev/g364fb.c     |  29 +---
 2 files changed, 15 insertions(+), 281 deletions(-)

--=20
2.24.1
