From: Finn Thain <fthain@telegraphics.com.au>
Date: Sun, 02 Feb 2020 02:33:32 +0000
Subject: [PATCH 0/3] Improve MIPS Magnum support
Message-Id: <cover.1580610812.git.fthain@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

A few minor patches are needed to more easily boot a MIPS Magnum build
under 'qemu-system-mips64el -M magnum'. This series fixes a build failure
in the g364fb driver and modifies jazz_defconfig for use with QEMU.

Note that QEMU's dp8393x implementation has bugs, one of which prevents
the Linux jazzsonic driver from probing the chip. I have fixed the bugs
that I know of in a series of patches at,
https://github.com/fthain/qemu/commits/sonic


Finn Thain (3):
  fbdev/g364fb: Fix build failure
  mips/jazz: Remove redundant settings and shrink jazz_defconfig
  mips/jazz: Update jazz_defconfig for MIPS Magnum

 arch/mips/configs/jazz_defconfig | 267 ++-----------------------------
 drivers/video/fbdev/g364fb.c     |  29 +---
 2 files changed, 15 insertions(+), 281 deletions(-)

-- 
2.24.1
