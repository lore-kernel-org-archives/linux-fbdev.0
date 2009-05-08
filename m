From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 0/15] ps3{fb,vram,disk} patches for 2.6.31
Date: Fri,  8 May 2009 16:01:09 +0200
Message-ID: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759637AbZEHOBz@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

	Hi all,

Here are my PS3 patches for 2.6.31. Most of them are for ps3{vram,fb}.
Patch 8 is a generic cleanup for Cell. Patch 15 touches ps3disk, too.

  [01/15] ps3vram: Fix error path (return -EIO) for short read/write
  [02/15] ps3vram: Use proc_create_data() instead of proc_create()
  [03/15] ps3vram: Correct exchanged gotos in ps3vram_probe() error pat=
h
  [04/15] ps3vram: Replace mutex by spinlock + list
  [05/15] ps3fb: Remove useless debug checks in ps3fb_shutdown()
  [06/15] ps3fb: Inline functions in ps3fb_probe(), to ease cleanup in =
the error path
  [07/15] ps3fb: Correct handling of device opening in ps3fb_probe()
  [08/15] powerpc/cell: Extract duplicated IOPTE_* to <asm/iommu.h>
  [09/15] ps3fb: GPU memory mapping cleanup
  [10/15] ps3vram: GPU memory mapping cleanup
  [11/15] ps3fb/vram: Extract common GPU stuff into <asm/ps3gpu.h>
  [12/15] ps3fb: Tear down FB setup during cleanup
  [13/15] ps3vram: Remove no longer used ps3vram_priv.ddr_base
  [14/15] ps3vram: Make ps3vram_priv.reports a void *
  [15/15] block/ps3: remove driver_data direct access of struct device

How shall we get them in? Through Ben's powerpc tree?

Thanks!

arch/powerpc/include/asm/ps3gpu.h         |    8=20
b/arch/powerpc/include/asm/iommu.h        |   10=20
b/arch/powerpc/include/asm/ps3.h          |    3=20
b/arch/powerpc/include/asm/ps3gpu.h       |   78 +++++++
b/arch/powerpc/platforms/cell/iommu.c     |   10=20
b/arch/powerpc/platforms/ps3/mm.c         |    1=20
b/arch/powerpc/platforms/ps3/platform.h   |   10=20
b/arch/powerpc/platforms/ps3/setup.c      |    1=20
b/arch/powerpc/platforms/ps3/system-bus.c |    2=20
b/drivers/block/ps3disk.c                 |   18 -
b/drivers/block/ps3vram.c                 |    2=20
b/drivers/ps3/ps3av_cmd.c                 |    3=20
b/drivers/video/ps3fb.c                   |   15 -
drivers/block/ps3vram.c                   |  183 +++++++++---------
drivers/video/ps3fb.c                     |  304 +++++++++++++---------=
--------
15 files changed, 339 insertions(+), 309 deletions(-)

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =C2=B7 Da Vincilaan 7-D1 =C2=B7 B-1935 Zaventem =C2=
=B7 Belgium

Phone:    +32 (0)2 700 8453
=46ax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =C2=B7 RPR Brussels
=46ortis =C2=B7 BIC GEBABEBB =C2=B7 IBAN BE41293037680010
