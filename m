From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:17:50 +0000
Subject: [PATCH v1 00/47] mtrr/x86/drivers: bury MTRR
Message-Id: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

When a system has PAT support enabled you don't need to be
using MTRRs. Andy had added arch_phys_wc_add() long ago to
help with this but not all drivers were converted over. We
have to take care to only convert drivers where we know that
the proper ioremap_wc() API has been used. Doing this requires
a bit of work on verifying the driver split out the ioremap'd
areas -- and if not doing that ourselves. Verifying a driver
uses the same areas can be hard but with a bit of love Coccinelle
can help with that.

We're motivated to change drivers for a few reasons:

1) Take advantage of PAT when available

2) Help with the goal of eventually using _PAGE_CACHE_UC over
   _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (de33c442e)

3) Bury MTRR code away from drivers as it is architecture specific

While working on the conversion I noticed a few things.

a) Run time disabling of MTRR

Some systems can technically have both PAT and MTRR enabled
and even if they support it, a system may end up not enabling MTRR.
There are a few reasons why this can happen but the code right now
doesn't address this well. This leads to another point: PAT code
right now is not a first class citizen on x86 -- pat_init() depends
on MTRR code so we can't actually enable PAT without building MTRR.
Doing this requires quite a bit more work so let this serve as
a starting point for conversation if we want to address that.

b) Driver work and required ioremap split

In order to take advantage of PAT device drivers that were using
MTRR must make sure that the area that was using MTRR is ioremap'd
separately. Fortunately a lot of drivers already do this, but there's
quite a bit of drivers that require some love to get that happen.
This leaves us needing to expose an last resort API to annotate this
and also avoid a regression on performance for systems that may have
PAT but can't yet move away from using MTRR. To find the drivers that
need love check out __arch_phys_wc_add(). For a good example driver
where the work was done refer to the atyfb driver fixes.

c) Missing APIs for write-combining

There's a few API calls missing to take advantage of write-combining,
this series add those.

d) Further framebuffer driver MTRR usage simplication

We can simplify MTRR usage by having the framebuffer core
add the MTRR by passing a flag when register_framebuffer()
is called, this could for instance be done on very few drivers
where the smem_len and smem_start are both used for the ioremap_wc()
and also for the arch_phys_wc_add(). Coccinelle can be easily used
to do a transformation here. I didn't do that here given that it
does not work for all device drivers *and* DRM drivers already
have something similar. Lastly this technically could also be done
on some other generic helper --- but figured its best we review that
here. One reason to *not* do this is that tons of framebuffer drivers
have mtrr options exposed -- we'd need to generalize those and provide
a port ... or deal with the fact that we are going to remove all that.

Luis R. Rodriguez (47):
  x86: mtrr: annotate mtrr_type_lookup() is only implemented on
    generic_mtrr_ops
  x86: mtrr: generalize run time disabling of MTRR
  devres: add devm_ioremap_wc()
  pci: add pci_ioremap_wc_bar()
  pci: add pci_iomap_wc() variants
  mtrr: add __arch_phys_wc_add()
  video: fbdev: atyfb: move framebuffer length fudging to helper
  video: fbdev: atyfb: clarify ioremap() base and length used
  vidoe: fbdev: atyfb: remove and fix MTRR MMIO "hole" work around
  video: fbdev: atyfb: use arch_phys_wc_add() and ioremap_wc()
  IB/qib: add acounting for MTRR
  IB/qib: use arch_phys_wc_add()
  IB/ipath: add counting for MTRR
  IB/ipath: use __arch_phys_wc_add()
  [media] media: ivtv: use __arch_phys_wc_add()
  fusion: use __arch_phys_wc_add()
  video: fbdev: vesafb: only support MTRR_TYPE_WRCOMB
  vidoe: fbdev: vesafb: add missing mtrr_del() for added MTRR
  video: fbdev: vesafb: use arch_phys_wc_add()
  mtrr: avoid ifdef'ery with phys_wc_to_mtrr_index()
  ethernet: myri10ge: use arch_phys_wc_add()
  staging: sm750fb: use arch_phys_wc_add() and ioremap_wc()
  staging: xgifb: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: arkfb: use arch_phys_wc_add() and pci_iomap_wc()
  video: fbdev: radeonfb: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: gbefb: add missing mtrr_del() calls
  video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
  video: fbdev: intelfb: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: neofb: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: s3fb: use arch_phys_wc_add() and pci_iomap_wc()
  video: fbdev: nvidia: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: savagefb: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: sisfb: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: aty: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: i810: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: i740fb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
  video: fbdev: kyrofb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
  video: fbdev: pm2fb: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: pm3fb: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: rivafb: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: tdfxfb: use arch_phys_wc_add() and ioremap_wc()
  video: fbdev: vt8623fb: use arch_phys_wc_add() and pci_iomap_wc()
  video: fbdev: atmel_lcdfb: use ioremap_wc() for framebuffer
  video: fbdev: geode gxfb: use ioremap_wc() for framebuffer
  video: fbdev: gxt4500: use pci_ioremap_wc_bar() for framebuffer
  mtrr: bury MTRR - unexport mtrr_add() and mtrr_del()

 Documentation/driver-model/devres.txt            |  1 +
 arch/x86/include/asm/io.h                        |  6 ++
 arch/x86/include/asm/mtrr.h                      |  7 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c               |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c               |  7 +-
 arch/x86/kernel/cpu/mtrr/if.c                    |  3 +
 arch/x86/kernel/cpu/mtrr/main.c                  | 73 +++++++++++++------
 drivers/gpu/drm/drm_ioctl.c                      | 14 +---
 drivers/infiniband/hw/ipath/ipath_driver.c       |  7 +-
 drivers/infiniband/hw/ipath/ipath_kernel.h       |  4 +-
 drivers/infiniband/hw/ipath/ipath_wc_x86_64.c    | 47 +++++--------
 drivers/infiniband/hw/qib/qib_wc_x86_64.c        | 31 ++------
 drivers/media/pci/ivtv/ivtvfb.c                  | 51 ++++----------
 drivers/message/fusion/mptbase.c                 | 19 ++---
 drivers/message/fusion/mptbase.h                 |  2 +-
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 36 +++-------
 drivers/pci/pci.c                                | 14 ++++
 drivers/staging/sm750fb/sm750.c                  | 34 ++-------
 drivers/staging/sm750fb/sm750.h                  |  3 -
 drivers/staging/sm750fb/sm750_hw.c               |  3 +-
 drivers/staging/xgifb/XGI_main_26.c              | 27 ++-----
 drivers/video/fbdev/arkfb.c                      | 36 ++--------
 drivers/video/fbdev/atmel_lcdfb.c                |  3 +-
 drivers/video/fbdev/aty/aty128fb.c               | 36 ++--------
 drivers/video/fbdev/aty/atyfb.h                  |  5 +-
 drivers/video/fbdev/aty/atyfb_base.c             | 90 ++++++++----------------
 drivers/video/fbdev/aty/radeon_base.c            | 29 ++------
 drivers/video/fbdev/aty/radeonfb.h               |  2 +-
 drivers/video/fbdev/gbefb.c                      | 18 +++--
 drivers/video/fbdev/geode/gxfb_core.c            |  3 +-
 drivers/video/fbdev/gxt4500.c                    |  2 +-
 drivers/video/fbdev/i740fb.c                     | 35 ++-------
 drivers/video/fbdev/i810/i810.h                  |  3 +-
 drivers/video/fbdev/i810/i810_main.c             | 11 +--
 drivers/video/fbdev/i810/i810_main.h             | 26 -------
 drivers/video/fbdev/intelfb/intelfb.h            |  4 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c         | 38 ++--------
 drivers/video/fbdev/kyro/fbdev.c                 | 33 +++------
 drivers/video/fbdev/matrox/matroxfb_base.c       | 36 ++++------
 drivers/video/fbdev/matrox/matroxfb_base.h       | 27 +------
 drivers/video/fbdev/neofb.c                      | 26 ++-----
 drivers/video/fbdev/nvidia/nv_type.h             |  7 +-
 drivers/video/fbdev/nvidia/nvidia.c              | 37 ++--------
 drivers/video/fbdev/pm2fb.c                      | 31 ++------
 drivers/video/fbdev/pm3fb.c                      | 30 ++------
 drivers/video/fbdev/riva/fbdev.c                 | 39 ++--------
 drivers/video/fbdev/riva/rivafb.h                |  4 +-
 drivers/video/fbdev/s3fb.c                       | 35 ++-------
 drivers/video/fbdev/savage/savagefb.h            |  4 +-
 drivers/video/fbdev/savage/savagefb_driver.c     | 17 +----
 drivers/video/fbdev/sis/sis.h                    |  2 +-
 drivers/video/fbdev/sis/sis_main.c               | 27 ++-----
 drivers/video/fbdev/tdfxfb.c                     | 41 ++---------
 drivers/video/fbdev/vesafb.c                     | 77 +++++++-------------
 drivers/video/fbdev/vt8623fb.c                   | 31 ++------
 include/asm-generic/pci_iomap.h                  | 14 ++++
 include/linux/io.h                               | 12 ++++
 include/linux/pci.h                              |  1 +
 include/video/kyro.h                             |  4 +-
 include/video/neomagic.h                         |  5 +-
 include/video/tdfx.h                             |  2 +-
 lib/devres.c                                     | 29 ++++++++
 lib/pci_iomap.c                                  | 61 ++++++++++++++++
 63 files changed, 463 insertions(+), 901 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

