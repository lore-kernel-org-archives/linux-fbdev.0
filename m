From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Tue, 07 Aug 2012 09:49:54 +0000
Subject: [PATCH V3 0/5] arm: samsung: Move FIMD headers to include/video/
Message-Id: <1344332279-16736-1-git-send-email-l.krishna@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, kgene.kim@samsung.com, m.szyprowski@samsung.com

This patchset moves the contents of regs-fb-v4.h and regs-fb.h from arch side
to include/video/samsung_fimd.h

This patchset is created and rebased against master branch of torvalds tree.
Tested on smdk5250 board, build tested for other boards.

Changes from version 2:
	- Changed the EXYNOS5_xxx macro name to FIMD_V8_xxx
	- Moved the header inclusion under same kind

Changes from version 1:
	- Split the patches as per Sylwester comments
	- Changed FIMD_V8_xxx macro to EXYNOS5_xxx	

Leela Krishna Amudala (5):
  include/video: Add samsung FIMD register header
  include/video: Add Exynos5 specific FIMD register offsets
  arm: samsung: Include the modified FIMD header file
  driver: Include the modified FIMD header file
  arm: samsung: delete frame buffer header files from platform

 arch/arm/mach-exynos/mach-nuri.c                |    2 +-
 arch/arm/mach-exynos/mach-origen.c              |    2 +-
 arch/arm/mach-exynos/mach-smdk4x12.c            |    2 +-
 arch/arm/mach-exynos/mach-smdkv310.c            |    2 +-
 arch/arm/mach-exynos/mach-universal_c210.c      |    2 +-
 arch/arm/mach-exynos/setup-fimd0.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c            |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c                |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c                |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c           |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c            |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c            |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c           |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c           |    2 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c           |    2 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c           |    2 +-
 arch/arm/mach-s5pv210/mach-aquila.c             |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c               |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c           |    2 +-
 arch/arm/plat-samsung/include/plat/regs-fb-v4.h |  159 -------
 arch/arm/plat-samsung/include/plat/regs-fb.h    |  403 -----------------
 drivers/gpu/drm/exynos/exynos_drm_fimd.c        |    2 +-
 drivers/video/s3c-fb.c                          |    2 +-
 include/video/samsung_fimd.h                    |  533 +++++++++++++++++++++++
 27 files changed, 557 insertions(+), 586 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb-v4.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-fb.h
 create mode 100644 include/video/samsung_fimd.h

